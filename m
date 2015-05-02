From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] ALSA: jack: fix a randconfig build issue
Date: Sat, 2 May 2015 07:24:04 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A905523EDA@SHSMSX101.ccr.corp.intel.com>
References: <1430449829-10568-1-git-send-email-yang.jie@intel.com>
 <s5hd22kkc26.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A905523E71@SHSMSX101.ccr.corp.intel.com>
 <s5h1tizjwe1.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A905523EBA@SHSMSX101.ccr.corp.intel.com>
 <s5hy4l7ihcf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 54ED5261522
 for <alsa-devel@alsa-project.org>; Sat,  2 May 2015 09:24:10 +0200 (CEST)
In-Reply-To: <s5hy4l7ihcf.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Saturday, May 02, 2015 3:12 PM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [PATCH] ALSA: jack: fix a randconfig build issue
> 
> At Sat, 2 May 2015 07:09:50 +0000,
> Jie, Yang wrote:
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Saturday, May 02, 2015 3:01 PM
> > > To: Jie, Yang
> > > Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam
> > > R
> > > Subject: Re: [PATCH] ALSA: jack: fix a randconfig build issue
> > >
> > > At Sat, 2 May 2015 04:51:34 +0000,
> > > Jie, Yang wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > Sent: Friday, May 01, 2015 3:11 PM
> > > > > To: Jie, Yang
> > > > > Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood,
> > > > > Liam R
> > > > > Subject: Re: [PATCH] ALSA: jack: fix a randconfig build issue
> > > > >
> > > > > At Fri,  1 May 2015 11:10:29 +0800, Jie Yang wrote:
> > > > > >
> > > > > > There may be no input_dev for jack(e.g. phantom jack), when
> > > > > > CONFIG_INPUT is not selected, building errors such as:
> > > > > > undefined reference to `input_xxx'...
> > > > > >
> > > > > > Here add #ifdef judgement to fix the issue.
> > > > >
> > > > > Well, the standard idiom so far is to enable SND_JACK selectively.
> > > > > Take a look at the comment in sound/core/Kconfig.
> > > > >
> > > > > # To be effective this also requires INPUT - users should say:
> > > > > #    select SND_JACK if INPUT=y || INPUT=SND
> > > > > # to avoid having to force INPUT on.
> > > > > config SND_JACK
> > > > > 	bool
> > > > >
> > > > > And, looking at sound/pci/hda/Kconfig, there is still
> > > SND_HDA_INPUT_JACK.
> > > > >
> > > > > So, what you need to fix is:
> > > > > - Remove SND_HDA_INPUT_JACK from sound/pci/hda/Kconfig and
> the
> > > last
> > > > >   ifdef in hda_codec.h
> > > > >
> > > > > - Replace the line "select SND_JACK" with
> > > > > 	select SND_JACK if INPUT=y || INPUT=SND_HDA
> > > >
> > > > OK, will follow this. What I only concern is that if user want
> > > > SND_JACk when INPUT=N(e.g. phantom jack?), it becomes impossible.
> > >
> > > Right, it's impossible now.  But this is the case really no one
> > > would care much (who wants the jack detection on a system without any
> input capability?).
> >
> > Got it. Another question here, I found that this change in
> > sound/pci/had/Kconfig doesn't fix the building issue:
> > 	select SND_JACK if INPUT=y || INPUT=SND_HDA but this do:
> > 	select SND_JACK if INPUT=y || INPUT=SND
> >
> > suppose we should use the latter one, right?
> 
> Yes, correct.
> 
> > Do you know why the former one
> > doesn't fix?(seems here "INPUT=SND..." added for both
> CONFIG_INPUT=m
> > and SND...=m case?)
> 
> SND may be y while SND_HDA=m and INPUT=m.
 
Thanks, will update the patch and send out soon.

~Keyon
> 
> 
> Takashi
