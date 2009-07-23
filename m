From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 2/4] Make wm97xx-core pass platform_data to
	battery, ts
Date: Thu, 23 Jul 2009 16:19:13 +0200
Message-ID: <200907231619.13817.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hFHaKEATzhuwlqM"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f226.google.com (mail-bw0-f226.google.com
	[209.85.218.226])
	by alsa0.perex.cz (Postfix) with ESMTP id F09471039E9
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 16:19:33 +0200 (CEST)
Received: by bwz26 with SMTP id 26so893018bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2009 07:19:33 -0700 (PDT)
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

--Boundary-00=_hFHaKEATzhuwlqM
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

--Boundary-00=_hFHaKEATzhuwlqM
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-Make-wm97xx-core-pass-platform_data-to-battery-ts.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-Make-wm97xx-core-pass-platform_data-to-battery-ts.patch"

=46rom 802ff2951522b63fe97f66b8ca4f42a49b98ccaa Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Thu, 23 Jul 2009 15:50:43 +0200
Subject: [PATCH 2/4] Make wm97xx-core pass platform_data to battery, ts

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 drivers/input/touchscreen/wm97xx-core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

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
=2D-=20
1.6.3.3


--Boundary-00=_hFHaKEATzhuwlqM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_hFHaKEATzhuwlqM--
