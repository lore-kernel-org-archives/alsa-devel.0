From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ASoC: cAVS: add device_link to HDMI audio
Date: Mon, 8 Apr 2019 13:34:43 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19528165F4@SHSMSX103.ccr.corp.intel.com>
References: <1554686513-7770-1-git-send-email-libin.yang@intel.com>
 <70a4cd39-bf42-6c2c-6b3f-ffc343b016d1@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51D4BF89618
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2019 15:34:57 +0200 (CEST)
In-Reply-To: <70a4cd39-bf42-6c2c-6b3f-ffc343b016d1@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

>-----Original Message-----
>From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
>Sent: Monday, April 8, 2019 9:15 PM
>To: Yang, Libin <libin.yang@intel.com>; alsa-devel@alsa-project.org;
>tiwai@suse.de; broonie@kernel.org
>Subject: Re: [alsa-devel] [PATCH] ASoC: cAVS: add device_link to HDMI audio
>
>
>
>On 4/7/19 8:21 PM, libin.yang@intel.com wrote:
>> From: Libin Yang <libin.yang@intel.com>
>>
>> In resume from S3, HDAC HDMI codec driver dapm event callback may be
>> operated before HDMI codec driver turns on the display audio power
>> domain because of the contest between display driver and hdmi codec
>driver.
>>
>> This patch adds the device_link between cAVS generic machine device
>> (consumer) and hdmi codec device (supplier) to make sure the sequence
>> is always correct.
>>
>> Signed-off-by: Libin Yang <libin.yang@intel.com>
>> ---
>>   sound/soc/intel/boards/skl_hda_dsp_common.c  | 15 +++++++++++++++
>>   sound/soc/intel/boards/skl_hda_dsp_common.h  |  1 +
>>   sound/soc/intel/boards/skl_hda_dsp_generic.c | 12 ++++++++++++
>
>It's Monday morning and I have mixed feelings about this fix.
>
>0. What does 'resume from S3' mean? from the description it looks like the
>application was playing already before entering S3? I am ready to bet it's a use
>case that was never tested in the past given that Chromebooks tend to stop all
>streams before entering S3...

Yes, this patch is fixing the case of HDMI audio S3 with playback.
Chrome has different behavior from aplay and etc. As you described,
chrome will stop the streams when suspend and start the stream when resume.
So suspend/resume when HDMI playback in chrome will never hit this bug.
And our QA test result does show chrome is OK even without this patch.

>
>1. As discussed in other threads, Takashi suggested that maybe the
>INFO_RESUME flag should be removed?  What would be the impact should we
>indeed remove this flag, is this patch still necessary?

That is another issue. Actually, our sof has 2 bugs in HDMI S3 with playback.
One is DMA link setting. The other is the bug this patch try to fix.
Another thread is used to fix the DMA link setting.

>
>2. if this is really a generic issue then shouldn't it be fixed for all users of the
>iDISP link? Why stop at the HDAudio machine driver?

I will submit other patches for other machine drivers. Which HDAudio machine 
driver do you mean?

>
>3. we already have the component model to deal with interaction between
>i915 and audio, now we are adding a second layer. That looks clunky.

The component model between i915 and audio is used to communicate
between display driver and audio driver. This patch is used to setup the
consumer and supplier relationship.

Regards,
Libin

>
>Thanks
>-Pierre
>
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.c
>> b/sound/soc/intel/boards/skl_hda_dsp_common.c
>> index 9b30c0e..01c8937 100644
>> --- a/sound/soc/intel/boards/skl_hda_dsp_common.c
>> +++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
>> @@ -17,6 +17,18 @@
>>
>>   #define NAME_SIZE	32
>>
>> +static int skl_hdmi_init(struct snd_soc_pcm_runtime *rtd) {
>> +	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(rtd->card);
>> +	struct snd_soc_dai *dai = rtd->codec_dai;
>> +
>> +	if (!ctx->link)
>> +		ctx->link = device_link_add(rtd->card->dev, dai->dev,
>> +					    DL_FLAG_RPM_ACTIVE);
>> +
>> +	return 0;
>> +}
>> +
>>   int skl_hda_hdmi_add_pcm(struct snd_soc_card *card, int device)
>>   {
>>   	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(card); @@
>> -48,6 +60,7 @@ struct snd_soc_dai_link
>skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
>>   		.cpu_dai_name = "iDisp1 Pin",
>>   		.codec_name = "ehdaudio0D2",
>>   		.codec_dai_name = "intel-hdmi-hifi1",
>> +		.init = skl_hdmi_init,
>>   		.dpcm_playback = 1,
>>   		.no_pcm = 1,
>>   		.trigger[0] = SND_SOC_DPCM_TRIGGER_POST, @@ -58,6 +71,7
>@@ struct
>> snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
>>   		.cpu_dai_name = "iDisp2 Pin",
>>   		.codec_name = "ehdaudio0D2",
>>   		.codec_dai_name = "intel-hdmi-hifi2",
>> +		.init = skl_hdmi_init,
>>   		.dpcm_playback = 1,
>>   		.no_pcm = 1,
>>   		.trigger[0] = SND_SOC_DPCM_TRIGGER_POST, @@ -68,6 +82,7
>@@ struct
>> snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
>>   		.cpu_dai_name = "iDisp3 Pin",
>>   		.codec_name = "ehdaudio0D2",
>>   		.codec_dai_name = "intel-hdmi-hifi3",
>> +		.init = skl_hdmi_init,
>>   		.dpcm_playback = 1,
>>   		.no_pcm = 1,
>>   		.trigger[0] = SND_SOC_DPCM_TRIGGER_POST, diff --git
>> a/sound/soc/intel/boards/skl_hda_dsp_common.h
>> b/sound/soc/intel/boards/skl_hda_dsp_common.h
>> index 87c50af..df5cc6b 100644
>> --- a/sound/soc/intel/boards/skl_hda_dsp_common.h
>> +++ b/sound/soc/intel/boards/skl_hda_dsp_common.h
>> @@ -29,6 +29,7 @@ struct skl_hda_private {
>>   	int pcm_count;
>>   	int dai_index;
>>   	const char *platform_name;
>> +	struct device_link *link;
>>   };
>>
>>   extern struct snd_soc_dai_link
>> skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS];
>> diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c
>> b/sound/soc/intel/boards/skl_hda_dsp_generic.c
>> index b9a21e6..ceca11e 100644
>> --- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
>> +++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
>> @@ -166,8 +166,20 @@ static int skl_hda_audio_probe(struct
>platform_device *pdev)
>>   	return devm_snd_soc_register_card(&pdev->dev, &hda_soc_card);
>>   }
>>
>> +static int skl_hda_audio_remove(struct platform_device *pdev) {
>> +	struct snd_soc_card *card = platform_get_drvdata(pdev);
>> +	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(card);
>> +
>> +	if (ctx->link)
>> +		device_link_del(ctx->link);
>> +
>> +	return 0;
>> +}
>> +
>>   static struct platform_driver skl_hda_audio = {
>>   	.probe = skl_hda_audio_probe,
>> +	.remove = skl_hda_audio_remove,
>>   	.driver = {
>>   		.name = "skl_hda_dsp_generic",
>>   		.pm = &snd_soc_pm_ops,
>>
