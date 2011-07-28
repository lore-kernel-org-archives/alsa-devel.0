From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC: Add device tree binding for WM8731
Date: Thu, 28 Jul 2011 16:26:30 -0600
Message-ID: <20110728222630.GG4674@ponder.secretlab.ca>
References: <4e2f1db6.43f42a0a.523f.fffffa25SMTPIN_ADDED@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 77B0F103933
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jul 2011 00:26:35 +0200 (CEST)
Received: by gyc15 with SMTP id 15so2355688gyc.38
	for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2011 15:26:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4e2f1db6.43f42a0a.523f.fffffa25SMTPIN_ADDED@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant@secretlab.ca>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>, devicetree-discuss@lists.ozlabs.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 26, 2011 at 09:02:11PM +0100, Mark Brown wrote:
> Tested with the famous "hey, look! this compiles" test plan.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  Documentation/devicetree/bindings/sound/wm8731.txt |   18 ++++++++++++++++++
>  sound/soc/codecs/wm8731.c                          |   12 ++++++++++++
>  2 files changed, 30 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wm8731.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/wm8731.txt b/Documentation/devicetree/bindings/sound/wm8731.txt
> new file mode 100644
> index 0000000..15f7004
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/wm8731.txt
> @@ -0,0 +1,18 @@
> +WM8731 audio CODEC
> +
> +This device supports both I2C and SPI (configured with pin strapping
> +on the board).
> +
> +Required properties:
> +
> +  - compatible : "wlf,wm8731"
> +
> +  - reg : the I2C address of the device for I2C, the chip select
> +          number for SPI.
> +
> +Example:
> +
> +codec: wm8731@1a {
> +	compatible = "wlf,wm8731";
> +	reg = <0x1a>;
> +};

Acked by: Grant Likely <grant.likely@secretlab.ca>

Although I'm sure some actual testing would be valuable before it is
actually merged.  :-)  And there is one comment below.

> diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
> index 76b4361..5ecc05a 100644
> --- a/sound/soc/codecs/wm8731.c
> +++ b/sound/soc/codecs/wm8731.c
> @@ -22,6 +22,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> +#include <linux/of_device.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> @@ -607,6 +608,11 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
>  	.num_dapm_routes = ARRAY_SIZE(wm8731_intercon),
>  };
>  
> +static const struct of_device_id wm8731_of_match[] = {
> +	{ .compatible = "wlf,wm8731", },
> +	{ }
> +};
> +
>  #if defined(CONFIG_SPI_MASTER)
>  static int __devinit wm8731_spi_probe(struct spi_device *spi)
>  {
> @@ -634,10 +640,13 @@ static int __devexit wm8731_spi_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +MODULE_DEVICE_TABLE(spi, wm8731_of_match);

MODULE_DEVICE_TABLE(of, wm8731_of_match);

> +
>  static struct spi_driver wm8731_spi_driver = {
>  	.driver = {
>  		.name	= "wm8731",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = wm8731_of_match,
>  	},
>  	.probe		= wm8731_spi_probe,
>  	.remove		= __devexit_p(wm8731_spi_remove),
> @@ -678,10 +687,13 @@ static const struct i2c_device_id wm8731_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, wm8731_i2c_id);
>  
> +MODULE_DEVICE_TABLE(i2c, wm8731_of_match);
> +

And this line can be dropped.

i2c module info is separate from i2c and spi tables (although there
may be some breakage here that need to be looked at.  Right now I
don't think the OF device ids get exported to udev for
non-platform_devices.  It needs some investigation.)

>  static struct i2c_driver wm8731_i2c_driver = {
>  	.driver = {
>  		.name = "wm8731",
>  		.owner = THIS_MODULE,
> +		.of_match_table = wm8731_of_match,
>  	},
>  	.probe =    wm8731_i2c_probe,
>  	.remove =   __devexit_p(wm8731_i2c_remove),
> -- 
> 1.7.5.4
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
