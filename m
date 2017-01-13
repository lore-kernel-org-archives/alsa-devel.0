From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/4] ASoC: es8328-i2c: Add compatible for ES8388
Date: Fri, 13 Jan 2017 17:43:45 +0100
Message-ID: <3724319.rPxRAuBZBQ@phil>
References: <20170113161452.14313-1-romain.perier@collabora.com> <20170113161452.14313-2-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170113161452.14313-2-romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Romain,

Am Freitag, 13. Januar 2017, 17:14:49 CET schrieb Romain Perier:
> This commit adds a compatible string for everest,es8388. This is
> an audio codec that is compatible with es8328.
> 
> Signed-off-by: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/es8328.txt | 2 +-
>  sound/soc/codecs/es8328-i2c.c                      | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/es8328.txt
> b/Documentation/devicetree/bindings/sound/es8328.txt index 30ea8a3..33fbf05
> 100644
> --- a/Documentation/devicetree/bindings/sound/es8328.txt
> +++ b/Documentation/devicetree/bindings/sound/es8328.txt
> @@ -4,7 +4,7 @@ This device supports both I2C and SPI.
> 
>  Required properties:
> 
> -  - compatible : "everest,es8328"
> +  - compatible  : Should be "everest,es8328" or "everest,es8388"
>    - DVDD-supply : Regulator providing digital core supply voltage 1.8 -
> 3.6V - AVDD-supply : Regulator providing analog supply voltage 3.3V
>    - PVDD-supply : Regulator providing digital IO supply voltage 1.8 - 3.6V
> diff --git a/sound/soc/codecs/es8328-i2c.c b/sound/soc/codecs/es8328-i2c.c
> index 2d05b5d..09ae67f 100644
> --- a/sound/soc/codecs/es8328-i2c.c
> +++ b/sound/soc/codecs/es8328-i2c.c
> @@ -19,13 +19,14 @@
>  #include "es8328.h"
> 
>  static const struct i2c_device_id es8328_id[] = {
> -	{ "es8328", 0 },
> +	{ "es8328", "es8388", 0 },

that looks strange or I'm just blind.

struct i2c_device_id {
        char name[I2C_NAME_SIZE];
        kernel_ulong_t driver_data;     /* Data private to the driver */
};

so shouldn't this be

 static const struct i2c_device_id es8328_id[] = {
 	{ "es8328", 0 },
+	{ "es8388", 0 },

instead?

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, es8328_id);
> 
>  static const struct of_device_id es8328_of_match[] = {
>  	{ .compatible = "everest,es8328", },
> +	{ .compatible = "everest,es8388", },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, es8328_of_match);


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
