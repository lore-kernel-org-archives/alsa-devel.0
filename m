From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx: Move SPI erratum workaround into SPI
 I/O function
Date: Thu, 19 Sep 2013 10:13:18 +0100
Message-ID: <20130919091318.GA22389@lee--X1>
References: <1379527587-14567-1-git-send-email-broonie@kernel.org>
 <1379527587-14567-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379527587-14567-2-git-send-email-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Marc Reilly <marc@cpdesign.com.au>, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 18 Sep 2013, Mark Brown wrote:

> From: Mark Brown <broonie@linaro.org>
>=20
> Move the workaround for double sending AUDIO_CODEC and AUDIO_DAC writ=
es
> into the SPI core, aiding refactoring to eliminate the ASoC custom I/=
O
> functions and avoiding the extra writes for I2C.
>=20
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/mfd/mc13xxx-spi.c   | 5 +++++
>  include/linux/mfd/mc13xxx.h | 7 +++++++
>  sound/soc/codecs/mc13783.c  | 4 ----
>  3 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
> index 77189da..363c359 100644
> --- a/drivers/mfd/mc13xxx-spi.c
> +++ b/drivers/mfd/mc13xxx-spi.c
> @@ -94,10 +94,15 @@ static int mc13xxx_spi_write(void *context, const=
 void *data, size_t count)
>  {
>  	struct device *dev =3D context;
>  	struct spi_device *spi =3D to_spi_device(dev);
> +	char *reg =3D data;

I think this requires a cast.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
