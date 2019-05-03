From: "Chiang, Mac" <mac.chiang@intel.com>
Subject: Re: [PATCH] ASoC: Intel: boards: kbl_da7219_max98927:
 add dai_trigger function
Date: Fri, 3 May 2019 02:50:40 +0000
Message-ID: <5B37778DAAD9B04DA049B4A421B9B3EE71E81D6F@PGSMSX112.gar.corp.intel.com>
References: <1556780786-23805-1-git-send-email-mac.chiang@intel.com>
 <9a1fd4d6-ac57-d27d-3aec-022c2c0cce12@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74872F8075A
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2019 04:50:44 +0200 (CEST)
In-Reply-To: <9a1fd4d6-ac57-d27d-3aec-022c2c0cce12@linux.intel.com>
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
Cc: "broonie@kernel.org" <broonie@kernel.org>, "Patel,
 Chintan M" <chintan.m.patel@intel.com>, "Tc, Jenny" <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

>> From: Mac Chiang <mac.chiang@intel.com>
>> 
>> amplifier feedback is not modeled as being dependent on any active 
>> output. Even when there is no playback happening, parts of the graph, 
>> specifically the IV sense->speaker protection->output remains active 
>> and this prevents the DSP from entering low-power states.
>> 
>> This patch suggest a machine driver level approach where the speaker 
>> pins are enabled/disabled dynamically depending on stream start/stop 
>> events. DPAM graph representations show the feedback loop is indeed 
>> disabled and low-power states can be reached.
>> 
>> Signed-off-by: Jenny TC <jenny.tc@intel.com>
>> Signed-off-by: Harshapriya.n <harshapriya.n@intel.com>
>> Signed-off-by: Mac Chiang <mac.chiang@intel.com>

> I am confused here.

> There was a first patch sent on March 1, then updates posted by Jenny TC with a v3 that I acked on March 8, but there's also a v4 on April 1.

> So is this the same as v4? if yes why did you drop the change log or not add a note it's a resend? If no, what has changed?

Yes, it's the same as v4. I pick up it directly and should notice the change log missing. Sorry for spam this, I just resend it[patch resend] with change log manually.

>> ---
>>   sound/soc/intel/boards/kbl_da7219_max98927.c | 73 +++++++++++++++++++++++++++-
>>   1 file changed, 71 insertions(+), 2 deletions(-)
>> 
>> diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c 
>> b/sound/soc/intel/boards/kbl_da7219_max98927.c
>> index f72a7bf..1efe7fd 100644
>> --- a/sound/soc/intel/boards/kbl_da7219_max98927.c
>> +++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
>> @@ -219,8 +219,60 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
>>   	return 0;
>>   }
>>   
>> +static int kabylake_ssp0_trigger(struct snd_pcm_substream *substream, 
>> +int cmd) {
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	int j, ret;
>> +
>> +	for (j = 0; j < rtd->num_codecs; j++) {
>> +		struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
>> +		const char *name = codec_dai->component->name;
>> +		struct snd_soc_component *component = codec_dai->component;
>> +		struct snd_soc_dapm_context *dapm =
>> +				snd_soc_component_get_dapm(component);
>> +		char pin_name[20];
>> +
>> +		if (strcmp(name, MAX98927_DEV0_NAME) &&
>> +			strcmp(name, MAX98927_DEV1_NAME) &&
>> +			strcmp(name, MAX98373_DEV0_NAME) &&
>> +			strcmp(name, MAX98373_DEV1_NAME))
>> +			continue;
>> +
>> +		snprintf(pin_name, ARRAY_SIZE(pin_name), "%s Spk",
>> +			codec_dai->component->name_prefix);
>> +
>> +		switch (cmd) {
>> +		case SNDRV_PCM_TRIGGER_START:
>> +		case SNDRV_PCM_TRIGGER_RESUME:
>> +		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +			ret = snd_soc_dapm_enable_pin(dapm, pin_name);
>> +			if (ret) {
>> +				dev_err(rtd->dev, "failed to enable %s: %d\n",
>> +				pin_name, ret);
>> +				return ret;
>> +			}
>> +			snd_soc_dapm_sync(dapm);
>> +			break;
>> +		case SNDRV_PCM_TRIGGER_STOP:
>> +		case SNDRV_PCM_TRIGGER_SUSPEND:
>> +		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> +			ret = snd_soc_dapm_disable_pin(dapm, pin_name);
>> +			if (ret) {
>> +				dev_err(rtd->dev, "failed to disable %s: %d\n",
>> +				pin_name, ret);
>> +				return ret;
>> +			}
>> +			snd_soc_dapm_sync(dapm);
>> +			break;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static struct snd_soc_ops kabylake_ssp0_ops = {
>>   	.hw_params = kabylake_ssp0_hw_params,
>> +	.trigger = kabylake_ssp0_trigger,
>>   };
>>   
>>   static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd, @@ 
>> -950,6 +1002,7 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
>>   {
>>   	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(card);
>>   	struct kbl_hdmi_pcm *pcm;
>> +	struct snd_soc_dapm_context *dapm = &card->dapm;
>>   	struct snd_soc_component *component = NULL;
>>   	int err, i = 0;
>>   	char jack_name[NAME_SIZE];
>> @@ -976,9 +1029,25 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
>>   	if (!component)
>>   		return -EINVAL;
>>   
>> -	return hdac_hdmi_jack_port_init(component, &card->dapm);
>>   
>> -	return 0;
>> +	err = hdac_hdmi_jack_port_init(component, &card->dapm);
>> +
>> +	if (err < 0)
>> +		return err;
>> +
>> +	err = snd_soc_dapm_disable_pin(dapm, "Left Spk");
>> +	if (err) {
>> +		dev_err(card->dev, "failed to disable Left Spk: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	err = snd_soc_dapm_disable_pin(dapm, "Right Spk");
>> +	if (err) {
>> +		dev_err(card->dev, "failed to disable Right Spk: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	return snd_soc_dapm_sync(dapm);
>>   }
>>   
>>   /* kabylake audio machine driver for SPT + DA7219 */
>> 
