From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Allow passing platform_data to devices
	attached to AC97 bus
Date: Wed, 22 Jul 2009 00:40:56 +0200
Message-ID: <200907220040.57052.marek.vasut@gmail.com>
References: <200907211633.14388.marek.vasut@gmail.com>
	<20090721223334.GE7547@n2100.arm.linux.org.uk>
	<200907220039.00790.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5PkZKGLF2+U6F0c"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 8967C10388C
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 00:41:22 +0200 (CEST)
Received: by fxm26 with SMTP id 26so3146145fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2009 15:41:22 -0700 (PDT)
In-Reply-To: <200907220039.00790.marek.vasut@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, cbou@mail.ru, dwmw2@infradead.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_5PkZKGLF2+U6F0c
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dne St 22. =C4=8Dervence 2009 00:39:00 Marek Vasut napsal(a):
> Dne St 22. =C4=8Dervence 2009 00:33:34 Russell King - ARM Linux napsal(a):
> > On Wed, Jul 22, 2009 at 12:13:12AM +0200, Marek Vasut wrote:
> > > +		ret =3D set_irq_type(gpio_to_irq(pdata->charge_gpio),
> > > +				IRQ_TYPE_EDGE_BOTH);
> > > +		if (ret)
> > > +			goto err2;
> > > +		ret =3D request_irq(gpio_to_irq(pdata->charge_gpio),
> > > +				wm97xx_chrg_irq, IRQF_DISABLED,
> > > +				"AC Detect", 0);
> >
> > This should be done as one call to request_irq().
> >
> > Why?
> >
> > If the IRQ is already in use by something else, calling set_irq_type()
> > will stamp on that other user, enforcing the change of configuration.
> > request_irq() will then fail, leaving the IRQ configuration buggered.
> >
> > Combining the two allows request_irq() to fail if the IRQ line is busy.
> > If it isn't busy, it will configure the IRQ line prior to enabling the
> > IRQ.  If the IRQ is shared and sharing is permitted, it will fail if
> > the configuration is not compatible with the existing IRQ configuration.
> >
> > set_irq_type() should only be used very sparingly and when there's no
> > other option.
>
> Sorry, I removed that, this patch should be OK.

Argh, I forget to fix the goto label.

--Boundary-00=_5PkZKGLF2+U6F0c
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0003-Convert-WM97xx-driver-to-use-platform_data.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0003-Convert-WM97xx-driver-to-use-platform_data.patch"

=46rom 54febe82847aeef3fcc02a074fd9d21def97f174 Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Tue, 21 Jul 2009 18:52:28 +0200
Subject: [PATCH 3/4] Convert WM97xx driver to use platform_data

This patch converts the wm97xx driver to use platform_data supplied by
ac97 bus. Also, this fixes the related wm97xx-battery driver to use
it's platform_data and prepares a structure for touchscreen driver.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 drivers/input/touchscreen/wm97xx-core.c |    3 ++
 drivers/power/wm97xx_battery.c          |   55 ++++++++++++++++++++++-----=
=2D--
 include/linux/wm97xx.h                  |   18 ++++++++++
 include/linux/wm97xx_batt.h             |   26 --------------
 4 files changed, 61 insertions(+), 41 deletions(-)
 delete mode 100644 include/linux/wm97xx_batt.h

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchs=
creen/wm97xx-core.c
index 252eb11..f944918 100644
=2D-- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -561,6 +561,7 @@ static void wm97xx_ts_input_close(struct input_dev *ide=
v)
 static int wm97xx_probe(struct device *dev)
 {
 	struct wm97xx *wm;
+	struct wm97xx_pdata *pdata =3D dev->platform_data;
 	int ret =3D 0, id =3D 0;
=20
 	wm =3D kzalloc(sizeof(struct wm97xx), GFP_KERNEL);
@@ -658,6 +659,7 @@ static int wm97xx_probe(struct device *dev)
 	}
 	platform_set_drvdata(wm->battery_dev, wm);
 	wm->battery_dev->dev.parent =3D dev;
