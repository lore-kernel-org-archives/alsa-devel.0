From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: pxa: Convert poodle to use
	snd_soc_register_card()
Date: Fri, 30 Dec 2011 09:45:55 +0800
Message-ID: <CAN1soZyLrqUvM55gHEZb1as5dEEGjH4hhQ6foU_k9Rgj7dADqw@mail.gmail.com>
References: <1325207771.9599.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FB4B103A99
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 02:45:56 +0100 (CET)
Received: by vbbfp1 with SMTP id fp1so10668406vbb.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 17:45:55 -0800 (PST)
In-Reply-To: <1325207771.9599.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 30, 2011 at 9:16 AM, Axel Lin <axel.lin@gmail.com> wrote:
> Use snd_soc_register_card() instead of creating a "soc-audio" platform de=
vice.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> =A0arch/arm/mach-pxa/poodle.c | =A0 =A06 ++++++
> =A0sound/soc/pxa/poodle.c =A0 =A0 | =A0 42 +++++++++++++++++++++++-------=
------------
> =A02 files changed, 29 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
> index 69036e4..744baee 100644
> --- a/arch/arm/mach-pxa/poodle.c
> +++ b/arch/arm/mach-pxa/poodle.c
> @@ -158,6 +158,11 @@ static struct scoop_pcmcia_config poodle_pcmcia_conf=
ig =3D {
> =A0EXPORT_SYMBOL(poodle_scoop_device);
>
>
> +static struct platform_device poodle_audio_device =3D {
> + =A0 =A0 =A0 .name =A0 =3D "poodle-audio",
> + =A0 =A0 =A0 .id =A0 =A0 =3D -1,
> +};
> +
> =A0/* LoCoMo device */
> =A0static struct resource locomo_resources[] =3D {
> =A0 =A0 =A0 =A0[0] =3D {
> @@ -407,6 +412,7 @@ static struct platform_device sharpsl_rom_device =3D {
> =A0static struct platform_device *devices[] __initdata =3D {
> =A0 =A0 =A0 =A0&poodle_locomo_device,
> =A0 =A0 =A0 =A0&poodle_scoop_device,
> + =A0 =A0 =A0 &poodle_audio_device,
> =A0 =A0 =A0 =A0&sharpsl_nand_device,
> =A0 =A0 =A0 =A0&sharpsl_rom_device,
> =A0};
> diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
> index 4c29bc1..c9e24bf 100644
> --- a/sound/soc/pxa/poodle.c
> +++ b/sound/soc/pxa/poodle.c
> @@ -281,22 +281,18 @@ static struct snd_soc_dai_link poodle_dai =3D {
> =A0};
>
> =A0/* poodle audio machine driver */
> -static struct snd_soc_card snd_soc_poodle =3D {
> +static struct snd_soc_card poodle =3D {
> =A0 =A0 =A0 =A0.name =3D "Poodle",
> =A0 =A0 =A0 =A0.dai_link =3D &poodle_dai,
> =A0 =A0 =A0 =A0.num_links =3D 1,
> =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> =A0};
>
> -static struct platform_device *poodle_snd_device;
> -
> -static int __init poodle_init(void)
> +static int __devinit poodle_probe(struct platform_device *pdev)
> =A0{
> + =A0 =A0 =A0 struct snd_soc_card *card =3D &poodle;
> =A0 =A0 =A0 =A0int ret;
>
> - =A0 =A0 =A0 if (!machine_is_poodle())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> -
> =A0 =A0 =A0 =A0locomo_gpio_set_dir(&poodle_locomo_device.dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0POODLE_LOCOMO_GPIO_AMP_ON, 0);
> =A0 =A0 =A0 =A0/* should we mute HP at startup - burning power ?*/
> @@ -305,28 +301,36 @@ static int __init poodle_init(void)
> =A0 =A0 =A0 =A0locomo_gpio_set_dir(&poodle_locomo_device.dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0POODLE_LOCOMO_GPIO_MUTE_R, 0);
>
> - =A0 =A0 =A0 poodle_snd_device =3D platform_device_alloc("soc-audio", -1=
);
> - =A0 =A0 =A0 if (!poodle_snd_device)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> -
> - =A0 =A0 =A0 platform_set_drvdata(poodle_snd_device, &snd_soc_poodle);
> - =A0 =A0 =A0 ret =3D platform_device_add(poodle_snd_device);
> + =A0 =A0 =A0 card->dev =3D &pdev->dev;
>
> + =A0 =A0 =A0 ret =3D snd_soc_register_card(card);
> =A0 =A0 =A0 =A0if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_device_put(poodle_snd_device);
> -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "snd_soc_register_card(=
) failed: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static void __exit poodle_exit(void)
> +static int __devexit poodle_remove(struct platform_device *pdev)
> =A0{
> - =A0 =A0 =A0 platform_device_unregister(poodle_snd_device);
> + =A0 =A0 =A0 struct snd_soc_card *card =3D platform_get_drvdata(pdev);
> +
> + =A0 =A0 =A0 snd_soc_unregister_card(card);
> + =A0 =A0 =A0 return 0;
> =A0}
>
> -module_init(poodle_init);
> -module_exit(poodle_exit);
> +static struct platform_driver poodle_driver =3D {
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "poodle-audio",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D poodle_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(poodle_remove),
> +};
> +
> +module_platform_driver(poodle_driver);
>
> =A0/* Module information */
> =A0MODULE_AUTHOR("Richard Purdie");
> =A0MODULE_DESCRIPTION("ALSA SoC Poodle");
> =A0MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:poodle-audio");
> --
> 1.7.5.4
>
Acked.

I think Mark can merge this patch series.

Best Regards
Haojian
