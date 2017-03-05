From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH v2 03/12] ASoC: sun8i-codec-analog: split
 out mbias
Date: Sun, 05 Mar 2017 21:49:59 +0800
Message-ID: <6803451488721799@web16g.yandex.ru>
References: <20170305133709.6288-1-icenowy@aosc.xyz> <20170305133709.6288-4-icenowy@aosc.xyz>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBCVP6DCQKGQE3HKNFLA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170305133709.6288-4-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



05.03.2017, 21:38, "Icenowy Zheng" <icenowy-ymACFijhrKM@public.gmane.org>:
> Allwinner V3s features an analog codec without MBIAS pin.
>
> Split out this part, in order to prepare for the V3s analog codec.
>
> Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
> ---
> =C2=A0sound/soc/sunxi/sun8i-codec-analog.c | 34 +++++++++++++++++++++++++=
++++-----
> =C2=A01 file changed, 29 insertions(+), 5 deletions(-)
>

Sorry a definiation of has_mbias is mising in the patch...

It's

diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-c=
odec-analog.c
index af56afe5c403..edcc3eb7cd9a 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -695,6 +695,7 @@ struct sun8i_codec_analog_quirks {
  	bool has_hmic;
 	bool has_linein;
 	bool has_lineout;
+	bool has_mbias;
 	bool has_mic2;
 };
=20

> diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i=
-codec-analog.c
> index 6c17c99c2c8d..af56afe5c403 100644
> --- a/sound/soc/sunxi/sun8i-codec-analog.c
> +++ b/sound/soc/sunxi/sun8i-codec-analog.c
> @@ -289,11 +289,6 @@ static const struct snd_soc_dapm_widget sun8i_codec_=
common_widgets[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Microphone input=
 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SND_SOC_DAPM_INPUT(=
"MIC1"),
>
> - /* Microphone Bias */
> - SND_SOC_DAPM_SUPPLY("MBIAS", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
> - SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MMICBIASEN,
> - 0, NULL, 0),
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Mic input path *=
/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SND_SOC_DAPM_PGA("M=
ic1 Amplifier", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MIC1AMPEN, 0, NULL, 0),
> @@ -453,6 +448,27 @@ static int sun8i_codec_add_headphone(struct snd_soc_=
component *cmpnt)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
>
> +/* mbias specific widget */
> +static const struct snd_soc_dapm_widget sun8i_codec_mbias_widgets[] =3D =
{
> + SND_SOC_DAPM_SUPPLY("MBIAS", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
> + SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MMICBIASEN,
> + 0, NULL, 0),
> +};
> +
> +static int sun8i_codec_add_mbias(struct snd_soc_component *cmpnt)
> +{
> + struct snd_soc_dapm_context *dapm =3D snd_soc_component_get_dapm(cmpnt)=
;
> + struct device *dev =3D cmpnt->dev;
> + int ret;
> +
> + ret =3D snd_soc_dapm_new_controls(dapm, sun8i_codec_mbias_widgets,
> + ARRAY_SIZE(sun8i_codec_mbias_widgets));
> + if (ret)
> + dev_err(dev, "Failed to add MBIAS DAPM widgets: %d\n", ret);
> +
> + return ret;
> +}
> +
> =C2=A0/* hmic specific widget */
> =C2=A0static const struct snd_soc_dapm_widget sun8i_codec_hmic_widgets[] =
=3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SND_SOC_DAPM_SUPPLY=
("HBIAS", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
> @@ -686,12 +702,14 @@ static const struct sun8i_codec_analog_quirks sun8i=
_a23_quirks =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.has_headphone =3D =
true,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.has_hmic =3D true,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.has_linein =3D tru=
e,
> + .has_mbias =3D true,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.has_mic2 =3D true,
> =C2=A0};
>
> =C2=A0static const struct sun8i_codec_analog_quirks sun8i_h3_quirks =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.has_linein =3D tru=
e,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.has_lineout =3D tr=
ue,
> + .has_mbias =3D true,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.has_mic2 =3D true,
> =C2=A0};
>
> @@ -734,6 +752,12 @@ static int sun8i_codec_analog_cmpnt_probe(struct snd=
_soc_component *cmpnt)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0return ret;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> + if (quirks->has_mbias) {
> + ret =3D sun8i_codec_add_mbias(cmpnt);
> + if (ret)
> + return ret;
> + }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (quirks->has_mic=
2) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D sun8i_codec_add_mic2(cmpnt);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> --
> 2.11.1

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
