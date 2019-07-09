From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: DW-DMA: Probe failures on broadwell
Date: Tue, 9 Jul 2019 12:27:49 -0700
Message-ID: <CAOReqxgnbDJsEcv7vdX3w44rzB=B69sHj95E8yBZ8DnZq0=63Q@mail.gmail.com>
References: <CAOReqxhxHiJ-4UYC-j4Quuuy5YP9ywohe_JwiLpCxqCvP-7ypg@mail.gmail.com>
 <20190709131401.GA9224@smile.fi.intel.com>
 <20190709132943.GB9224@smile.fi.intel.com>
 <20190709133448.GC9224@smile.fi.intel.com>
 <20190709133847.GD9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CED4F800E2
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2019 21:28:06 +0200 (CEST)
Received: by mail-lj1-x243.google.com with SMTP id x25so13960881ljh.2
 for <alsa-devel@alsa-project.org>; Tue, 09 Jul 2019 12:28:01 -0700 (PDT)
In-Reply-To: <20190709133847.GD9224@smile.fi.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Ross Zwisler <zwisler@google.com>, Fletcher Woodruff <fletcherw@google.com>, Liam Girdwood <liam.r.girdwood@intel.com>, dmaengine@vger.kernel.org, Pierre-louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Andy,

Thanks for the information, we are running a 4.14 kernel so we don't
have the idma32 driver, I will see if I can backport it and report
back if the fix works.

Thanks.

On Tue, Jul 9, 2019 at 6:38 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jul 09, 2019 at 04:34:48PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 09, 2019 at 04:29:43PM +0300, Andy Shevchenko wrote:
> > > On Tue, Jul 09, 2019 at 04:14:01PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Jul 08, 2019 at 01:50:07PM -0700, Curtis Malainey wrote:
> > >
> > > > So, the correct fix is to provide a platform data, like it's done in
> > > > drivers/dma/dw/pci.c::idma32_pdata, in the sst-firmware.c::dw_probe(), and call
> > > > idma32_dma_probe() with idma32_dma_remove() respectively on removal stage.
> > > >
> > > > (It will require latest patches to be applied, which are material for v5.x)
> > >
> > > Below completely untested patch to try
> >
> > Also, it might require to set proper request lines (currently it uses 0 AFAICS).
> > Something like it's done in drivers/spi/spi-pxa2xx-pci.c for Intel Merrifield.
>
> And SST_DSP_DMA_MAX_BURST seems encoded while it's should be simple number,
> like 8 (bytes). Also SPI PXA is an example to look into.
>
> I doubt it has been validated with upstream driver (I know about some internal
> drivers, hacked version of dw one, you may find sources somewhere in public).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
