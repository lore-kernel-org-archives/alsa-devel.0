From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: Intel: Haswell: Remove set but
 not used variable 'stage_type'
Date: Wed, 17 Apr 2019 12:41:52 -0500
Message-ID: <ba043cd7-07af-717f-7498-d6bda7d6b79e@linux.intel.com>
References: <20190417151140.20320-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417151140.20320-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yue Haibing <yuehaibing@huawei.com>, liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 4/17/19 10:11 AM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> sound/soc/intel/haswell/sst-haswell-ipc.c: In function 'hsw_stream_message':
> sound/soc/intel/haswell/sst-haswell-ipc.c:669:29: warning: variable 'stage_type' set but not used [-Wunused-but-set-variable]
> 
> It is never used since introduction in
> commit ba57f68235cf ("ASoC: Intel: create haswell folder and move haswell platform files in")

Thanks for the patch.

I think you could go further in the cleanup and remove both the variable 
declaration and the static inline mst_get_stage_type that will also be 
useless as a consequence of this assignment removal.

Care to send a v2?

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   sound/soc/intel/haswell/sst-haswell-ipc.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
> index 31fcdf12..4d3de99 100644
> --- a/sound/soc/intel/haswell/sst-haswell-ipc.c
> +++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
> @@ -672,7 +672,6 @@ static int hsw_stream_message(struct sst_hsw *hsw, u32 header)
>   
>   	stream_msg = msg_get_stream_type(header);
>   	stream_id = msg_get_stream_id(header);
> -	stage_type = msg_get_stage_type(header);
>   
>   	stream = get_stream_by_id(hsw, stream_id);
>   	if (stream == NULL)
> 
