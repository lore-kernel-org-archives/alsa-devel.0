From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 05/11] ASoC: fsl-ssi: Add support for
	imx-pcm-fiq
Date: Sun, 14 Apr 2013 16:10:15 +0200
Message-ID: <20130414141015.GC27394@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
 <51620CEA.3010703@tabi.org> <20130414103819.GA27394@pengutronix.de>
 <516AB111.3000007@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 9D65D2615E1
 for <alsa-devel@alsa-project.org>; Sun, 14 Apr 2013 16:10:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <516AB111.3000007@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 14, 2013 at 08:37:21AM -0500, Timur Tabi wrote:
> Markus Pargmann wrote:
> >I do not think it is possible. For example imx27 ssi does support
> >DMA but for specific boards we have to use fiq instead (phycore-ac97).
> >So I would prefer to define the DMA in the chip dtsi file and choose
> >fiq, if necessary, in the board dts.
>
> I'm not completely familiar with the way i.MX SSI bindings work, but
> isn't there some property that says, "this SSI needs to use this DMA
> channel"? So if that property is missing, then it means that there's
> no link between the SSI and a DMA channel, and so you need to use
> FIQ.
>
> For example, for PowerPC bindings, we have this:
>
> 		ssi@16000 {
> 			compatible = "fsl,mpc8610-ssi";
> 			cell-index = <0>;
> 			reg = <0x16000 0x100>;
> 			interrupt-parent = <&mpic>;
> 			interrupts = <62 2>;
> 			fsl,mode = "i2s-slave";
> 			codec-handle = <&cs4270>;
> -->			fsl,playback-dma = <&dma00>;
> -->			fsl,capture-dma = <&dma01>;
>
> So on PowerPC, if these two properties are missing, then we would
> use interrupt mode.

In general, imx27 does support SSI with DMA, for example
MACH_IMX27_VISSTRIM_M10 does use SSI with DMA. But there are special
boards like Eukrea TLV320 and phycore-ac97 that have to use FIQ instead.
All of them have a imx27 chip.
The imx27 SSI node (not posted yet) using the generic DMA bindings:

	ssi1: ssi@10010000 {
		compatible = "fsl,imx21-ssi";
		reg = <0x10010000 0x1000>;
		interrupts = <14>;
		dmas = <&dma 13
			&dma 12
			&dma 15
			&dma 14>;
		dma-names = "tx", "rx", "tx1", "rx1";
		clocks = <&clks 26>;
		clock-names = "ipg";
		fsl,mode = "i2s-slave";
		status = "disabled";
	};

So instead of defining the dma channels in imx27.dtsi, we could define
them only in board dts files. But that would duplicate the DMA property for
every board using DMA. The alternative is the "fsl,imx-fiq" property as
introduced in this patch.

Regards,

Markus

--
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
