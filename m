From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Convert non-SoC PXA2xx AC97 driver to clock API
Date: Thu, 21 Feb 2008 15:27:41 +0000
Message-ID: <20080221152741.GB19670@flint.arm.linux.org.uk>
References: <20080219160341.GA6387@rakim.wolfsonmicro.main>
	<1203437058-7288-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1203437058-7288-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1203437058-7288-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1203437058-7288-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <1203437058-7288-4-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, eric miao <eric.miao@marvell.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 19, 2008 at 04:04:18PM +0000, Mark Brown wrote:
> @@ -335,8 +340,21 @@ static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
>  #ifdef CONFIG_PXA27x
>  	/* Use GPIO 113 as AC97 Reset on Bulverde */
>  	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
> +	ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
> +	if (IS_ERR(ac97conf_clk)) {
> +		ac97conf_clk = NULL;
> +		ret = -ENODEV;

Same comments as previous patch.

> +		goto err;
> +	}
>  #endif
> -	pxa_set_cken(CKEN_AC97, 1);
> +
> +	ac97_clk = clk_get(&dev->dev, "AC97CLK");
> +	if (IS_ERR(ac97_clk)) {
> +		ac97_clk = NULL;
> +		ret = -ENODEV;

Ditto.

> +		goto err;
> +	}
> +	clk_enable(ac97_clk);
>  
>  	ret = snd_ac97_bus(card, 0, &pxa2xx_ac97_ops, NULL, &ac97_bus);
>  	if (ret)
> @@ -361,11 +379,20 @@ static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
>   err:
>  	if (card)
>  		snd_card_free(card);
> -	if (CKEN & (1 << CKEN_AC97)) {
> +	if (ac97_clk) {
>  		GCR |= GCR_ACLINK_OFF;
>  		free_irq(IRQ_AC97, NULL);
> -		pxa_set_cken(CKEN_AC97, 0);
> +		clk_disable(ac97_clk);
> +		clk_put(ac97_clk);
> +		ac97_clk = NULL;
> +	}
> +#ifdef CONFIG_PXA27x
> +	if (ac97conf_clk) {
> +		clk_disable(ac97conf_clk);

This might disable the clock more times than its been enabled, particularly
if the getting of ac97_clk fails.


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
