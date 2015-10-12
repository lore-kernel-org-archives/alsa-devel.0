From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: multi-codec support for arizona-ldo1 was Re: System with
 multiple arizona (wm5102) codecs
Date: Mon, 12 Oct 2015 12:37:02 +0100
Message-ID: <20151012113702.GC8805@ck-lbox>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
 <20151012090045.GA7448@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151012090045.GA7448@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 12, 2015 at 11:00:45AM +0200, Pavel Machek wrote:
> Hi!
> 
> > I guess you would need to be careful with the machine driver as
> > well, you will need to use a snd_soc_codec_conf structure for at
> > least one (although I would do both) of the CODECs to give  a
> > prefix for all the widget/control names, otherwise those will
> > clash and everything will probably behave very strangely. See
> > sound/soc/samsung/bells.c for an example doing this for wm9081.
> 
> wm9081 is indeed useful example.
> 
> Does this look like a step in right direction?

Yeah looks reasonable a few comments added.

> 
> Thanks,
> 							Pavel
> 
> diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
> index 81d8681..2be9513 100644
> --- a/drivers/regulator/arizona-ldo1.c
> +++ b/drivers/regulator/arizona-ldo1.c
> @@ -27,13 +27,17 @@
>  #include <linux/mfd/arizona/registers.h>
>  
>  struct arizona_ldo1 {
> +	char name[99];

Can probably use a much smaller buffer here only really need a
couple of characters room on it.

>  	struct regulator_dev *regulator;
>  	struct arizona *arizona;
> +	struct regulator_desc desc;
>  
>  	struct regulator_consumer_supply supply;
>  	struct regulator_init_data init_data;
>  };
>  
> +
> +
>  static int arizona_ldo1_hc_list_voltage(struct regulator_dev *rdev,
>  					unsigned int selector)
>  {
> @@ -121,7 +125,6 @@ static struct regulator_ops arizona_ldo1_hc_ops = {
>  };
>  
>  static const struct regulator_desc arizona_ldo1_hc = {
> -	.name = "LDO1",
>  	.supply_name = "LDOVDD",
>  	.type = REGULATOR_VOLTAGE,
>  	.ops = &arizona_ldo1_hc_ops,
> @@ -146,7 +149,6 @@ static struct regulator_ops arizona_ldo1_ops = {
>  };
>  
>  static const struct regulator_desc arizona_ldo1 = {
> -	.name = "LDO1",
>  	.supply_name = "LDOVDD",
>  	.type = REGULATOR_VOLTAGE,
>  	.ops = &arizona_ldo1_ops,
> @@ -183,8 +185,8 @@ static const struct regulator_init_data arizona_ldo1_default = {
>  static int arizona_ldo1_probe(struct platform_device *pdev)
>  {
>  	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
> -	const struct regulator_desc *desc;
>  	struct regulator_config config = { };
> +	int id = 0;

Should the id not be coming from the pdev?

>  	struct arizona_ldo1 *ldo1;
>  	int ret;
>  
> @@ -194,8 +196,10 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +
> +
> +	printk("Initializing arizona-ldo1 for codec %d\n", id);
>  	ldo1->arizona = arizona;
> -
>  	/*
>  	 * Since the chip usually supplies itself we provide some
>  	 * default init_data for it.  This will be overridden with
> @@ -203,15 +207,18 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
>  	 */
>  	switch (arizona->type) {
>  	case WM5102:
> -		desc = &arizona_ldo1_hc;
>  		ldo1->init_data = arizona_ldo1_dvfs;
> +		ldo1->desc = arizona_ldo1_hc;
>  		break;
>  	default:
> -		desc = &arizona_ldo1;
>  		ldo1->init_data = arizona_ldo1_default;
> +		ldo1->desc = arizona_ldo1;
>  		break;
>  	}
>  
> +	ldo1->desc.name = ldo1->name;
> +	sprintf(ldo1->name, "LDO1_%d", id);

Would be nice to use an snprintf here.

Thanks,
Charles
