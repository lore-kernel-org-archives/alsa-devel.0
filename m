From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC v3 06/11] ASoC: hdac_hda: add ASoC based HDA
 codec driver
Date: Thu, 21 Dec 2017 16:39:10 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579ADF577@BGSMSX104.gar.corp.intel.com>
References: <s5h4lorvxvj.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADB65F@BGSMSX104.gar.corp.intel.com>
 <85DFEED57DC57344B2483EF7BF8CB60579ADCE9A@BGSMSX104.gar.corp.intel.com>
 <s5hmv2fc5ze.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADD339@BGSMSX104.gar.corp.intel.com>
 <s5hmv2ebuay.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADD712@BGSMSX104.gar.corp.intel.com>
 <s5ha7yebsa7.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADD8AC@BGSMSX104.gar.corp.intel.com>
 <s5hk1xi4je6.wl-tiwai@suse.de>	<20171220102625.GB17890@sirena.org.uk>
 <85DFEED57DC57344B2483EF7BF8CB60579ADE906@BGSMSX104.gar.corp.intel.com>
 <85DFEED57DC57344B2483EF7BF8CB60579ADF4DE@BGSMSX104.gar.corp.intel.com>
 <s5hpo7884kz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 26101266BBC
 for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2017 17:39:17 +0100 (CET)
In-Reply-To: <s5hpo7884kz.wl-tiwai@suse.de>
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
 Vinod" <vinod.koul@intel.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Thursday, December 21, 2017 9:18 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: Mark Brown <broonie@kernel.org>; alsa-devel@alsa-project.org; Koul, Vinod
><vinod.koul@intel.com>; pierre-louis.bossart@linux.intel.com;
>liam.r.girdwood@linux.intel.com; Patches Audio <patches.audio@intel.com>
>Subject: Re: [alsa-devel] [RFC v3 06/11] ASoC: hdac_hda: add ASoC based HDA
>codec driver

>>
>> Let me know if this is the right way to go. I can send you the full series
>> once you are okay with the direction.
>
>Yes, this is a sort of idea I had.
>My original thought was to have an extra ops in hdac_bus, and refer
>directly there instead of setting in each hda_codec object.  Not coded
>yet, so I can't judge which one is better.  Maybe you can actually
>quick-try and test differences.

Let me try that out and will move to hdac_bus if I don't run into any
practical issues.

>
>But still an open question is where to hook.  You've put the branch at
>the very beginning of each probe/remove, that is, completely replacing
>the whole probe/remove callbacks.  Meanwhile, the legacy codec driver
>still expects the legacy hda_codec object handling, so keeping more
>common stuff would make sense.  That is, if we do switching at the
>beginning, the rest should just compose the same helper functions in
>slightly different ways.  Or we share most parts of probe/remove in
>both legacy and asoc but branch off after some later point in the
>probe/remove functions.

I think I am wrong in doing the above. I was thinking that I cannot do
all those steps done in the probe before the snd_soc_codec probe gets
called.

After looking at the code again after your comments, It looks like 
I can call all these before the card is registered by the machine driver.

Is that right understanding ? same thing is happening in legacy
driver also. The card is registered at the end. So I will just skip that step.

>
>In anyway, a whole patchset would be helpful so that I can give it a
>try, too.  But maybe I'll have little time tomorrow and a few days
>thereafter due to vacation.

Sure, will send you the series tomorrow by correcting few more things.

Regards,
Rakesh
