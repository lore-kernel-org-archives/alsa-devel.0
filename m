From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: Intel: Haswell: Remove set but
 not used variable 'stage_type'
Date: Thu, 18 Apr 2019 09:25:17 +0800
Message-ID: <48184039-4c08-ed17-c933-3b697e4aac08@huawei.com>
References: <20190417151140.20320-1-yuehaibing@huawei.com>
 <ba043cd7-07af-717f-7498-d6bda7d6b79e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ba043cd7-07af-717f-7498-d6bda7d6b79e@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2019/4/18 1:41, Pierre-Louis Bossart wrote:
> On 4/17/19 10:11 AM, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> sound/soc/intel/haswell/sst-haswell-ipc.c: In function 'hsw_stream_message':
>> sound/soc/intel/haswell/sst-haswell-ipc.c:669:29: warning: variable 'stage_type' set but not used [-Wunused-but-set-variable]
>>
>> It is never used since introduction in
>> commit ba57f68235cf ("ASoC: Intel: create haswell folder and move haswell platform files in")
> 
> Thanks for the patch.
> 
> I think you could go further in the cleanup and remove both the variable declaration and the static inline mst_get_stage_type that will also be useless as a consequence of this assignment removal.

You are right.
> 
> Care to send a v2?

Sure, will do that,thanks!
> 
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   sound/soc/intel/haswell/sst-haswell-ipc.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
>> index 31fcdf12..4d3de99 100644
>> --- a/sound/soc/intel/haswell/sst-haswell-ipc.c
>> +++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
>> @@ -672,7 +672,6 @@ static int hsw_stream_message(struct sst_hsw *hsw, u32 header)
>>         stream_msg = msg_get_stream_type(header);
>>       stream_id = msg_get_stream_id(header);
>> -    stage_type = msg_get_stage_type(header);
>>         stream = get_stream_by_id(hsw, stream_id);
>>       if (stream == NULL)
>>
> 
> 
> .
> 
