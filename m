From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda - PCH HDA controller not
 controlled by i915 power
Date: Wed, 10 Jun 2015 00:41:38 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1967247C@SHSMSX103.ccr.corp.intel.com>
References: <1433829918-5807-1-git-send-email-libin.yang@intel.com>
 <s5h1thlbder.wl-tiwai@suse.de>	<55768BCB.3060001@canonical.com>
 <s5hy4jt9td4.wl-tiwai@suse.de>	<5576A907.9050305@canonical.com>
 <s5hsia19rpa.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BB8226583C
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 02:41:43 +0200 (CEST)
In-Reply-To: <s5hsia19rpa.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

+ Mengdong

Hi Takashi & David,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, June 09, 2015 5:06 PM
> To: David Henningsson
> Cc: Yang, Libin; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - PCH HDA controller not
> controlled by i915 power
> 
> At Tue, 09 Jun 2015 10:51:19 +0200,
> David Henningsson wrote:
> >
> >
> >
> > On 2015-06-09 10:30, Takashi Iwai wrote:
> > > At Tue, 09 Jun 2015 08:46:35 +0200,
> > > David Henningsson wrote:
> > >>
> > >>
> > >>
> > >> On 2015-06-09 08:31, Takashi Iwai wrote:
> > >>> At Tue,  9 Jun 2015 14:05:18 +0800,
> > >>> libin.yang@intel.com wrote:
> > >>>>
> > >>>> From: Libin Yang <libin.yang@intel.com>
> > >>>>
> > >>>> On some Intel platforms, the HDMI codec is connected to PCH
> HDA
> > >>>> controller. In this case, AZX_DCAPS_I915_POWERWELL is set
> and
> > >>>> the i915 power well failure should not block the hda controller
> > >>>> initialization.
> > >>>>
> > >>>> Signed-off-by: Libin Yang <libin.yang@intel.com>
> > >>>
> > >>> Is this fix needed for 4.1, or it's only for 4.2?
> > >>
> > >> It's a bug fix, and as such should go to all kernels, even with cc to
> > >> stable. That said, it mainly concerns Skylake, so kernels that don't
> > >> support Skylake would not need a backport.
> > >
> > > The patch can't be applied even to 4.1 as is because of the code
> > > structure change.  So, Cc to stable doesn't work, in anyway.
> > >
> > >>> I vaguely remember of a bug report.  If there is any relevant bug
> > >>> report, please give the link, too.
> > >>
> > >> I think this was raised to Intel by us. The use case is when the
> > >> integrated GPU is disabled and a discrete GPU is used. In this case
> the
> > >> i915 module fails to load. If then the HDMI and analog codec are
> both on
> > >> the same controller, the entire controller fails instead of just the
> > >> HDMI codec.
> > >>
> > >> I'll see if I can get the patch tested ASAP.
> > >
> > > OK, the bug seems needed for 4.1 and earlier.  But Libin's patch is
> > > only for 4.2.  And even worse, backporting this isn't
> > > straightforward due to the lack of need_i915_power field.  Hmm.
> > >
> > > I think we can make it easier by just allowing to continue the probe.
> > > A totally untested patch for 4.1 is below.
> >
> > As part of the wider discussion, I think we could continue instead of
> > failing also on Haswell and Broadwell. This is to some degree
> > hypothetical, but if the i915 module does not load for some reason,
> then
> > the i915 module would not turn the power well off either, so it
> remains
> > on the entire time (and then audio could potentially work).
> 
> Without graphics HDMI/DP never works, so practically it's useless.
> The problem can be reproduced easily by passing nomodeset boot
> option.
> 
> OTOH, it'd simplify the change, and this was indeed my initial patch
> before posting.  Then I thought this might lead to a regression; a
> non-working HDMI/DP sound card appears while it wasn't before.  So I
> added the check of HSW/BDW.
> 
> Meanwhile, nomodeset or failing i915 is a more or less special
> situation, so we might not consider about this behavior change so
> much, and take rather for the code simplicity.
> 
> Comments?

Yes, HDMI/DP depends on gfx.

BDW/HSW has 2 controllers: one is in power well, the other is not.
The one in powerwell connects HDMI/DP codec.
The one in PCH connects analog codec.

SKL/BSW/BYT has one controller and it connects both HDMI/DP codec
and analog codec.

So we get the conclusion:
1. whatever power well is turned on, BDW/HSW PCH HDA controller
will work.
2. If power well is turned off, BDW/HSW HDA controller in gfx will not
work.
3. if power well is turned off, SKL/BSW/BYT controller will work (analog
audio will use it), but HDMI/DP audio will not work.



> 
> 
> Takashi
