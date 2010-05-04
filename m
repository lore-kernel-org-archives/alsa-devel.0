From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] powerpc/8610: add probing for
 individual DMA channels, not just DMA controllers
Date: Tue, 4 May 2010 15:54:30 +0100
Message-ID: <20100504145430.GC3651@opensource.wolfsonmicro.com>
References: <1272923655-31807-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2244C24656
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 16:54:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272923655-31807-1-git-send-email-timur@freescale.com>
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
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, May 03, 2010 at 04:54:15PM -0500, Timur Tabi wrote:

>  	{ .compatible = "simple-bus", },
> -	{ .compatible = "gianfar", },
> +	/* So that the DMA channel nodes can be probed individually: */
> +	{ .compatible = "fsl,eloplus-dma", },
>  	{}

The removal of gianfar looks a bit surprising here - if it's not a
mistake a note in the changelog would be useful.
