From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: hdac_hdmi: Add sampling
 frequencies constraint
Date: Tue, 7 Aug 2018 10:10:54 -0500
Message-ID: <846a7e15-ad36-3e92-35c6-d586dc708fb3@linux.intel.com>
References: <1533653765-26080-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id EC6B7267692
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 17:10:56 +0200 (CEST)
In-Reply-To: <1533653765-26080-1-git-send-email-yong.zhi@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yong Zhi <yong.zhi@intel.com>, broonie@kernel.org
Cc: harshapriya.n@intel.com, naveen.m@intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org



On 08/07/2018 09:56 AM, Yong Zhi wrote:
> Playback of 44.1Khz contents with HDMI plugged returns
> "Invalid pipe config".
>
> This patch adds rate constraint to allow user space SRC
> to do the converting.
>
> Signed-off-by: Yong Zhi <yong.zhi@intel.com>
I didn't test this personally but 44.1kHz isn't well supported with the 
firmware+iDisp/HDMI path. The code looks good to me so

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   sound/soc/codecs/hdac_hdmi.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
>
> diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> index 7b8533abf637..b222a2e91463 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -288,6 +288,38 @@ static unsigned int sad_sample_bits_lpcm(const u8 *sad)
>   	return (sad[2] & 7);
>   }
>   
> +/**
> + * sad_sample_rates_lpcm - Find supported sampling frequencies
> + *
> + * @sad: pointer to CEA_SADs entry byte 2 which details sampling frequencies
> + *	 supported according to CEA-861 EDID V3. In little endian byte order.
> + *
> + *	 bit 7: Reserved (0)
> + *	 bit 6: 192kHz
> + *	 bit 5: 176kHz
> + *	 bit 4: 96kHz
> + *	 bit 3: 88kHz
> + *	 bit 2: 48kHz
> + *	 bit 1: 44kHz
> + *	 bit 0: 32kHz
> + *
> + * Return: bitmask of supported sampling frequencies.
> + */
> +static u8 sad_sample_rates_lpcm(const u8 *sad)
> +{
> +	return (sad[1] & 0x7F);
> +}
> +
> +static const unsigned int cea_sampling_freqs[7] = {
> +	SNDRV_PCM_RATE_32000,	/* 0:  32000Hz */
> +	SNDRV_PCM_RATE_44100,	/* 1:  44100Hz */
> +	SNDRV_PCM_RATE_48000,	/* 2:  48000Hz */
> +	SNDRV_PCM_RATE_88200,	/* 3:  88200Hz */
> +	SNDRV_PCM_RATE_96000,	/* 4:  96000Hz */
> +	SNDRV_PCM_RATE_176400,	/* 5: 176400Hz */
> +	SNDRV_PCM_RATE_192000,	/* 6: 192000Hz */
> +};
> +
>   static int hdac_hdmi_eld_limit_formats(struct snd_pcm_runtime *runtime,
>   						void *eld)
>   {
> @@ -301,6 +333,8 @@ static int hdac_hdmi_eld_limit_formats(struct snd_pcm_runtime *runtime,
>   
>   	for (i = drm_eld_sad_count(eld_buf); i > 0; i--, sad += 3) {
>   		if (sad_format(sad) == 1) { /* AUDIO_CODING_TYPE_LPCM */
> +			unsigned int rates = 0;
> +			u8 sad_rates, j;
>   
>   			/*
>   			 * the controller support 20 and 24 bits in 32 bit
> @@ -308,6 +342,16 @@ static int hdac_hdmi_eld_limit_formats(struct snd_pcm_runtime *runtime,
>   			 */
>   			if (sad_sample_bits_lpcm(sad) & 0x6)
>   				formats |= SNDRV_PCM_FMTBIT_S32;
> +
> +			sad_rates = sad_sample_rates_lpcm(sad);
> +			/* Filter out 44.1, 88.2 and 176.4Khz */
> +			for (j = 0; j < 7; j += 2)
> +				if (sad_rates & BIT(j))
> +					rates |= cea_sampling_freqs[j];
> +
> +			snd_pcm_hw_constraint_mask64(runtime,
> +						     SNDRV_PCM_HW_PARAM_RATE,
> +						     rates);
>   		}
>   	}
>   
