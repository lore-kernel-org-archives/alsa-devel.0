From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] ALSA: ac97c: Fix an error handling path in
 'atmel_ac97c_probe()'
Date: Thu, 31 Aug 2017 22:50:57 +0200
Message-ID: <20170831205057.lehboig6uv3boggc@piout.net>
References: <20170831044042.23306-1-christophe.jaillet@wanadoo.fr>
 <20170831081021.g4luo557ggtnyfyg@piout.net>
 <20170831101903.avhj5tqywpvfsj4u@sirena.org.uk>
 <s5h1snsjaey.wl-tiwai@suse.de>
 <20170831103825.77shnqzi7ykpm7ah@sirena.org.uk>
 <11403b91-f38d-bcd7-de0b-b2bb59801725@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11403b91-f38d-bcd7-de0b-b2bb59801725@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, nicolas.ferre@microchip.com, garsilva@embeddedor.com, arvind.yadav.cs@gmail.com, andriy.shevchenko@linux.intel.com, bhumirks@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 31/08/2017 at 21:08:10 +0200, Christophe JAILLET wrote:
> Le 31/08/2017 à 12:38, Mark Brown a écrit :
> > On Thu, Aug 31, 2017 at 12:31:33PM +0200, Takashi Iwai wrote:
> > 
> > > This is again a typical problem by such a trivial fix patch: the code
> > > looks as if it were trivial and correct, buried in a patch series that
> > > easily leads to the oversight by the maintainer's review.
> > Right, plus the amount of context that diff shows you.
> > 
> Hi,
> 
> My proposed patch was initially triggered using coccinelle, as you must have
> guessed.
> 
> In fact, I was surprised by the initial commit.
> I don't have any strong opinion if testing the return value of
> 'clk_prepare_enable()' is relevant or not, but I was surprised that the
> error handling path had not been updated at the same time.
> 
> So, before posting my patch, I have searched a bit in git history and it
> gave:
> 
> git shortlog --author="Arvind Yadav" | grep clk_prepare
>       ata: sata_rcar: Handle return value of clk_prepare_enable
>       hwrng: omap3-rom - Handle return value of clk_prepare_enable
>       crypto: img-hash - Handle return value of clk_prepare_enable
>       dmaengine: DW DMAC: Handle return value of clk_prepare_enable
>       gpio: davinci: Handle return value of clk_prepare_enable
>       cpufreq: kirkwood-cpufreq:- Handle return value of
> clk_prepare_enable()
>       dmaengine: imx-sdma: Handle return value of clk_prepare_enable
>       Input: s3c2410_ts - handle return value of clk_prepare_enable
>       iio: adc: xilinx: Handle return value of clk_prepare_enable
>       iio:adc:lpc32xx Handle return value of clk_prepare_enable
>       memory: ti-aemif: Handle return value of clk_prepare_enable
>       spi: davinci: Handle return value of clk_prepare_enable
>       [media] tc358743: Handle return value of clk_prepare_enable
>       mtd: nand: orion: Handle return value of clk_prepare_enable
>       iio: Aspeed ADC - Handle return value of clk_prepare_enable
>       PM / devfreq: exynos-nocp: Handle return value of clk_prepare_enable
>       PM / devfreq: exynos-ppmu: Handle return value of clk_prepare_enable
>       usb: host: ehci-exynos: Handle return value of clk_prepare_enable
>       usb: mtu3: Handle return value of clk_prepare_enable
>       usb: mtu3: Handle return value of clk_prepare_enable
>       video: fbdev: pxafb: Handle return value of clk_prepare_enable
>       usb: gadget: mv_udc: Handle return value of clk_prepare_enable.
>       usb: dwc3: exynos: Handle return value of clk_prepare_enable
>       i2c: at91: Handle return value of clk_prepare_enable
>       i2c: emev2: Handle return value of clk_prepare_enable
>       usb: host: ohci-pxa27x: Handle return value of clk_prepare_enable
>       thermal: imx: Handle return value of clk_prepare_enable
>       thermal: hisilicon: Handle return value of clk_prepare_enable
>       PCI: rockchip: Check for clk_prepare_enable() errors during resume
>       watchdog: meson: Handle return value of clk_prepare_enable
>       watchdog: davinci: Handle return value of clk_prepare_enable
>       mfd: tc6393xb: Handle return value of clk_prepare_enable
>       ASoC: samsung: s3c2412: Handle return value of clk_prepare_enable.
>       ASoC: samsung: s3c24xx: Handle return value of clk_prepare_enable.
>       ASoC: samsung: pcm: Handle return value of clk_prepare_enable.
>       ASoC: samsung: i2s: Handle return value of clk_prepare_enable.
>       ASoC: samsung: spdif: Handle return value of clk_prepare_enable.
>       ASoC: mxs-saif: Handle return value of clk_prepare_enable/clk_prepare.
>       ASoC: jz4740: Handle return value of clk_prepare_enable.
>       ASoC: sun4i-spdif: Handle return value of clk_prepare_enable.
>       ASoC: atmel: ac97c: Handle return value of clk_prepare_enable.
>       gpio: mb86s7x: Handle return value of clk_prepare_enable.
>       memory: mtk-smi: Handle return value of clk_prepare_enable
>       mmc: sdhci-st: Handle return value of clk_prepare_enable
>       mmc: wmt-sdmmc: Handle return value of clk_prepare_enable
>       mmc: mxcmmc: Handle return value of clk_prepare_enable
>       dmaengine: at_xdmac: Handle return value of clk_prepare_enable.
>       mtd: nand: denali: Handle return value of clk_prepare_enable.
>       mtd: oxnas_nand: Handle clk_prepare_enable/clk_disable_unprepare.
>       mtd: nand: lpc32xx_slc: Handle return value of clk_prepare_enable.
>       mtd: nand: lpc32xx_mlc: Handle return value of clk_prepare_enable.
>       mtd: st_spi_fsm: Handle clk_prepare_enable/clk_disable_unprepare.
> 
> Some of these are after a devm_clk_get(), which does not require a
> modification in the error handling path (at least according to the one I've
> looked at)
> 
> Some don't have any [devm_]clk_get() in the same function, and were not
> investigated further.
> 
> But several also had the same construction as the one reported in this
> thread, and needed, IMHO, an update of the error handling path to call
> through clk_put().
> 
> 
> It was "too" surprising to me to have "all" these "obviously" incomplete
> patches merged.
> I thought that I had missed something obvious and decided to propose one fix
> to see the reaction (and didn't expected all your replies!)
> 

You didn't miss anything, that's exactly what I am complaining about
some of the patches were OK, some aren't and all the real work is left
to the maintainer.

> So now, I think we should go through the commits above to either revert the
> commit and remove the test (and document why it is not needed) or fix the
> error handling path accordingly, even if one could know that it cant'
> happen.

I think you should go ahead and fix those now...

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
