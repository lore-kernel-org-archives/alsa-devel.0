From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: DW-DMA: Probe failures on broadwell
Date: Tue, 9 Jul 2019 16:38:47 +0300
Message-ID: <20190709133847.GD9224@smile.fi.intel.com>
References: <CAOReqxhxHiJ-4UYC-j4Quuuy5YP9ywohe_JwiLpCxqCvP-7ypg@mail.gmail.com>
 <20190709131401.GA9224@smile.fi.intel.com>
 <20190709132943.GB9224@smile.fi.intel.com>
 <20190709133448.GC9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13383F800E2
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2019 15:38:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190709133448.GC9224@smile.fi.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Curtis Malainey <cujomalainey@google.com>
Cc: alsa-devel@alsa-project.org, Ross Zwisler <zwisler@google.com>, Fletcher Woodruff <fletcherw@google.com>, Liam Girdwood <liam.r.girdwood@intel.com>, dmaengine@vger.kernel.org, Pierre-louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 09, 2019 at 04:34:48PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 09, 2019 at 04:29:43PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 09, 2019 at 04:14:01PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jul 08, 2019 at 01:50:07PM -0700, Curtis Malainey wrote:
> > 
> > > So, the correct fix is to provide a platform data, like it's done in
> > > drivers/dma/dw/pci.c::idma32_pdata, in the sst-firmware.c::dw_probe(), and call
> > > idma32_dma_probe() with idma32_dma_remove() respectively on removal stage.
> > > 
> > > (It will require latest patches to be applied, which are material for v5.x)
> > 
> > Below completely untested patch to try
> 
> Also, it might require to set proper request lines (currently it uses 0 AFAICS).
> Something like it's done in drivers/spi/spi-pxa2xx-pci.c for Intel Merrifield.

And SST_DSP_DMA_MAX_BURST seems encoded while it's should be simple number,
like 8 (bytes). Also SPI PXA is an example to look into.

I doubt it has been validated with upstream driver (I know about some internal
drivers, hacked version of dw one, you may find sources somewhere in public).

-- 
With Best Regards,
Andy Shevchenko
