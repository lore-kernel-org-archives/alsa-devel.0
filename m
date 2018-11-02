From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: dmic: Introduce mode switch delay
Date: Fri, 2 Nov 2018 09:34:37 -0500
Message-ID: <d4c0718d-b931-6dfb-6c27-2e75d437bea7@linux.intel.com>
References: <1541143847-30450-1-git-send-email-jenny.tc@intel.com>
 <1541143847-30450-2-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id B37332675BA
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2018 15:34:41 +0100 (CET)
In-Reply-To: <1541143847-30450-2-git-send-email-jenny.tc@intel.com>
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
Cc: Jairaj Arava <jairaj.arava@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harshapriya N <harshapriya.n@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org


On 11/2/18 2:30 AM, Jenny TC wrote:
> Some DMICs require a delay as defined in the DMIC data sheet to complete
> DMIC mode transitions. DMIC may enter a bad state if the clock is stopped
> before successful mode transition. To handle this, a delay is introduced
> in the STOP STREAM to ensure the clock is running for the mode switch delay
> duration. A module parameter is introduced to pass the delay as a module
> parameter.

Sorry, I am still not clear on the effect of the delay on a TRIGGER_STOP 
since the clock is managed at a different level - by the DSP firmware to 
be precise. In the absence of a command to tell the DMIC a mode switch 
is going to happen, the only thing that the dmic observes is the clock, 
and whether you delay the stop or not isn't going to result in a 
stimulus that can be used to change modes.

There's been multiple emails on this and there is no clear explanation 
on the results of the delay..I would suggest describing the requirement 
with more information to understand how this delay helps with 
conformance, in 'as measured by' terms.

While I am at it, if we use module parameters we might as well use them 
for all parameters, including the wakeup_delay, so that the information 
can be passed by either of device_property or module parameters in all 
cases.

>
> Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
> Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
> ---
>   sound/soc/codecs/dmic.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
> diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
> index 8c4926d..0527bc2 100644
> --- a/sound/soc/codecs/dmic.c
> +++ b/sound/soc/codecs/dmic.c
> @@ -30,9 +30,35 @@
>   #include <sound/soc.h>
>   #include <sound/soc-dapm.h>
>   
> +static int modeswitch_delay_ms;
> +module_param(modeswitch_delay_ms, uint, 0644);
> +
>   struct dmic {
>   	struct gpio_desc *gpio_en;
>   	int wakeup_delay;
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
>   };
>   
>   static int dmic_aif_event(struct snd_soc_dapm_widget *w,
> @@ -68,6 +94,7 @@ static int dmic_aif_event(struct snd_soc_dapm_widget *w,
>   			| SNDRV_PCM_FMTBIT_S24_LE
>   			| SNDRV_PCM_FMTBIT_S16_LE,
>   	},
> +	.ops    = &dmic_dai_ops,
>   };
>   
>   static int dmic_component_probe(struct snd_soc_component *component)
> @@ -85,6 +112,10 @@ static int dmic_component_probe(struct snd_soc_component *component)
>   
>   	device_property_read_u32(component->dev, "wakeup-delay-ms",
>   				 &dmic->wakeup_delay);
> +	device_property_read_u32(component->dev, "modeswitch_delay_ms",
> +				 &dmic->modeswitch_delay_ms);
> +	if (modeswitch_delay_ms)
> +		dmic->modeswitch_delay_ms  = modeswitch_delay_ms;
>   
>   	snd_soc_component_set_drvdata(component, dmic);
>   
