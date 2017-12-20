From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC v3 06/11] ASoC: hdac_hda: add ASoC based HDA
 codec driver
Date: Wed, 20 Dec 2017 10:52:58 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579ADE906@BGSMSX104.gar.corp.intel.com>
References: <s5h4lorvxvj.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADB65F@BGSMSX104.gar.corp.intel.com>
 <85DFEED57DC57344B2483EF7BF8CB60579ADCE9A@BGSMSX104.gar.corp.intel.com>
 <s5hmv2fc5ze.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADD339@BGSMSX104.gar.corp.intel.com>
 <s5hmv2ebuay.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADD712@BGSMSX104.gar.corp.intel.com>
 <s5ha7yebsa7.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579ADD8AC@BGSMSX104.gar.corp.intel.com>
 <s5hk1xi4je6.wl-tiwai@suse.de> <20171220102625.GB17890@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C2322677DD
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 11:53:03 +0100 (CET)
In-Reply-To: <20171220102625.GB17890@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Wednesday, December 20, 2017 3:56 PM
>To: Takashi Iwai <tiwai@suse.de>
>Cc: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>; alsa-devel@alsa-
>project.org; Koul, Vinod <vinod.koul@intel.com>; pierre-
>louis.bossart@linux.intel.com; liam.r.girdwood@linux.intel.com; Patches Audio
><patches.audio@intel.com>
>Subject: Re: [alsa-devel] [RFC v3 06/11] ASoC: hdac_hda: add ASoC based
>HDA codec driver
>
>On Tue, Dec 19, 2017 at 08:17:37PM +0100, Takashi Iwai wrote:
>
>> Well, honestly speaking, that complete morphing scares me.  If it's a
>> simple additional call, it's easier to track the code flow.  But your
>> patch essentially fakes the legacy codec and bus structs and twists
>> the control by that switch...  which looks too fragile to me.
>
>Especially when it's layered on top of all the other x86 code which is
>also complicated and fragile - feels like there's lots of places things
>can go wrong and lots of potential unexpected interactions.

Thanks, for the feedback Mark and Takashi. I will send the test patch 
based on the suggestions from Takashi within couple of days.

Regards,
Rakesh
