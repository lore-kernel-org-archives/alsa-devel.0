From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: ASoC updates for 2.6.32
Date: Fri, 28 Aug 2009 02:29:40 +0200
Message-ID: <200908280229.40432.marek.vasut@gmail.com>
References: <20090823101656.GA11491@sirena.org.uk>
	<s5hvdkeiho6.wl%tiwai@suse.de>
	<20090823173828.GA5516@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0TylKPex65Bft60"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 350232443F
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Aug 2009 02:30:09 +0200 (CEST)
Received: by fxm3 with SMTP id 3so1327481fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2009 17:30:06 -0700 (PDT)
In-Reply-To: <20090823173828.GA5516@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_0TylKPex65Bft60
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Dne Po 24. srpna 2009 09:37:16 Takashi Iwai napsal(a):
> At Sun, 23 Aug 2009 18:38:28 +0100,
>
> Mark Brown wrote:
> > On Sun, Aug 23, 2009 at 07:06:17PM +0200, Takashi Iwai wrote:
> > > Hm, this causes merge errors regarding wm97xx battery driver.
> >
> > Causes merge errors with which tree?  It's a straight fast forward
> > aginst topic/asoc.
>
> Merging your changes into topic/asoc, then merging into master or
> for-next.  So, it seems conflicting with the latest upstream.

Those patches were made against sound-2.6 from Mark ... I assume some 
additional stuff was pushed into the kernel after Mark updated his tree.
>
> > > Also, when I merge with 2.6.31-rc7, it gives more merge errors in
> > > arch code.
> > >
> > > Do they depend on other tree changes like linux-arm?
> >
> > I suspect they're at most only textual.  In any case, this is all
> > causing far too much trouble so I've just dropped all of the patches
> > that are causing issues.
> >
> > Marek, I suggest that you submit the patch to use IRQs against the power
> > tree. 

Where would this one be ?
> > I also suggest that you submit a version of the battery platform
> > data changes against the power tree which avoids making the platforms
> > instabuggy then when that's applied submit changes to Eric to use the
> > new platform data, making it clear that the machine changes will need to
> > wait for both power and ALSA trees to be merged during the merge window.
> > This is the approach that's been suggested previously - it makes life
> > much easier if changes go through the relevant trees.

If those changes go through one tree, it'll make them consistent and avoid 
breakage (because if some of those changes go through the power tree, some 
through Erics tree ... all of those trees would be broken for some time).
> >
> > The following changes since commit
> > a0a499c5792b8656cd51e11d5e0db9fb21640f58: Eduardo Valentin (1):
> >         ASoC: OMAP: Use DMA operating mode of McBSP
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git
> > for-2.6.32
>
> Thanks, pulled now.
>
>
> Takashi

I rebased those patches against your tree -- sound-2.6/master -- and attached 
is the patch that had problems with merging (fixed version). The other patches 
apply fine.

--Boundary-00=_0TylKPex65Bft60
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-Convert-WM97xx-battery-to-use-platform_data.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-Convert-WM97xx-battery-to-use-platform_data.patch"

=46rom 45f88c5ca31ff4214cd4248ed9541c8279753c9e Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Fri, 28 Aug 2009 02:19:14 +0200
Subject: [PATCH 2/5] Convert WM97xx battery to use platform_data

This patch converts the wm97xx-battery driver to use platform_data
supplied by ac97 bus.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 drivers/power/wm97xx_battery.c |   26 +++++++++++++++++---------
 include/linux/wm97xx.h         |   18 ++++++++++++++++++
 include/linux/wm97xx_batt.h    |   26 --------------------------
 3 files changed, 35 insertions(+), 35 deletions(-)
 delete mode 100644 include/linux/wm97xx_batt.h

diff --git a/drivers/power/wm97xx_battery.c b/drivers/power/wm97xx_battery.c
index b787335..b62f7ae 100644
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
 	return wm97xx_read_aux_adc(dev_get_drvdata(bat_ps->dev->parent),
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
 	return wm97xx_read_aux_adc(dev_get_drvdata(bat_ps->dev->parent),
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
@@ -97,6 +104,8 @@ static void wm97xx_bat_external_power_changed(struct pow=
er_supply *bat_ps)
 static void wm97xx_bat_update(struct power_supply *bat_ps)
 {
 	int old_status =3D bat_status;
+	struct wm97xx_pdata *wmdata =3D bat_ps->dev->parent->platform_data;
+	struct wm97xx_batt_pdata *pdata =3D wmdata->batt_pdata;
=20
 	mutex_lock(&work_lock);
=20
@@ -149,6 +158,8 @@ static int __devinit wm97xx_bat_probe(struct platform_d=
evice *dev)
 	int ret =3D 0;
 	int props =3D 1;	/* POWER_SUPPLY_PROP_PRESENT */
 	int i =3D 0;
+	struct wm97xx_pdata *wmdata =3D dev->dev.platform_data;
+	struct wm97xx_batt_pdata *pdata =3D wmdata->batt_pdata;
=20
 	if (dev->id !=3D -1)
 		return -EINVAL;
@@ -156,7 +167,7 @@ static int __devinit wm97xx_bat_probe(struct platform_d=
evice *dev)
 	mutex_init(&work_lock);
=20
 	if (!pdata) {
=2D		dev_err(&dev->dev, "Please use wm97xx_bat_set_pdata\n");
+		dev_err(&dev->dev, "No platform_data supplied\n");
 		return -EINVAL;
 	}
=20
@@ -229,6 +240,9 @@ err:
=20
 static int __devexit wm97xx_bat_remove(struct platform_device *dev)
 {
+	struct wm97xx_pdata *wmdata =3D dev->dev.platform_data;
+	struct wm97xx_batt_pdata *pdata =3D wmdata->batt_pdata;
+
 	if (pdata && pdata->charge_gpio && pdata->charge_gpio >=3D 0)
 		gpio_free(pdata->charge_gpio);
 	flush_scheduled_work();
@@ -258,12 +272,6 @@ static void __exit wm97xx_bat_exit(void)
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
index 6f69968..b2c2297 100644
=2D-- a/include/linux/wm97xx.h
+++ b/include/linux/wm97xx.h
@@ -286,6 +286,24 @@ struct wm97xx {
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


--Boundary-00=_0TylKPex65Bft60
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_0TylKPex65Bft60--
