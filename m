From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 21/26] alsa: ASoC: Add JZ4740 ASoC
	support
Date: Thu, 3 Jun 2010 18:55:11 +0100
Message-ID: <20100603175511.GI2762@rakim.wolfsonmicro.main>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
	<1275505950-17334-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B036D103AE9
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 19:55:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1275505950-17334-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 02, 2010 at 09:12:27PM +0200, Lars-Peter Clausen wrote:

Again, overall very good.

> +static int jz4740_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
> +{
> +	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
> +
> +	switch (div_id) {
> +	case JZ4740_I2S_BIT_CLK:
> +		if (div & 1 || div > 16)
> +			return -EINVAL;
> +		jz4740_i2s_write(i2s, JZ_REG_AIC_CLK_DIV, div - 1);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

You can probably figure out the bit clock automatically by default...

> +	if (dai->active) {
> +		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
> +		conf &= ~JZ_AIC_CONF_ENABLE;
> +		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
> +
> +		clk_disable(i2s->clk_i2s);
> +	}
> +
> +	clk_disable(i2s->clk_aic);

Might make sense to manage this clock dynamically at runtime too for a
little extra power saving?

> +	i2s->clk_aic = clk_get(&pdev->dev, "aic");
> +	if (IS_ERR(i2s->clk_aic)) {
> +		ret = PTR_ERR(i2s->clk_aic);
> +		goto err_iounmap;
> +	}
> +
> +	i2s->clk_i2s = clk_get(&pdev->dev, "i2s");
> +	if (IS_ERR(i2s->clk_i2s)) {
> +		ret = PTR_ERR(i2s->clk_i2s);
> +		goto err_iounmap;
> +	}

Ideally you'd free the AIC clock when unwinding (and later stop it after
it was enabled).  Though since you don't do any error checking after
this point it's kind of academic :)
