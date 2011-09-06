From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH] ASoC: Blackfin: bf5xx-ad193x: Fix codec
 device name
Date: Tue, 6 Sep 2011 10:35:35 +0800
Message-ID: <CAHG8p1B9Oshc6GgJn8UyERczGB2E0B=6nB6UsPX5Pis_CxUdmg@mail.gmail.com>
References: <1315223397-18627-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f43.google.com (mail-qw0-f43.google.com
	[209.85.216.43]) by alsa0.perex.cz (Postfix) with ESMTP id BD1CE244FC
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 04:35:40 +0200 (CEST)
Received: by qwm42 with SMTP id 42so3257610qwm.2
	for <alsa-devel@alsa-project.org>; Mon, 05 Sep 2011 19:35:35 -0700 (PDT)
In-Reply-To: <1315223397-18627-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, stable@kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2011/9/5 Lars-Peter Clausen <lars@metafoo.de>:
> Fix the codec_name field of the dai_link to match the actual device name
> of the codec. Otherwise the card won't be instantiated.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: stable@kernel.org
> ---
> =A0sound/soc/blackfin/bf5xx-ad193x.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx=
-ad193x.c
> index a118a0f..5956584 100644
> --- a/sound/soc/blackfin/bf5xx-ad193x.c
> +++ b/sound/soc/blackfin/bf5xx-ad193x.c
> @@ -103,7 +103,7 @@ static struct snd_soc_dai_link bf5xx_ad193x_dai[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.cpu_dai_name =3D "bfin-tdm.0",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.codec_dai_name =3D"ad193x-hifi",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_name =3D "bfin-tdm-pcm-audio",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .codec_name =3D "ad193x.5",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .codec_name =3D "spi0.5",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ops =3D &bf5xx_ad193x_ops,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> @@ -112,7 +112,7 @@ static struct snd_soc_dai_link bf5xx_ad193x_dai[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.cpu_dai_name =3D "bfin-tdm.1",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.codec_dai_name =3D"ad193x-hifi",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_name =3D "bfin-tdm-pcm-audio",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .codec_name =3D "ad193x.5",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .codec_name =3D "spi0.5",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ops =3D &bf5xx_ad193x_ops,
> =A0 =A0 =A0 =A0},
> =A0};
> --
> 1.7.2.5

Lars, I have to tell you ad193x supports i2c and spi.

#if defined(CONFIG_SND_SOC_AD193X_SPI)
                .codec_name =3D "spi0.5",
#elif defined(CONFIG_SND_SOC_AD193X_I2C)
                .codec_name =3D "ad193x.0-0004",
#endif

It is better to modify machine driver to platform driver and pass in
control type.

Scott
