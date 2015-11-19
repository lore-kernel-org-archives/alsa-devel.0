From: Han Lu <han.lu@linux.intel.com>
Subject: Re: [PATCH 1/3] ASoC: Intel: Hsw: Move driver to use
 SND_SOC_BYTES_TLV
Date: Thu, 19 Nov 2015 14:56:47 +0800
Message-ID: <564D72AF.7060206@linux.intel.com>
References: <1447853952-6414-1-git-send-email-vinod.koul@intel.com>
 <1447853952-6414-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D2985265D91
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 07:57:17 +0100 (CET)
In-Reply-To: <1447853952-6414-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

There was no special reason for me to use SND_SOC_BYTES_EXT here. But 
will this patch
influences user space, since the parameter list of hsw_waves_param_get() 
be modified?

Regards,
Han Lu

On 11/18/2015 09:39 PM, Vinod Koul wrote:
> Haswell driver was using SND_SOC_BYTES_EXT. Since we want to
> remove this, convert it to use SND_SOC_BYTES_TLV
>
> Signed-off-by: Vinod Koul<vinod.koul@intel.com>
> Cc: Jie Yang<yang.jie@linux.intel.com>
> Cc: Liam Girdwood<lgirdwood@gmail.com>
> ---
>   sound/soc/intel/haswell/sst-haswell-pcm.c | 50 ++++++++++++++++++++++++-------
>   1 file changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
> index 1aa819c7e09b..65594dff291a 100644
> --- a/sound/soc/intel/haswell/sst-haswell-pcm.c
> +++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
> @@ -368,41 +368,71 @@ static int hsw_waves_switch_put(struct snd_kcontrol *kcontrol,
>   }
>   
>   static int hsw_waves_param_get(struct snd_kcontrol *kcontrol,
> -				struct snd_ctl_elem_value *ucontrol)
> +			unsigned int __user *data, unsigned int size)
>   {
>   	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
>   	struct hsw_priv_data *pdata = snd_soc_platform_get_drvdata(platform);
>   	struct sst_hsw *hsw = pdata->hsw;
> +	u8 *buffer;
> +	int ret;
> +
> +	buffer = kzalloc(size, GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;
>   
>   	/* return a matching line from param buffer */
> -	return sst_hsw_load_param_line(hsw, ucontrol->value.bytes.data);
> +	ret = sst_hsw_load_param_line(hsw, buffer);
> +	if (ret)
> +		goto err;
> +
> +	if (copy_to_user(data, buffer, size))
> +		ret = -EFAULT;
> +
> +err:
> +	kfree(buffer);
> +	return ret;
>   }
>   
>   static int hsw_waves_param_put(struct snd_kcontrol *kcontrol,
> -				struct snd_ctl_elem_value *ucontrol)
> +		const unsigned int __user *data, unsigned int size)
>   {
>   	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
>   	struct hsw_priv_data *pdata = snd_soc_platform_get_drvdata(platform);
>   	struct sst_hsw *hsw = pdata->hsw;
> -	int ret;
> +	int ret = 0;
>   	enum sst_hsw_module_id id = SST_HSW_MODULE_WAVES;
> -	int param_id = ucontrol->value.bytes.data[0];
> +	int param_id;
>   	int param_size = WAVES_PARAM_COUNT;
> +	u8 *buffer;
> +
> +	buffer = kzalloc(size, GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(buffer, data, size)) {
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +
> +	param_id = *buffer;
>   
>   	/* clear param buffer and reset buffer index */
>   	if (param_id == 0xFF) {
>   		sst_hsw_reset_param_buf(hsw);
> -		return 0;
> +		goto exit;
>   	}
>   
>   	/* store params into buffer */
> -	ret = sst_hsw_store_param_line(hsw, ucontrol->value.bytes.data);
> +	ret = sst_hsw_store_param_line(hsw, buffer);
>   	if (ret < 0)
> -		return ret;
> +		goto exit;
>   
>   	if (sst_hsw_is_module_active(hsw, id))
>   		ret = sst_hsw_module_set_param(hsw, id, 0, param_id,
> -				param_size, ucontrol->value.bytes.data);
> +						param_size, buffer);
> +
> +exit:
> +	kfree(buffer);
>   	return ret;
>   }
>   
> @@ -431,7 +461,7 @@ static const struct snd_kcontrol_new hsw_volume_controls[] = {
>   	SOC_SINGLE_BOOL_EXT("Waves Switch", 0,
>   		hsw_waves_switch_get, hsw_waves_switch_put),
>   	/* set parameters to module waves */
> -	SND_SOC_BYTES_EXT("Waves Set Param", WAVES_PARAM_COUNT,
> +	SND_SOC_BYTES_TLV("Waves Set Param", WAVES_PARAM_COUNT,
>   		hsw_waves_param_get, hsw_waves_param_put),
>   };
>   
