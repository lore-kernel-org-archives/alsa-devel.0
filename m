From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 3/4] Convert WM97xx battery to use platform_data
Date: Thu, 23 Jul 2009 16:19:42 +0200
Message-ID: <200907231619.42913.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+FHaKoPAvhOIhf8"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 332F4103A16
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 16:20:04 +0200 (CEST)
Received: by fxm26 with SMTP id 26so902400fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2009 07:20:03 -0700 (PDT)
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

--Boundary-00=_+FHaKoPAvhOIhf8
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

--Boundary-00=_+FHaKoPAvhOIhf8
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0003-Convert-WM97xx-battery-to-use-platform_data.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0003-Convert-WM97xx-battery-to-use-platform_data.patch"

=46rom 2c67cab373142cb442f31b8943c29b392123af77 Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Thu, 23 Jul 2009 15:52:08 +0200
Subject: [PATCH 3/4] Convert WM97xx battery to use platform_data

This patch converts the wm97xx-battery driver to use platform_data
supplied by ac97 bus.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 drivers/power/wm97xx_battery.c |   25 ++++++++++++++++---------
 include/linux/wm97xx.h         |   18 ++++++++++++++++++
 include/linux/wm97xx_batt.h    |   26 --------------------------
 3 files changed, 34 insertions(+), 35 deletions(-)
 delete mode 100644 include/linux/wm97xx_batt.h

diff --git a/drivers/power/wm97xx_battery.c b/drivers/power/wm97xx_battery.c
index 8bde921..9e38f4b 100644
=2D-- a/drivers/power/wm97xx_battery.c
+++ b/drivers/power/wm97xx_battery.c
@@ -22,17 +22,18 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
=2D#include <linux/wm97xx_batt.h>
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
@@ -40,6 +41,9 @@ static unsigned long wm97xx_read_bat(struct power_supply =
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
@@ -49,6 +53,9 @@ static int wm97xx_bat_get_property(struct power_supply *b=
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
@@ -97,6 +104,7 @@ static void wm97xx_bat_external_power_changed(struct pow=
er_supply *bat_ps)
 static void wm97xx_bat_update(struct power_supply *bat_ps)
 {
 	int old_status =3D bat_status;
+	struct wm97xx_batt_pdata *pdata =3D dev_get_drvdata(bat_ps->dev->parent);
=20
 	mutex_lock(&work_lock);
=20
@@ -149,6 +157,8 @@ static int __devinit wm97xx_bat_probe(struct platform_d=
evice *dev)
 	int ret =3D 0;
 	int props =3D 1;	/* POWER_SUPPLY_PROP_PRESENT */
 	int i =3D 0;
+	struct wm97xx_pdata *wmdata =3D dev->dev.platform_data;
+	struct wm97xx_batt_pdata *pdata =3D wmdata->batt_pdata;
=20
 	if (dev->id !=3D -1)
 		return -EINVAL;
@@ -156,7 +166,7 @@ static int __devinit wm97xx_bat_probe(struct platform_d=
evice *dev)
 	mutex_init(&work_lock);
=20
 	if (!pdata) {
=2D		dev_err(&dev->dev, "Please use wm97xx_bat_set_pdata\n");
+		dev_err(&dev->dev, "No platform_data supplied\n");
 		return -EINVAL;
 	}
=20
@@ -229,6 +239,9 @@ err:
=20
 static int __devexit wm97xx_bat_remove(struct platform_device *dev)
 {
+	struct wm97xx_pdata *wmdata =3D dev->dev.platform_data;
+	struct wm97xx_batt_pdata *pdata =3D wmdata->batt_pdata;
+
 	if (pdata && pdata->charge_gpio && pdata->charge_gpio >=3D 0)
 		gpio_free(pdata->charge_gpio);
 	flush_scheduled_work();
@@ -258,12 +271,6 @@ static void __exit wm97xx_bat_exit(void)
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


--Boundary-00=_+FHaKoPAvhOIhf8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_+FHaKoPAvhOIhf8--
