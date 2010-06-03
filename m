From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC][PATCH 21/26] alsa: ASoC: Add JZ4740 ASoC support
Date: Thu, 03 Jun 2010 21:27:44 +0200
Message-ID: <4C080230.1070909@metafoo.de>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de> <1275505950-17334-5-git-send-email-lars@metafoo.de> <20100603175511.GI2762@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100603175511.GI2762@rakim.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Wed, Jun 02, 2010 at 09:12:27PM +0200, Lars-Peter Clausen wrote:
>
> Again, overall very good.
>
>   
>> +static int jz4740_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
>> +{
>> +	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
>> +
>> +	switch (div_id) {
>> +	case JZ4740_I2S_BIT_CLK:
>> +		if (div & 1 || div > 16)
>> +			return -EINVAL;
>> +		jz4740_i2s_write(i2s, JZ_REG_AIC_CLK_DIV, div - 1);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>>     
>
> You can probably figure out the bit clock automatically by default...
>   
Hm, yes, you are right.
>   
>> +	if (dai->active) {
>> +		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
>> +		conf &= ~JZ_AIC_CONF_ENABLE;
>> +		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
>> +
>> +		clk_disable(i2s->clk_i2s);
>> +	}
>> +
>> +	clk_disable(i2s->clk_aic);
>>     
>
> Might make sense to manage this clock dynamically at runtime too for a
> little extra power saving?
>   
I think I tried it once and the power savings were marginal. On the
other hand each callback would have to make sure the clock is enabled
before accessing registers and disabling it again if it was disabled.
>   
>> +	i2s->clk_aic = clk_get(&pdev->dev, "aic");
>> +	if (IS_ERR(i2s->clk_aic)) {
>> +		ret = PTR_ERR(i2s->clk_aic);
>> +		goto err_iounmap;
>> +	}
>> +
>> +	i2s->clk_i2s = clk_get(&pdev->dev, "i2s");
>> +	if (IS_ERR(i2s->clk_i2s)) {
>> +		ret = PTR_ERR(i2s->clk_i2s);
>> +		goto err_iounmap;
>> +	}
>>     
>
> Ideally you'd free the AIC clock when unwinding (and later stop it after
> it was enabled).  Though since you don't do any error checking after
> this point it's kind of academic :)
>
>   
It should at least freed if the i2s clock is not found.

- Lars
