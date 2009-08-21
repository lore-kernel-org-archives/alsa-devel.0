From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH] Convert WM97xx-battery to dev_pm_ops
Date: Sat, 22 Aug 2009 01:05:52 +0200
Message-ID: <200908220105.52244.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QhyjKeNN/AFcCQ2"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B50D2454D
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Aug 2009 01:06:14 +0200 (CEST)
Received: by fxm3 with SMTP id 3so694655fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2009 16:06:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: avorontsov@ru.mvista.com, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_QhyjKeNN/AFcCQ2
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Anton, are you fine with this one? Mark, in case Anton is ok, would you mind 
applying? Thanks!

Cheers!
Marek Vasut

--Boundary-00=_QhyjKeNN/AFcCQ2
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Convert-WM97xx-battery-to-dev_pm_ops.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Convert-WM97xx-battery-to-dev_pm_ops.patch"

=46rom 90955155d905ac8222af37317379cb084ba850ea Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Sat, 22 Aug 2009 00:36:43 +0200
Subject: [PATCH] Convert WM97xx-battery to dev_pm_ops

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 drivers/power/wm97xx_battery.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/power/wm97xx_battery.c b/drivers/power/wm97xx_battery.c
index 98f2f37..af6d3cd 100644
=2D-- a/drivers/power/wm97xx_battery.c
+++ b/drivers/power/wm97xx_battery.c
@@ -144,20 +144,22 @@ static irqreturn_t wm97xx_chrg_irq(int irq, void *dat=
a)
 }
=20
 #ifdef CONFIG_PM
=2Dstatic int wm97xx_bat_suspend(struct platform_device *dev, pm_message_t =
state)
+static int wm97xx_bat_suspend(struct device *dev)
 {
 	flush_scheduled_work();
 	return 0;
 }
=20
=2Dstatic int wm97xx_bat_resume(struct platform_device *dev)
+static int wm97xx_bat_resume(struct device *dev)
 {
 	schedule_work(&bat_work);
 	return 0;
 }
=2D#else
=2D#define wm97xx_bat_suspend NULL
=2D#define wm97xx_bat_resume NULL
+
+static const struct dev_pm_ops wm97xx_bat_pm_ops =3D {
+	.suspend	=3D wm97xx_bat_suspend,
+	.resume		=3D wm97xx_bat_resume,
+};
 #endif
=20
 static int __devinit wm97xx_bat_probe(struct platform_device *dev)
@@ -273,11 +275,12 @@ static struct platform_driver wm97xx_bat_driver =3D {
 	.driver	=3D {
 		.name	=3D "wm97xx-battery",
 		.owner	=3D THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	=3D &wm97xx_bat_pm_ops,
+#endif
 	},
 	.probe		=3D wm97xx_bat_probe,
 	.remove		=3D __devexit_p(wm97xx_bat_remove),
=2D	.suspend	=3D wm97xx_bat_suspend,
=2D	.resume		=3D wm97xx_bat_resume,
 };
=20
 static int __init wm97xx_bat_init(void)
=2D-=20
1.6.3.3


--Boundary-00=_QhyjKeNN/AFcCQ2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_QhyjKeNN/AFcCQ2--
