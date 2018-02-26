From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH v1 8/9] ASoC: hdac_hda: add asoc extension
 for legacy HDA codec drivers
Date: Mon, 26 Feb 2018 16:02:23 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579B2A5D0@BGSMSX104.gar.corp.intel.com>
References: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1519373550-2545-9-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hmv00ggc4.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579B2A211@BGSMSX104.gar.corp.intel.com>
 <s5h606krqt1.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579B2A56A@BGSMSX104.gar.corp.intel.com>
 <s5h1sh7rbb7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 4255D2675E6
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 17:02:33 +0100 (CET)
In-Reply-To: <s5h1sh7rbb7.wl-tiwai@suse.de>
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
>Sent: Monday, February 26, 2018 9:30 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org;
>liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com; Koul,
>Vinod <vinod.koul@intel.com>; Patches Audio <patches.audio@intel.com>
>Subject: Re: [PATCH v1 8/9] ASoC: hdac_hda: add asoc extension for legacy HDA
>codec drivers
>
>On Mon, 26 Feb 2018 16:57:45 +0100,
>Ughreja, Rakesh A wrote:
>>
>> >Ah crap, now I see the point.  The confusion comes from that you have
>> >two probe and two remove functions.  How about renaming the ext_ops
>> >ones?
>>
>> Oh okay, instead of "probe" and "remove", shall I call them "hdev_probe"
>> and "hdev_remove" to indicate that its related to HDA Device probe at the
>> bus level and not the ASoC porbe.
>
>I'd call e.g. hdev_attach and hdev_detach or such so that the terms
>don't conflict.

Sure, I will use the hdev_attach and hdev_detach.

Regards,
Rakesh
