From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC V2: Improve pause/unpause
	performance in	Freescale 8610 drivers
Date: Wed, 6 Aug 2008 09:47:10 +0100
Message-ID: <20080806084710.GA19301@rakim.wolfsonmicro.main>
References: <1217965051-14051-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C9E2F2475B
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Aug 2008 10:47:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1217965051-14051-1-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 05, 2008 at 02:37:31PM -0500, Timur Tabi wrote:

> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied, thanks.

> +			 * Wait until the SSI has filled its FIFO. Without this
> +			 * delay, ALSA complains about overruns.  When the FIFO
> +			 * is full, the DMA controller initiates its first
> +			 * transfer.  Until then, however, the DMA's DAR
> +			 * register is zero, which translates to an
> +			 * out-of-bounds pointer.  This makes ALSA think an
> +			 * overrun has occurred.
>  			 */
> -			mdelay(1);
> +			while (!(in_be32(&ssi->sisr) & CCSR_SSI_SISR_RFF0));

It'd be nice to have a timeout here in case the FIFO never fills.
