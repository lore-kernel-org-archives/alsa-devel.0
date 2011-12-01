From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] mfd: Test for jack detection when deciding if
	wm8994 should suspend
Date: Thu,  1 Dec 2011 17:22:13 +0000
Message-ID: <1322760133-4919-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2BC84243AB
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 18:22:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The jack detection on WM1811 is often required during system suspend, add
it as another check when deciding if we should suspend.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

This depends on the ALSA side changes implementing the feature due to
the addition of the new register field, I guess merging via ASoC makes
sense?

 drivers/mfd/wm8994-core.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 3160cdd..4549999 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -242,6 +242,20 @@ static int wm8994_suspend(struct device *dev)
 		break;
 	}
 
+	switch (wm8994->type) {
+	case WM1811:
+		ret = wm8994_reg_read(wm8994, WM8994_ANTIPOP_2);
+		if (ret < 0) {
+			dev_err(dev, "Failed to read jackdet: %d\n", ret);
+		} else if (ret & WM1811_JACKDET_MODE_MASK) {
+			dev_dbg(dev, "CODEC still active, ignoring suspend\n");
+			return 0;
+		}
+		break;
+	default:
+		break;
+	}
+
 	/* Disable LDO pulldowns while the device is suspended if we
 	 * don't know that something will be driving them. */
 	if (!wm8994->ldo_ena_always_driven)
-- 
1.7.7.3
