From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH v2 09/18] irqchip: Add driver for Cirrus Logic Madera
 codecs
Date: Wed, 10 May 2017 17:03:46 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1705101634390.1979@nanos>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com> <1493050124-5970-10-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493050124-5970-10-git-send-email-rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Apr 2017, Richard Fitzgerald wrote:
> +
> +struct madera_irq_priv {
> +	struct device *dev;
> +	int irq;
> +	struct regmap_irq_chip_data *irq_data;
> +	struct madera *madera;

Please write your struct definitions in a tabular fashion:

struct madera_irq_priv {
	struct device			*dev;
	int				irq;
	struct regmap_irq_chip_data	*irq_data;
	struct madera			*madera;

> +};
> +
> +static const struct regmap_irq madera_irqs[MADERA_NUM_IRQ] = {
> +	[MADERA_IRQ_FLL1_LOCK] =  { .reg_offset = 0,
> +				    .mask = MADERA_FLL1_LOCK_EINT1 },
> +	[MADERA_IRQ_FLL2_LOCK] =  { .reg_offset = 0,
> +				    .mask = MADERA_FLL2_LOCK_EINT1 },
> +	[MADERA_IRQ_FLL3_LOCK] =  { .reg_offset = 0,
> +				    .mask = MADERA_FLL3_LOCK_EINT1 },
> +	[MADERA_IRQ_FLLAO_LOCK] = { .reg_offset = 0,
> +				    .mask = MADERA_FLLAO_LOCK_EINT1 },
> +
> +	[MADERA_IRQ_MICDET1] = { .reg_offset = 4,
> +				 .mask = MADERA_MICDET1_EINT1 },
> +	[MADERA_IRQ_MICDET2] = { .reg_offset = 4,
> +				 .mask = MADERA_MICDET2_EINT1 },
> +	[MADERA_IRQ_HPDET] =   { .reg_offset = 4,
> +				 .mask = MADERA_HPDET_EINT1 },
> +
> +	[MADERA_IRQ_MICD_CLAMP_RISE] = { .reg_offset = 5,
> +					 .mask = MADERA_MICD_CLAMP_RISE_EINT1 },

This is hard to read, makes my eyes hurt and takes way too many lines.

#define REGMAP_IRQ(_irq, _off, _mask)                    	\
        [MADERA_IRQ_##_irq] = { .reg_offset = (_off),	 	\
			    	.mask = MADERA_##_irq_EINT1) }

static const struct regmap_irq madera_irqs[MADERA_NUM_IRQ] = {
	REGMAP_IRQ(FLL1_LOCK,		0),
	REGMAP_IRQ(FLL2_LOCK,		0),
	....
	REGMAP_IRQ(MICD_CLAMP_RISE,	5),

Hmm?

> +
> +static const struct regmap_irq_chip madera_irq = {
> +	.name = "madera IRQ",

Again. Tabluar fashion, please.

> +	.status_base = MADERA_IRQ1_STATUS_2,
> +	.mask_base = MADERA_IRQ1_MASK_2,
> +	.ack_base = MADERA_IRQ1_STATUS_2,
> +	.runtime_pm = true, /* codec must be resumed to read IRQ status */

Please do not use tail comments. Aside of that this comment is superfluous.

> +	.num_regs = 32,
> +	.irqs = madera_irqs,
> +	.num_irqs = ARRAY_SIZE(madera_irqs),
> +};
> +
> +static int madera_map_irq(struct madera *madera, int irq)
> +{
> +	struct madera_irq_priv *priv = dev_get_drvdata(madera->irq_dev);
> +
> +	if (irq < 0)
> +		return irq;

Why would irq be < 0 ?

> +
> +	if (!madera->irq_dev)
> +		return -ENOENT;
> +
> +	return regmap_irq_get_virq(priv->irq_data, irq);
> +}

> +static int madera_irq_probe(struct platform_device *pdev)
> +{
> +	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
> +	struct madera_irq_priv *priv;
> +	struct irq_data *irq_data;
> +	unsigned int irq_flags = madera->pdata.irqchip.irq_flags;
> +	int ret;
> +
> +	dev_dbg(&pdev->dev, "probe\n");
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = &pdev->dev;
> +	priv->madera = madera;
> +	priv->irq = madera->irq;
> +
> +	/* Read the flags from the interrupt controller if not specified */
> +	if (!irq_flags) {
> +		irq_data = irq_get_irq_data(priv->irq);
> +		if (!irq_data) {
> +			dev_err(priv->dev, "Invalid IRQ: %d\n", priv->irq);
> +			return -EINVAL;
> +		}
> +
> +		irq_flags = irqd_get_trigger_type(irq_data);
> +		if (irq_flags == IRQ_TYPE_NONE)
> +			irq_flags = IRQF_TRIGGER_LOW; /* Device default */

Please do not use tail comments. They are horrible to parse and disturb the
reading flow.

> +	}
> +
> +	if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) {
> +		dev_err(priv->dev,
> +			"Host interrupt not level-triggered\n");
> +		return -EINVAL;
> +	}
> +
> +	if (irq_flags & IRQF_TRIGGER_HIGH) {
> +		ret = regmap_update_bits(madera->regmap, MADERA_IRQ1_CTRL,
> +					 MADERA_IRQ_POL_MASK, 0);
> +		if (ret) {
> +			dev_err(priv->dev,
> +				"Failed to set IRQ polarity: %d\n", ret);
> +			return ret;
> +		}
> +	}

What makes sure that the hardware is NOT set to TRIGGER_HIGH when you want
to have TRIGGER_LOW?

> +static struct platform_driver madera_irq_driver = {
> +	.probe = madera_irq_probe,

Tabular layout please

> +	.remove = madera_irq_remove,
> +	.driver = {
> +		.name	= "madera-irq",
> +		.pm = &madera_irq_pm_ops,
> +	}
> +};
> +

Pointless newline

> +module_platform_driver(madera_irq_driver);
> +

> --- /dev/null
> +++ b/include/linux/irqchip/irq-madera-pdata.h
> @@ -0,0 +1,19 @@
> +
> +struct madera_irqchip_pdata {
> +	/** Mode for primary IRQ (defaults to active low) */

If you want to document your structs, then please use proper kerneldoc
style.

> +	unsigned int irq_flags;
> +};

Thanks,

	tglx
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
