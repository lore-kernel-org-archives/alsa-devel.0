From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ALSA: ac97c: Fix an error handling path in
 'atmel_ac97c_probe()'
Date: Thu, 31 Aug 2017 21:08:10 +0200
Message-ID: <11403b91-f38d-bcd7-de0b-b2bb59801725@wanadoo.fr>
References: <20170831044042.23306-1-christophe.jaillet@wanadoo.fr>
 <20170831081021.g4luo557ggtnyfyg@piout.net>
 <20170831101903.avhj5tqywpvfsj4u@sirena.org.uk>
 <s5h1snsjaey.wl-tiwai@suse.de>
 <20170831103825.77shnqzi7ykpm7ah@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr
 [80.12.242.124])
 by alsa0.perex.cz (Postfix) with ESMTP id CBF63266B70
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 21:08:20 +0200 (CEST)
In-Reply-To: <20170831103825.77shnqzi7ykpm7ah@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com, garsilva@embeddedor.com, arvind.yadav.cs@gmail.com, andriy.shevchenko@linux.intel.com, bhumirks@gmail.com
List-Id: alsa-devel@alsa-project.org

Le 31/08/2017 =E0 12:38, Mark Brown a =E9crit=A0:
> On Thu, Aug 31, 2017 at 12:31:33PM +0200, Takashi Iwai wrote:
>
>> This is again a typical problem by such a trivial fix patch: the code
>> looks as if it were trivial and correct, buried in a patch series that
>> easily leads to the oversight by the maintainer's review.
> Right, plus the amount of context that diff shows you.
>
Hi,

My proposed patch was initially triggered using coccinelle, as you must =

have guessed.

In fact, I was surprised by the initial commit.
I don't have any strong opinion if testing the return value of =

'clk_prepare_enable()' is relevant or not, but I was surprised that the =

error handling path had not been updated at the same time.

So, before posting my patch, I have searched a bit in git history and it =

gave:

git shortlog --author=3D"Arvind Yadav" | grep clk_prepare
 =A0=A0=A0=A0=A0 ata: sata_rcar: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 hwrng: omap3-rom - Handle return value of clk_prepare_enab=
le
 =A0=A0=A0=A0=A0 crypto: img-hash - Handle return value of clk_prepare_enab=
le
 =A0=A0=A0=A0=A0 dmaengine: DW DMAC: Handle return value of clk_prepare_ena=
ble
 =A0=A0=A0=A0=A0 gpio: davinci: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 cpufreq: kirkwood-cpufreq:- Handle return value of =

clk_prepare_enable()
 =A0=A0=A0=A0=A0 dmaengine: imx-sdma: Handle return value of clk_prepare_en=
able
 =A0=A0=A0=A0=A0 Input: s3c2410_ts - handle return value of clk_prepare_ena=
ble
 =A0=A0=A0=A0=A0 iio: adc: xilinx: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 iio:adc:lpc32xx Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 memory: ti-aemif: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 spi: davinci: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 [media] tc358743: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 mtd: nand: orion: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 iio: Aspeed ADC - Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 PM / devfreq: exynos-nocp: Handle return value of clk_prep=
are_enable
 =A0=A0=A0=A0=A0 PM / devfreq: exynos-ppmu: Handle return value of clk_prep=
are_enable
 =A0=A0=A0=A0=A0 usb: host: ehci-exynos: Handle return value of clk_prepare=
_enable
 =A0=A0=A0=A0=A0 usb: mtu3: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 usb: mtu3: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 video: fbdev: pxafb: Handle return value of clk_prepare_en=
able
 =A0=A0=A0=A0=A0 usb: gadget: mv_udc: Handle return value of clk_prepare_en=
able.
 =A0=A0=A0=A0=A0 usb: dwc3: exynos: Handle return value of clk_prepare_enab=
le
 =A0=A0=A0=A0=A0 i2c: at91: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 i2c: emev2: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 usb: host: ohci-pxa27x: Handle return value of clk_prepare=
_enable
 =A0=A0=A0=A0=A0 thermal: imx: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 thermal: hisilicon: Handle return value of clk_prepare_ena=
ble
 =A0=A0=A0=A0=A0 PCI: rockchip: Check for clk_prepare_enable() errors durin=
g resume
 =A0=A0=A0=A0=A0 watchdog: meson: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 watchdog: davinci: Handle return value of clk_prepare_enab=
le
 =A0=A0=A0=A0=A0 mfd: tc6393xb: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 ASoC: samsung: s3c2412: Handle return value of clk_prepare=
_enable.
 =A0=A0=A0=A0=A0 ASoC: samsung: s3c24xx: Handle return value of clk_prepare=
_enable.
 =A0=A0=A0=A0=A0 ASoC: samsung: pcm: Handle return value of clk_prepare_ena=
ble.
 =A0=A0=A0=A0=A0 ASoC: samsung: i2s: Handle return value of clk_prepare_ena=
ble.
 =A0=A0=A0=A0=A0 ASoC: samsung: spdif: Handle return value of clk_prepare_e=
nable.
 =A0=A0=A0=A0=A0 ASoC: mxs-saif: Handle return value of =

clk_prepare_enable/clk_prepare.
 =A0=A0=A0=A0=A0 ASoC: jz4740: Handle return value of clk_prepare_enable.
 =A0=A0=A0=A0=A0 ASoC: sun4i-spdif: Handle return value of clk_prepare_enab=
le.
 =A0=A0=A0=A0=A0 ASoC: atmel: ac97c: Handle return value of clk_prepare_ena=
ble.
 =A0=A0=A0=A0=A0 gpio: mb86s7x: Handle return value of clk_prepare_enable.
 =A0=A0=A0=A0=A0 memory: mtk-smi: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 mmc: sdhci-st: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 mmc: wmt-sdmmc: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 mmc: mxcmmc: Handle return value of clk_prepare_enable
 =A0=A0=A0=A0=A0 dmaengine: at_xdmac: Handle return value of clk_prepare_en=
able.
 =A0=A0=A0=A0=A0 mtd: nand: denali: Handle return value of clk_prepare_enab=
le.
 =A0=A0=A0=A0=A0 mtd: oxnas_nand: Handle clk_prepare_enable/clk_disable_unp=
repare.
 =A0=A0=A0=A0=A0 mtd: nand: lpc32xx_slc: Handle return value of clk_prepare=
_enable.
 =A0=A0=A0=A0=A0 mtd: nand: lpc32xx_mlc: Handle return value of clk_prepare=
_enable.
 =A0=A0=A0=A0=A0 mtd: st_spi_fsm: Handle clk_prepare_enable/clk_disable_unp=
repare.

Some of these are after a devm_clk_get(), which does not require a =

modification in the error handling path (at least according to the one =

I've looked at)

Some don't have any [devm_]clk_get() in the same function, and were not =

investigated further.

But several also had the same construction as the one reported in this =

thread, and needed, IMHO, an update of the error handling path to call =

through clk_put().


It was "too" surprising to me to have "all" these "obviously" incomplete =

patches merged.
I thought that I had missed something obvious and decided to propose one =

fix to see the reaction (and didn't expected all your replies!)

So now, I think we should go through the commits above to either revert =

the commit and remove the test (and document why it is not needed) or =

fix the error handling path accordingly, even if one could know that it =

cant' happen.

CJ
