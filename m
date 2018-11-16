From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: dmic: introduce mode switch delay
Date: Fri, 16 Nov 2018 08:20:04 -0600
Message-ID: <2be3f98b-dc65-4a46-44f6-5dbbf1cdb0a2@linux.intel.com>
References: <1542366609-18861-1-git-send-email-jenny.tc@intel.com>
 <1542366609-18861-2-git-send-email-jenny.tc@intel.com>
 <23d2b1d4-b8c8-9af0-4eb8-3f42a77929bb@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 93F30267949
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2018 15:20:07 +0100 (CET)
In-Reply-To: <23d2b1d4-b8c8-9af0-4eb8-3f42a77929bb@perex.cz>
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
To: Jaroslav Kysela <perex@perex.cz>, Jenny TC <jenny.tc@intel.com>, alsa-devel@alsa-project.org
Cc: Jairaj Arava <jairaj.arava@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harshapriya N <harshapriya.n@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org


On 11/16/18 7:29 AM, Jaroslav Kysela wrote:
> Dne 16.11.2018 v 12:10 Jenny TC napsal(a):
>> On startup, applications such as PulseAudio or CRAS enable playback or
>> capture on all PCM devices to verify that configurations are correct,
>> and close them immediately. For DMICs, this can result in the clock
>> being turned off very quickly, which may not compatible with internal
>> state machine transition requirements.
>>
>> This patch add a mode-switch delay which will prevent the clock from
>> being turned off without complying with manufacturer timing
>> specifications. While the DMIC clock may be controlled at a lower level,
>> be it with hardware or firmware, applying the delay during the
>> STOP_TRIGGER phase ensures that there is no race condition, e.g. with
>> the hardware/firmware turning off the clock earlier
>>
>> Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
>> Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
>> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
>> ---
>>   sound/soc/codecs/dmic.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
>> index 8c4926d..0527bc2 100644
>> --- a/sound/soc/codecs/dmic.c
>> +++ b/sound/soc/codecs/dmic.c
>> @@ -30,9 +30,35 @@
>>   #include <sound/soc.h>
>>   #include <sound/soc-dapm.h>
>>   
>> +static int modeswitch_delay_ms;
>> +module_param(modeswitch_delay_ms, uint, 0644);
>> +
>>   struct dmic {
>>   	struct gpio_desc *gpio_en;
>>   	int wakeup_delay;
>> +	/* Delay after DMIC mode switch */
>> +	int modeswitch_delay_ms;
>> +};
>> +
>> +int dmic_daiops_trigger(struct snd_pcm_substream *substream,
>> +		int cmd, struct snd_soc_dai *dai)
>> +{
>> +	struct snd_soc_component *component = dai->component;
>> +	struct dmic *dmic = snd_soc_component_get_drvdata(component);
>> +
>> +	switch (cmd) {
>> +	case SNDRV_PCM_TRIGGER_STOP:
>> +		if (dmic->modeswitch_delay_ms)
>> +			mdelay(dmic->modeswitch_delay_ms);
>> +
>> +		break;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct snd_soc_dai_ops dmic_dai_ops = {
>> +	.trigger	= dmic_daiops_trigger,
>>   };
>>   
>>   static int dmic_aif_event(struct snd_soc_dapm_widget *w,
>> @@ -68,6 +94,7 @@ static int dmic_aif_event(struct snd_soc_dapm_widget *w,
>>   			| SNDRV_PCM_FMTBIT_S24_LE
>>   			| SNDRV_PCM_FMTBIT_S16_LE,
>>   	},
>> +	.ops    = &dmic_dai_ops,
>>   };
>>   
>>   static int dmic_component_probe(struct snd_soc_component *component)
>> @@ -85,6 +112,10 @@ static int dmic_component_probe(struct snd_soc_component *component)
>>   
>>   	device_property_read_u32(component->dev, "wakeup-delay-ms",
>>   				 &dmic->wakeup_delay);
>> +	device_property_read_u32(component->dev, "modeswitch_delay_ms",
>> +				 &dmic->modeswitch_delay_ms);
> This should be probably consistent with the previous property name. Use
> "modeswitch-delay-ms".

Indeed. I'd go even further in the nitpicks department and only use the 
the -ms suffix in the property and use a modeswitch_delay field and 
parameter for naming consistency with the existing wake_delay.

The patches look good otherwise, it's a useful patch to add. Jenny, can 
you do this cosmetic fix and resubmit?

>
>> +	if (modeswitch_delay_ms)
>> +		dmic->modeswitch_delay_ms  = modeswitch_delay_ms;
>>   
>>   	snd_soc_component_set_drvdata(component, dmic);
>>   
>>
> 					Jaroslav
>
