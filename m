From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: fix exit and
 error paths in DMA and SSI drivers
Date: Thu, 5 Aug 2010 06:52:31 -0700
Message-ID: <20100805135231.GC14470@opensource.wolfsonmicro.com>
References: <1280876128-19263-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B03D01038EE
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 15:52:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1280876128-19263-1-git-send-email-timur@freescale.com>
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

On Tue, Aug 03, 2010 at 05:55:28PM -0500, Timur Tabi wrote:
> The error handling code in the OF probe function of the SSI driver is not
> freeing all resources correctly.
> 
> Since the machine driver no longer calls the DMA driver to provide information
> about the SSI, we don't need to keep a list of DMA objects any more.  In
> addition, the fsl_soc_dma_remove() function is incorrectly removing *all*
> DMA objects when it should only remove one.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
