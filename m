From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v2 05/11] ASoC: fsl-ssi: Add support for
	imx-pcm-fiq
Date: Sun, 14 Apr 2013 08:37:21 -0500
Message-ID: <516AB111.3000007@tabi.org>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
 <51620CEA.3010703@tabi.org> <20130414103819.GA27394@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by alsa0.perex.cz (Postfix) with ESMTP id E30A02615DC
 for <alsa-devel@alsa-project.org>; Sun, 14 Apr 2013 15:37:24 +0200 (CEST)
In-Reply-To: <20130414103819.GA27394@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Markus Pargmann wrote:
> I do not think it is possible. For example imx27 ssi does support
> DMA but for specific boards we have to use fiq instead (phycore-ac97).
> So I would prefer to define the DMA in the chip dtsi file and choose
> fiq, if necessary, in the board dts.

I'm not completely familiar with the way i.MX SSI bindings work, but isn't 
there some property that says, "this SSI needs to use this DMA channel"? 
So if that property is missing, then it means that there's no link between 
the SSI and a DMA channel, and so you need to use FIQ.

For example, for PowerPC bindings, we have this:

		ssi@16000 {
			compatible = "fsl,mpc8610-ssi";
			cell-index = <0>;
			reg = <0x16000 0x100>;
			interrupt-parent = <&mpic>;
			interrupts = <62 2>;
			fsl,mode = "i2s-slave";
			codec-handle = <&cs4270>;
-->			fsl,playback-dma = <&dma00>;
-->			fsl,capture-dma = <&dma01>;

So on PowerPC, if these two properties are missing, then we would use 
interrupt mode.


-- 
Timur Tabi
