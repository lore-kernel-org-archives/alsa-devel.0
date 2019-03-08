From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3] ASoC: Intel: boards:
 kbl_da7219_max98927: add dai_trigger function
Date: Fri, 8 Mar 2019 09:31:06 -0600
Message-ID: <99337b7b-ee2e-0727-2c52-1fad9c45c753@linux.intel.com>
References: <1551752535-27367-1-git-send-email-mac.chiang@intel.com>
 <1552022165-32599-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5CCCF80724
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 16:31:09 +0100 (CET)
In-Reply-To: <1552022165-32599-1-git-send-email-mac.chiang@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: mac.chiang@intel.com, alsa-devel@alsa-project.org
Cc: Harshapriya.n@intel.com, tiwai@suse.de, broonie@kernel.org, jenny.tc@intel.com
List-Id: alsa-devel@alsa-project.org


On 3/7/19 11:16 PM, mac.chiang@intel.com wrote:
> From: Mac Chiang <mac.chiang@intel.com>
>
> amplifier feedback is not modeled as being dependent on any active output.
> Even when there is no playback happening, parts of the graph, specifically the IV
> sense->speaker protection->output remains active and this prevents the DSP from
> entering low-power states.
>
> This patch suggest a machine driver level approach where the speaker
> pins are enabled/disabled dynamically depending on stream start/stop
> events. DPAM graph representations show the feedback loop is indeed
> disabled and low-power states can be reached.

I can't think of a better solution so

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


>
> Signed-off-by: Jenny TC <jenny.tc@intel.com>
> Signed-off-by: Harshapriya.n <harshapriya.n@intel.com>
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>
> ---
> Changelog:
>    v3:
>      - fixed the return logic at the end of kabylake_card_late_probe()
>    v2:
>      - described clearly in commit message
>      - added snd_soc_dapm_disable_pin in kabylake_card_late_probe()
> ---
>   sound/soc/intel/boards/kbl_da7219_max98927.c | 71 +++++++++++++++++++++++++++-
>   1 file changed, 69 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
> index 723a493..a9dcc0a 100644
> --- a/sound/soc/intel/boards/kbl_da7219_max98927.c
> +++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
> @@ -195,8 +195,58 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
>   	return 0;
>   }
>   
> +static int kabylake_ssp0_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	int j, ret;
> +
> +	for (j = 0; j < rtd->num_codecs; j++) {
> +		struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
> +		const char *name = codec_dai->component->name;
> +		struct snd_soc_component *component = codec_dai->component;
> +		struct snd_soc_dapm_context *dapm =
> +				snd_soc_component_get_dapm(component);
> +		char pin_name[20];
> +
> +		if (strcmp(name, MAXIM_DEV0_NAME) &&
> +			strcmp(name, MAXIM_DEV1_NAME))
> +			continue;
> +
> +		snprintf(pin_name, ARRAY_SIZE(pin_name), "%s Spk",
> +			codec_dai->component->name_prefix);
> +
> +		switch (cmd) {
> +		case SNDRV_PCM_TRIGGER_START:
> +		case SNDRV_PCM_TRIGGER_RESUME:
> +		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +			ret = snd_soc_dapm_enable_pin(dapm, pin_name);
> +			if (ret) {
> +				dev_err(rtd->dev, "failed to enable %s: %d\n",
> +				pin_name, ret);
> +				return ret;
> +			}
> +			snd_soc_dapm_sync(dapm);
> +			break;
> +		case SNDRV_PCM_TRIGGER_STOP:
> +		case SNDRV_PCM_TRIGGER_SUSPEND:
> +		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +			ret = snd_soc_dapm_disable_pin(dapm, pin_name);
> +			if (ret) {
> +				dev_err(rtd->dev, "failed to disable %s: %d\n",
> +				pin_name, ret);
> +				return ret;
> +			}
> +			snd_soc_dapm_sync(dapm);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static struct snd_soc_ops kabylake_ssp0_ops = {
>   	.hw_params = kabylake_ssp0_hw_params,
> +	.trigger = kabylake_ssp0_trigger,
>   };
>   
>   static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
> @@ -864,6 +914,7 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
>   {
>   	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(card);
>   	struct kbl_hdmi_pcm *pcm;
> +	struct snd_soc_dapm_context *dapm = &card->dapm;
>   	struct snd_soc_component *component = NULL;
>   	int err, i = 0;
>   	char jack_name[NAME_SIZE];
> @@ -890,9 +941,25 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
>   	if (!component)
>   		return -EINVAL;
>   
> -	return hdac_hdmi_jack_port_init(component, &card->dapm);
>   
> -	return 0;
> +	err = hdac_hdmi_jack_port_init(component, &card->dapm);
> +
> +	if (err < 0)
> +		return err;
> +
> +	err = snd_soc_dapm_disable_pin(dapm, "Left Spk");
> +	if (err) {
> +		dev_err(card->dev, "failed to disable Left Spk: %d\n", err);
> +		return err;
> +	}
> +
> +	err = snd_soc_dapm_disable_pin(dapm, "Right Spk");
> +	if (err) {
> +		dev_err(card->dev, "failed to disable Right Spk: %d\n", err);
> +		return err;
> +	}
> +
> +	return snd_soc_dapm_sync(dapm);
>   }
>   
>   /* kabylake audio machine driver for SPT + DA7219 */
