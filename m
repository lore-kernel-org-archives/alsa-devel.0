From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: add DMA platform driver for MX1x
 and MX2x
Date: Tue, 4 Aug 2009 20:00:39 +0100
Message-ID: <20090804190039.GB4342@sirena.org.uk>
References: <eedb5540908040817kbd91dc0r40927c0bd67c51d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 136892439C
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 21:00:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <eedb5540908040817kbd91dc0r40927c0bd67c51d4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 04, 2009 at 05:17:52PM +0200, javier Martin wrote:
> This adds support for DMA platform valid for i.MX1 and i.MX2 platforms.
> 
> This is not valid for i.MX3 since it doesn't share the same DMA
> interface than i.MX1 and i.MX2.
> 
> It has been tested on i.MX27 board.

> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

This looks basically good.  I'll need to check to make sure it's up to
date against the more current code but if there's anything wrong there
it'll be fairly minor stuff.

> +	depends on (ARCH_MX2 || ARCH_MX1) && SND

No need to depend on SND, the menu will stop the configuration being
visible if it's not selected.

> +		ret = imx_dma_setup_single(prtd->dma_ch, mem_addr,
> +					dma_size, dev_addr,
> +					prtd->dma_params->transfer_type);
> +		if (ret < 0) {
> +			printk(KERN_ERR "Error configuring DMA\n");
> +			return ret;
> +		}

It'd be nice to print out ret here - the same thing applies in quite a
few other places in the driver.

> +#ifndef _MXC_PCM_H
> +#define _MXC_PCM_H
> +
> +/* AUDMUX register definitions */
> +#define AUDMUX_IO_BASE_ADDR	IO_ADDRESS(AUDMUX_BASE_ADDR)
> +
> +#define DAM_HPCR1	(*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x00)))
> +#define DAM_HPCR2	(*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x04)))
> +#define DAM_HPCR3	(*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x08)))
> +#define DAM_PPCR1	(*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x10)))
> +#define DAM_PPCR2	(*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x14)))
> +#define DAM_PPCR3	(*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x1C)))
> +
> +#define AUDMUX_HPCR_TFSDIR	(1 << 31)
> +#define AUDMUX_HPCR_TCLKDIR	(1 << 30)
> +#define AUDMUX_HPCR_TFCSEL(x)	(((x) & 0xff) << 26)
> +#define AUDMUX_HPCR_RXDSEL(x)	(((x) & 0x7) << 13)
> +#define AUDMUX_HPCR_SYN		(1 << 12)
> +
> +#define AUDMUX_PPCR_TFSDIR	(1 << 31)
> +#define AUDMUX_PPCR_TCLKDIR	(1 << 30)
> +#define AUDMUX_PPCR_TFCSEL(x)	(((x) & 0xff) << 26)
> +#define AUDMUX_PPCR_RXDSEL(x)	(((x) & 0x7) << 13)
> +#define AUDMUX_PPCR_SYN		(1 << 12)

Hrm.  I suspect these should be under arch/arm somewhere; they're not
actually used by this driver so could be removed.
