From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: DW-DMA: Probe failures on broadwell
Date: Tue, 9 Jul 2019 16:14:01 +0300
Message-ID: <20190709131401.GA9224@smile.fi.intel.com>
References: <CAOReqxhxHiJ-4UYC-j4Quuuy5YP9ywohe_JwiLpCxqCvP-7ypg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0230F800E0
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2019 15:14:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOReqxhxHiJ-4UYC-j4Quuuy5YP9ywohe_JwiLpCxqCvP-7ypg@mail.gmail.com>
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

(I think this is okay to go on public here)
+Cc: Pierre, Liam, DMA Engine ML, ASoC ML

On Mon, Jul 08, 2019 at 01:50:07PM -0700, Curtis Malainey wrote:
> Hello Andy,
> 
> I am reaching out to you as you are the main author for
> drivers/dma/dw/core.c and we are seeing a failure in there on some of
> our samus devices. On certain device we are seeing the following
> failure (debugging enabled in this log.)
> 
> [    3.587515] sst-acpi INT3438:00: DW_PARAMS: 0x00000000

AFAIK, when Synopsys DesignWare DMA IP is in use in Intel, we almost always
(yes, I know couple of exceptions), enable auto configuration block. Thus, the
*private* DMA controllers used in Broadwell are actually Intel iDMA 32-bit.
Nowadays the differences can be seen in drivers/dma/dw/idma32.c.

Note, DMA in the driver is used solely for firmware load, simplest workaround
is to disable DMA. Though, personally, for sake of test coverage, I would like
to see how it works in DMA case.

> [    3.587519] haswell-pcm-audio haswell-pcm-audio: error: DMA device
> register failed
> [    3.587524] haswell-pcm-audio haswell-pcm-audio: sst_dma_new failed -22
> [    3.598010] bdw-rt5677 bdw-rt5677: ASoC: failed to init link System PCM
> 
> I don't have the datasheets for this component but I am wondering if
> you could help us troubleshoot this bug it would be greatly
> appreciated if possible. I am not sure if we are seeing a hardware
> boot failure or a boot race. I was hoping you could shed some light on
> this and if it is a boot race help us recover from it. I know Intel
> relies on no defers typically but it would be nice to see if we can
> fix this. Below is where I have traced the error source to in core.c.

So, the correct fix is to provide a platform data, like it's done in
drivers/dma/dw/pci.c::idma32_pdata, in the sst-firmware.c::dw_probe(), and call
idma32_dma_probe() with idma32_dma_remove() respectively on removal stage.

(It will require latest patches to be applied, which are material for v5.x)

>                  dw_params = dma_readl(dw, DW_PARAMS);
>                  dev_dbg(chip->dev, "DW_PARAMS: 0x%08x\n", dw_params);
> 
>                  autocfg = dw_params >> DW_PARAMS_EN & 1;
>                  if (!autocfg) {
>                          err = -EINVAL;
>                          goto err_pdata;
>                  }
> Let me know if you have any ideas on how to mitigate this, thanks.

-- 
With Best Regards,
Andy Shevchenko
