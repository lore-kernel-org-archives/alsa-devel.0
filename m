From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: mrfld: fix uninitialized
 variable access
Date: Sun, 4 Nov 2018 09:10:13 -0600
Message-ID: <f14b9bda-47d9-cb3a-b881-0a8058a0f59c@linux.intel.com>
References: <20181103212140.890081-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181103212140.890081-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 11/3/18 4:21 PM, Arnd Bergmann wrote:
> Randconfig testing revealed a very old bug, with gcc-8:
>
> sound/soc/intel/atom/sst/sst_loader.c: In function 'sst_load_fw':
> sound/soc/intel/atom/sst/sst_loader.c:357:5: error: 'fw' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    if (fw == NULL) {
>       ^
> sound/soc/intel/atom/sst/sst_loader.c:354:25: note: 'fw' was declared here
>    const struct firmware *fw;
>
> We must check the return code of request_firmware() before we look at the
> pointer result that may be uninitialized when the function fails.

yes indeed, good catch.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

>
> Fixes: 9012c9544eea ("ASoC: Intel: mrfld - Add DSP load and management")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/soc/intel/atom/sst/sst_loader.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
> index 27413ebae956..b8c456753f01 100644
> --- a/sound/soc/intel/atom/sst/sst_loader.c
> +++ b/sound/soc/intel/atom/sst/sst_loader.c
> @@ -354,14 +354,14 @@ static int sst_request_fw(struct intel_sst_drv *sst)
>   	const struct firmware *fw;
>   
>   	retval = request_firmware(&fw, sst->firmware_name, sst->dev);
> -	if (fw == NULL) {
> -		dev_err(sst->dev, "fw is returning as null\n");
> -		return -EINVAL;
> -	}
>   	if (retval) {
>   		dev_err(sst->dev, "request fw failed %d\n", retval);
>   		return retval;
>   	}
> +	if (fw == NULL) {
> +		dev_err(sst->dev, "fw is returning as null\n");
> +		return -EINVAL;
> +	}
>   	mutex_lock(&sst->sst_lock);
>   	retval = sst_cache_and_parse_fw(sst, fw);
>   	mutex_unlock(&sst->sst_lock);
