From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Palm interrupt driven touchscreen driver
Date: Thu, 4 Jun 2009 22:05:14 +0200
Message-ID: <200906042205.14267.marek.vasut@gmail.com>
References: <200906032341.03266.marek.vasut@gmail.com>
	<20090604081458.GA29926@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6jCKKyHfU5/df5U"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E85A10380B
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 22:05:14 +0200 (CEST)
Received: by fxm18 with SMTP id 18so1085842fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2009 13:05:13 -0700 (PDT)
In-Reply-To: <20090604081458.GA29926@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_6jCKKyHfU5/df5U
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 04 of June 2009 10:14:59 Russell King - ARM Linux wrote:
> On Wed, Jun 03, 2009 at 11:41:03PM +0200, Marek Vasut wrote:
> > +#include <mach/gpio.h>
>
> should be linux/gpio.h

Fixed in the following patch. Thanks

--Boundary-00=_6jCKKyHfU5/df5U
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0001-Add-Palm-support-to-Mainstone-accelerated-touch.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Add-Palm-support-to-Mainstone-accelerated-touch.patch"

=46rom f86f889e648369a095099e2f8a4423d787f512d6 Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Thu, 4 Jun 2009 22:02:18 +0200
Subject: [PATCH 1/2] Add Palm support to Mainstone accelerated touch

This patch refactors the Mainstone accelerated touch code a little and
adds support for interrupt driven touchscreen on Palm LifeDrive, TX and
Tungsten T5.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 drivers/input/touchscreen/Kconfig            |    4 +-
 drivers/input/touchscreen/mainstone-wm97xx.c |   52 +++++++++++++++++-----=
=2D--
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/=
Kconfig
index b01fd61..4072d22 100644
=2D-- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -342,11 +342,11 @@ config TOUCHSCREEN_WM9713
 	  WM9713 touchscreen controller.
=20
 config TOUCHSCREEN_WM97XX_MAINSTONE
=2D	tristate "WM97xx Mainstone accelerated touch"
+	tristate "WM97xx Mainstone/Palm accelerated touch"
 	depends on TOUCHSCREEN_WM97XX && ARCH_PXA
 	help
 	  Say Y here for support for streaming mode with WM97xx touchscreens
=2D	  on Mainstone systems.
+	  on Mainstone, Palm Tungsten T5, TX and LifeDrive systems.
=20
 	  If unsure, say N.
=20
diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/t=
ouchscreen/mainstone-wm97xx.c
index 4cc047a..60bda9a 100644
=2D-- a/drivers/input/touchscreen/mainstone-wm97xx.c
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c
@@ -31,9 +31,13 @@
 #include <linux/interrupt.h>
 #include <linux/wm97xx.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
+
 #include <mach/regs-ac97.h>
=20
=2D#define VERSION		"0.13"
+#include <asm/mach-types.h>
+
+#define VERSION		"0.14"
=20
 struct continuous {
 	u16 id;    /* codec id */
@@ -62,6 +66,7 @@ static const struct continuous cinfo[] =3D {
 /* continuous speed index */
 static int sp_idx;
 static u16 last, tries;
+static int irq;
=20
 /*
  * Pen sampling frequency (Hz) in continuous mode.
@@ -171,7 +176,7 @@ up:
=20
 static int wm97xx_acc_startup(struct wm97xx *wm)
 {
=2D	int idx =3D 0;
+	int idx =3D 0, ret =3D 0;
=20
 	/* check we have a codec */
 	if (wm->ac97 =3D=3D NULL)
@@ -191,18 +196,37 @@ static int wm97xx_acc_startup(struct wm97xx *wm)
 		 "mainstone accelerated touchscreen driver, %d samples/sec\n",
 		 cinfo[sp_idx].speed);
=20
+	/* IRQ driven touchscreen is used on Palm hardware */
+	if (machine_is_palmt5() || machine_is_palmtx() || machine_is_palmld()) {
+		pen_int =3D 1;
+		irq =3D 27;
+	} else if (machine_is_mainstone() && pen_int)
+		irq =3D 4;
+
+	if (irq) {
+		ret =3D gpio_request(irq, "Touchscreen IRQ");
+		if (ret)
+			goto out;
+
+		ret =3D gpio_direction_input(irq);
+		if (ret) {
+			gpio_free(irq);
+			goto out;
+		}
+
+		wm->pen_irq =3D gpio_to_irq(irq);
+		set_irq_type(wm->pen_irq, IRQ_TYPE_EDGE_BOTH);
+	} else	/* pen irq not supported */
+		pen_int =3D 0;
+
 	/* codec specific irq config */
 	if (pen_int) {
 		switch (wm->id) {
 		case WM9705_ID2:
=2D			wm->pen_irq =3D IRQ_GPIO(4);
=2D			set_irq_type(IRQ_GPIO(4), IRQ_TYPE_EDGE_BOTH);
 			break;
 		case WM9712_ID2:
 		case WM9713_ID2:
=2D			/* enable pen down interrupt */
 			/* use PEN_DOWN GPIO 13 to assert IRQ on GPIO line 2 */
=2D			wm->pen_irq =3D MAINSTONE_AC97_IRQ;
 			wm97xx_config_gpio(wm, WM97XX_GPIO_13, WM97XX_GPIO_IN,
 					   WM97XX_GPIO_POL_HIGH,
 					   WM97XX_GPIO_STICKY,
@@ -220,23 +244,17 @@ static int wm97xx_acc_startup(struct wm97xx *wm)
 		}
 	}
=20
=2D	return 0;
+out:
+	return ret;
 }
=20
 static void wm97xx_acc_shutdown(struct wm97xx *wm)
 {
 	/* codec specific deconfig */
 	if (pen_int) {
=2D		switch (wm->id & 0xffff) {
=2D		case WM9705_ID2:
=2D			wm->pen_irq =3D 0;
=2D			break;
=2D		case WM9712_ID2:
=2D		case WM9713_ID2:
=2D			/* disable interrupt */
=2D			wm->pen_irq =3D 0;
=2D			break;
=2D		}
+		if (irq)
+			gpio_free(irq);
+		wm->pen_irq =3D 0;
 	}
 }
=20
=2D-=20
1.6.2.1


--Boundary-00=_6jCKKyHfU5/df5U
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_6jCKKyHfU5/df5U--
