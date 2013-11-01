From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v4 0/4] Add dual-fifo mode support of i.MX
	ssi
Date: Fri, 1 Nov 2013 17:33:27 +0800
Message-ID: <20131101093326.GE28401@MrMyself>
References: <cover.1383226444.git.b42378@freescale.com>
 <20131101091156.GC10324@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 by alsa0.perex.cz (Postfix) with ESMTP id A0F6E265243
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 10:45:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131101091156.GC10324@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, s.hauer@pengutronix.de, swarren@wwwdotorg.org, timur@tabi.org, rob.herring@calxeda.com, linux-kernel@vger.kernel.org, broonie@kernel.org, dmaengine@vger.kernel.org, ijc+devicetree@hellion.org.uk, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 01, 2013 at 05:11:58PM +0800, Shawn Guo wrote:
> Nicolin,
> 
> The dmaengine maintainer Vinod Koul should be copied on the series.
> (Just added).
>

Ah, I was careless last night when I sent these patches. My VPN connection
was pretty laggy :( Please forgive me, Vinod.

Thank Shawn for adding for me. Much obliged.

> On Thu, Oct 31, 2013 at 09:44:12PM +0800, Nicolin Chen wrote:
> > Nicolin Chen (4):
> >   dma: imx-sdma: Add sdma firmware version 2 support
> >   dma: imx-sdma: Add new dma type for ssi dual fifo script
> >   ASoC: fsl_ssi: Add dual fifo mode support
> >   ARM: dts: imx: use dual-fifo sdma script for ssi
> 
> Vinod,
> 
> To keep git bisect, the series has to be merged through single tree.
> Since Mark has ACK-ed patch #3, I think it's easier to merge the series
> through your tree, so for patch #4:
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
