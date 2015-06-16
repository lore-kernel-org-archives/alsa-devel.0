From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 2/4] ASoC: Intel - add Skylake HDA audio
	driver
Date: Tue, 16 Jun 2015 09:22:47 +0530
Message-ID: <20150616035247.GT28601@localhost>
References: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
 <1434040438-14535-3-git-send-email-vinod.koul@intel.com>
 <20150615155632.GU18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 079C7260705
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 05:51:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150615155632.GU18309@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2015 at 04:56:33PM +0100, Mark Brown wrote:
> > +static int skl_suspend(struct device *dev)
> > +{
> > +	struct pci_dev *pci = to_pci_dev(dev);
> > +	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
> > +	struct hdac_bus *bus = ebus_to_hbus(ebus);
> > +
> > +	snd_hdac_bus_stop_chip(bus);
> > +	snd_hdac_bus_enter_link_reset(bus);
> > +	if (bus->irq >= 0) {
> > +		free_irq(bus->irq, bus);
> 
> 
> Why are we freeing the interrupt over suspend?  That is very unusual
> behaviour.
As Takashi said, these maybe old HDA related, so I can check if we cna
remove these. I we find an odd machine/BIOS we can always add this later

> 
> > +static int skl_dmic_device_register(struct skl *skl)
> > +{
> > +	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
> > +	struct platform_device *pdev;
> > +	int ret;
> > +
> > +	pdev = platform_device_alloc("dmic-codec", -1);
> > +	if (!pdev) {
> > +		dev_err(bus->dev, "failed to allocate dmic device\n");
> > +		return -1;
> > +	}
> > +
> > +	ret = platform_device_add(pdev);
> > +	if (ret) {
> > +		dev_err(bus->dev, "failed to add hda codec device\n");
> > +		platform_device_put(pdev);
> > +		return -1;
> > +	}
> 
> Don't squash the error codes you get, return them - and if you must
> return a fixed error code I'm pretty sure you don't mean -EPERM.
Ah yes, will fix this

> 
> > +	skl->dmic_dev = pdev;
> 
> There can only ever be one DMIC?
One DMIC port, so we need only one DMIC codec device for creating the
DAI-link.

> 
> > +
> > +static const struct hdac_io_ops skl_io_ops = {
> > +	.reg_writel = skl_pci_writel,
> > +	.reg_readl = skl_pci_readl,
> > +	.reg_writew = skl_pci_writew,
> > +	.reg_readw = skl_pci_readw,
> > +	.reg_writeb = skl_pci_writeb,
> > +	.reg_readb = skl_pci_readb,
> > +	.dma_alloc_pages = skl_dma_alloc_pages,
> > +	.dma_free_pages = skl_dma_free_pages,
> > +};
> 
> Still not thrilled at open coding these wrappers.
If we have this is core, I will remove the part :)


-- 
~Vinod
