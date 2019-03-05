From: "Chiang, Mac" <mac.chiang@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: boards:
 kbl_da7219_max98927: add dai_trigger function
Date: Tue, 5 Mar 2019 05:42:13 +0000
Message-ID: <5B37778DAAD9B04DA049B4A421B9B3EE71E4EA86@PGSMSX111.gar.corp.intel.com>
References: <1551460451-24540-1-git-send-email-mac.chiang@intel.com>
 <1551752535-27367-1-git-send-email-mac.chiang@intel.com>
 <f4e39672-3d66-bf3b-faca-b89053e52c78@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70F2DF806F7
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2019 06:42:23 +0100 (CET)
In-Reply-To: <f4e39672-3d66-bf3b-faca-b89053e52c78@linux.intel.com>
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
Cc: "N, Harshapriya" <harshapriya.n@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "Tc, Jenny" <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

>>   
>>   static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd, @@ 
>> -864,6 +914,7 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
>>   {
>>   	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(card);
>>   	struct kbl_hdmi_pcm *pcm;
>> +	struct snd_soc_dapm_context *dapm = &card->dapm;
>>   	struct snd_soc_component *component = NULL;
>>   	int err, i = 0;
>>   	char jack_name[NAME_SIZE];
>> @@ -890,9 +941,25 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
>>   	if (!component)
>>   		return -EINVAL;
>>   
>> +
>>   	return hdac_hdmi_jack_port_init(component, &card->dapm);
>>
>That part looks quite broken. You have functional code after the unconditional return above for the jack init.
>
>This is not a diff illusion, I applied this patch and looked at the diff with emacs and I don't know how this could possibly work.

>The code prior to this patch was also weird with 2 returns at the end of
>kabylake_card_late_probe()

>My take is that this has never been tested against Mark's branch but ported without tests from the Chrome tree.

I'm missing one line change as below. So there is only one return in kabylake_card_late_probe() as prior one. I've tested and verified it on Chrome tree.
   	error = hdac_hdmi_jack_port_init(component, &card->dapm);

>>   
>> -	return 0;
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