+	wm->battery_dev->dev.platform_data =3D pdata;
 	ret =3D platform_device_add(wm->battery_dev);
 	if (ret < 0)
 		goto batt_reg_err;
@@ -671,6 +673,7 @@ static int wm97xx_probe(struct device *dev)
 	}
 	platform_set_drvdata(wm->touch_dev, wm);
 	wm->touch_dev->dev.parent =3D dev;
+	wm->touch_dev->dev.platform_data =3D pdata;
 	ret =3D platform_device_add(wm->touch_dev);
 	if (ret < 0)
 		goto touch_reg_err;
diff --git a/drivers/power/wm97xx_battery.c b/drivers/power/wm97xx_battery.c
index 8bde921..f31cad9 100644
=2D-- a/drivers/power/wm97xx_battery.c
+++ b/drivers/power/wm97xx_battery.c
@@ -22,17 +22,19 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
=2D#include <linux/wm97xx_batt.h>
+#include <linux/irq.h>
=20
 static DEFINE_MUTEX(bat_lock);
 static struct work_struct bat_work;
 struct mutex work_lock;
 static int bat_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
=2Dstatic struct wm97xx_batt_info *pdata;
 static enum power_supply_property *prop;
=20
 static unsigned long wm97xx_read_bat(struct power_supply *bat_ps)
 {
+	struct wm97xx_pdata *wmdata =3D bat_ps->dev->parent->platform_data;
+	struct wm97xx_batt_pdata *pdata =3D wmdata->batt_pdata;
+
 	return wm97xx_read_aux_adc(bat_ps->dev->parent->driver_data,
 					pdata->batt_aux) * pdata->batt_mult /
 					pdata->batt_div;
@@ -40,6 +42,9 @@ static unsigned long wm97xx_read_bat(struct power_supply =
*bat_ps)
=20
 static unsigned long wm97xx_read_temp(struct power_supply *bat_ps)
 {
+	struct wm97xx_pdata *wmdata =3D bat_ps->dev->parent->platform_data;
+	struct wm97xx_batt_pdata *pdata =3D wmdata->batt_pdata;
+
 	return wm97xx_read_aux_adc(bat_ps->dev->parent->driver_data,
 					pdata->temp_aux) * pdata->temp_mult /
 					pdata->temp_div;
@@ -49,6 +54,9 @@ static int wm97xx_bat_get_property(struct power_supply *b=
at_ps,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
 {
+	struct wm97xx_pdata *wmdata =3D bat_ps->dev->parent->platform_data;
+	struct wm97xx_batt_pdata *pdata =3D wmdata->batt_pdata;
+
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		val->intval =3D bat_status;
@@ -97,6 +105,7 @@ static void wm97xx_bat_external_power_changed(struct pow=
er_supply *bat_ps)
 static void wm97xx_bat_update(struct power_supply *bat_ps)
 {
 	int old_status =3D bat_status;
+	struct wm97xx_batt_pdata *pdata =3D dev_get_drvdata(bat_ps->dev->parent);
=20
 	mutex_lock(&work_lock);
=20
@@ -127,6 +136,12 @@ static void wm97xx_bat_work(struct work_struct *work)
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
@@ -149,6 +164,8 @@ static int __devinit wm97xx_bat_probe(struct platform_d=
evice *dev)
 	int ret =3D 0;
 	int props =3D 1;	/* POWER_SUPPLY_PROP_PRESENT */
 	int i =3D 0;
+	struct wm97xx_pdata *wmdata =3D dev->dev.platform_data;
+	struct wm97xx_batt_pdata *pdata =3D wmdata->batt_pdata;
=20
 	if (dev->id !=3D -1)
 		return -EINVAL;
@@ -156,17 +173,22 @@ static int __devinit wm97xx_bat_probe(struct platform=
_device *dev)
 	mutex_init(&work_lock);
=20
 	if (!pdata) {
=2D		dev_err(&dev->dev, "Please use wm97xx_bat_set_pdata\n");
+		dev_err(&dev->dev, "No platform_data supplied\n");
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
@@ -183,7 +205,7 @@ static int __devinit wm97xx_bat_probe(struct platform_d=
evice *dev)
=20
 	prop =3D kzalloc(props * sizeof(*prop), GFP_KERNEL);
 	if (!prop)
=2D		goto err2;
+		goto err3;
=20
 	prop[i++] =3D POWER_SUPPLY_PROP_PRESENT;
 	if (pdata->charge_gpio >=3D 0)
@@ -216,21 +238,30 @@ static int __devinit wm97xx_bat_probe(struct platform=
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
=20
 static int __devexit wm97xx_bat_remove(struct platform_device *dev)
 {
=2D	if (pdata && pdata->charge_gpio && pdata->charge_gpio >=3D 0)
+	struct wm97xx_pdata *wmdata =3D dev->dev.platform_data;
+	struct wm97xx_batt_pdata *pdata =3D wmdata->batt_pdata;
+
+	if (pdata && gpio_is_valid(pdata->charge_gpio)) {
+		free_irq(gpio_to_irq(pdata->charge_gpio), dev);
 		gpio_free(pdata->charge_gpio);
+	}
 	flush_scheduled_work();
 	power_supply_unregister(&bat_ps);
 	kfree(prop);
@@ -258,12 +289,6 @@ static void __exit wm97xx_bat_exit(void)
 	platform_driver_unregister(&wm97xx_bat_driver);
 }
=20
=2Dvoid __init wm97xx_bat_set_pdata(struct wm97xx_batt_info *data)
=2D{
=2D	pdata =3D data;
=2D}
=2DEXPORT_SYMBOL_GPL(wm97xx_bat_set_pdata);
=2D
 module_init(wm97xx_bat_init);
 module_exit(wm97xx_bat_exit);
=20
diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
index 0c98781..38e8c4d 100644
=2D-- a/include/linux/wm97xx.h
+++ b/include/linux/wm97xx.h
@@ -293,6 +293,24 @@ struct wm97xx {
 	u16 suspend_mode;               /* PRP in suspend mode */
 };
=20
+struct wm97xx_batt_pdata {
+	int	batt_aux;
+	int	temp_aux;
+	int	charge_gpio;
+	int	min_voltage;
+	int	max_voltage;
+	int	batt_div;
+	int	batt_mult;
+	int	temp_div;
+	int	temp_mult;
+	int	batt_tech;
+	char	*batt_name;
+};
+
+struct wm97xx_pdata {
+	struct wm97xx_batt_pdata	*batt_pdata;	/* battery data */
+};
+
 /*
  * Codec GPIO access (not supported on WM9705)
  * This can be used to set/get codec GPIO and Virtual GPIO status.
diff --git a/include/linux/wm97xx_batt.h b/include/linux/wm97xx_batt.h
deleted file mode 100644
index 9681d1a..0000000
=2D-- a/include/linux/wm97xx_batt.h
+++ /dev/null
@@ -1,26 +0,0 @@
=2D#ifndef _LINUX_WM97XX_BAT_H
=2D#define _LINUX_WM97XX_BAT_H
=2D
=2D#include <linux/wm97xx.h>
=2D
=2Dstruct wm97xx_batt_info {
=2D	int	batt_aux;
=2D	int	temp_aux;
=2D	int	charge_gpio;
=2D	int	min_voltage;
=2D	int	max_voltage;
=2D	int	batt_div;
=2D	int	batt_mult;
=2D	int	temp_div;
=2D	int	temp_mult;
=2D	int	batt_tech;
=2D	char	*batt_name;
=2D};
=2D
=2D#ifdef CONFIG_BATTERY_WM97XX
=2Dvoid __init wm97xx_bat_set_pdata(struct wm97xx_batt_info *data);
=2D#else
=2Dstatic inline void wm97xx_bat_set_pdata(struct wm97xx_batt_info *data) {}
=2D#endif
=2D
=2D#endif
=2D-=20
1.6.3.3


--Boundary-00=_5PkZKGLF2+U6F0c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_5PkZKGLF2+U6F0c--
