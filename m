From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH v2] soundwire: stream: fix bad unlock balance
Date: Thu, 6 Jun 2019 15:58:33 +0100
Message-ID: <f13c82d2-94a4-9517-bcf6-95aa40c6a42f@linaro.org>
References: <20190606112222.16502-1-srinivas.kandagatla@linaro.org>
 <9427a73a-e09a-4a9c-7690-271d2e2e1024@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9427a73a-e09a-4a9c-7690-271d2e2e1024@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 06/06/2019 15:28, Pierre-Louis Bossart wrote:
> On 6/6/19 6:22 AM, Srinivas Kandagatla wrote:
>> multi bank switching code takes lock on condition but releases without
>> any check resulting in below warning.
>> This patch fixes this.
> 
> 
> Question to make sure we are talking about the same thing: multi-link 
> bank switching is a capability beyond the scope of the SoundWire spec 
> which requires hardware support to synchronize links and as Sanyog 
> hinted at in a previous email follow a different flow for bank switches.
> 
> You would not use the multi-link mode if you have different links that 
> can operate independently and have no synchronization requirement. You 
> would conversely use the multi-link mode if you have two devices on the 
> same type on different links and want audio to be rendered at the same 
> time.
> 
> Can you clarify if indeed you were using the full-blown multi-link mode 
> with hardware synchronization or a regular single-link operation? I am 
> not asking for details of your test hardware, just trying to reconstruct 
> the program flow leading to this problem.
> 

Am testing on a regular single link, which hits this path.

> It could also be that your commit message was meant to say:
> "the msg lock is taken for multi-link cases only but released 
> unconditionally, leading to an unlock balance warning for single-link 
> usages"?
Yes.
Vinod can update comment while applying this patch?
If not I can respin with correct log.

thanks,
srini

> 
> Thanks!
> 
>>
>>   =====================================
>>   WARNING: bad unlock balance detected!
>>   5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G        W
>>   -------------------------------------
>>   aplay/2954 is trying to release lock (&bus->msg_lock) at:
>>   do_bank_switch+0x21c/0x480
>>   but there are no more locks to release!
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/stream.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>> index ce9cb7fa4724..73c52cd4fec8 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -814,7 +814,8 @@ static int do_bank_switch(struct 
>> sdw_stream_runtime *stream)
>>               goto error;
>>           }
>> -        mutex_unlock(&bus->msg_lock);
>> +        if (bus->multi_link)
>> +            mutex_unlock(&bus->msg_lock);
>>       }
>>       return ret;
>>
> 
