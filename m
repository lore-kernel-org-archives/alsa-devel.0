From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 1/2] sound: soc: add alias for tlv320aic3x
Date: Wed, 1 Feb 2012 09:56:47 +0800
Message-ID: <CAF+7xWnDPQEXQM_Qtb=700OscztcHJGszDE6fHdE0LkPkQUr2w@mail.gmail.com>
References: <1328058380-29360-1-git-send-email-felipe.contreras@gmail.com>
	<1328058380-29360-2-git-send-email-felipe.contreras@gmail.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 29EF11038DE
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 02:57:08 +0100 (CET)
Received: by lags15 with SMTP id s15so392769lag.38
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 17:57:07 -0800 (PST)
In-Reply-To: <1328058380-29360-2-git-send-email-felipe.contreras@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2012/2/1 Felipe Contreras <felipe.contreras@gmail.com>:
> According to the documentation, should help hotplugging.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> =A0sound/soc/codecs/tlv320aic3x.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3=
x.c
> index 492f22f..00eb29d 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -1565,3 +1565,4 @@ module_exit(aic3x_exit);
> =A0MODULE_DESCRIPTION("ASoC TLV320AIC3X codec driver");
> =A0MODULE_AUTHOR("Vladimir Barinov");
> =A0MODULE_LICENSE("GPL");
> +MODULE_ALIAS("i2c:tlv320aic3x");
This is not required because "tlv320aic3x" is already in the aic3x_i2c_id t=
able.
MODULE_DEVICE_TABLE will automatically setup this modalias.

> --
> 1.7.9
>
