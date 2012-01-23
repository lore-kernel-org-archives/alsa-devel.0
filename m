From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] mfd: Add __devinit and __devexit
	annotations in wm8994
Date: Mon, 23 Jan 2012 13:59:30 +0000
Message-ID: <1327327172-8411-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0639F2434C
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 14:59:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The wm8994_device_init() and wm8994_device_exit() functions were not
annotated as device init and exit functions, meaning they shouldn't
reference __devinitdata.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

This is mostly just a warning fix for the second patch and doesn't seem
terribly critical otherwise so it should probably get merged along with
it.

 drivers/mfd/wm8994-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index a04b3c1..a215b15 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -362,7 +362,7 @@ static int wm8994_ldo_in_use(struct wm8994_pdata *pdata, int ldo)
 /*
  * Instantiate the generic non-control parts of the device.
  */
-static int wm8994_device_init(struct wm8994 *wm8994, int irq)
+static __devinit int wm8994_device_init(struct wm8994 *wm8994, int irq)
 {
 	struct wm8994_pdata *pdata = wm8994->dev->platform_data;
 	struct regmap_config *regmap_config;
@@ -594,7 +594,7 @@ err_regmap:
 	return ret;
 }
 
-static void wm8994_device_exit(struct wm8994 *wm8994)
+static __devexit void wm8994_device_exit(struct wm8994 *wm8994)
 {
 	pm_runtime_disable(wm8994->dev);
 	mfd_remove_devices(wm8994->dev);
-- 
1.7.7.3
