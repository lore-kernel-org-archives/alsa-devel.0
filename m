From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ARM: S3C64XX: Hook up supply for WM8994
	LDOs on Littlemill
Date: Thu,  8 Mar 2012 11:55:07 +0000
Message-ID: <1331207707-6026-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1331207707-6026-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 40C9A10413A
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 12:55:11 +0100 (CET)
In-Reply-To: <1331207707-6026-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kukjin Kim <kgene.kim@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Kukjin, are you OK with this going via the MFD tree?  It depends on the
previous change.

 arch/arm/mach-s3c64xx/mach-crag6410-module.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 77c8342..6eb4b55 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -163,6 +163,14 @@ static const struct i2c_board_info wm1259_devs[] = {
 	},
 };
 
+static struct regulator_init_data wm8994_ldo1 = {
+	.supply_regulator = "WALLVDD",
+};
+
+static struct regulator_init_data wm8994_ldo2 = {
+	.supply_regulator = "WALLVDD",
+};
+
 static struct wm8994_pdata wm8994_pdata = {
 	.gpio_base = CODEC_GPIO_BASE,
 	.gpio_defaults = {
@@ -170,8 +178,8 @@ static struct wm8994_pdata wm8994_pdata = {
 	},
 	.irq_base = CODEC_IRQ_BASE,
 	.ldo = {
-		 { },
-		 { },
+		 { .init_data = &wm8994_ldo1, },
+		 { .init_data = &wm8994_ldo2, },
 	},
 };
 
-- 
1.7.9.1
