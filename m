From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 2/4] ASoC: Intel - add Skylake HDA audio
	driver
Date: Tue, 16 Jun 2015 20:54:05 +0530
Message-ID: <20150616152405.GX28601@localhost>
References: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
 <1434040438-14535-3-git-send-email-vinod.koul@intel.com>
 <20150615155632.GU18309@sirena.org.uk>
 <20150616035247.GT28601@localhost>
 <20150616102826.GF18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 12E3A2657FE
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 17:22:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150616102826.GF18309@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, tiwai@suse.de
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 16, 2015 at 11:28:26AM +0100, Mark Brown wrote:
> On Tue, Jun 16, 2015 at 09:22:47AM +0530, Vinod Koul wrote:
> > On Mon, Jun 15, 2015 at 04:56:33PM +0100, Mark Brown wrote:
> 
> > > > +static const struct hdac_io_ops skl_io_ops = {
> > > > +	.reg_writel = skl_pci_writel,
> > > > +	.reg_readl = skl_pci_readl,
> > > > +	.reg_writew = skl_pci_writew,
> > > > +	.reg_readw = skl_pci_readw,
> > > > +	.reg_writeb = skl_pci_writeb,
> > > > +	.reg_readb = skl_pci_readb,
> > > > +	.dma_alloc_pages = skl_dma_alloc_pages,
> > > > +	.dma_free_pages = skl_dma_free_pages,
> > > > +};
> 
> > > Still not thrilled at open coding these wrappers.
> 
> > If we have this is core, I will remove the part :)
> 
> You could always send changes to add default ops to the core!
Takashi, you okay with that approach?

Thanks
-- 
~Vinod
