From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC v3 06/11] ASoC: hdac_hda: add ASoC based HDA
	codec driver
Date: Sat, 16 Dec 2017 07:48:35 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579ADAF8C@BGSMSX104.gar.corp.intel.com>
References: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1513337448-31685-7-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hd13ggr18.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADA90D@BGSMSX104.gar.corp.intel.com>
 <s5hvah8f0x6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 63070266B0F
 for <alsa-devel@alsa-project.org>; Sat, 16 Dec 2017 08:48:44 +0100 (CET)
In-Reply-To: <s5hvah8f0x6.wl-tiwai@suse.de>
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
>Sent: Friday, December 15, 2017 9:18 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org;
>liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com; Koul, Vinod
><vinod.koul@intel.com>; Patches Audio <patches.audio@intel.com>
>Subject: Re: [RFC v3 06/11] ASoC: hdac_hda: add ASoC based HDA codec driver
>

>> >Can we check differently?  For example, we may put some difference in
>> >the driver and check it here instead of the static IS_ENABLED().
>>
>> Do you think a module parameter is a good idea ?
>
>I don't think so.  We do need to consider a better way.
>
>Maybe an alternative is to give the additional indirect calls.
>That is, put some new ops or hook to the bus for calling some extra
>probing task in addition to the standard codec probe.
>

I am not sure if I understand you fully, so asking some follow up
Questions.

I am assuming you are asking me to implement something like following.
Where I have to implement snd_hda_get_mode() function which would
return "true" if we need to register the driver as "asoc" driver.

Is that right understanding ?

int __hda_codec_driver_register(struct hda_codec_driver *drv, const char *name,
                               struct module *owner)
{
        /*
         * check if we need to register ASoC HDA driver
         */
#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)
        int asoc_mode = snd_hda_get_mode();
        if (asoc_mode) {
                drv->core.id_table = drv->id;
                return __hdac_hda_codec_driver_register(&drv->core, name, owner);
        }
#endif
        return __hda_legacy_codec_driver_register(drv, name, owner);
}

If above is true then the follow up question is, what are the criteria to determine
the mode. Since I cannot assume that the bus instance is already created at the
time of driver registration, I am not sure how to determine what kind of platform
driver would be loaded in future.

Regards,
Rakesh
