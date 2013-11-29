From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH 03/11] ad193x: Use IS_ENABLED() macro
Date: Fri, 29 Nov 2013 15:24:27 +0800
Message-ID: <CAHG8p1BqbhL2zv8ZMmFeg1fKniipKjXS4r=zhrOdaifwmvrGgg@mail.gmail.com>
References: <1384969072-25906-1-git-send-email-festevam@gmail.com>
 <1384969072-25906-4-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f44.google.com (mail-vb0-f44.google.com
 [209.85.212.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 413F026030E
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 08:24:31 +0100 (CET)
Received: by mail-vb0-f44.google.com with SMTP id w20so6574734vbb.3
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 23:24:28 -0800 (PST)
In-Reply-To: <1384969072-25906-4-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

2013/11/21 Fabio Estevam <festevam@gmail.com>:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Using the IS_ENABLED() macro can make the code shorter and simpler.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  sound/soc/codecs/ad193x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
> index aea7e52..12c27eb 100644
> --- a/sound/soc/codecs/ad193x.c
> +++ b/sound/soc/codecs/ad193x.c
> @@ -413,7 +413,7 @@ static struct spi_driver ad193x_spi_driver = {
>  };
>  #endif
>
> -#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +#if IS_ENABLED(CONFIG_I2C)
>
>  static const struct regmap_config ad193x_i2c_regmap_config = {
>         .val_bits = 8,
> @@ -470,7 +470,7 @@ static int __init ad193x_modinit(void)
>  {
>         int ret;
>
> -#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +#if IS_ENABLED(CONFIG_I2C)
>         ret =  i2c_add_driver(&ad193x_i2c_driver);
>         if (ret != 0) {
>                 printk(KERN_ERR "Failed to register AD193X I2C driver: %d\n",
> @@ -495,7 +495,7 @@ static void __exit ad193x_modexit(void)
>         spi_unregister_driver(&ad193x_spi_driver);
>  #endif
>
> -#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +#if IS_ENABLED(CONFIG_I2C)
>         i2c_del_driver(&ad193x_i2c_driver);
>  #endif
>  }

Acked-by: Scott Jiang <scott.jiang.linux@gmail.com>
