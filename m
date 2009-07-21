From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Allow passing platform_data to devices
	attached to AC97 bus
Date: Tue, 21 Jul 2009 20:18:44 +0200
Message-ID: <200907212018.44914.marek.vasut@gmail.com>
References: <200907211633.14388.marek.vasut@gmail.com>
	<20090721145323.GA8991@rakim.wolfsonmicro.main>
	<s5hd47u2hjc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EagZKpfINnF1CNK"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f226.google.com (mail-bw0-f226.google.com
	[209.85.218.226])
	by alsa0.perex.cz (Postfix) with ESMTP id DAAE910385D
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 20:19:10 +0200 (CEST)
Received: by bwz26 with SMTP id 26so1921952bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2009 11:19:10 -0700 (PDT)
In-Reply-To: <s5hd47u2hjc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_EagZKpfINnF1CNK
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dne =C3=9At 21. =C4=8Dervence 2009 17:16:07 Takashi Iwai napsal(a):
> At Tue, 21 Jul 2009 15:53:23 +0100,
>
> Mark Brown wrote:
> > On Tue, Jul 21, 2009 at 04:50:26PM +0200, Takashi Iwai wrote:
> > > Marek Vasut wrote:
> > > >  	int ret;
> > > > +	pxa2xx_audio_ops_t *pdata =3D dev->dev.platform_data;
> > >
> > > Use the get function.
> >
> > There's no such function in mainline right now.  However, apropos of
> > something else I submitted a patch adding that to the driver core - it's
> > been merged for 2.6.32 but won't be available in ALSA until after the
> > next merge window.  The function is dev_get_platdata().
>
> Ah, right.  This can be fixed later, then.
>
> > > Also, at the next time, add Russell or linux-arm to Cc so that he
> > > knows at least that a file in arch/arm will be changed.
> >
> > Ideally split things into two separate patches.
>
> Agreed.
>
>
> Takashi

And one more patch to convert the mainstone accelerated touch driver to use=
=20
platform_data.

--Boundary-00=_EagZKpfINnF1CNK
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Convert-the-mainstone-accelerated-touch-driver-to-us.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Convert-the-mainstone-accelerated-touch-driver-to-us.patch"

=46rom c75defb486f199d4bc9ead3245032ca2c0d298c9 Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Tue, 21 Jul 2009 20:12:23 +0200
Subject: [PATCH] Convert the mainstone accelerated touch driver to use plat=
form_data

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 arch/arm/mach-pxa/mainstone.c                |   10 ++++++++++
 arch/arm/mach-pxa/palmld.c                   |    9 ++++++++-
 arch/arm/mach-pxa/palmt5.c                   |    9 ++++++++-
 arch/arm/mach-pxa/palmtx.c                   |    9 ++++++++-
 drivers/input/touchscreen/mainstone-wm97xx.c |   26 ++++++++++++++++------=
=2D---
 include/linux/wm97xx.h                       |    3 ++-
 6 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index a4eeae3..b116927 100644
=2D-- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -27,6 +27,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/pwm_backlight.h>
 #include <linux/smc91x.h>
+#include <linux/wm97xx.h>
=20
 #include <asm/types.h>
 #include <asm/setup.h>
@@ -284,11 +285,20 @@ static void mst_audio_resume(void *priv)
 	MST_MSCWR2 &=3D mst_audio_suspend_mask | ~MST_MSCWR2_AC97_SPKROFF;
 }
=20
+static struct wm97xx_touch_pdata mainstone_touch_pdata =3D {
+	.irq_gpio	=3D 4,
+};
+
+static struct wm97xx_pdata mainstone_wm97xx_pdata =3D {
+	.touch_pdata	=3D &palmtx_touch_pdata,
+};
+
 static pxa2xx_audio_ops_t mst_audio_ops =3D {
 	.startup	=3D mst_audio_startup,
 	.shutdown	=3D mst_audio_shutdown,
 	.suspend	=3D mst_audio_suspend,
 	.resume		=3D mst_audio_resume,
+	.codec_pdata	=3D { &mainstone_wm97xx_pdata, },
 };
