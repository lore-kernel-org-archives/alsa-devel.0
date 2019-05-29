From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 0/3] Add mclk0 clock source for SAI
Date: Wed, 29 May 2019 16:03:57 -0700
Message-ID: <20190529230357.GB17556@Asurada-Nvidia.nvidia.com>
References: <20190528132034.3908-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190528132034.3908-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "timur@kernel.org" <timur@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa->
List-Id: alsa-devel@alsa-project.org

On Tue, May 28, 2019 at 01:20:46PM +0000, Daniel Baluta wrote:

> 1) SAI clock source select MUX is really part of the hardware
> 2) flexibility! We let DT tell us which is the option for MUX
> option 0.

I think the "MUX" is plausible comparing to your previous version.
As long as DT maintainers ack the DT binding doc, I would be okay
to ack too. Just one comments at the dts/dtsi changes, I know the
driver would just warn old DTs, but it does change the behavior at
the mclk_clk[0] from previously bus_clk to NULL after this series.
