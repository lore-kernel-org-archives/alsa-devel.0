From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 1/2] ALSA: fireworks: accessing to user space outside
 spinlock
Date: Tue, 30 Aug 2016 15:27:34 +0900
Message-ID: <87689314-7c37-0477-2b7e-8f870f4d6e44@sakamocchi.jp>
References: <1472511695-29316-1-git-send-email-o-takashi@sakamocchi.jp>
 <1472511695-29316-2-git-send-email-o-takashi@sakamocchi.jp>
 <s5ha8fu4yv7.wl-tiwai@suse.de> <57C52288.4010502@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <57C52288.4010502@oracle.com>
Sender: stable-owner@vger.kernel.org
To: Vaishali Thakkar <vaishali.thakkar@oracle.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, stable@vger.kernel.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Aug 30 2016 15:07, Vaishali Thakkar wrote:
>>> diff --git a/sound/firewire/fireworks/fireworks_hwdep.c b/sound/firewire/fireworks/fireworks_hwdep.c
>>> index 33df865..8ed4b29 100644
>>> --- a/sound/firewire/fireworks/fireworks_hwdep.c
>>> +++ b/sound/firewire/fireworks/fireworks_hwdep.c
>>> @@ -38,6 +38,7 @@ hwdep_read_resp_buf(struct snd_efw *efw, char __user *buf, long remained,
>>>  	buf += sizeof(type);
>>>
>>>  	/* write into buffer as many responses as possible */
>>> +	spin_lock_irq(&efw->lock);
>>>  	while (efw->resp_queues > 0) {
>>>  		t = (struct snd_efw_transaction *)(efw->pull_ptr);
>>>  		length = be32_to_cpu(t->length) * sizeof(__be32);
>>> @@ -52,9 +53,13 @@ hwdep_read_resp_buf(struct snd_efw *efw, char __user *buf, long remained,
>>>  				(unsigned int)(efw->pull_ptr - efw->resp_buf);
>>>  			till_end = min_t(unsigned int, length, till_end);
>>>
>>> +			spin_unlock_irq(&efw->lock);
>>> +
>>>  			if (copy_to_user(buf, efw->pull_ptr, till_end))
>>>  				return -EFAULT;
>>>
>>> +			spin_lock_irq(&efw->lock);
>>> +
>>>  			efw->pull_ptr += till_end;
>>
>> Strictly speaking, this is still racy.  efw->pull_ptr is accessed
>> outside the spinlock, and it can be modified while copy_to_user() is
>> being processed.
>
> Should disabling pagefaults while interacting with user space work here?

Instead, assignment efw->pull_ptr to automatic variable in the spin 
lock, then use it to copy_to_user(). The pointer is in ring buffer and 
moves when receiving replies from actual devices, thus it's still valid 
as long as an application sent transactions in order.
(One application is allowed to use this interface in a time.)

Not the best, but better with less complexities, I think.


Regards

Takashi Sakamoto
