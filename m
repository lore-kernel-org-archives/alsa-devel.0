From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 1/2] ALSA: hda - Continue probing even if
 i915 binding fails
Date: Fri, 12 Jun 2015 05:50:43 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B88BA69@SHSMSX101.ccr.corp.intel.com>
References: <1433931965-12337-1-git-send-email-tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F82B88A8E4@SHSMSX101.ccr.corp.intel.com>
 <s5hmw057bu3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 80546266640
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 07:51:13 +0200 (CEST)
In-Reply-To: <s5hmw057bu3.wl-tiwai@suse.de>
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
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, June 12, 2015 1:09 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org; David Henningsson; Yang, Libin
> Subject: Re: [PATCH 1/2] ALSA: hda - Continue probing even if i915 binding fails
> 
> At Fri, 12 Jun 2015 02:08:50 +0000,
> Lin, Mengdong wrote:
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Wednesday, June 10, 2015 6:26 PM
> > >
> > > Currently snd-hda-intel driver aborts the probing of Intel HD-audio
> > > controller with i915 power well management when binding with i915
> > > driver via
> > > hda_i915_init() fails.  This is no big problem for Haswell and
> > > Broadwell where the HD-audio controllers are dedicated to HDMI/DP,
> > > thus i915 link is mandatory.  However, Skylake, Baytrail and
> > > Braswell have only one controller and both HDMI/DP and analog codecs
> > > share the same bus.  Thus, even if HDMI/DP isn't usable, we should keep
> the controller working for other codecs.
> > >
> > > For fixing this, this patch simply allows continuing the probing
> > > even if
> > > hda_i915_init() call fails.  This may leave stale sound components
> > > for HDMI/DP devices that are unbound with graphics.  We could abort
> > > the probing selectively, but from the code simplicity POV, it's
> > > better to continue in all cases.
> > >
> > > Reported-by: Libin Yang <libin.yang@intel.com>
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > > This is for 4.1.  Appying to 4.2 may result in trivial conflicts.
> > >
> > >  sound/pci/hda/hda_intel.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > > index fea198c58196..8a0af6770e1d 100644
> > > --- a/sound/pci/hda/hda_intel.c
> > > +++ b/sound/pci/hda/hda_intel.c
> > > @@ -1855,7 +1855,7 @@ static int azx_probe_continue(struct azx
> > > *chip) #ifdef CONFIG_SND_HDA_I915
> > >  		err = hda_i915_init(hda);
> > >  		if (err < 0)
> > > -			goto out_free;
> > > +			goto skip_i915;
> > >  		err = hda_display_power(hda, true);
> > >  		if (err < 0) {
> > >  			dev_err(chip->card->dev,
> > > @@ -1865,6 +1865,7 @@ static int azx_probe_continue(struct azx
> > > *chip) #endif
> > >  	}
> > >
> > > + skip_i915:
> > >  	err = azx_first_init(chip);
> > >  	if (err < 0)
> > >  		goto out_free;
> > > --
> > > 2.4.3
> >
> > Thanks for your patch. But maybe we should not skip i915 for the
> > dedicated display HD-A controller on Haswell/Broadwell.
> >
> > For HSW/BDW, their HD-A controller for display audio (PCI dev#3) is
> > *partly* in GPU power domain:
> > - Its PCI configuration space is out of i915 power well, but in an
> > always-on  power well. So even if the BIOS disables the Intel GPU (PCI
> > dev#2), the HD-A  controller is still present, and we can still access
> > all standard registers in PCI  config space.
> 
> Right, and changing this doesn't break things.
> 
> > - Its audio functions are in the i915 power well. If hda_i915_init()
> > fails and
> >  I915 power well is unavailable, read/write to the audio register of
> > the  Controller will fail and we'll get kernel error messages. So I
> > feel it's better  to abort if hda_i915_init() fails for this HD-A controller.
> 
> By skipping, the access to i915 power well won't happen later, since the
> component ops isn't set.
> 
> I tested Haswell machines with nomodeset to simulate the situation, and there
> was no any kernel errors except for the first one indicating the failure of i915
> binding.
> 
> I haven't tested Broadwell, though.

Hi Takashi,

I think there is no error because the i915 power well is ON by default on
Haswell and BIOS does not touch this. However, it's possible that the BIOS may
disable this power well and depends on i915 driver to turn it on when need, or
just disable the power well when disabling the Intel GPU.

I remember previously we met audio register I/O error when HSW introduced
this power well and i915 disabled it without sync with audio driver.

Since we cannot expect the exact BIOS behavior, I feel it's safer not to use this
HD-A controller without i915 on HSW and BDW.

Thanks
Mengdong
