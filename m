From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH] ASoC: samsung: Add I2C dependency for snow
Date: Wed, 4 Jun 2014 16:56:05 +0530
Message-ID: <CAHbNUh2tKh1zMM7xQ41sWEs6xwd5U5OyzewZQTC9wdPRTZ4nsA@mail.gmail.com>
References: <7290614.Z7JFMYFomx@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 3401A261B19
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 13:26:07 +0200 (CEST)
Received: by mail-ob0-f172.google.com with SMTP id wp18so7516416obc.3
 for <alsa-devel@alsa-project.org>; Wed, 04 Jun 2014 04:26:06 -0700 (PDT)
In-Reply-To: <7290614.Z7JFMYFomx@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 4 June 2014 15:10, Arnd Bergmann <arnd@arndb.de> wrote:
> Both codecs used by snow, max98090 and max98095 require the use
> of I2C, so we can only select this driver if I2C is there, otherwise
> we get a build error like:
>
> codecs/max98090.c:2494:1: warning: data definition has no type or storage class [enabled by default]
>  module_i2c_driver(max98090_i2c_driver);
>  ^
> codecs/max98095.c:2443:1: warning: data definition has no type or storage class [enabled by default]
>  module_i2c_driver(max98095_i2c_driver);
>  ^
>
> This adds one more I2C dependency to the hundreds we already
> have.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tushar Behera <tushar.behera@linaro.org>

Thanks for the patch. I should have added this dependency while
introducing this config option.

Acked-by: Tushar Behera <tushar.behera@linaro.org>

> ---
> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> index a7cb8f6..cb7be4f 100644
> --- a/sound/soc/samsung/Kconfig
> +++ b/sound/soc/samsung/Kconfig
> @@ -232,7 +232,7 @@ config SND_SOC_LITTLEMILL
>
>  config SND_SOC_SNOW
>         tristate "Audio support for Google Snow boards"
> -       depends on SND_SOC_SAMSUNG
> +       depends on SND_SOC_SAMSUNG && I2C
>         select SND_SOC_MAX98090
>         select SND_SOC_MAX98095
>         select SND_SAMSUNG_I2S
>

-- 
Tushar Behera
