From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC v5 0/3] Enable HDA Codec support on Intel
 Platforms (Series1)
Date: Thu, 4 Jan 2018 04:34:05 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579AE376D@BGSMSX104.gar.corp.intel.com>
References: <1514955336-693-1-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hbmibc5sg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id BD1D32676A9
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 05:34:18 +0100 (CET)
In-Reply-To: <s5hbmibc5sg.wl-tiwai@suse.de>
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
>Sent: Wednesday, January 3, 2018 9:07 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org;
>liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com; Koul, Vinod
><vinod.koul@intel.com>; Patches Audio <patches.audio@intel.com>
>Subject: Re: [RFC v5 0/3] Enable HDA Codec support on Intel Platforms (Series1)

>
>Unfortunately my Dell machine has no DSP, and it doesn't give the
>proper NHLT entry, thus the snd-soc-skl loading fails.
>(BTW, there was a kernel WARNING hit by that; will submit the fix
>patch later.)

Yes, you are right.
Based on specification of Dell Latitude 7270, it looks like it is SKL
SoC and so may not have DSP enabled in the BIOS.

>
>So, only judging from the quick glance over the patches:
>first off, the less change in ALSA legacy side than previous versions
>is nice.  Where to call the probe and the remove of ext_ops is still a
>slight question (whether it has to be the very beginning or not), but
>it's a good start.

Based on your suggestion during the previous reviews, I tried reusing
the other functions like snd_hda_codec_set_name, snd_hdac_regmap_init,
patch, snd_hda_codec_build_pcms, snd_hda_codec_build_controls etc.

Except the regmap_init function everything else requires snd_card which
is created only at the machine driver load, so I was not able to reuse 
any other function. That's why I am calling all these functions in the 
snd_soc_codec probe time, and not during the hdac_dev probe.
I have tried calling the regmap_init in the hdac_dev probe and things seem
to work fine, but I am not sure if it is right thing to do, since the card is not
created. 

Do you know if we can do regmap_init before the card is created ?

>
>Maybe we can drop the introduction of bus type, too.  Basically just
>checking the non-NULL bus->ext_ops should be enough to identify the
>ext-bus type.

Yes, sure. I will include this change in the next series.

Regards,
Rakesh
