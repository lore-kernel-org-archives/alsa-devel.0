From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] General fix for Palm27x aSoC driver
Date: Fri, 17 Apr 2009 11:42:08 +0200
Message-ID: <200904171142.08879.marek.vasut@gmail.com>
References: <200904121858.42931.marek.vasut@gmail.com>
	<f17812d70904151943kef62292v2fc3e0bc0dbe579c@mail.gmail.com>
	<200904160645.17191.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_w7E6Je+ewsX1oZG"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 14F72103809
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 11:42:02 +0200 (CEST)
Received: by fxm18 with SMTP id 18so888049fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2009 02:42:01 -0700 (PDT)
In-Reply-To: <200904160645.17191.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Brown <broonie@sirena.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_w7E6Je+ewsX1oZG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 16 of April 2009 06:45:17 Marek Vasut wrote:
> On Thursday 16 of April 2009 04:43:27 Eric Miao wrote:
> > On Wed, Apr 15, 2009 at 4:21 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> > > On Tue, Apr 14, 2009 at 11:42:34PM +0200, Marek Vasut wrote:
> > >> OK, shall I change it and resend (ps. to what if you dont mind telling
> > >> me?) ?
> > >
> > > pxa2xx_audio_ops_t
> > >
> > >> Also, do you want to push it through also tree or ARM tree ? I'm for
> > >> the second option as it's more of a bugfix suitable for that tree.
> > >
> > > ARM.
> >
> > Marek,
> >
> > Any update?
>
> Sorry, LinuxEXPO takes place here so my sleep amount is reduced to about
> three hours a day ...
>
> I'll try asap (I hope today), sorry for the delay.

Ok, this one should be fine with you

--Boundary-00=_w7E6Je+ewsX1oZG
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0001-General-fix-for-Palm27x-aSoC-driver.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-General-fix-for-Palm27x-aSoC-driver.patch"

=46rom bf32cbc4b2360773f878656018940c7203ae80c7 Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Fri, 17 Apr 2009 11:37:35 +0200
Subject: [PATCH] General fix for Palm27x aSoC driver

=46irstly, this patch makes the palm27x asoc driver a little more sane. Als=
o,
since all affected devices use GPIO95 as AC97_nRESET, this patch sets that
properly. Affected are PalmT5, TX and LifeDrive.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 arch/arm/mach-pxa/include/mach/palmasoc.h |    7 +------
 arch/arm/mach-pxa/palmld.c                |   18 +++++++++++++++---
 arch/arm/mach-pxa/palmt5.c                |   18 +++++++++++++++---
 arch/arm/mach-pxa/palmtx.c                |   23 ++++++++++++++++++++++-
 sound/soc/pxa/palm27x.c                   |   27 +++++++++++++++++++++++--=
=2D-
 5 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/palmasoc.h b/arch/arm/mach-pxa/=
include/mach/palmasoc.h
index 6c4b1f7..58afb30 100644
=2D-- a/arch/arm/mach-pxa/include/mach/palmasoc.h
+++ b/arch/arm/mach-pxa/include/mach/palmasoc.h
@@ -1,13 +1,8 @@
 #ifndef _INCLUDE_PALMASOC_H_
 #define _INCLUDE_PALMASOC_H_
+
 struct palm27x_asoc_info {
 	int	jack_gpio;
 };
