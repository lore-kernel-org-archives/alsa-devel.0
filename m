From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] Convert WM97xx driver to use
	platform_data
Date: Thu, 23 Jul 2009 12:49:00 +0100
Message-ID: <20090723114900.GE6673@rakim.wolfsonmicro.main>
References: <200907211633.14388.marek.vasut@gmail.com>
	<20090721223424.GA21147@oksana.dev.rtsoft.ru>
	<200907221301.04239.marek.vasut@gmail.com>
	<200907221304.16534.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2E4A7244F4
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 13:49:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907221304.16534.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Robert Jarzmik <robert.jarzmik@free.fr>, cbou@mail.ru, Eric Miao <eric.y.miao@gmail.com>, avorontsov@ru.mvista.com, dwmw2@infradead.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 22, 2009 at 01:04:16PM +0200, Marek Vasut wrote:

> diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
> index 252eb11..f944918 100644
> --- a/drivers/input/touchscreen/wm97xx-core.c
> +++ b/drivers/input/touchscreen/wm97xx-core.c
> @@ -561,6 +561,7 @@ static void wm97xx_ts_input_close(struct input_dev *idev)
>  static int wm97xx_probe(struct device *dev)
>  {
>  	struct wm97xx *wm;
> +	struct wm97xx_pdata *pdata = dev->platform_data;
>  	int ret = 0, id = 0;
>  
>  	wm = kzalloc(sizeof(struct wm97xx), GFP_KERNEL);

> +++ b/drivers/power/wm97xx_battery.c
> @@ -22,17 +22,19 @@
>  #include <linux/spinlock.h>
>  #include <linux/interrupt.h>
>  #include <linux/gpio.h>
> -#include <linux/wm97xx_batt.h>
> +#include <linux/irq.h>

...

> +static irqreturn_t wm97xx_chrg_irq(int irq, void *data)
> +{
> +	schedule_work(&bat_work);
> +	return IRQ_HANDLED;
> +}
> +

> -	if (pdata->charge_gpio >= 0 && gpio_is_valid(pdata->charge_gpio)) {
> +	if (gpio_is_valid(pdata->charge_gpio)) {
>  		ret = gpio_request(pdata->charge_gpio, "BATT CHRG");
>  		if (ret)
>  			goto err;
>  		ret = gpio_direction_input(pdata->charge_gpio);
>  		if (ret)
>  			goto err2;
> +		ret = request_irq(gpio_to_irq(pdata->charge_gpio),
> +				wm97xx_chrg_irq, IRQF_DISABLED,
> +				"AC Detect", 0);
> +		if (ret)
> +			goto err2;
>  		props++;	/* POWER_SUPPLY_PROP_STATUS */

None of these hunks appear to be related to the change in where the
platform data is coming from and should be split out, as should all the
error handling code which follows.

> -void __init wm97xx_bat_set_pdata(struct wm97xx_batt_info *data)
> -{
> -	pdata = data;
> -}
> -EXPORT_SYMBOL_GPL(wm97xx_bat_set_pdata);
> -

This change and the removal of the old structure should ideally be
included in the commit which converts all the users to avoid build
errors during bisection.  I'd say it's OK to have the driver just print
a warning or something if someone boots the affected kernel during the
transition period.
