From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v4 3/4] ASoC: dapm: support mixer controls with mute at
 non-zero value
Date: Tue, 28 Jun 2016 10:12:37 +0200
Message-ID: <7780cb9b-9d46-7cbb-501e-10a154ccc527@axentia.se>
References: <1463260181-21344-1-git-send-email-peda@axentia.se>
 <1463260181-21344-4-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463260181-21344-4-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Pawel Moll <pawel.moll@arm.com>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Misbah Ullah Khan <Misbahk@danlawinc.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

Sorry to send a ping like this, with the patch still in patchwork
and all. But it's been a month since 1/4 and 2/4 were committed
and I expected at least some comment on the approach for patches
3 and 4...

Cheers,
Peter

On 2016-05-14 23:09, Peter Rosin wrote:
> The max9860 codec has a mixer control field that has its mute/disable at
> the wrong end of the scale. I.e. you turn the volume up and up, and then
> as the final step the volume is off. This does not sit well with DAPM,
> which assumes the mute/off is at the minimum value.
> 
> Add support for such backwards controls with code that searches TLV ranges
> for the mute value and use that as trigger for DAPM off.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  sound/soc/soc-dapm.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index c4464858bf01..8a1131781339 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -42,6 +42,7 @@
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
>  #include <sound/initval.h>
> +#include <sound/tlv.h>
>  
>  #include <trace/events/asoc.h>
>  
> @@ -722,16 +723,46 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
>  	return -ENODEV;
>  }
>  
> +static int dapm_find_tlv_mute(const unsigned int *tlv)
> +{
> +	int cnt;
> +	const unsigned int *range;
> +
> +	if (!tlv || tlv[0] != SNDRV_CTL_TLVT_DB_RANGE)
> +		return 0;
> +
> +	cnt = tlv[1] / sizeof(unsigned int);
> +
> +	/*
> +	 * Each group of six values should be
> +	 * { start end type len min step/mute }
> +	 */
> +	for (range = &tlv[2]; cnt >= 6; cnt -= 6, range += 6) {
> +		if (range[2] != SNDRV_CTL_TLVT_DB_SCALE)
> +			return 0; /* wrong type, terminate */
> +		if (range[3] != 2 * sizeof(unsigned int))
> +			return 0; /* wrong len, terminate */
> +		if (!(range[5] & TLV_DB_SCALE_MUTE))
> +			continue; /* no mute in this range */
> +		return range[0]; /* start of this range is the mute value */
> +	}
> +
> +	return 0;
> +}
> +
>  /* set up initial codec paths */
>  static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
>  {
> +	const struct snd_kcontrol_new *kcontrol_new
> +		= &p->sink->kcontrol_news[i];
>  	struct soc_mixer_control *mc = (struct soc_mixer_control *)
> -		p->sink->kcontrol_news[i].private_value;
> +		kcontrol_new->private_value;
>  	unsigned int reg = mc->reg;
>  	unsigned int shift = mc->shift;
>  	unsigned int max = mc->max;
>  	unsigned int mask = (1 << fls(max)) - 1;
>  	unsigned int invert = mc->invert;
> +	int mute_value = dapm_find_tlv_mute(kcontrol_new->tlv.p);
>  	unsigned int val;
>  
>  	if (reg != SND_SOC_NOPM) {
> @@ -739,7 +770,7 @@ static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
>  		val = (val >> shift) & mask;
>  		if (invert)
>  			val = max - val;
> -		p->connect = !!val;
> +		p->connect = val != mute_value;
>  	} else {
>  		p->connect = 0;
>  	}
> @@ -3045,6 +3076,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
>  	int max = mc->max;
>  	unsigned int mask = (1 << fls(max)) - 1;
>  	unsigned int invert = mc->invert;
> +	int mute_value = dapm_find_tlv_mute(kcontrol->tlv.p);
>  	unsigned int val;
>  	int connect, change, reg_change = 0;
>  	struct snd_soc_dapm_update update;
> @@ -3056,7 +3088,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
>  			 kcontrol->id.name);
>  
>  	val = (ucontrol->value.integer.value[0] & mask);
> -	connect = !!val;
> +	connect = val != mute_value;
>  
>  	if (invert)
>  		val = max - val;
> 
