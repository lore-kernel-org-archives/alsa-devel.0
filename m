From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Allow passing platform_data to devices
	attached to AC97 bus
Date: Tue, 21 Jul 2009 19:40:21 +0200
Message-ID: <200907211940.21638.marek.vasut@gmail.com>
References: <200907211633.14388.marek.vasut@gmail.com>
	<20090721145323.GA8991@rakim.wolfsonmicro.main>
	<s5hd47u2hjc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_F2fZKxv06Qd7wK1"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 2831710384C
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 19:40:43 +0200 (CEST)
Received: by fxm26 with SMTP id 26so2981468fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2009 10:40:43 -0700 (PDT)
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

--Boundary-00=_F2fZKxv06Qd7wK1
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

Also, another patch (depends on previous two). This one converts wm97xx dri=
ver=20
to use supplied platform_data. This will have a follow-up patch that conver=
ts=20
all the platforms to supply the platform_data properly.

--Boundary-00=_F2fZKxv06Qd7wK1
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Convert-WM97xx-driver-to-use-platform_data.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Convert-WM97xx-driver-to-use-platform_data.patch"

=46rom 833cb3050e05bc1a2ed3445533d5fe44188364e7 Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Tue, 21 Jul 2009 18:52:28 +0200
Subject: [PATCH 1/2] Convert WM97xx driver to use platform_data

This patch converts the wm97xx driver to use platform_data supplied by
ac97 bus. Also, this fixes the related wm97xx-battery driver to use
it's platform_data and prepares a structure for touchscreen driver.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 drivers/input/touchscreen/wm97xx-core.c |    3 +++
 drivers/power/wm97xx_battery.c          |   13 ++++---------
 include/linux/wm97xx.h                  |   30 +++++++++++++++++++++++++++=
+++
 include/linux/wm97xx_batt.h             |   26 --------------------------
 4 files changed, 37 insertions(+), 35 deletions(-)
 delete mode 100644 include/linux/wm97xx_batt.h

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchs=
creen/wm97xx-core.c
index 252eb11..e379479 100644
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
+	wm->battery_dev->dev.platform_data =3D pdata->batt_pdata;
 	ret =3D platform_device_add(wm->battery_dev);
 	if (ret < 0)
 		goto batt_reg_err;
@@ -671,6 +673,7 @@ static int wm97xx_probe(struct device *dev)
 	}
 	platform_set_drvdata(wm->touch_dev, wm);
 	wm->touch_dev->dev.parent =3D dev;
+	wm->touch_dev->dev.platform_data =3D pdata->touch_pdata;
 	ret =3D platform_device_add(wm->touch_dev);
 	if (ret < 0)
 		goto touch_reg_err;
diff --git a/drivers/power/wm97xx_battery.c b/drivers/power/wm97xx_battery.c
index 8bde921..66af868 100644
=2D-- a/drivers/power/wm97xx_battery.c
+++ b/drivers/power/wm97xx_battery.c
@@ -22,13 +22,12 @@
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
+static struct wm97xx_batt_pdata *pdata;
 static enum power_supply_property *prop;
=20
 static unsigned long wm97xx_read_bat(struct power_supply *bat_ps)
@@ -150,13 +149,15 @@ static int __devinit wm97xx_bat_probe(struct platform=
_device *dev)
 	int props =3D 1;	/* POWER_SUPPLY_PROP_PRESENT */
 	int i =3D 0;
=20
+	pdata =3D dev->dev.platform_data;
+
 	if (dev->id !=3D -1)
 		return -EINVAL;
=20
 	mutex_init(&work_lock);
=20
 	if (!pdata) {
=2D		dev_err(&dev->dev, "Please use wm97xx_bat_set_pdata\n");
+		dev_err(&dev->dev, "No platform_data supplied\n");
 		return -EINVAL;
 	}
=20
@@ -258,12 +259,6 @@ static void __exit wm97xx_bat_exit(void)
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
index 0c98781..746edfa 100644
=2D-- a/include/linux/wm97xx.h
+++ b/include/linux/wm97xx.h
@@ -293,6 +293,36 @@ struct wm97xx {
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
+struct wm97xx_touch_pdata {
+	int	irq;
+	bool	irq_inverted;
+
+	int	cont_rate;
+	int	pen_int;
+	int	pressure;
+	int	ac97_touch_slot;
+
+};
+
+struct wm97xx_pdata {
+	struct wm97xx_batt_pdata	*batt_pdata;	/* battery data */
+	struct wm97xx_touch_pdata	*touch_pdata;
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


--Boundary-00=_F2fZKxv06Qd7wK1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_F2fZKxv06Qd7wK1--
