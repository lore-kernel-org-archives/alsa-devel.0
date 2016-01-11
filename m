From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 3/5] gpio: arizona: Support Cirrus Logic CS47L24 and
 WM1831
Date: Mon, 11 Jan 2016 06:26:19 +0000
Message-ID: <20160111062619.GP3331@x1>
References: <1446563316-28878-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1446563316-28878-4-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446563316-28878-4-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: linus.walleij@linaro.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 03 Nov 2015, Richard Fitzgerald wrote:

> The CS47L24 and WM1831 codecs only have two GPIO lines, but are
> otherwise similar to the WM8280.
>=20
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/gpio-arizona.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

> diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.=
c
> index ca00273..624ea54 100644
> --- a/drivers/gpio/gpio-arizona.c
> +++ b/drivers/gpio/gpio-arizona.c
> @@ -122,6 +122,10 @@ static int arizona_gpio_probe(struct platform_de=
vice *pdev)
>  	case WM1814:
>  		arizona_gpio->gpio_chip.ngpio =3D 5;
>  		break;
> +	case WM1831:
> +	case CS47L24:
> +		arizona_gpio->gpio_chip.ngpio =3D 2;
> +		break;
>  	default:
>  		dev_err(&pdev->dev, "Unknown chip variant %d\n",
>  			arizona->type);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
