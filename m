From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 02/10] ASoc: mxs: add mxs-saif driver
Date: Wed, 13 Jul 2011 10:03:46 +0900
Message-ID: <20110713010346.GA18959@opensource.wolfsonmicro.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-3-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1310483085-31442-3-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 12, 2011 at 11:04:37PM +0800, Dong Aisheng wrote:

Looks pretty good, a few small issues below.

> +	/* The SAIF clock should be either 384*fs or 512*fs */
> +	if (saif->mclk_in_use) {
> +		if (mclk % 32 == 0) {
> +			scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
> +			ret = clk_set_rate(saif->clk, 512 * rate);
> +		} else if (mclk % 48 == 0) {
> +			scr |= BM_SAIF_CTRL_BITCLK_BASE_RATE;
> +			ret = clk_set_rate(saif->clk, 384 * rate);
> +		}

What if MCLK is not set corectly for some reason?  We'll just silently
do nothing.

> +	if (ret)
> +		return  -EINVAL;

Should pass through any error codes we get.

In hw_params()...
> +	stat = __raw_readl(saif->base + SAIF_STAT);
> +	if (stat & BM_SAIF_STAT_BUSY) {
> +		dev_err(cpu_dai->dev, "error: busy\n");
> +		return -EBUSY;
> +	}

Does this work for simultaneous playback and record?  Perhaps you need
to set symmetric_rates in the DAI (if the hardware needs the same sample
rate for playback and record) and have a check here to see if we're
trying to apply the same configuration as we already have.

> +	struct mxs_saif *saif = dev_id;
> +	unsigned int stat;
> +
> +	stat = __raw_readl(saif->base + SAIF_STAT);
> +	if (stat & BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ)
> +		dev_dbg(saif->dev, "underrun!!! %d\n", ++saif->fifo_underrun);
> +
> +	if (stat & BM_SAIF_STAT_FIFO_OVERFLOW_IRQ)
> +		dev_dbg(saif->dev, "overrun!!! %d\n", ++saif->fifo_overrun);

Probably dev_err()?

> +	__raw_writel(BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ |
> +			BM_SAIF_STAT_FIFO_OVERFLOW_IRQ,
> +			saif->base + SAIF_STAT + MXS_CLR_ADDR);
> +
> +	return IRQ_HANDLED;

Should really check to see if underflow or overflow occurred and only
report handled if they did - otherwise we might have trouble with new
hardware blocks that have other interrupts.

> +	if (pdev->id >= 2)
> +		return -EINVAL;
> +	mxs_saif[pdev->id] = saif;

The id check should check for ARRAY_SIZE() mxs_saif[] to make updates
easier if a new chip has more ports.

> +	saif->dma_param.chan_irq = platform_get_irq(pdev, 1);
> +	if (saif->dma_param.chan_irq < 0) {

Does the IRQ requesting need to happen after you've set the base
address?  Otherwise there's a potential race if for some reason the IRQ
fires before we've got the data structures set up.
