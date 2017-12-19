From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC v3 06/11] ASoC: hdac_hda: add ASoC based
	HDA	codec driver
Date: Tue, 19 Dec 2017 17:12:03 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579ADD8AC@BGSMSX104.gar.corp.intel.com>
References: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1513337448-31685-7-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hd13ggr18.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADA90D@BGSMSX104.gar.corp.intel.com>
 <s5hvah8f0x6.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADAF8C@BGSMSX104.gar.corp.intel.com>
 <s5h4lorvxvj.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADB65F@BGSMSX104.gar.corp.intel.com>
 <85DFEED57DC57344B2483EF7BF8CB60579ADCE9A@BGSMSX104.gar.corp.intel.com>
 <s5hmv2fc5ze.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADD339@BGSMSX104.gar.corp.intel.com>
 <s5hmv2ebuay.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADD712@BGSMSX104.gar.corp.intel.com>
 <s5ha7yebsa7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F4CC2676D6
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 18:14:26 +0100 (CET)
In-Reply-To: <s5ha7yebsa7.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Tuesday, December 19, 2017 9:54 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; Koul, Vinod <vinod.koul@intel.com>; pierre-
>louis.bossart@linux.intel.com; liam.r.girdwood@linux.intel.com; Patches Audio
><patches.audio@intel.com>; broonie@kernel.org
>Subject: Re: [alsa-devel] [RFC v3 06/11] ASoC: hdac_hda: add ASoC based HDA
>codec driver
>
>> >
>> >Well, a big unclear question to me is why do we need to bind the stuff
>> >so differently.  Can't we simply provide the same binding to the
>> >legacy codec from asoc driver?  In the legacy-support mode, asoc
>> >driver creates the legacy-compatible codec objects with the
>> >legacy-compatible hda_bus.
>> >
>>
>> Both the drivers i.e. ASoC and Legacy are registering the driver in
>> exact same way by filling the hdac_driver fields. There is no difference
>> in terms of HDA bus interactions. First series unifies even the data
>> structures hdac_device, hdac_driver and hdac_bus.
>
>Yes, that's a good part.
>
>> Once the device is enumerated and the hdac_driver->probe
>> is called the difference starts, primarily because ASoC vs ALSA
>> codec driver differences.
>
>Why so different?  Is it hard to integrate them somehow?
>
>What exactly do we need to do in addition to the existing legacy
>HD-audio codec probe/remove/whatever?

probe/remove of the ASoC driver takes care of registering/unregistering 
the snd_soc_codec_driver with ASoC framework. Which would register
dai, widgets and controls associated with the codec.

But in this driver probe the card is not created and so nothing else is done.
It waits until the ASoC framework calls snd_soc_codec probe.

So the way I see is ASoC driver probe is just a bus level probe and its
one level before the legacy codec driver probe.

Legacy codec driver probe is kind of similar to snd_soc_codec probe.
Again if you think from unification, we are calling the exact same APIs
which are called in the legacy driver probe. Some legacy APIs are not 
used e.g. build_pcms.

snd_soc_codec_driver callbacks are handled by ASoC framework
and so we can not call it from anywhere else. But within this we call 
most of the APIs of the legacy codec driver.

You can look at the ~/sound/soc/codecs/hdac_hda.c file, its just one file
for the ASoC driver.

>
>> Here also if you notice, after taking care of
>> the ASoC related components, ASoC codec driver calls exact same APIs of the
>> legacy HDA codec driver which are called by the legacy controller driver.
>>
>> The hda_bus and hda_codec data structures are also used by the ASoC
>> driver as it is to call legacy codec driver APIs.
>>
>> So I am not sure if we are doing binding in two different ways, or I
>> misunderstood you completely ?
>
>Well, I still am not sure why do we need two ways, completely
>switching the whole binding.  If it's a matter of some additional
>calls on top of the legacy probe, we can add a new optional bus ops,
>and call it in the probe function, too.  At the time of probe
>callback, the bus is already present.

>From the bus point of view, there are no differences in the driver.
The Series 1 has already done that.

The difference is only due to ASoC vs ALSA framework. 

In the last patch, instead of checking the bus_type everywhere in the code,
it uses it to call the individual driver function. That way the hdac_driver 
callback implementation remains separate and much cleaner for ASoC
and legacy drivers. So the legacy codec driver APIs are still used but
without too many if else conditions.

Regards,
Rakesh
