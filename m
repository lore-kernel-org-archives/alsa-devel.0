From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] MFD: twl6040: Fix revision information
Date: Mon, 16 Jul 2012 11:49:43 +0200
Message-ID: <1342432184-12046-2-git-send-email-peter.ujfalusi@ti.com>
References: <1342432184-12046-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342432184-12046-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

twl6040 ES1.1 and ES1.2 have the same revid (0x01).
ES1.3 of twl6040 REVID is 0x02.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/mfd/twl6040.h |    4 ++--
 sound/soc/codecs/twl6040.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index 6659487..e002097 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -161,8 +161,8 @@
 #define TWL6040_CELLS			2
 
 #define TWL6040_REV_ES1_0		0x00
-#define TWL6040_REV_ES1_1		0x01
-#define TWL6040_REV_ES1_2		0x02
+#define TWL6040_REV_ES1_1		0x01 /* Rev ES1.1 and ES1.2 */
+#define TWL6040_REV_ES1_3		0x02
 
 #define TWL6040_IRQ_TH			0
 #define TWL6040_IRQ_PLUG		1
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index a36e9fc..2786de2 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -653,7 +653,7 @@ int twl6040_get_hs_step_size(struct snd_soc_codec *codec)
 {
 	struct twl6040 *twl6040 = codec->control_data;
 
-	if (twl6040_get_revid(twl6040) < TWL6040_REV_ES1_2)
+	if (twl6040_get_revid(twl6040) < TWL6040_REV_ES1_3)
 		/* For ES under ES_1.3 HS step is 2 mV */
 		return 2;
 	else
-- 
1.7.8.6
