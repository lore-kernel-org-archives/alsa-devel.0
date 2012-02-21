From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8776: Add WM8775 device ID to the
	WM8776
Date: Tue, 21 Feb 2012 09:12:56 +0000
Message-ID: <1329815576-20930-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 49133103DA5
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2012 10:13:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM8775 is register compatible with the WM8776 so can be supported with
the same driver though it is an ADC only part. Add the device ID to the
WM8776 driver, further updates will be added in the future.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8776.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 33e97d1..a19db5a 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -30,6 +30,11 @@
 
 #include "wm8776.h"
 
+enum wm8776_chip_type {
+	WM8775 = 1,
+	WM8776,
+};
+
 /* codec private data */
 struct wm8776_priv {
 	enum snd_soc_control_type control_type;
@@ -512,7 +517,8 @@ static __devexit int wm8776_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id wm8776_i2c_id[] = {
-	{ "wm8776", 0 },
+	{ "wm8775", WM8775 },
+	{ "wm8776", WM8776 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wm8776_i2c_id);
-- 
1.7.9
