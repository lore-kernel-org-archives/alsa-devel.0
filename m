From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: [PATCH 1/5] mfd: add codec resource into 88pm860x
	driver
Date: Fri, 13 Aug 2010 21:55:19 +0800
Message-ID: <AANLkTi=NVRGys_Mv8u-2Ca6w2r1F2DCvKdquqsquwbpH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5936A10384F
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 15:55:20 +0200 (CEST)
Received: by wwi17 with SMTP id 17so768715wwi.20
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2010 06:55:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>From 7f48ab298f0017ff8b86dbc11f8de21505965ce7 Mon Sep 17 00:00:00 2001
From: Haojian Zhuang <haojian.zhuang@marvell.com>
Date: Thu, 12 Aug 2010 11:59:33 +0800
Subject: [PATCH 1/5] mfd: add codec resource into 88pm860x driver

Add codec IRQ resources that are used in 88pm860x codec driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm860x-core.c |   44 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 1580f1f..fba00b4 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -158,6 +158,43 @@ static struct mfd_cell onkey_devs[] = {
 	},
 };

+static struct resource codec_resources[] = {
+	{
+		/* Headset microphone insertion or removal */
+		.name		= "micin",
+		.start		= PM8607_IRQ_MICIN,
+		.end		= PM8607_IRQ_MICIN,
+		.flags		= IORESOURCE_IRQ,
+	}, {
+		/* Hook-switch press or release */
+		.name		= "hook",
+		.start		= PM8607_IRQ_HOOK,
+		.end		= PM8607_IRQ_HOOK,
+		.flags		= IORESOURCE_IRQ,
+	}, {
+		/* Headset insertion or removal */
+		.name		= "headset",
+		.start		= PM8607_IRQ_HEADSET,
+		.end		= PM8607_IRQ_HEADSET,
+		.flags		= IORESOURCE_IRQ,
+	}, {
+		/* Audio short */
+		.name		= "audio-short",
+		.start		= PM8607_IRQ_AUDIO_SHORT,
+		.end		= PM8607_IRQ_AUDIO_SHORT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct mfd_cell codec_devs[] = {
+	{
+		.name		= "88pm860x-codec",
+		.num_resources	= 4,
+		.resources	= &codec_resources[0],
+		.id		= -1,
+	},
+};
+
 static struct resource regulator_resources[] = {
 	PM8607_REG_RESOURCE(BUCK1, BUCK1),
 	PM8607_REG_RESOURCE(BUCK2, BUCK2),
@@ -695,6 +732,13 @@ static void __devinit device_8607_init(struct
pm860x_chip *chip,
 		goto out_dev;
 	}

+	ret = mfd_add_devices(chip->dev, 0, &codec_devs[0],
+			      ARRAY_SIZE(codec_devs),
+			      &codec_resources[0], 0);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to add codec subdev\n");
+		goto out_dev;
+	}
 	return;
 out_dev:
 	mfd_remove_devices(chip->dev);
-- 
1.5.6.5
