From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH v1 1/9] ASoC: Intel: Boards: Machine driver
 for Intel platforms
Date: Tue, 27 Feb 2018 05:12:51 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579B2AC53@BGSMSX104.gar.corp.intel.com>
References: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1519373550-2545-2-git-send-email-rakesh.a.ughreja@intel.com>
 <caa12ca2-324a-3b6b-2e60-6c67272162c8@linux.intel.com>
 <85DFEED57DC57344B2483EF7BF8CB60579B29A8C@BGSMSX104.gar.corp.intel.com>
 <aef6e261-aa47-2f29-197c-fa913c945b05@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A85B267AFC
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 06:12:57 +0100 (CET)
In-Reply-To: <aef6e261-aa47-2f29-197c-fa913c945b05@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
>Sent: Tuesday, February 27, 2018 12:41 AM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>; alsa-devel@alsa-
>project.org; broonie@kernel.org; tiwai@suse.de;
>liam.r.girdwood@linux.intel.com
>Cc: Koul, Vinod <vinod.koul@intel.com>; Patches Audio
><patches.audio@intel.com>
>Subject: Re: [alsa-devel] [PATCH v1 1/9] ASoC: Intel: Boards: Machine driver for
>Intel platforms
>
>
>>>> +	select SND_SOC_HDAC_HDMI
>>>> +	help
>>>> +	  This adds support for ASoC Onboard Codec HDA machine driver. This
>>> will
>>>> +	  create an alsa sound card for HDA Codecs.
>>>
>>> does this handle idisp as well? If yes, does this option conflict with
>>> the enablement of the other machine drivers which use the hdac_hdmi codec?
>>
>> Yes, the machine driver does handle iDisp codec. I didn't understand your
>> comment about conflict and other machine driver using the hdac_hdmi
>> codec. There is only one iDisp codec and so what is the reason for having
>> two machine drivers accessing the same codec ?
>
>thinking a bit more, all the existing machine drivers which provide
>support for HDMI/iDisp also cater to I2S codecs. Since you deal with
>HDaudio only if you haven't found a known I2S codec there is no real
>source of conflict.
>

So is it clear now ? Do I need to change anything ?

>
>>>> +/* skl_hda_digital audio interface glue - connects codec <--> CPU */
>>>> +struct snd_soc_dai_link
>skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS]
>>> = {
>>>> +
>>>> +	/* Back End DAI links */
>>>> +	{
>>>> +		.name = "iDisp1",
>>>> +		.id = 1,
>>>> +		.cpu_dai_name = "iDisp1 Pin",
>>>> +		.codec_name = "ehdaudio0D2",
>>>> +		.codec_dai_name = "intel-hdmi-hifi1",
>>>> +		.platform_name = "0000:00:1f.3",
>>>
>>> what happens if you run on a device with a different ID, e.g. APL or GLK?
>>
>> This is just a default ID. The same machine driver should work.
>> The platform name (ID) is passed from platform driver using platform_data.
>> You can see that in the later part of the code. So this name gets overwritten.
>
>i don't see the point of having a default then? It could just as well be
>"deadbeef" or not initialized to avoid storing useless strings.
>

Yes, I can make default as NULL.

>
>>>> +static const char *platform_name = "0000:00:1f.3";
>>>
>>> same comment as above, this is not constant across all devices
>>
>> Yes and its overwritten when it is received from platform driver.
>> You can see in the later part of the code.
>>
>> Copy/pasting the code here
>>
>>>> +	pdata = dev_get_drvdata(&pdev->dev);
>>>> +	if (pdata && pdata->platform) {
>>>> +		platform_name = pdata->platform;
>
>can be be a const char * then?

Since its used only within the file, I marked it as 
static const char *

>
>>>> +		for (i = 0; i < ctx->pcm_count; i++)
>>>> +			skl_hda_be_dai_links[i].platform_name =
>>> platform_name;
>
>and why do you need a static variable in the first place, wouldn't
>
>skl_hda_be_dai_links[i].platform_name = pdata->platform work just as well?

platform_name variable is used in skl_hda_add_dai_link as well.

>
>
>>>> +static const struct platform_device_id skl_hda_board_ids[] = {
>>>> +	{ .name = "skl_hda_generic" },
>>>> +	{ }
>>>> +};
>>>> +
>>>> +static struct platform_driver skl_hda_audio = {
>>>> +	.probe = skl_hda_audio_probe,
>>>> +	.driver = {
>>>> +		.name = "skl_hda_generic",
>>>> +		.pm = &snd_soc_pm_ops,
>>>> +	},
>>>> +	.id_table = skl_hda_board_ids,
>>>
>>> is this needed if you have a single id?
>>
>> I did the way other machine drivers are doing.
>> But I think it's not needed for single ID. But I think it's this way so that
>> more IDs can be added ? So I will keep it as it is.
>
>what other IDS would you use?

I would like to use different IDs for different combination of the codecs.
e.g. HDMI Only, HDA+HDMI to begin with.

>
>>
>>>
>>>> +};
>>>> +
>>>> +module_platform_driver(skl_hda_audio)
>>>> +
>>>> +/* Module information */
>>>> +MODULE_DESCRIPTION("SKL/KBL HDA Generic Machine driver");
>>>
>>> I don't see how this handles HDAudio codecs in general, is this limited
>>> to iDISP/HDMI support?
>>
>> In this patch only the iDisp/HDMI support is added. In the later patches
>> [Patch 9/9] support for HDA codec is added.
>
>yes, but I have to go read 8 patches before finding it out... I comment
>patches one by one.

This is mentioned in the commit message.
