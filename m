From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/2] ASoC: dmic: introduce mode switch delay
Date: Fri, 16 Nov 2018 14:29:09 +0100
Message-ID: <23d2b1d4-b8c8-9af0-4eb8-3f42a77929bb@perex.cz>
References: <1542366609-18861-1-git-send-email-jenny.tc@intel.com>
 <1542366609-18861-2-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id D3573267949
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2018 14:29:25 +0100 (CET)
In-Reply-To: <1542366609-18861-2-git-send-email-jenny.tc@intel.com>
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
To: Jenny TC <jenny.tc@intel.com>, alsa-devel@alsa-project.org
Cc: Jairaj Arava <jairaj.arava@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harshapriya N <harshapriya.n@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org

Dne 16.11.2018 v 12:10 Jenny TC napsal(a):
> On startup, applications such as PulseAudio or CRAS enable playback or
> capture on all PCM devices to verify that configurations are correct,
> and close them immediately. For DMICs, this can result in the clock
> being turned off very quickly, which may not compatible with internal
> state machine transition requirements.
> 
> This patch add a mode-switch delay which will prevent the clock from
> being turned off without complying with manufacturer timing
> specifications. While the DMIC clock may be controlled at a lower level,
> be it with hardware or firmware, applying the delay during the
> STOP_TRIGGER phase ensures that there is no race condition, e.g. with
> the hardware/firmware turning off the clock earlier
> 
> Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
> Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
> ---
>  sound/soc/codecs/dmic.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
> index 8c4926d..0527bc2 100644
> --- a/sound/soc/codecs/dmic.c
> +++ b/sound/soc/codecs/dmic.c
> @@ -30,9 +30,35 @@
>  #include <sound/soc.h>
>  #include <sound/soc-dapm.h>
>  
> +static int modeswitch_delay_ms;
> +module_param(modeswitch_delay_ms, uint, 0644);
> +
>  struct dmic {
>  	struct gpio_desc *gpio_en;
>  	int wakeup_delay;
> +	/* Delay after DMIC mode switch */
> +	int modeswitch_delay_ms;
> +};
> +
> +int dmic_daiops_trigger(struct snd_pcm_substream *substream,
> +		int cmd, struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct dmic *dmic = snd_soc_component_get_drvdata(component);
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_STOP:
> +		if (dmic->modeswitch_delay_ms)
> +			mdelay(dmic->modeswitch_delay_ms);
> +
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_dai_ops dmic_dai_ops = {
> +	.trigger	= dmic_daiops_trigger,
>  };
>  
>  static int dmic_aif_event(struct snd_soc_dapm_widget *w,
> @@ -68,6 +94,7 @@ static int dmic_aif_event(struct snd_soc_dapm_widget *w,
>  			| SNDRV_PCM_FMTBIT_S24_LE
>  			| SNDRV_PCM_FMTBIT_S16_LE,
>  	},
> +	.ops    = &dmic_dai_ops,
>  };
>  
>  static int dmic_component_probe(struct snd_soc_component *component)
> @@ -85,6 +112,10 @@ static int dmic_component_probe(struct snd_soc_component *component)
>  
>  	device_property_read_u32(component->dev, "wakeup-delay-ms",
>  				 &dmic->wakeup_delay);
> +	device_property_read_u32(component->dev, "modeswitch_delay_ms",
> +				 &dmic->modeswitch_delay_ms);

This should be probably consistent with the previous property name. Use
"modeswitch-delay-ms".

> +	if (modeswitch_delay_ms)
> +		dmic->modeswitch_delay_ms  = modeswitch_delay_ms;
>  
>  	snd_soc_component_set_drvdata(component, dmic);
>  
> 

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
