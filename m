From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] asoc/multi-component: fsl: add
	support for	variable SSI FIFO depth
Date: Sat, 7 Aug 2010 13:27:39 +0100
Message-ID: <20100807122739.GA11817@opensource.wolfsonmicro.com>
References: <1281114972-21450-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 550D824457
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 14:27:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281114972-21450-1-git-send-email-timur@freescale.com>
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

On Fri, Aug 06, 2010 at 12:16:12PM -0500, Timur Tabi wrote:
> Add code that programs the DMA and SSI controllers differently based on the
> FIFO depth of the SSI.
> 
> The SSI devices on the MPC8610 and the P1022 are identical in every way except
> one: the transmit and receive FIFO depth.  On the MPC8610, the depth is eight.
> On the P1022, it's fifteen.  The device tree nodes for the SSI include a
> "fsl,fifo-depth" property that specifies the FIFO depth.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
