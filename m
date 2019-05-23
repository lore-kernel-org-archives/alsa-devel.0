From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] soundwire: stream: fix bad unlock balance
Date: Thu, 23 May 2019 09:43:14 +0100
Message-ID: <2dc66f9d-e508-d457-a7d6-c06c4336e7b8@linaro.org>
References: <20190522162528.5892-1-srinivas.kandagatla@linaro.org>
 <4744834c-36b1-dd8d-45fa-76c75eb3d5cb@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4744834c-36b1-dd8d-45fa-76c75eb3d5cb@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org
Cc: sanyog.r.kale@intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 22/05/2019 17:41, Pierre-Louis Bossart wrote:
> 
> 
> On 5/22/19 11:25 AM, Srinivas Kandagatla wrote:
>> This patch fixes below warning due to unlocking without locking.
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
>> index 544925ff0b40..d16268f30e4f 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -814,7 +814,8 @@ static int do_bank_switch(struct 
>> sdw_stream_runtime *stream)
>>               goto error;
>>           }
>> -        mutex_unlock(&bus->msg_lock);
>> +        if (mutex_is_locked(&bus->msg_lock))
>> +            utex_unlock(&bus->msg_lock);
> 
> Does this even compile? should be mutex_unlock, no?
> 
> We also may want to identify the issue in more details without pushing 
> it under the rug. The locking mechanism is far from simple and it's 
> likely there are a number of problems with it.
> 
msg_lock is taken conditionally during multi link bank switch cases, 
however the unlock is done unconditionally leading to this warning.

Having a closer look show that there could be a dead lock in this path 
while executing sdw_transfer(). And infact there is no need to take 
msg_lock in  multi link switch cases as sdw_transfer should take care of 
this.

Vinod/Sanyog any reason why msg_lock is really required in this path?

--srini

>>       }
>>       return ret;
>>
