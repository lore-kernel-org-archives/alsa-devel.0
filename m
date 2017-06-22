From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] ASoC: es8316: add I2C dependency
Date: Thu, 22 Jun 2017 07:14:46 -0600
Message-ID: <CAD8Lp47tkPWKApp9ufMmtekgoL+Y_7u6E+o0XV6d5pJ5yx5vCA@mail.gmail.com>
References: <20170621220943.104170-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170621220943.104170-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 21, 2017 at 4:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Without CONFIG_I2C, we get a build failure:
>
> sound/soc/codecs/es8316.c:633:1: error: data definition has no type or storage class [-Werror]
> sound/soc/codecs/es8316.c:633:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
> sound/soc/codecs/es8316.c:633:1: error: parameter names (without types) in function declaration [-Werror]
> sound/soc/codecs/es8316.c:623:26: error: 'es8316_i2c_driver' defined but not used [-Werror=unused-variable]
>
> This adds the required Kconfig dependency.
>
> Fixes: b8b88b70875a ("ASoC: add es8316 codec driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Daniel Drake <drake@endlessm.com>

Thanks for the patch.

> ---
>  sound/soc/codecs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index c6286e5ba511..f0f794186186 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -546,6 +546,7 @@ config SND_SOC_ES7134
>
>  config SND_SOC_ES8316
>         tristate "Everest Semi ES8316 CODEC"
> +       depends on I2C
>
>  config SND_SOC_ES8328
>         tristate
> --
> 2.9.0
>