=20
 static struct resource flash_resources[] =3D {
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index bcf5b46..e7af187 100644
=2D-- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -406,7 +406,7 @@ static struct platform_device power_supply =3D {
 };
=20
 /*************************************************************************=
*****
=2D * WM97xx audio, battery
+ * WM97xx audio, touchscreen, battery
  *************************************************************************=
*****/
 static struct wm97xx_batt_pdata palmld_batt_pdata =3D {
 	.batt_aux	=3D WM97XX_AUX_ID3,
@@ -422,8 +422,15 @@ static struct wm97xx_batt_pdata palmld_batt_pdata =3D {
 	.batt_name	=3D "main-batt",
 };
=20
+static struct wm97xx_touch_pdata palmld_touch_pdata =3D {
+	.irq_gpio	=3D GPIO_NR_PALMLD_WM9712_IRQ,
+	.pen_int	=3D 1,
+	.variant	=3D WM97xx_WM1613,
+};
+
 static struct wm97xx_pdata palmld_wm97xx_pdata =3D {
 	.batt_pdata	=3D &palmld_batt_pdata,
+	.touch_pdata	=3D &palmld_touch_pdata,
 };
=20
 static pxa2xx_audio_ops_t palmld_ac97_pdata =3D {
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 3e8b21d..3863cb9 100644
=2D-- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -317,7 +317,7 @@ static struct platform_device power_supply =3D {
 };
=20
 /*************************************************************************=
*****
=2D * WM97xx audio, battery
+ * WM97xx audio, touchscreen, battery
  *************************************************************************=
*****/
 static struct wm97xx_batt_pdata palmt5_batt_pdata =3D {
 	.batt_aux	=3D WM97XX_AUX_ID3,
@@ -333,8 +333,15 @@ static struct wm97xx_batt_pdata palmt5_batt_pdata =3D {
 	.batt_name	=3D "main-batt",
 };
=20
+static struct wm97xx_touch_pdata palmt5_touch_pdata =3D {
+	.irq_gpio	=3D GPIO_NR_PALMT5_WM9712_IRQ,
+	.pen_int	=3D 1,
+	.variant	=3D WM97xx_WM1613,
+};
+
 static struct wm97xx_pdata palmt5_wm97xx_pdata =3D {
 	.batt_pdata	=3D &palmt5_batt_pdata,
+	.touch_pdata	=3D &palmt5_touch_pdata,
 };
=20
 static pxa2xx_audio_ops_t palmt5_ac97_pdata =3D {
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 554b3da..9009bd6 100644
=2D-- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -340,7 +340,7 @@ static struct platform_device power_supply =3D {
 };
=20
 /*************************************************************************=
*****
=2D * WM97xx audio, battery
+ * WM97xx audio, touchscreen, battery
  *************************************************************************=
*****/
 static struct wm97xx_batt_pdata palmtx_batt_pdata =3D {
 	.batt_aux	=3D WM97XX_AUX_ID3,
@@ -356,8 +356,15 @@ static struct wm97xx_batt_pdata palmtx_batt_pdata =3D {
 	.batt_name	=3D "main-batt",
 };
=20
+static struct wm97xx_touch_pdata palmtx_touch_pdata =3D {
+	.irq_gpio	=3D GPIO_NR_PALMTX_WM9712_IRQ,
+	.pen_int	=3D 1,
+	.variant	=3D WM97xx_WM1613,
+};
+
 static struct wm97xx_pdata palmtx_wm97xx_pdata =3D {
 	.batt_pdata	=3D &palmtx_batt_pdata,
+	.touch_pdata	=3D &palmtx_touch_pdata,
 };
=20
 static pxa2xx_audio_ops_t palmtx_ac97_pdata =3D {
diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/t=
ouchscreen/mainstone-wm97xx.c
index e000ab3..96bedd3 100644
=2D-- a/drivers/input/touchscreen/mainstone-wm97xx.c
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c
@@ -194,16 +194,6 @@ static int wm97xx_acc_startup(struct wm97xx *wm)
 		 "mainstone accelerated touchscreen driver, %d samples/sec\n",
 		 cinfo[sp_idx].speed);
=20
=2D	/* IRQ driven touchscreen is used on Palm hardware */
=2D	if (machine_is_palmt5() || machine_is_palmtx() || machine_is_palmld()) {
=2D		pen_int =3D 1;
=2D		irq =3D 27;
=2D		/* There is some obscure mutant of WM9712 interbred with WM9713
=2D		 * used on Palm HW */
=2D		wm->variant =3D WM97xx_WM1613;
=2D	} else if (machine_is_mainstone() && pen_int)
=2D		irq =3D 4;
=2D
 	if (irq) {
 		ret =3D gpio_request(irq, "Touchscreen IRQ");
 		if (ret)
@@ -280,6 +270,22 @@ static struct wm97xx_mach_ops mainstone_mach_ops =3D {
 static int mainstone_wm97xx_probe(struct platform_device *pdev)
 {
 	struct wm97xx *wm =3D platform_get_drvdata(pdev);
+	struct wm97xx_touch_pdata *pdata =3D pdev->dev.platform_data;
+
+	if (pdata) {
+		if (pdata->irq_gpio)
+			irq =3D pdata->irq_gpio;
+		if (pdata->cont_rate)
+			cont_rate =3D pdata->cont_rate;
+		if (pdata->pen_int)
+			pen_int =3D pdata->pen_int;
+		if (pdata->pressure)
+			pressure =3D pdata->pressure;
+		if (pdata->ac97_touch_slot)
+			ac97_touch_slot =3D pdata->ac97_touch_slot;
+		if (pdata->variant)
+			wm->variant =3D pdata->variant;
+	}
=20
 	return wm97xx_register_mach_ops(wm, &mainstone_mach_ops);
 }
diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
index 746edfa..0c71c63 100644
=2D-- a/include/linux/wm97xx.h
+++ b/include/linux/wm97xx.h
@@ -309,7 +309,8 @@ struct wm97xx_batt_pdata {
=20
 struct wm97xx_touch_pdata {
 	int	irq;
=2D	bool	irq_inverted;
+	int	irq_gpio;	/* this is for mainstone and palm */
+	int	variant;
=20
 	int	cont_rate;
 	int	pen_int;
=2D-=20
1.6.3.3


--Boundary-00=_EagZKpfINnF1CNK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_EagZKpfINnF1CNK--
