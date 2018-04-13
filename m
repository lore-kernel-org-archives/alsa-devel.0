From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Date: Fri, 13 Apr 2018 09:08:28 -0700
Message-ID: <20180413160828.GA27560@fury>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
 <20180412105909.tbyfcjm55sb47hiq@pali>
 <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Takashi Iwai <tiwai@suse.de>, Lukas Wunner <lukas@wunner.de>, mario.limonciello@dell.com, andy@infradead.org, mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 12, 2018 at 10:15:41PM +0800, Kai-Heng Feng wrote:
> at 6:59 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> 
> > On Thursday 12 April 2018 12:50:02 Takashi Iwai wrote:
> > > > +#if IS_ENABLED(CONFIG_DELL_LAPTOP)
> > > > +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
> > > > +{
> > > > +	bool (*dell_switchable_gfx_is_enabled_func)(void);
> > > > +	bool enabled;
> > > > +
> > > > +	/* Only need to check for Dell laptops and AIOs */
> > > > +	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) ||
> > > > +	    !(dmi_match(DMI_CHASSIS_TYPE, "10") ||
> > > > +	      dmi_match(DMI_CHASSIS_TYPE, "13")) ||
> > > > +	    !(pdev->vendor == PCI_VENDOR_ID_ATI ||
> > > > +	      pdev->vendor == PCI_VENDOR_ID_NVIDIA))
> > > > +		return false;
> > ...
> > > > @@ -1711,6 +1745,11 @@ static int azx_create(struct snd_card
> > > > *card, struct pci_dev *pci,
> > > >  	if (err < 0)
> > > >  		return err;
> > > > 
> > > > +	if (check_dell_switchable_gfx(pci)) {
> > > > +		pci_disable_device(pci);
> > 
> > Hi!
> > 
> > Now looking at it again... This code disables all ATI and NVIDIA sound
> > cards available in any Dell System (laptop or AIO) if system says that
> > SG is enabled, right?
> 
> Yes.
> 
> > 
> > It means that also any external ATI or NVIDIA PCI card with audio device
> > connected to Thunderbolt (e.g. via PCI <--> TB bridge) is always
> > unconditionally disabled too?
> 
> I never thought of this case, thanks for bringing this up.
> Do you have any suggestion to check if it connects to the system via
> Thunderbolt?

Is there any kind of indicator for a PCI device if it is a removable
device?  Only disabling those PCI devices which are wholly integrated
with the platform would be ideal.

Failing that, is there an indicator in the PCI configuration which will
distinguish such devices? Are the integrated devices using specific
lanes, are the external devices behind a switch? etc. And can we do this
in a generic way for all relevant platforms.

-- 
Darren Hart
VMware Open Source Technology Center
