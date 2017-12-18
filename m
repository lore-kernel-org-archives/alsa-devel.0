From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC v3 06/11] ASoC: hdac_hda: add ASoC based HDA
	codec driver
Date: Mon, 18 Dec 2017 04:06:13 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579ADB65F@BGSMSX104.gar.corp.intel.com>
References: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1513337448-31685-7-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hd13ggr18.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADA90D@BGSMSX104.gar.corp.intel.com>
 <s5hvah8f0x6.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADAF8C@BGSMSX104.gar.corp.intel.com>
 <s5h4lorvxvj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C9241267196
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 05:06:19 +0100 (CET)
In-Reply-To: <s5h4lorvxvj.wl-tiwai@suse.de>
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
>Sent: Saturday, December 16, 2017 2:44 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org;
>liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com; Koul, Vinod
><vinod.koul@intel.com>; Patches Audio <patches.audio@intel.com>
>Subject: Re: [RFC v3 06/11] ASoC: hdac_hda: add ASoC based HDA codec driver
>

>> I am not sure if I understand you fully, so asking some follow up
>> Questions.
>>
>> I am assuming you are asking me to implement something like following.
>> Where I have to implement snd_hda_get_mode() function which would
>> return "true" if we need to register the driver as "asoc" driver.
>>
>> Is that right understanding ?
>>
>> int __hda_codec_driver_register(struct hda_codec_driver *drv, const char
>*name,
>>                                struct module *owner)
>> {
>>         /*
>>          * check if we need to register ASoC HDA driver
>>          */
>> #if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)
>>         int asoc_mode = snd_hda_get_mode();
>>         if (asoc_mode) {
>>                 drv->core.id_table = drv->id;
>>                 return __hdac_hda_codec_driver_register(&drv->core, name, owner);
>>         }
>> #endif
>>         return __hda_legacy_codec_driver_register(drv, name, owner);
>> }
>>
>> If above is true then the follow up question is, what are the criteria to determine
>> the mode. Since I cannot assume that the bus instance is already created at the
>> time of driver registration, I am not sure how to determine what kind of platform
>> driver would be loaded in future.
>
>My assumption is that there is only one hda_codec_driver_register().
>The legacy code needs to be rewritten to implement the standard
>probe/remove as preliminary.  Any the rest differentiation is done via
>additional callbacks at probe/remove time.
>

Oh I see. Let me work on this and may ask you some additional clarifications.

Regards,
Rakesh
