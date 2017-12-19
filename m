From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC v3 06/11] ASoC: hdac_hda: add ASoC based
	HDA	codec driver
Date: Tue, 19 Dec 2017 16:14:38 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579ADD712@BGSMSX104.gar.corp.intel.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 36DA8266F2E
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 17:14:56 +0100 (CET)
In-Reply-To: <s5hmv2ebuay.wl-tiwai@suse.de>
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
>Sent: Tuesday, December 19, 2017 9:10 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; Koul, Vinod <vinod.koul@intel.com>; pierre-
>louis.bossart@linux.intel.com; liam.r.girdwood@linux.intel.com; Patches Audio
><patches.audio@intel.com>; broonie@kernel.org
>Subject: Re: [alsa-devel] [RFC v3 06/11] ASoC: hdac_hda: add ASoC based HDA
>codec driver
>


>>
>> Are you referring to the calling overhead because of the wrapper involved ?
>>
>> The way I see is we have two options.
>>
>> 1. Single driver option. - There is going to be a common wrapper here,
>> which needs to come into picture before it re-directs it to the appropriate
>> driver. This is what is done in the following patch.
>>
>> 2. Separate driver for ASoC and Legacy. - This requires ID tables, Can we move
>> id tables into separate header file ? then it can solve the problem involved in
>> option 1. This also solves the problem related to wrappers as well as the
>> problem related to accessing the ID tables via extern symbols, that you
>> mentioned in the previous series.
>
>I believe (2) is no-go, it's a straight maintenance hell.

Got it.

>
>> >May we start from a "big picture" to describe the whole driver
>> >bindings?
>> >
>>
>> This patch registers the hdac_driver callback at the root level agnostic to
>> asoc and legacy and then selects the appropriate legacy or asoc callbacks,
>> based on the bus which enumerated the driver.
>>
>> I cannot think of any other approach if we want to go with a single driver
>> approach. You will have to give some more hints :-)
>
>Well, a big unclear question to me is why do we need to bind the stuff
>so differently.  Can't we simply provide the same binding to the
>legacy codec from asoc driver?  In the legacy-support mode, asoc
>driver creates the legacy-compatible codec objects with the
>legacy-compatible hda_bus.
>

Both the drivers i.e. ASoC and Legacy are registering the driver in
exact same way by filling the hdac_driver fields. There is no difference
in terms of HDA bus interactions. First series unifies even the data
structures hdac_device, hdac_driver and hdac_bus.

Once the device is enumerated and the hdac_driver->probe
is called the difference starts, primarily because ASoC vs ALSA
codec driver differences. Here also if you notice, after taking care of 
the ASoC related components, ASoC codec driver calls exact same APIs of the 
legacy HDA codec driver which are called by the legacy controller driver.

The hda_bus and hda_codec data structures are also used by the ASoC
driver as it is to call legacy codec driver APIs.

So I am not sure if we are doing binding in two different ways, or I
misunderstood you completely ?

Regards,
Rakesh
