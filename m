From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1] ASoC: Intel: byt-max98090: Add GPIO
	ACPI mapping table
Date: Fri, 9 Jun 2017 12:12:35 -0700
Message-ID: <CAKdAkRTHy-raif2PU1VuXwGj7syzo=N-RzHenScYg+0FnS_u+Q@mail.gmail.com>
References: <20170609183801.43892-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f67.google.com (mail-vk0-f67.google.com
 [209.85.213.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AF0A267695
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 21:12:37 +0200 (CEST)
Received: by mail-vk0-f67.google.com with SMTP id 19so4395509vkd.2
 for <alsa-devel@alsa-project.org>; Fri, 09 Jun 2017 12:12:37 -0700 (PDT)
In-Reply-To: <20170609183801.43892-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nicolas Porcel <nicolasporcel06@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 9, 2017 at 11:38 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> In order to make GPIO ACPI library stricter prepare users of
> gpiod_get_index() to correctly behave when there no mapping is
> provided by firmware.
>
> Here we add explicit mapping between _CRS GpioIo() resources and
> their names used in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is a bit more verbose than simply using the same connection name,
but I guess will provide better diagnostic to userspace as we will
have distinct GPIO names.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  sound/soc/intel/boards/byt-max98090.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/intel/boards/byt-max98090.c b/sound/soc/intel/boards/byt-max98090.c
> index d9f81b8d915d..62f5a09aa613 100644
> --- a/sound/soc/intel/boards/byt-max98090.c
> +++ b/sound/soc/intel/boards/byt-max98090.c
> @@ -67,20 +67,29 @@ static struct snd_soc_jack_pin hs_jack_pins[] = {
>
>  static struct snd_soc_jack_gpio hs_jack_gpios[] = {
>         {
> -               .name           = "hp-gpio",
> +               .name           = "hp",
>                 .idx            = 0,
>                 .report         = SND_JACK_HEADPHONE | SND_JACK_LINEOUT,
>                 .debounce_time  = 200,
>         },
>         {
> -               .name           = "mic-gpio",
> -               .idx            = 1,
> +               .name           = "mic",
> +               .idx            = 0,
>                 .invert         = 1,
>                 .report         = SND_JACK_MICROPHONE,
>                 .debounce_time  = 200,
>         },
>  };
>
> +static const struct acpi_gpio_params hp_gpios = { 0, 0, false };
> +static const struct acpi_gpio_params mic_gpios = { 1, 0, false };
> +
> +static const struct acpi_gpio_mapping acpi_byt_max98090_gpios[] = {
> +       { "hp-gpios", &hp_gpios, 1 },
> +       { "mic-gpios", &mic_gpios, 1 },
> +       {},
> +};
> +
>  static int byt_max98090_init(struct snd_soc_pcm_runtime *runtime)
>  {
>         int ret;
> @@ -140,8 +149,9 @@ static struct snd_soc_card byt_max98090_card = {
>
>  static int byt_max98090_probe(struct platform_device *pdev)
>  {
> -       int ret_val = 0;
> +       struct device *dev = &pdev->dev;
>         struct byt_max98090_private *priv;
> +       int ret_val;
>
>         priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
>         if (!priv) {
> @@ -149,6 +159,10 @@ static int byt_max98090_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>         }
>
> +       ret_val = devm_acpi_dev_add_driver_gpios(dev, acpi_byt_max98090_gpios);
> +       if (ret_val)
> +               dev_dbg(dev, "Unable to add GPIO mapping table\n");
> +
>         byt_max98090_card.dev = &pdev->dev;
>         snd_soc_card_set_drvdata(&byt_max98090_card, priv);
>         ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_max98090_card);
> --
> 2.11.0
>

Thanks.

-- 
Dmitry
