From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Allow passing platform_data to devices
	attached to AC97 bus
Date: Wed, 22 Jul 2009 00:43:33 +0200
Message-ID: <200907220043.34047.marek.vasut@gmail.com>
References: <200907211633.14388.marek.vasut@gmail.com>
	<200907220013.12824.marek.vasut@gmail.com>
	<20090721223424.GA21147@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WSkZKwKfsWCKNA6"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id A56AE10393D
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 00:43:56 +0200 (CEST)
Received: by fxm26 with SMTP id 26so3146999fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2009 15:43:56 -0700 (PDT)
In-Reply-To: <20090721223424.GA21147@oksana.dev.rtsoft.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: avorontsov@ru.mvista.com
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@opensource.wolfsonmicro.com>, cbou@mail.ru, Eric Miao <eric.y.miao@gmail.com>, dwmw2@infradead.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_WSkZKwKfsWCKNA6
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dne St 22. =C4=8Dervence 2009 00:34:24 Anton Vorontsov napsal(a):
> On Wed, Jul 22, 2009 at 12:13:12AM +0200, Marek Vasut wrote:
> > Btw. I also reworked the wm97xx-battery a little more. Also, CCing powe=
r-
> > supply people.
> >
> > From 0c04c7f9cac26de8b4e401c17e65051c7f44ec3e Mon Sep 17 00:00:00 2001
> > From: Marek Vasut <marek.vasut@gmail.com>
> > Date: Tue, 21 Jul 2009 18:52:28 +0200
> > Subject: [PATCH 3/4] Convert WM97xx driver to use platform_data
> >
> > This patch converts the wm97xx driver to use platform_data supplied by
> > ac97 bus. Also, this fixes the related wm97xx-battery driver to use
> > it's platform_data and prepares a structure for touchscreen driver.
> >
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > ---
>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
>
> > +		ret =3D set_irq_type(gpio_to_irq(pdata->charge_gpio),
> > +				IRQ_TYPE_EDGE_BOTH);
> > +		if (ret)
> > +			goto err2;
>
> I always thought that request_irq() would set trigger type
> as necessary if you pass IRQF_TRIGGER_* flags, so there is
> no need for explicit set_irq_type() call?
>
> This code in kernel/irq/manage.c:__setup_irq():
>
>                 /* Setup the type (level, edge polarity) if configured: */
>                 if (new->flags & IRQF_TRIGGER_MASK) {
>                         ret =3D __irq_set_trigger(desc, irq,
>                                         new->flags & IRQF_TRIGGER_MASK);
>
> > +		ret =3D request_irq(gpio_to_irq(pdata->charge_gpio),
> > +				wm97xx_chrg_irq, IRQF_DISABLED,
> > +				"AC Detect", 0);
> > +		if (ret)
> > +			goto err3;

Yes, sorry, I fixed this one. Btw. we can safely apply the attached patch t=
hen.=20
This will need Robert's ack though (mioa701 change).

--Boundary-00=_WSkZKwKfsWCKNA6
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0004-Convert-all-platforms-to-pass-platform_data-to-wm97x.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0004-Convert-all-platforms-to-pass-platform_data-to-wm97x.patch"

=46rom 0ccf06e47672e0cc1795c18c701b6db79bdc2eea Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Tue, 21 Jul 2009 19:22:13 +0200
Subject: [PATCH 4/4] Convert all platforms to pass platform_data to wm97xx =
battery

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 arch/arm/mach-pxa/mioa701.c |    7 ++++++-
 arch/arm/mach-pxa/palmld.c  |   19 ++++++++++---------
 arch/arm/mach-pxa/palmt5.c  |   19 ++++++++++---------
 arch/arm/mach-pxa/palmte2.c |   20 ++++++++++++--------
 arch/arm/mach-pxa/palmtx.c  |   19 ++++++++++---------
 arch/arm/mach-pxa/palmz72.c |   20 ++++++++++++--------
 arch/arm/mach-pxa/treo680.c |    1 -
 7 files changed, 60 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 3cab452..803917d 100644
=2D-- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -34,7 +34,7 @@
 #include <linux/irq.h>
 #include <linux/pda_power.h>
 #include <linux/power_supply.h>
=2D#include <linux/wm97xx_batt.h>
+#include <linux/wm97xx.h>
 #include <linux/mtd/physmap.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/regulator/max1586.h>
@@ -660,6 +660,10 @@ static struct wm97xx_batt_info mioa701_battery_data =
=3D {
 	.batt_name	=3D "mioa701_battery",
 };
=20
+static struct wm97xx_pdata mioa701_wm97xx_pdata =3D {
+	.batt_pdata	=3D &mioa701_battery_data,
+};
+
 /*
  * Voltage regulation
  */
@@ -728,6 +732,7 @@ struct i2c_pxa_platform_data i2c_pdata =3D {
=20
 static pxa2xx_audio_ops_t mioa701_ac97_info =3D {
 	.reset_gpio =3D 95,
+	.codec_pdata =3D { &mioa701_wm97xx_pdata, },
 };
=20
 /*
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 1ad029d..bcf5b46 100644
=2D-- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -22,7 +22,7 @@
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
=2D#include <linux/wm97xx_batt.h>
+#include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/sysdev.h>
 #include <linux/mtd/mtd.h>
@@ -406,9 +406,9 @@ static struct platform_device power_supply =3D {
 };
=20
 /*************************************************************************=
*****
=2D * WM97xx battery
+ * WM97xx audio, battery
  *************************************************************************=
*****/
=2Dstatic struct wm97xx_batt_info wm97xx_batt_pdata =3D {
+static struct wm97xx_batt_pdata palmld_batt_pdata =3D {
 	.batt_aux	=3D WM97XX_AUX_ID3,
 	.temp_aux	=3D WM97XX_AUX_ID2,
 	.charge_gpio	=3D -1,
@@ -422,15 +422,17 @@ static struct wm97xx_batt_info wm97xx_batt_pdata =3D {
 	.batt_name	=3D "main-batt",
 };
=20
=2D/***********************************************************************=
*******
=2D * aSoC audio
=2D ***********************************************************************=
*******/
=2Dstatic struct palm27x_asoc_info palmld_asoc_pdata =3D {
=2D	.jack_gpio	=3D GPIO_NR_PALMLD_EARPHONE_DETECT,
+static struct wm97xx_pdata palmld_wm97xx_pdata =3D {
+	.batt_pdata	=3D &palmld_batt_pdata,
 };
=20
 static pxa2xx_audio_ops_t palmld_ac97_pdata =3D {
 	.reset_gpio	=3D 95,
+	.codec_pdata	=3D { &palmld_wm97xx_pdata, },
+};
+
+static struct palm27x_asoc_info palmld_asoc_pdata =3D {
+	.jack_gpio	=3D GPIO_NR_PALMLD_EARPHONE_DETECT,
 };
=20
 static struct platform_device palmld_asoc =3D {
@@ -536,7 +538,6 @@ static void __init palmld_init(void)
 	pxa_set_ac97_info(&palmld_ac97_pdata);
 	pxa_set_ficp_info(&palmld_ficp_platform_data);
 	pxa_set_keypad_info(&palmld_keypad_platform_data);
=2D	wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
=20
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 2dd7ce2..3e8b21d 100644
=2D-- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -24,7 +24,7 @@
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
=2D#include <linux/wm97xx_batt.h>
+#include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
=20
@@ -317,9 +317,9 @@ static struct platform_device power_supply =3D {
 };
=20
 /*************************************************************************=
*****
=2D * WM97xx battery
+ * WM97xx audio, battery
  *************************************************************************=
*****/
=2Dstatic struct wm97xx_batt_info wm97xx_batt_pdata =3D {
+static struct wm97xx_batt_pdata palmt5_batt_pdata =3D {
 	.batt_aux	=3D WM97XX_AUX_ID3,
 	.temp_aux	=3D WM97XX_AUX_ID2,
 	.charge_gpio	=3D -1,
@@ -333,15 +333,17 @@ static struct wm97xx_batt_info wm97xx_batt_pdata =3D {
 	.batt_name	=3D "main-batt",
 };
=20
=2D/***********************************************************************=
*******
=2D * aSoC audio
=2D ***********************************************************************=
*******/
=2Dstatic struct palm27x_asoc_info palmt5_asoc_pdata =3D {
=2D	.jack_gpio	=3D GPIO_NR_PALMT5_EARPHONE_DETECT,
+static struct wm97xx_pdata palmt5_wm97xx_pdata =3D {
+	.batt_pdata	=3D &palmt5_batt_pdata,
 };
=20
 static pxa2xx_audio_ops_t palmt5_ac97_pdata =3D {
 	.reset_gpio	=3D 95,
+	.codec_pdata	=3D { &palmt5_wm97xx_pdata, },
+};
+
+static struct palm27x_asoc_info palmt5_asoc_pdata =3D {
+	.jack_gpio	=3D GPIO_NR_PALMT5_EARPHONE_DETECT,
 };
=20
 static struct platform_device palmt5_asoc =3D {
@@ -426,7 +428,6 @@ static void __init palmt5_init(void)
 	pxa_set_ac97_info(&palmt5_ac97_pdata);
 	pxa_set_ficp_info(&palmt5_ficp_platform_data);
 	pxa_set_keypad_info(&palmt5_keypad_platform_data);
=2D	wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
=20
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 277c406..21c241b 100644
=2D-- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -23,7 +23,7 @@
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
=2D#include <linux/wm97xx_batt.h>
+#include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
=20
@@ -290,9 +290,9 @@ static struct platform_device power_supply =3D {
 };
=20
 /*************************************************************************=
*****
=2D * WM97xx battery
+ * WM97xx audio, battery
  *************************************************************************=
*****/
=2Dstatic struct wm97xx_batt_info wm97xx_batt_pdata =3D {
+static struct wm97xx_batt_info palmte2_batt_pdata =3D {
 	.batt_aux	=3D WM97XX_AUX_ID3,
 	.temp_aux	=3D WM97XX_AUX_ID2,
 	.charge_gpio	=3D -1,
@@ -306,9 +306,14 @@ static struct wm97xx_batt_info wm97xx_batt_pdata =3D {
 	.batt_name	=3D "main-batt",
 };
=20
=2D/***********************************************************************=
*******
=2D * aSoC audio
=2D ***********************************************************************=
*******/
+static struct wm97xx_pdata palmte2_wm97xx_pdata =3D {
+	.batt_pdata	=3D &palmte2_batt_pdata,
+};
+
+static pxa2xx_audio_ops_t palmte2_ac97_pdata =3D {
+	.codec_pdata	=3D { &palmte2_wm97xx_pdata, },
+};
+
 static struct palm27x_asoc_info palmte2_asoc_pdata =3D {
 	.jack_gpio	=3D GPIO_NR_PALMTE2_EARPHONE_DETECT,
 };
@@ -376,9 +381,8 @@ static void __init palmte2_init(void)
 	set_pxa_fb_info(&palmte2_lcd_screen);
 	pxa_set_mci_info(&palmte2_mci_platform_data);
 	palmte2_udc_init();
=2D	pxa_set_ac97_info(NULL);
+	pxa_set_ac97_info(&palmte2_ac97_pdata);
 	pxa_set_ficp_info(&palmte2_ficp_platform_data);
=2D	wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
=20
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index f1e248c..554b3da 100644
=2D-- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -25,7 +25,7 @@
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
=2D#include <linux/wm97xx_batt.h>
+#include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/mtd/nand.h>
@@ -340,9 +340,9 @@ static struct platform_device power_supply =3D {
 };
=20
 /*************************************************************************=
*****
=2D * WM97xx battery
+ * WM97xx audio, battery
  *************************************************************************=
*****/
=2Dstatic struct wm97xx_batt_info wm97xx_batt_pdata =3D {
+static struct wm97xx_batt_pdata palmtx_batt_pdata =3D {
 	.batt_aux	=3D WM97XX_AUX_ID3,
 	.temp_aux	=3D WM97XX_AUX_ID2,
 	.charge_gpio	=3D -1,
@@ -356,15 +356,17 @@ static struct wm97xx_batt_info wm97xx_batt_pdata =3D {
 	.batt_name	=3D "main-batt",
 };
=20
=2D/***********************************************************************=
*******
=2D * aSoC audio
=2D ***********************************************************************=
*******/
=2Dstatic struct palm27x_asoc_info palmtx_asoc_pdata =3D {
=2D	.jack_gpio	=3D GPIO_NR_PALMTX_EARPHONE_DETECT,
+static struct wm97xx_pdata palmtx_wm97xx_pdata =3D {
+	.batt_pdata	=3D &palmtx_batt_pdata,
 };
=20
 static pxa2xx_audio_ops_t palmtx_ac97_pdata =3D {
 	.reset_gpio	=3D 95,
+	.codec_pdata	=3D { &palmtx_wm97xx_pdata, },
+};
+
+static struct palm27x_asoc_info palmtx_asoc_pdata =3D {
+	.jack_gpio	=3D GPIO_NR_PALMTX_EARPHONE_DETECT,
 };
=20
 static struct platform_device palmtx_asoc =3D {
@@ -538,7 +540,6 @@ static void __init palmtx_init(void)
 	pxa_set_ac97_info(&palmtx_ac97_pdata);
 	pxa_set_ficp_info(&palmtx_ficp_platform_data);
 	pxa_set_keypad_info(&palmtx_keypad_platform_data);
=2D	wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
=20
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index c2bf493..b769447 100644
=2D-- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -27,7 +27,7 @@
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
=2D#include <linux/wm97xx_batt.h>
+#include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
=20
@@ -343,9 +343,9 @@ static struct platform_device power_supply =3D {
 };
=20
 /*************************************************************************=
*****
=2D * WM97xx battery
+ * WM97xx audio, battery
  *************************************************************************=
*****/
=2Dstatic struct wm97xx_batt_info wm97xx_batt_pdata =3D {
+static struct wm97xx_batt_info palmz72_batt_pdata =3D {
 	.batt_aux	=3D WM97XX_AUX_ID3,
 	.temp_aux	=3D WM97XX_AUX_ID2,
 	.charge_gpio	=3D -1,
@@ -359,9 +359,14 @@ static struct wm97xx_batt_info wm97xx_batt_pdata =3D {
 	.batt_name	=3D "main-batt",
 };
=20
=2D/***********************************************************************=
*******
=2D * aSoC audio
=2D ***********************************************************************=
*******/
+static struct wm97xx_pdata palmz72_wm97xx_pdata =3D {
+	.batt_pdata	=3D &palmz72_batt_pdata,
+};
+
+static pxa2xx_audio_ops_t palmz72_ac97_pdata =3D {
+	.codec_pdata	=3D { &palmz72_wm97xx_pdata, },
+};
+
 static struct platform_device palmz72_asoc =3D {
 	.name =3D "palm27x-asoc",
 	.id   =3D -1,
@@ -494,10 +499,9 @@ static void __init palmz72_init(void)
 	set_pxa_fb_info(&palmz72_lcd_screen);
 	pxa_set_mci_info(&palmz72_mci_platform_data);
 	palmz72_udc_init();
=2D	pxa_set_ac97_info(NULL);
+	pxa_set_ac97_info(&palmz72_ac97_pdata);
 	pxa_set_ficp_info(&palmz72_ficp_platform_data);
 	pxa_set_keypad_info(&palmz72_keypad_platform_data);
=2D	wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
=20
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-pxa/treo680.c b/arch/arm/mach-pxa/treo680.c
index f537265..f9acb12 100644
=2D-- a/arch/arm/mach-pxa/treo680.c
+++ b/arch/arm/mach-pxa/treo680.c
@@ -19,7 +19,6 @@
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
=2D#include <linux/wm97xx_batt.h>
 #include <linux/power_supply.h>
 #include <linux/sysdev.h>
 #include <linux/w1-gpio.h>
=2D-=20
1.6.3.3


--Boundary-00=_WSkZKwKfsWCKNA6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_WSkZKwKfsWCKNA6--
