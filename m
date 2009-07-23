From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 4/4] Let wm97xx-battery use irq to detect
	charger state
Date: Thu, 23 Jul 2009 16:20:00 +0200
Message-ID: <200907231620.01064.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RGHaKpQPyYzkyjM"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D7D0103A0F
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 16:20:19 +0200 (CEST)
Received: by mail-fx0-f226.google.com with SMTP id 26so902400fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2009 07:20:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, avorontsov@ru.mvista.com, Takashi Iwai <tiwai@suse.de>, Eric Miao <eric.y.miao@gmail.com>, alsa-devel@alsa-project.org, Russell King
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_RGHaKpQPyYzkyjM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I split the "[PATCH 3/4] Convert WM97xx driver to use platform_data" patch 
into three smaller as Mark requested. These three will be:

[PATCH 2/4] Make wm97xx-core pass platform_data to battery, ts
[PATCH 3/4] Convert WM97xx battery to use platform_data
[PATCH 4/4] Let wm97xx-battery use irq to detect charger state

--Boundary-00=_RGHaKpQPyYzkyjM
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0004-Let-wm97xx-battery-use-irq-to-detect-charger-state.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0004-Let-wm97xx-battery-use-irq-to-detect-charger-state.patch"

=46rom 9dbdca1d8e9d0f66b0d3fa5b829c8dd438f8e2d5 Mon Sep 17 00:00:00 2001
=46rom: root <root@rin.(none)>
Date: Thu, 23 Jul 2009 16:02:08 +0200
Subject: [PATCH 4/4] Let wm97xx-battery use irq to detect charger state

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 drivers/power/wm97xx_battery.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/power/wm97xx_battery.c b/drivers/power/wm97xx_battery.c
index 9e38f4b..bda1c79 100644
=2D-- a/drivers/power/wm97xx_battery.c
+++ b/drivers/power/wm97xx_battery.c
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
+#include <linux/irq.h>
=20
 static DEFINE_MUTEX(bat_lock);
 static struct work_struct bat_work;
@@ -135,6 +136,12 @@ static void wm97xx_bat_work(struct work_struct *work)
 	wm97xx_bat_update(&bat_ps);
 }
=20
+static irqreturn_t wm97xx_chrg_irq(int irq, void *data)
+{
+	schedule_work(&bat_work);
+	return IRQ_HANDLED;
+}
+
 #ifdef CONFIG_PM
 static int wm97xx_bat_suspend(struct platform_device *dev, pm_message_t st=
ate)
 {
@@ -170,13 +177,18 @@ static int __devinit wm97xx_bat_probe(struct platform=
_device *dev)
 		return -EINVAL;
 	}
=20
=2D	if (pdata->charge_gpio >=3D 0 && gpio_is_valid(pdata->charge_gpio)) {
+	if (gpio_is_valid(pdata->charge_gpio)) {
 		ret =3D gpio_request(pdata->charge_gpio, "BATT CHRG");
 		if (ret)
 			goto err;
 		ret =3D gpio_direction_input(pdata->charge_gpio);
 		if (ret)
 			goto err2;
+		ret =3D request_irq(gpio_to_irq(pdata->charge_gpio),
+				wm97xx_chrg_irq, IRQF_DISABLED,
+				"AC Detect", 0);
+		if (ret)
+			goto err2;
 		props++;	/* POWER_SUPPLY_PROP_STATUS */
 	}
=20
@@ -193,7 +205,7 @@ static int __devinit wm97xx_bat_probe(struct platform_d=
evice *dev)
=20
 	prop =3D kzalloc(props * sizeof(*prop), GFP_KERNEL);
 	if (!prop)
=2D		goto err2;
+		goto err3;
=20
 	prop[i++] =3D POWER_SUPPLY_PROP_PRESENT;
 	if (pdata->charge_gpio >=3D 0)
@@ -226,13 +238,17 @@ static int __devinit wm97xx_bat_probe(struct platform=
_device *dev)
 	if (!ret)
 		schedule_work(&bat_work);
 	else
=2D		goto err3;
+		goto err4;
=20
 	return 0;
=2Derr3:
+err4:
 	kfree(prop);
+err3:
+	if (gpio_is_valid(pdata->charge_gpio))
+		free_irq(gpio_to_irq(pdata->charge_gpio), dev);
 err2:
=2D	gpio_free(pdata->charge_gpio);
+	if (gpio_is_valid(pdata->charge_gpio))
+		gpio_free(pdata->charge_gpio);
 err:
 	return ret;
 }
@@ -242,8 +258,10 @@ static int __devexit wm97xx_bat_remove(struct platform=
_device *dev)
 	struct wm97xx_pdata *wmdata =3D dev->dev.platform_data;
 	struct wm97xx_batt_pdata *pdata =3D wmdata->batt_pdata;
=20
=2D	if (pdata && pdata->charge_gpio && pdata->charge_gpio >=3D 0)
+	if (pdata && gpio_is_valid(pdata->charge_gpio)) {
+		free_irq(gpio_to_irq(pdata->charge_gpio), dev);
 		gpio_free(pdata->charge_gpio);
+	}
 	flush_scheduled_work();
 	power_supply_unregister(&bat_ps);
 	kfree(prop);
=2D-=20
1.6.3.3


--Boundary-00=_RGHaKpQPyYzkyjM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_RGHaKpQPyYzkyjM--
