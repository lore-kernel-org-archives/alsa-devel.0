From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx: Add mclk0 clock for SAI
Date: Wed, 29 May 2019 15:57:48 -0700
Message-ID: <20190529225742.GA17556@Asurada-Nvidia.nvidia.com>
References: <20190528132034.3908-1-daniel.baluta@nxp.com>
 <20190528132034.3908-2-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190528132034.3908-2-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "timur@kernel.org" <timur@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa->
List-Id: alsa-devel@alsa-project.org

On Tue, May 28, 2019 at 01:21:00PM +0000, Daniel Baluta wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> Audio MCLK source option is selected with a 4:1 MUX
> controller using MCLK Select bits in SAI xCR2 register.
> 
> On imx6/7 mclk0 and mclk1 always point to the same clock
> source. Anyhow, this is no longer true for imx8.
> 
> For this reason, we need to add mclk0 and handle it
> in a generic way in SAI driver.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 6 ++++--
>  arch/arm/boot/dts/imx6ul.dtsi | 9 ++++++---
>  arch/arm/boot/dts/imx7s.dtsi  | 9 ++++++---

These are dtsi/dts files that have SAI missing mclk0:
arch/arm/boot/dts/imx6ul.dtsi
arch/arm/boot/dts/imx6sx.dtsi
arch/arm/boot/dts/ls1021a.dtsi
arch/arm/boot/dts/imx7s.dtsi
arch/arm/boot/dts/vfxxx.dtsi
arch/arm64/boot/dts/freescale/imx8mq.dtsi
arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi

Would it be possible for you to update the others also?

Thanks
Nicolin
