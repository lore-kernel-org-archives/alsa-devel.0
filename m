From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda - Set intel hda controller power
 at	freeze() and thaw()
Date: Thu, 17 Dec 2015 08:29:39 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D197B28F2@SHSMSX103.ccr.corp.intel.com>
References: <1450335524-22848-1-git-send-email-xiong.y.zhang@intel.com>
 <s5h4mfhfrk9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 310A52654ED
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 09:29:46 +0100 (CET)
In-Reply-To: <s5h4mfhfrk9.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "Zhang, Xiong Y" <xiong.y.zhang@intel.com>
Cc: "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, December 17, 2015 3:44 PM
> To: Zhang, Xiong Y
> Cc: alsa-devel@alsa-project.org; Yang, Libin; Lu, Han
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - Set intel hda controller
> power at freeze() and thaw()
> 
> On Thu, 17 Dec 2015 07:58:44 +0100,
> Xiong Zhang wrote:
> >
> > It takes three minutes to enter into hibernation on some OEM SKL
> > machines and we see many codec spurious response after thaw()
> opertion.
> > This is because HDA is still in D0 state after freeze() call and
> > pci_pm_freeze/pci_pm_freeze_noirq() don't set D3 hot in pci_bus
> driver.
> > It seems bios still access HDA when system enter into freeze state,
> > HDA will receive codec response interrupt immediately after thaw() call.
> > Because of this unexpected interrupt, HDA enter into a abnormal
> > state and slow down the system enter into hibernation.
> >
> > In this patch, we put HDA into D3 hot state in azx_freeze_noirq() and
> > put HDA into D0 state in azx_thaw_noirq().
> 
> A slight concern is whether this would cause any impact on older
> chipsets.  I don't believe it would, but BIOSen are often crazy
> sensitive about such a detail.
> 
> Maybe safer to limit this to SKL+?  I guess Broxton should be covered
> as well?

As the issue fixed by the patch is only found on SKL, I agree to
limit it to SKL+. And apply it to other old platforms later if necessary.

BTW: We have tested it on BDW and SKL. It works on both platforms.

Regards,
Libin

> 
> 
> thanks,
> 
> Takashi
> 
> >
> > Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> > ---
> >  sound/pci/hda/hda_intel.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index c38c68f..3ba7cbc 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -890,6 +890,16 @@ static int azx_suspend(struct device *dev)
> >  	return 0;
> >  }
> >
> > +static int azx_freeze_noirq(struct device *dev)
> > +{
> > +	struct pci_dev *pci = to_pci_dev(dev);
> > +
> > +	if (pci->vendor == PCI_VENDOR_ID_INTEL)
> > +		pci_set_power_state(pci, PCI_D3hot);
> > +
> > +	return 0;
> > +}
> > +
> >  static int azx_resume(struct device *dev)
> >  {
> >  	struct pci_dev *pci = to_pci_dev(dev);
> > @@ -924,6 +934,14 @@ static int azx_resume(struct device *dev)
> >  	trace_azx_resume(chip);
> >  	return 0;
> >  }
> > +
> > +static int azx_thaw_noirq(struct device *dev)
> > +{
> > +	struct pci_dev *pci = to_pci_dev(dev);
> > +
> > +	if (pci->vendor == PCI_VENDOR_ID_INTEL)
> > +		pci_set_power_state(pci, PCI_D0);
> > +}
> >  #endif /* CONFIG_PM_SLEEP || SUPPORT_VGA_SWITCHEROO */
> >
> >  #ifdef CONFIG_PM
> > @@ -1035,6 +1053,8 @@ static int azx_runtime_idle(struct device
> *dev)
> >
> >  static const struct dev_pm_ops azx_pm = {
> >  	SET_SYSTEM_SLEEP_PM_OPS(azx_suspend, azx_resume)
> > +	.freeze_noirq = azx_freeze_noirq,
> > +	.thaw_noirq = azx_thaw_noirq,
> >  	SET_RUNTIME_PM_OPS(azx_runtime_suspend,
> azx_runtime_resume, azx_runtime_idle)
> >  };
> >
> > --
> > 1.8.2.1
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
