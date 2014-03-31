From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] ASoC: rt5640: add an of_match table
Date: Mon, 31 Mar 2014 19:14:27 +0200
Message-ID: <CAOf5uwn=cr45QWG4iMoKrQX4jR=izopQn_iSa9AH+2Ojf8ifKw@mail.gmail.com>
References: <1396285517-17892-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id C58CC26513D
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 19:14:27 +0200 (CEST)
Received: by mail-wg0-f42.google.com with SMTP id y10so6122219wgg.1
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 10:14:27 -0700 (PDT)
In-Reply-To: <1396285517-17892-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi

Il 31/mar/2014 19:05 "Stephen Warren" <swarren@wwwdotorg.org> ha scritto:
>
> From: Stephen Warren <swarren@nvidia.com>
>
> Add a device tree match table. This serves to make the driver's support
> of device tree more explicit. Perhaps the fallback for DT matching to
> using the i2c_device_id table will go away one day, since it fails in
> face of devices from different vendors with the same name.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  sound/soc/codecs/rt5640.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
> index b5014a2024e2..b6a02c16f100 100644
> --- a/sound/soc/codecs/rt5640.c
> +++ b/sound/soc/codecs/rt5640.c
> @@ -2018,6 +2018,14 @@ static const struct i2c_device_id rt5640_i2c_id[]
= {
>  };
>  MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
>
> +#if defined(CONFIG_OF)
> +static const struct of_device_id rt5640_of_match[] = {
> +       { .compatible = "realtek,rt5640", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, rt5640_of_match);
> +#endif

Are you sure that you need #if defined?

Michael

> +
>  #ifdef CONFIG_ACPI
>  static struct acpi_device_id rt5640_acpi_match[] = {
>         { "INT33CA", 0 },
> @@ -2166,6 +2174,7 @@ static struct i2c_driver rt5640_i2c_driver = {
>                 .name = "rt5640",
>                 .owner = THIS_MODULE,
>                 .acpi_match_table = ACPI_PTR(rt5640_acpi_match),
> +               .of_match_table = of_match_ptr(rt5640_of_match),
>         },
>         .probe = rt5640_i2c_probe,
>         .remove   = rt5640_i2c_remove,
> --
> 1.8.1.5
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
