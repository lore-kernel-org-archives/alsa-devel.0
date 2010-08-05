From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
 variable SSI FIFO depth
Date: Thu, 5 Aug 2010 12:10:11 +0100
Message-ID: <20100805111010.GA13146@rakim.wolfsonmicro.main>
References: <1280952264-21813-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00CEF103881
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 13:10:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1280952264-21813-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 04, 2010 at 03:04:24PM -0500, Timur Tabi wrote:
> Add code that programs the DMA and SSI controllers differently based on the
> FIFO depth of the SSI.
> 
> The SSI devices on the MPC8610 and the P1022 are identical in every way except
> one: the transmit and receive FIFO depth.  On the MPC8610, the depth is eight.
> On the P1022, it's fifteen.  The device tree nodes for the SSI include a
> "fsl,fifo-depth" property that specifies the FIFO depth.

My first thought with this is that it's not something I'd expect to be
in the device tree at all - it looks like it's all properties of the
silicon which I'd expect the drivers to be able to figure out for
themselves without needing to be told by the device tree.