=20
=2D#ifdef CONFIG_SND_PXA2XX_SOC_PALM27X
=2Dvoid __init palm27x_asoc_set_pdata(struct palm27x_asoc_info *data);
=2D#else
=2Dstatic inline void palm27x_asoc_set_pdata(struct palm27x_asoc_info *data=
) {}
=2D#endif
=2D
 #endif
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index ecf5910..1cec180 100644
=2D-- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -477,10 +477,22 @@ static struct wm97xx_batt_info wm97xx_batt_pdata =3D {
 /*************************************************************************=
*****
  * aSoC audio
  *************************************************************************=
*****/
=2Dstatic struct palm27x_asoc_info palm27x_asoc_pdata =3D {
+static struct palm27x_asoc_info palmld_asoc_pdata =3D {
 	.jack_gpio	=3D GPIO_NR_PALMLD_EARPHONE_DETECT,
 };
=20
+static pxa2xx_audio_ops_t palmld_ac97_pdata =3D {
+	.reset_gpio	=3D 95,
+};
+
+static struct platform_device palmld_asoc =3D {
+	.name =3D "palm27x-asoc",
+	.id   =3D -1,
+	.dev  =3D {
+		.platform_data =3D &palmld_asoc_pdata,
+	},
+};
+
 /*************************************************************************=
*****
  * Framebuffer
  *************************************************************************=
*****/
@@ -544,6 +556,7 @@ static struct platform_device *devices[] __initdata =3D=
 {
 	&palmld_backlight,
 	&palmld_leds,
 	&power_supply,
+	&palmld_asoc,
 };
=20
 static struct map_desc palmld_io_desc[] __initdata =3D {
@@ -573,11 +586,10 @@ static void __init palmld_init(void)
=20
 	set_pxa_fb_info(&palmld_lcd_screen);
 	pxa_set_mci_info(&palmld_mci_platform_data);
=2D	pxa_set_ac97_info(NULL);
+	pxa_set_ac97_info(&palmld_ac97_pdata);
 	pxa_set_ficp_info(&palmld_ficp_platform_data);
 	pxa_set_keypad_info(&palmld_keypad_platform_data);
 	wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
=2D	palm27x_asoc_set_pdata(&palm27x_asoc_pdata);
=20
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index d7f8106..3066236 100644
=2D-- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -420,10 +420,22 @@ static struct wm97xx_batt_info wm97xx_batt_pdata =3D {
 /*************************************************************************=
*****
  * aSoC audio
  *************************************************************************=
*****/
=2Dstatic struct palm27x_asoc_info palm27x_asoc_pdata =3D {
+static struct palm27x_asoc_info palmt5_asoc_pdata =3D {
 	.jack_gpio	=3D GPIO_NR_PALMT5_EARPHONE_DETECT,
 };
=20
+static pxa2xx_audio_ops_t palmt5_ac97_pdata =3D {
+	.reset_gpio	=3D 95,
+};
+
+static struct platform_device palmt5_asoc =3D {
+	.name =3D "palm27x-asoc",
+	.id   =3D -1,
+	.dev  =3D {
+		.platform_data =3D &palmt5_asoc_pdata,
+	},
+};
+
 /*************************************************************************=
*****
  * Framebuffer
  *************************************************************************=
*****/
@@ -486,6 +498,7 @@ static struct platform_device *devices[] __initdata =3D=
 {
 #endif
 	&palmt5_backlight,
 	&power_supply,
+	&palmt5_asoc,
 };
=20
 /* setup udc GPIOs initial state */
@@ -504,12 +517,11 @@ static void __init palmt5_init(void)
 	set_pxa_fb_info(&palmt5_lcd_screen);
 	pxa_set_mci_info(&palmt5_mci_platform_data);
 	palmt5_udc_init();
+	pxa_set_ac97_info(&palmt5_ac97_pdata);
 	pxa_set_udc_info(&palmt5_udc_info);
=2D	pxa_set_ac97_info(NULL);
 	pxa_set_ficp_info(&palmt5_ficp_platform_data);
 	pxa_set_keypad_info(&palmt5_keypad_platform_data);
 	wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
=2D	palm27x_asoc_set_pdata(&palm27x_asoc_pdata);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
=20
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 14393d0..e2d44b1 100644
=2D-- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -40,6 +40,7 @@
 #include <mach/irda.h>
 #include <mach/pxa27x_keypad.h>
 #include <mach/udc.h>
+#include <mach/palmasoc.h>
=20
 #include "generic.h"
 #include "devices.h"
@@ -434,6 +435,25 @@ static struct wm97xx_batt_info wm97xx_batt_pdata =3D {
 };
=20
 /*************************************************************************=
*****
+ * aSoC audio
+ *************************************************************************=
*****/
+static struct palm27x_asoc_info palmtx_asoc_pdata =3D {
+	.jack_gpio	=3D GPIO_NR_PALMTX_EARPHONE_DETECT,
+};
+
+static pxa2xx_audio_ops_t palmtx_ac97_pdata =3D {
+	.reset_gpio	=3D 95,
+};
+
+static struct platform_device palmtx_asoc =3D {
+	.name =3D "palm27x-asoc",
+	.id   =3D -1,
+	.dev  =3D {
+		.platform_data =3D &palmtx_asoc_pdata,
+	},
+};
+
+/*************************************************************************=
*****
  * Framebuffer
  *************************************************************************=
*****/
 static struct pxafb_mode_info palmtx_lcd_modes[] =3D {
@@ -495,6 +515,7 @@ static struct platform_device *devices[] __initdata =3D=
 {
 #endif
 	&palmtx_backlight,
 	&power_supply,
+	&palmtx_asoc,
 };
=20
 static struct map_desc palmtx_io_desc[] __initdata =3D {
@@ -529,8 +550,8 @@ static void __init palmtx_init(void)
 	set_pxa_fb_info(&palmtx_lcd_screen);
 	pxa_set_mci_info(&palmtx_mci_platform_data);
 	palmtx_udc_init();
+	pxa_set_ac97_info(&palmtx_ac97_pdata);
 	pxa_set_udc_info(&palmtx_udc_info);
=2D	pxa_set_ac97_info(NULL);
 	pxa_set_ficp_info(&palmtx_ficp_platform_data);
 	pxa_set_keypad_info(&palmtx_keypad_platform_data);
 	wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 48a73f6..44fcc4e 100644
=2D-- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -200,7 +200,7 @@ static struct snd_soc_device palm27x_snd_devdata =3D {
=20
 static struct platform_device *palm27x_snd_device;
=20
=2Dstatic int __init palm27x_asoc_init(void)
+static int palm27x_asoc_probe(struct platform_device *pdev)
 {
 	int ret;
=20
@@ -208,6 +208,10 @@ static int __init palm27x_asoc_init(void)
 		machine_is_palmld()))
 		return -ENODEV;
=20
+	if (pdev->dev.platform_data)
+		palm27x_ep_gpio =3D ((struct palm27x_asoc_info *)
+			(pdev->dev.platform_data))->jack_gpio;
+
 	ret =3D gpio_request(palm27x_ep_gpio, "Headphone Jack");
 	if (ret)
 		return ret;
@@ -245,16 +249,31 @@ err_alloc:
 	return ret;
 }
=20
=2Dstatic void __exit palm27x_asoc_exit(void)
+static int __devexit palm27x_asoc_remove(struct platform_device *pdev)
 {
 	free_irq(gpio_to_irq(palm27x_ep_gpio), NULL);
 	gpio_free(palm27x_ep_gpio);
 	platform_device_unregister(palm27x_snd_device);
+	return 0;
 }
=20
=2Dvoid __init palm27x_asoc_set_pdata(struct palm27x_asoc_info *data)
+static struct platform_driver palm27x_wm9712_driver =3D {
+	.probe		=3D palm27x_asoc_probe,
+	.remove		=3D __devexit_p(palm27x_asoc_remove),
+	.driver		=3D {
+		.name		=3D "palm27x-asoc",
+		.owner		=3D THIS_MODULE,
+	},
+};
+
+static int __init palm27x_asoc_init(void)
+{
+	return platform_driver_register(&palm27x_wm9712_driver);
+}
+
+static void __exit palm27x_asoc_exit(void)
 {
=2D	palm27x_ep_gpio =3D data->jack_gpio;
+	platform_driver_unregister(&palm27x_wm9712_driver);
 }
=20
 module_init(palm27x_asoc_init);
=2D-=20
1.6.2


--Boundary-00=_w7E6Je+ewsX1oZG
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_w7E6Je+ewsX1oZG--
