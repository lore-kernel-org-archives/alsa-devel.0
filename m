From: Inha Song <ideal.song@samsung.com>
Subject: [alsa-devel] [PATCH] mfd: wm8994: set mfd id-base for regulator devs
 creation to avoid conflicts
Date: Tue, 30 Dec 2014 21:06:51 +0900
Message-ID: <1419941211-17667-1-git-send-email-ideal.song@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org
Cc: sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Inha Song <ideal.song@samsung.com>
List-Id: alsa-devel@alsa-project.org

After commit: 6e3f62f0793e ("mfd: core: Fix platform-device id generation")
We must set the id base when register a duplicate name of mfd_cell.
If not, duplicate filename error was reported.

- sysfs: cannot create duplicate filename '/devices/.../wm8994-ldo'

Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 drivers/mfd/wm8994-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index e6fab94..47cd3cc 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -36,12 +36,12 @@
 static const struct mfd_cell wm8994_regulator_devs[] = {
 	{
 		.name = "wm8994-ldo",
-		.id = 1,
+		.id = 0,
 		.pm_runtime_no_callbacks = true,
 	},
 	{
 		.name = "wm8994-ldo",
-		.id = 2,
+		.id = 1,
 		.pm_runtime_no_callbacks = true,
 	},
 };
@@ -344,7 +344,7 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 	dev_set_drvdata(wm8994->dev, wm8994);
 
 	/* Add the on-chip regulators first for bootstrapping */
-	ret = mfd_add_devices(wm8994->dev, -1,
+	ret = mfd_add_devices(wm8994->dev, 0,
 			      wm8994_regulator_devs,
 			      ARRAY_SIZE(wm8994_regulator_devs),
 			      NULL, 0, NULL);
-- 
2.0.0.390.gcb682f8
