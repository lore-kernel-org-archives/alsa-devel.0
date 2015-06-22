From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: rt5677: Switch to use unified
 device property API
Date: Tue, 23 Jun 2015 00:18:54 +0200
Message-ID: <558889CE.7010104@linux.intel.com>
References: <1434996780-34535-1-git-send-email-benzh@chromium.org>
 <1434996780-34535-2-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EC182604E2
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 00:19:01 +0200 (CEST)
In-Reply-To: <1434996780-34535-2-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Anatol Pomozov <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 6/22/15 8:13 PM, Ben Zhang wrote:
> This patch makes the driver use the unified device property API
> so that platform data can be provided by Device Tree, ACPI
> or board files.
>
> Signed-off-by: Ben Zhang <benzh@chromium.org>
> ---
>   sound/soc/codecs/rt5677.c | 57 +++++++++++++++++++++--------------------------
>   1 file changed, 25 insertions(+), 32 deletions(-)
>
> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> index c166217..69e45d8 100644
> --- a/sound/soc/codecs/rt5677.c
> +++ b/sound/soc/codecs/rt5677.c
> @@ -20,6 +20,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/spi/spi.h>
>   #include <linux/firmware.h>
> +#include <linux/property.h>
>   #include <sound/core.h>
>   #include <sound/pcm.h>
>   #include <sound/pcm_params.h>
> @@ -5018,27 +5019,29 @@ static const struct i2c_device_id rt5677_i2c_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
>
> -static int rt5677_parse_dt(struct rt5677_priv *rt5677, struct device_node *np)
> +static void rt5677_read_device_properties(struct rt5677_priv *rt5677,
> +		struct device *dev)
>   {
> -	rt5677->pdata.in1_diff = of_property_read_bool(np,
> -					"realtek,in1-differential");
> -	rt5677->pdata.in2_diff = of_property_read_bool(np,
> -					"realtek,in2-differential");
> -	rt5677->pdata.lout1_diff = of_property_read_bool(np,
> -					"realtek,lout1-differential");
> -	rt5677->pdata.lout2_diff = of_property_read_bool(np,
> -					"realtek,lout2-differential");
> -	rt5677->pdata.lout3_diff = of_property_read_bool(np,
> -					"realtek,lout3-differential");
> -
> -	of_property_read_u8_array(np, "realtek,gpio-config",
> -		rt5677->pdata.gpio_config, RT5677_GPIO_NUM);
> -
> -	of_property_read_u32(np, "realtek,jd1-gpio", &rt5677->pdata.jd1_gpio);
> -	of_property_read_u32(np, "realtek,jd2-gpio", &rt5677->pdata.jd2_gpio);
> -	of_property_read_u32(np, "realtek,jd3-gpio", &rt5677->pdata.jd3_gpio);
> -
> -	return 0;
> +	rt5677->pdata.in1_diff = device_property_read_bool(dev,
> +			"realtek,in1-differential");

Shouldn't it be device_property_present() ?
thanks for starting this transition, this will be very useful for 
ACPI-based solutions.
-Pierre

> +	rt5677->pdata.in2_diff = device_property_read_bool(dev,
> +			"realtek,in2-differential");
> +	rt5677->pdata.lout1_diff = device_property_read_bool(dev,
> +			"realtek,lout1-differential");
> +	rt5677->pdata.lout2_diff = device_property_read_bool(dev,
> +			"realtek,lout2-differential");
> +	rt5677->pdata.lout3_diff = device_property_read_bool(dev,
> +			"realtek,lout3-differential");
> +
> +	device_property_read_u8_array(dev, "realtek,gpio-config",
> +			rt5677->pdata.gpio_config, RT5677_GPIO_NUM);
> +
> +	device_property_read_u32(dev, "realtek,jd1-gpio",
> +			&rt5677->pdata.jd1_gpio);
> +	device_property_read_u32(dev, "realtek,jd2-gpio",
> +			&rt5677->pdata.jd2_gpio);
> +	device_property_read_u32(dev, "realtek,jd3-gpio",
> +			&rt5677->pdata.jd3_gpio);
>   }
>
>   static struct regmap_irq rt5677_irqs[] = {
> @@ -5121,18 +5124,8 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
>
>   	if (pdata)
>   		rt5677->pdata = *pdata;
> -
> -	if (i2c->dev.of_node) {
> -		ret = rt5677_parse_dt(rt5677, i2c->dev.of_node);
> -		if (ret) {
> -			dev_err(&i2c->dev, "Failed to parse device tree: %d\n",
> -				ret);
> -			return ret;
> -		}
> -	} else {
> -		rt5677->pow_ldo2 = -EINVAL;
> -		rt5677->reset_pin = -EINVAL;
> -	}
> +	else
> +		rt5677_read_device_properties(rt5677, &i2c->dev);
>
>   	/* pow-ldo2 and reset are optional. The codec pins may be statically
>   	 * connected on the board without gpios. If the gpio device property
>
