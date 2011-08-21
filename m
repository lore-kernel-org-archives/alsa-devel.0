From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Ensure we get an impedence reported for
	WM8958 jack detect
Date: Sun, 21 Aug 2011 13:28:05 +0100
Message-ID: <1313929685-13322-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A4E2F24378
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Aug 2011 14:28:12 +0200 (CEST)
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

Occasionally we may see an accessory reported before we have a stable
impedance for the accessory. If this happens then reread the status in
order to ensure that the handler can take the appropriate action for the
status change.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/registers.h |   15 +++++++++++++
 sound/soc/codecs/wm8994.c            |   37 +++++++++++++++++++++++----------
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/include/linux/mfd/wm8994/registers.h b/include/linux/mfd/wm8994/registers.h
index d7be463..10c483f 100644
--- a/include/linux/mfd/wm8994/registers.h
+++ b/include/linux/mfd/wm8994/registers.h
@@ -1967,6 +1967,21 @@
 #define WM8958_MICB2_DISCH_WIDTH                     1  /* MICB2_DISCH */
 
 /*
+ * R210 (0xD2) - Mic Detect 3
+ */
+#define WM8958_MICD_LVL_MASK                    0x07FC  /* MICD_LVL - [10:2] */
+#define WM8958_MICD_LVL_SHIFT                        2  /* MICD_LVL - [10:2] */
+#define WM8958_MICD_LVL_WIDTH                        9  /* MICD_LVL - [10:2] */
+#define WM8958_MICD_VALID                       0x0002  /* MICD_VALID */
+#define WM8958_MICD_VALID_MASK                  0x0002  /* MICD_VALID */
+#define WM8958_MICD_VALID_SHIFT                      1  /* MICD_VALID */
+#define WM8958_MICD_VALID_WIDTH                      1  /* MICD_VALID */
+#define WM8958_MICD_STS                         0x0001  /* MICD_STS */
+#define WM8958_MICD_STS_MASK                    0x0001  /* MICD_STS */
+#define WM8958_MICD_STS_SHIFT                        0  /* MICD_STS */
+#define WM8958_MICD_STS_WIDTH                        1  /* MICD_STS */
+
+/*
  * R76 (0x4C) - Charge Pump (1)
  */
 #define WM8994_CP_ENA                           0x8000  /* CP_ENA */
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 5e8d66d..a26cee1 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3043,19 +3043,34 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 {
 	struct wm8994_priv *wm8994 = data;
 	struct snd_soc_codec *codec = wm8994->codec;
-	int reg;
+	int reg, count;
 
-	reg = snd_soc_read(codec, WM8958_MIC_DETECT_3);
-	if (reg < 0) {
-		dev_err(codec->dev, "Failed to read mic detect status: %d\n",
-			reg);
-		return IRQ_NONE;
-	}
+	/* We may occasionally read a detection without an impedence
+	 * range being provided - if that happens loop again.
+	 */
+	count = 10;
+	do {
+		reg = snd_soc_read(codec, WM8958_MIC_DETECT_3);
+		if (reg < 0) {
+			dev_err(codec->dev,
+				"Failed to read mic detect status: %d\n",
+				reg);
+			return IRQ_NONE;
+		}
 
-	if (!(reg & WM8958_MICD_VALID)) {
-		dev_dbg(codec->dev, "Mic detect data not valid\n");
-		goto out;
-	}
+		if (!(reg & WM8958_MICD_VALID)) {
+			dev_dbg(codec->dev, "Mic detect data not valid\n");
+			goto out;
+		}
+
+		if (!(reg & WM8958_MICD_STS) || (reg & WM8958_MICD_LVL_MASK))
+			break;
+
+		msleep(1);
+	} while (count--);
+
+	if (count == 0)
+		dev_warn(codec->dev, "No impedence range reported for jack\n");
 
 #ifndef CONFIG_SND_SOC_WM8994_MODULE
 	trace_snd_soc_jack_irq(dev_name(codec->dev));
-- 
1.7.5.4
