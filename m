From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 5/5] ALSA: hda - Make device D3
	during	runtime	suspend
Date: Tue, 26 Nov 2013 13:32:11 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80141B01B@SHSMSX101.ccr.corp.intel.com>
References: <1385454553-12000-1-git-send-email-tiwai@suse.de>
 <1385454553-12000-6-git-send-email-tiwai@suse.de>
 <s5hwqjv8hq7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 391AF26109A
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 14:32:39 +0100 (CET)
In-Reply-To: <s5hwqjv8hq7.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
> Sent: Tuesday, November 26, 2013 8:34 PM
> To: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH 5/5] ALSA: hda - Make device D3 during
> runtime suspend
> 
> At Tue, 26 Nov 2013 09:29:13 +0100,
> Takashi Iwai wrote:
> >
> > We can make the device D3 for saving more power during the runtime
> > suspend.  Meanwhile, I observed that Haswell HDMI codecs gets
> > corrupted ELD bytes when woken up from runtime suspend with D3.
> > As a quick workaround, exclude these chips from D3.
> 
> Scratch this.  After reading the PCI core code, I found this patch is just a
> nonsense.

Could you share more info here?

On Haswell, the HDMI audio controller (PCI device 3) and codec are in display power well, so the power saving is achieved by releasing and turning off the display power well.

But at least for legacy audio, we need the controller (PCI device 1b) to enter D3 at runtime so PCI driver will call ACPI and BIOS can know the legacy audio controller is in D3 and power down the on-board codec.

Thanks
Mengdong

> >
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  sound/pci/hda/hda_intel.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index b001aa6da3bc..c0b2c9079607 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -2997,6 +2997,13 @@ static int azx_runtime_suspend(struct device
> *dev)
> >  	if (!chip->bus->avoid_link_reset)
> >  		azx_enter_link_reset(chip);
> >  	azx_clear_irq_pending(chip);
> > +
> > +	/* Haswell HDMI/DP shows the broken ELD read after runtime PM */
> > +	if (chip->driver_type != AZX_DRIVER_HDMI) {
> > +		pci_save_state(chip->pci);
> > +		pci_set_power_state(chip->pci, PCI_D3hot);
> > +	}
> > +
> >  	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
> >  		hda_display_power(false);
> >  	return 0;
> > @@ -3019,6 +3026,11 @@ static int azx_runtime_resume(struct device
> *dev)
> >  	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
> >  		hda_display_power(true);
> >
> > +	if (chip->driver_type != AZX_DRIVER_HDMI) {
> > +		pci_set_power_state(chip->pci, PCI_D0);
> > +		pci_restore_state(chip->pci);
> > +	}
> > +
> >  	/* Read STATESTS before controller reset */
> >  	status = azx_readw(chip, STATESTS);
> >
> > --
> > 1.8.4.3
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
