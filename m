From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC v3 06/11] ASoC: hdac_hda: add ASoC based
	HDA	codec driver
Date: Tue, 19 Dec 2017 15:26:04 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579ADD339@BGSMSX104.gar.corp.intel.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BD2BD266F2E
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 16:26:13 +0100 (CET)
In-Reply-To: <s5hmv2fc5ze.wl-tiwai@suse.de>
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
>Sent: Tuesday, December 19, 2017 4:58 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; Koul, Vinod <vinod.koul@intel.com>; pierre-
>louis.bossart@linux.intel.com; liam.r.girdwood@linux.intel.com; Patches Audio
><patches.audio@intel.com>; broonie@kernel.org
>Subject: Re: [alsa-devel] [RFC v3 06/11] ASoC: hdac_hda: add ASoC based HDA
>codec driver
>
>>
>> Hi Takashi,
>>
>> I worked on the concept that you proposed and here is the patch with main
>> code change. Basically I wrote common driver handlers for HDA Driver
>> snd_hdac_drv_probe, snd_hdac_drv_remove, snd_hdac_drv_shutdown,
>> snd_hdac_drv_match, snd_hdac_drv_unsol_event etc.
>>
>> Once the common driver is probed it checks what kind of bus it is enumerated
>> on by calling the bus API. If it is ASOC bus type it calls the ASOC driver
>> registered callbacks and if it is LEGACY bus type it calls the Legacy driver
>> registered callbacks.
>>
>> ASoC based platform drivers would create ASOC bus type while the legacy
>> controller drivers would create LEGACY bus type. I added the bus_type as
>> a part of hdac_bus, which gets set during snd_hdac_bus_init or
>> snd_hdac_ext_bus_init. hdac_device->type and hdac_driver->type are
>> set the HDA_DEV_CORE during registrations and enumeration.
>>
>> Also I have kept these routines as part of codec library, so that all the other
>> drivers can use it without duplicating the code.
>>
>> Let me know if you are okay, I can include these changes as part of my
>> next series.
>
>I need to think more deeply, but after a quick look, I find it too
>overhead.

Are you referring to the calling overhead because of the wrapper involved ?

The way I see is we have two options.

1. Single driver option. - There is going to be a common wrapper here,
which needs to come into picture before it re-directs it to the appropriate
driver. This is what is done in the following patch.

2. Separate driver for ASoC and Legacy. - This requires ID tables, Can we move
id tables into separate header file ? then it can solve the problem involved in
option 1. This also solves the problem related to wrappers as well as the
problem related to accessing the ID tables via extern symbols, that you
mentioned in the previous series.

>
>May we start from a "big picture" to describe the whole driver
>bindings?
>

This patch registers the hdac_driver callback at the root level agnostic to
asoc and legacy and then selects the appropriate legacy or asoc callbacks,
based on the bus which enumerated the driver.

I cannot think of any other approach if we want to go with a single driver
approach. You will have to give some more hints :-)

Thank you for taking time and giving feedback.

Regards,
Rakesh
