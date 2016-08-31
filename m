From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v3 2/2] ALSA: fireworks: accessing to user space outside
 spinlock
Date: Wed, 31 Aug 2016 22:03:33 +0900
Message-ID: <0d8d7d2e-7fc6-e7e9-41d4-d4e535af2133@sakamocchi.jp>
References: <1472642133-31576-1-git-send-email-o-takashi@sakamocchi.jp>
 <1472642133-31576-3-git-send-email-o-takashi@sakamocchi.jp>
 <s5h7faxgmdn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5h7faxgmdn.wl-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: clemens@ladisch.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Aug 31 2016 21:21, Takashi Iwai wrote:
> On Wed, 31 Aug 2016 13:15:33 +0200,
> Takashi Sakamoto wrote:
>>
>> In hwdep interface of fireworks driver, accessing to user space is in a
>> critical section with disabled local interrupt. Depending on architecture,
>> accessing to user space can cause page fault exception. Then local
>> processor stores machine status and handles the synchronous event. A
>> handler corresponding to the event can call task scheduler to wait for
>> preparing pages. In a case of usage of single core processor, the state to
>> disable local interrupt is worse because it don't handle usual interrupts
>> from hardware.
>>
>> This commit fixes this bug, performing the accessing outside spinlock.
>>
>> Reported-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
>> Cc: stable@vger.kernel.org
>> Fixes: 555e8a8f7f14('ALSA: fireworks: Add command/response functionality into hwdep interface')
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>  sound/firewire/fireworks/fireworks_hwdep.c       | 52 ++++++++++++++++++------
>>  sound/firewire/fireworks/fireworks_transaction.c |  4 +-
>>  2 files changed, 42 insertions(+), 14 deletions(-)
>>
>> diff --git a/sound/firewire/fireworks/fireworks_hwdep.c b/sound/firewire/fireworks/fireworks_hwdep.c
>> index 33df865..2563490 100644
>> --- a/sound/firewire/fireworks/fireworks_hwdep.c
>> +++ b/sound/firewire/fireworks/fireworks_hwdep.c
>> @@ -25,6 +25,7 @@ hwdep_read_resp_buf(struct snd_efw *efw, char __user *buf, long remained,
>>  {
>>  	unsigned int length, till_end, type;
>>  	struct snd_efw_transaction *t;
>> +	u8 *pull_ptr;
>>  	long count = 0;
>>  
>>  	if (remained < sizeof(type) + sizeof(struct snd_efw_transaction))
>> @@ -38,8 +39,17 @@ hwdep_read_resp_buf(struct snd_efw *efw, char __user *buf, long remained,
>>  	buf += sizeof(type);
>>  
>>  	/* write into buffer as many responses as possible */
>> +	spin_lock_irq(&efw->lock);
>> +
>> +	/*
>> +	 * When another task reaches here during this task's access to user
>> +	 * space, it picks up current position in buffer and can read the same
>> +	 * series of responses.
>> +	 */
>> +	pull_ptr = efw->pull_ptr;
>> +
>>  	while (efw->resp_queues > 0) {
>> -		t = (struct snd_efw_transaction *)(efw->pull_ptr);
>> +		t = (struct snd_efw_transaction *)(pull_ptr);
>>  		length = be32_to_cpu(t->length) * sizeof(__be32);
>>  
>>  		/* confirm enough space for this response */
>> @@ -49,16 +59,19 @@ hwdep_read_resp_buf(struct snd_efw *efw, char __user *buf, long remained,
>>  		/* copy from ring buffer to user buffer */
>>  		while (length > 0) {
>>  			till_end = snd_efw_resp_buf_size -
>> -				(unsigned int)(efw->pull_ptr - efw->resp_buf);
>> +				(unsigned int)(pull_ptr - efw->resp_buf);
>>  			till_end = min_t(unsigned int, length, till_end);
>>  
>> -			if (copy_to_user(buf, efw->pull_ptr, till_end))
>> +			spin_unlock_irq(&efw->lock);
>> +
>> +			if (copy_to_user(buf, pull_ptr, till_end))
>>  				return -EFAULT;
>>  
>> -			efw->pull_ptr += till_end;
>> -			if (efw->pull_ptr >= efw->resp_buf +
>> -					     snd_efw_resp_buf_size)
>> -				efw->pull_ptr -= snd_efw_resp_buf_size;
>> +			spin_lock_irq(&efw->lock);
>> +
>> +			pull_ptr += till_end;
>> +			if (pull_ptr >= efw->resp_buf + snd_efw_resp_buf_size)
>> +				pull_ptr -= snd_efw_resp_buf_size;
>>  
>>  			length -= till_end;
>>  			buf += till_end;
>> @@ -69,6 +82,18 @@ hwdep_read_resp_buf(struct snd_efw *efw, char __user *buf, long remained,
>>  		efw->resp_queues--;
>>  	}
>>  
>> +	/*
>> +	 * All of tasks can read from the buffer nearly simultaneously, but the
>> +	 * position of each task is different depending on the length of given
>> +	 * buffer. Here, for simplicity, a position of buffer is set by the
>> +	 * latest task. It's better for a listening application to allow one
>> +	 * thread to read from the buffer. Unless, each task can read different
>> +	 * sequence of responses depending on variation of buffer length.
>> +	 */
>> +	efw->pull_ptr = pull_ptr;
>> +
>> +	spin_unlock_irq(&efw->lock);
> 
> Hrm, I'm afraid that it still doesn't work properly when accessed
> concurrently.  In your code, efw->pull_ptr isn't updated until the end
> of the loop, while dfw->resp_queues are decremented in the loop.
> 
> Suppose resp_queues = 2, and two threads read concurrently.  What
> happens?   Both threads read from the first element only once, and
> resp_queues are decremented twice (one per each).  And now both
> threads go out of the loops, and both set the pull_ptr to the same
> next item, although the second item hasn't been processed.

Just from my overlooking.


Thanks

Takashi Sakamoto
