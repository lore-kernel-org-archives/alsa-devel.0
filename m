From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH v1 9/9] ASoC: Intel: Boards: add support
 for HDA codecs
Date: Tue, 27 Feb 2018 16:20:05 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579B2B1C8@BGSMSX104.gar.corp.intel.com>
References: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1519373550-2545-10-git-send-email-rakesh.a.ughreja@intel.com>
 <2536565b-4783-0829-536e-ee24e435c041@linux.intel.com>
 <85DFEED57DC57344B2483EF7BF8CB60579B2A59B@BGSMSX104.gar.corp.intel.com>
 <9bcab530-3517-5a27-7a49-65af8aff6ba5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id ED6C22676A9
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 17:20:09 +0100 (CET)
In-Reply-To: <9bcab530-3517-5a27-7a49-65af8aff6ba5@linux.intel.com>
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
>Sent: Tuesday, February 27, 2018 1:07 AM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>; alsa-devel@alsa-
>project.org; broonie@kernel.org; tiwai@suse.de;
>liam.r.girdwood@linux.intel.com
>Cc: Koul, Vinod <vinod.koul@intel.com>; Patches Audio
><patches.audio@intel.com>
>Subject: Re: [alsa-devel] [PATCH v1 9/9] ASoC: Intel: Boards: add support for HDA
>codecs
>
>
>>>> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
>>>> index ceb105c..d44cf1e 100644
>>>> --- a/sound/soc/intel/Kconfig
>>>> +++ b/sound/soc/intel/Kconfig
>>>> @@ -107,6 +107,7 @@ config SND_SOC_INTEL_SKYLAKE
>>>>    	select SND_HDA_DSP_LOADER
>>>>    	select SND_SOC_TOPOLOGY
>>>>    	select SND_SOC_INTEL_SST
>>>> +	select SND_SOC_HDAC_HDA if
>>> SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
>>>
>>> This looks odd, it beats the purpose of the clean split between platform
>>> and machine Kconfig added in 2017. You should select SND_SOC_HDAC_HDA
>in
>>> the config for SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
>>
>> If I move into the machine driver Kconfig, then it will be loaded after
>> the SKL platform driver loads and so symbol dependency will create an issue.
>>
>> hdac_hda needs to be loaded before the SKL driver, so that it can
>> get the ops from library. So I will have to load it manually in the platform
>> driver code. Let me try that, if it does not work, I will come back on this
>> topic.
>
>I don't believe the Kconfig selection has any bearing on how the codecs
>are loaded. In fact the existing I2S-based machine drivers are a
>counter-example, the machine drivers depend on a codec driver in
>Kconfig, but the latter needs to be loaded first so that the machine
>driver finds the relevant DAIs.

Let me come back on this after trying out few things.

>
>>>> +static const struct snd_kcontrol_new skl_hda_controls[] = {
>>>> +	SOC_DAPM_PIN_SWITCH("Headphone"),
>>>> +	SOC_DAPM_PIN_SWITCH("Headset Mic"),
>>>> +};
>>>> +
>>>> +static const struct snd_soc_dapm_widget skl_hda_widgets[] = {
>>>> +	SND_SOC_DAPM_HP("Headphone", NULL),
>>>> +	SND_SOC_DAPM_MIC("Headset Mic", NULL),
>>>> +	SND_SOC_DAPM_SPK("Codec Speaker", NULL),
>>>> +	SND_SOC_DAPM_MIC("Codec Mic", NULL),
>>>> +};
>>>
>>> what about all the other outputs, e.g. line out? And how does this work
>>> with pin retasking?
>>
>> Good point.
>>
>> The hdac_hda is just a wrapper around the legacy codec driver
>> and so it relies on the functionality of the legacy HDA codec driver
>> for all the functionality including pin re-tasking.
>>
>> The widget names that you see above is just to complete the
>> DAPM route. Based on your comment I am planning to rename it as
>> following
>>
>> Analog In Endpoint
>> Analog Output Endpoint
>> Digital In Endpoint
>> Digital Out Endpoint
>>
>> and will connect it to the Codec Pins.
>>
>> Also I think it makes sense to rename the codec Pin names accordingly
>>
>> Codec Analog Input Pin
>> Codec Analog Output Pin
>> Codec Digital Input Pin
>> Codec Digital Output Pin
>
>Humm, what if you have more than one analog input? It's almost as if
>this list should be created dynamically based on what is exposed by the
>codec, I don't see how a static list will cover all configurations.

If it is really required it can be done, the codec->pcm_list_head has got
entries stored.

But I am not sure what is the behavior of the legacy HDA codec driver
when it sees more than one Analog inputs.

Takashi, will I see two Analog entries in the pcm_list_head ?

>
>
>>>> +	err = snd_hdac_ext_bus_device_init(bus, addr, hdev);
>>>> +	if (err < 0)
>>>> +		return err;
>>>> +
>>>> +	if ((res & 0xFFFF0000) != 0x80860000)
>>>> +		hdev->type = HDA_DEV_LEGACY;
>>>
>>> I don't get what this test does?
>>
>> I am using the legacy HDA codec drivers only for the HDA codecs.
>> For iDisp I will continue to use the ASoC hdac_hdmi driver, which
>> is using ASOC BUS.
>>
>> To make it more clear I will convert the if condition into inline
>> function with proper name.
>
>As written in my previous email, this is fine for now but long term we'd
>want to avoid having duplication of functionality. Fixing issues in two
>locations is not efficient, I vote to deprecate hdac_hdmi at some point.

I have no objection. But that work won't be part of this patch series.

Regards,
Rakesh
