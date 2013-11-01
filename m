From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 0/4] Add dual-fifo mode support of i.MX ssi
Date: Fri, 1 Nov 2013 17:11:58 +0800
Message-ID: <20131101091156.GC10324@S2101-09.ap.freescale.net>
References: <cover.1383226444.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1383226444.git.b42378@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <b42378@freescale.com>, Vinod Koul <vinod.koul@intel.com>
Cc: timur@tabi.org, broonie@kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk
List-Id: alsa-devel@alsa-project.org

Nicolin,

The dmaengine maintainer Vinod Koul should be copied on the series.
(Just added).

On Thu, Oct 31, 2013 at 09:44:12PM +0800, Nicolin Chen wrote:
> Nicolin Chen (4):
>   dma: imx-sdma: Add sdma firmware version 2 support
>   dma: imx-sdma: Add new dma type for ssi dual fifo script
>   ASoC: fsl_ssi: Add dual fifo mode support
>   ARM: dts: imx: use dual-fifo sdma script for ssi

Vinod,

To keep git bisect, the series has to be merged through single tree.
Since Mark has ACK-ed patch #3, I think it's easier to merge the series
through your tree, so for patch #4:

Acked-by: Shawn Guo <shawn.guo@linaro.org>
