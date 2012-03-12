From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH v2] ASoC: mx27vis-aic32x4: Convert it to
	platform driver
Date: Mon, 12 Mar 2012 09:03:19 +0100
Message-ID: <CACKLOr2j-Apnno+-h6B6Rax2-H7ZTuQ=RzyeyB7pOsqJ=xUJuA@mail.gmail.com>
References: <1331499423-9761-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BA8324348
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 09:03:20 +0100 (CET)
Received: by iakh37 with SMTP id h37so7145247iak.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 01:03:19 -0700 (PDT)
In-Reply-To: <1331499423-9761-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On 11 March 2012 21:57, Fabio Estevam <festevam@gmail.com> wrote:
> Convert mx27vis-aic32x4 to platform driver.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Fix MODULE_ALIAS
> - Rename it to mx27vis
>
> =A0arch/arm/mach-imx/mach-imx27_visstrim_m10.c | =A0 =A01 +
> =A0sound/soc/imx/mx27vis-aic32x4.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 40 +++++=
+++++++++-------------
> =A02 files changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-=
imx/mach-imx27_visstrim_m10.c
> index 0a1643c..ed6023f 100644
> --- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> +++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> @@ -397,6 +397,7 @@ static void __init visstrim_m10_board_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0&iclink_tvp5150, sizeof(iclink_tvp5150));
> =A0 =A0 =A0 =A0gpio_led_register_device(0, &visstrim_m10_led_data);
> =A0 =A0 =A0 =A0visstrim_camera_init();
> + =A0 =A0 =A0 imx_add_platform_device("mx27vis", 0, NULL, 0, NULL, 0);
> =A0}
>
> =A0static void __init visstrim_m10_timer_init(void)
> diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-aic3=
2x4.c
> index 976f857..2554397 100644
> --- a/sound/soc/imx/mx27vis-aic32x4.c
> +++ b/sound/soc/imx/mx27vis-aic32x4.c
> @@ -188,22 +188,15 @@ static struct snd_soc_card mx27vis_aic32x4 =3D {
> =A0 =A0 =A0 =A0.num_dapm_routes =3D ARRAY_SIZE(aic32x4_dapm_routes),
> =A0};
>
> -static struct platform_device *mx27vis_aic32x4_snd_device;
> -
> -static int __init mx27vis_aic32x4_init(void)
> +static int __devinit mx27vis_aic32x4_probe(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0int ret;
>
> - =A0 =A0 =A0 mx27vis_aic32x4_snd_device =3D platform_device_alloc("soc-a=
udio", -1);
> - =A0 =A0 =A0 if (!mx27vis_aic32x4_snd_device)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> -
> - =A0 =A0 =A0 platform_set_drvdata(mx27vis_aic32x4_snd_device, &mx27vis_a=
ic32x4);
> - =A0 =A0 =A0 ret =3D platform_device_add(mx27vis_aic32x4_snd_device);
> -
> + =A0 =A0 =A0 ret =3D snd_soc_register_card(&mx27vis_aic32x4);
> =A0 =A0 =A0 =A0if (ret) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "ASoC: Platform device allo=
cation failed\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_device_put(mx27vis_aic32x4_snd_dev=
ice);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "snd_soc_register_card =
failed (%d)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Connect SSI0 as clock slave to SSI1 external pins */
> @@ -221,22 +214,31 @@ static int __init mx27vis_aic32x4_init(void)
>
> =A0 =A0 =A0 =A0ret =3D mxc_gpio_setup_multiple_pins(mx27vis_amp_pins,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(mx27vis_amp_pin=
s), "MX27VIS_AMP");
> - =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "ASoC: unable to setup gpi=
os\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_device_put(mx27vis_aic32x4_snd_dev=
ice);
> - =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static void __exit mx27vis_aic32x4_exit(void)
> +static int __devexit mx27vis_aic32x4_remove(struct platform_device *pdev)
> =A0{
> - =A0 =A0 =A0 platform_device_unregister(mx27vis_aic32x4_snd_device);
> + =A0 =A0 =A0 snd_soc_unregister_card(&mx27vis_aic32x4);
> +
> + =A0 =A0 =A0 return 0;
> =A0}
>
> -module_init(mx27vis_aic32x4_init);
> -module_exit(mx27vis_aic32x4_exit);
> +static struct platform_driver mx27vis_aic32x4_audio_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "mx27vis",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =3D mx27vis_aic32x4_probe,
> + =A0 =A0 =A0 .remove =3D __devexit_p(mx27vis_aic32x4_remove),
> +};
> +
> +module_platform_driver(mx27vis_aic32x4_audio_driver);
>
> =A0MODULE_AUTHOR("Javier Martin <javier.martin@vista-silicon.com>");
> =A0MODULE_DESCRIPTION("ALSA SoC AIC32X4 mx27 visstrim");
> =A0MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:mx27vis");
> --

I agree with the patch. However, I think another patch, which
registers this platform device for the visstrim_m10 board file
(http://lxr.linux.no/#linux+v3.2.9/arch/arm/mach-imx/mach-imx27_visstrim_m1=
0.c)
should be applied at the same time. Otherwise, audio would stop
working on this platform and that would be a regression.

Regards.
-- =

Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
