From: "Chiang, Mac" <mac.chiang@intel.com>
Subject: Re: [PATCH] ASoC: Intel: boards: kbl_da7219_max98927:
 add dai_trigger function
Date: Mon, 4 Mar 2019 02:33:05 +0000
Message-ID: <5B37778DAAD9B04DA049B4A421B9B3EE71E4E60A@PGSMSX111.gar.corp.intel.com>
References: <1551460451-24540-1-git-send-email-mac.chiang@intel.com>
 <872d7218-1d1a-af5a-7752-46da56e4121d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13A26F80736
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2019 03:33:11 +0100 (CET)
In-Reply-To: <872d7218-1d1a-af5a-7752-46da56e4121d@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "N, Harshapriya" <harshapriya.n@intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, "Tc, Jenny" <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

Sure. I'll refer your comments and submit again.


-----Original Message-----
From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com] 
Sent: Saturday, March 2, 2019 2:06 AM
To: Chiang, Mac <mac.chiang@intel.com>; alsa-devel@alsa-project.org
Cc: Tc, Jenny <jenny.tc@intel.com>; N, Harshapriya <harshapriya.n@intel.com>; Mark Brown <broonie@kernel.org>; Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ASoC: Intel: boards: kbl_da7219_max98927: add dai_trigger function


On 3/1/19 11:14 AM, mac.chiang@intel.com wrote:
> From: Mac Chiang <mac.chiang@intel.com>
>
> s0ix entry failure is root cause by default speaker/vi sense path 
> activate all the time that result in the audio IPs are not power gated(checked by pch_ip_power_gating_status).
> Adding the run time speaker control ensure playback widgets are going 
> to free and off eventually. With this func, counter works in s0ix subsequently (checked by slp_s0_residency_usc).

<rant>

If you submit a patch before internal reviews are complete, don't be surprised at the feedback. And if you don't copy maintainers this patch is going to be ignored as well.

</rant>

While the solution does solve a real issue, this commit message is probably one of the most convoluted and Intel-centric I've seen in a long time.

The issue really is that the amplifier feedback is not modeled as being dependent on any active output. Even when there is no playback happening, parts of the graph, specifically the IV sense->speaker 
protection->output remains active and this prevents the DSP from
entering low-power states.

One alternative would be to have userspace play with pins/kcontrols to 
take down the feedback loop. This is however not practical nor desirable.

A second approach would be to have a different model in the codec 
driver, however Maxim indicated that the feedback includes stuff that is 
not strictly related to playback.

This patch suggest a machine driver level approach where the speaker 
pins are enabled/disabled dynamically depending on stream start/stop 
events. DPAM graph representations show the feedback loop is indeed 
disabled and low-power states can be reached.

Can you please update the commit message and resubmit.

Thanks.

> Signed-off-by: Jenny TC <jenny.tc@intel.com>
> Signed-off-by: Harshapriya.n <harshapriya.n@intel.com>
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>
> ---
>   sound/soc/intel/boards/kbl_da7219_max98927.c | 50 ++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
>
> diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
> index 723a493..e01ca9a 100644
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
