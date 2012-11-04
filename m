From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 5/9] ASoC: Only compile adav80x codec when
 a	bus is defined
Date: Sun, 04 Nov 2012 09:13:36 +0100
Message-ID: <509623B0.2020605@metafoo.de>
References: <1351980150-24145-1-git-send-email-lee.jones@linaro.org> <1351980150-24145-6-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351980150-24145-6-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 11/03/2012 11:02 PM, Lee Jones wrote:
> If !CONFIG_SPI and !CONFIG_I2C* then there is no point adding support
> for the adav80x codec as it relies on a bus to operate. This patch
> fixes the build warnings below when SPI and I2C are not specified in
> the configuration.
>=20
> sound/soc/codecs/adav80x.c:842:22: warning: =E2=80=98adav80x_bus_prob=
e=E2=80=99 defined but not used [-Wunused-function]
> sound/soc/codecs/adav80x.c:863:22: warning: =E2=80=98adav80x_bus_remo=
ve=E2=80=99 defined but not used [-Wunused-function]
>=20
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  sound/soc/codecs/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index b92759a..0d8135a 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -19,7 +19,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
>  	select SND_SOC_AD73311
>  	select SND_SOC_ADAU1373 if I2C
> -	select SND_SOC_ADAV80X
> +	select SND_SOC_ADAV80X if (I2C || I2C_MODULE || SPI_MASTER)

That should be 'if SND_SOC_I2C_AND_SPI', but otherwise agreed.

>  	select SND_SOC_ADS117X
>  	select SND_SOC_AK4104 if SPI_MASTER
>  	select SND_SOC_AK4535 if I2C
