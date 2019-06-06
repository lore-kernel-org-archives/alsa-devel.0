From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2] soundwire: stream: fix bad unlock balance
Date: Thu, 6 Jun 2019 10:36:02 -0500
Message-ID: <43a381df-13d7-eaac-a1ae-704db5659cb9@linux.intel.com>
References: <20190606112222.16502-1-srinivas.kandagatla@linaro.org>
 <9427a73a-e09a-4a9c-7690-271d2e2e1024@linux.intel.com>
 <f13c82d2-94a4-9517-bcf6-95aa40c6a42f@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f13c82d2-94a4-9517-bcf6-95aa40c6a42f@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 6/6/19 9:58 AM, Srinivas Kandagatla wrote:
> 
> 
> On 06/06/2019 15:28, Pierre-Louis Bossart wrote:
>> On 6/6/19 6:22 AM, Srinivas Kandagatla wrote:
>>> multi bank switching code takes lock on condition but releases without
>>> any check resulting in below warning.
>>> This patch fixes this.
>>
>>
>> Question to make sure we are talking about the same thing: multi-link 
>> bank switching is a capability beyond the scope of the SoundWire spec 
>> which requires hardware support to synchronize links and as Sanyog 
>> hinted at in a previous email follow a different flow for bank switches.
>>
>> You would not use the multi-link mode if you have different links that 
>> can operate independently and have no synchronization requirement. You 
>> would conversely use the multi-link mode if you have two devices on 
>> the same type on different links and want audio to be rendered at the 
>> same time.
>>
>> Can you clarify if indeed you were using the full-blown multi-link 
>> mode with hardware synchronization or a regular single-link operation? 
>> I am not asking for details of your test hardware, just trying to 
>> reconstruct the program flow leading to this problem.
>>
> 
> Am testing on a regular single link, which hits this path.
> 
>> It could also be that your commit message was meant to say:
>> "the msg lock is taken for multi-link cases only but released 
>> unconditionally, leading to an unlock balance warning for single-link 
>> usages"?
> Yes.

Thanks for the precision. the change is legit so assuming the commit 
message is reworded to mention single link usage please feel free to 
take the following tag.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks!
