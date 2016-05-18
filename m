From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl6040: Disconnect AUX output pads on
	digital mute
Date: Wed, 18 May 2016 16:19:01 +0300
Message-ID: <1463577541-32295-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [198.47.19.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F9022604BE
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 15:19:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Disconnect also the path to AUXL from the HF path during digital_mute to
avoid pop noise leakage to Line-out pads.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/mfd/twl6040.h | 1 +
 sound/soc/codecs/twl6040.c  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index a7c50e54f3e0..8015db974157 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -134,6 +134,7 @@
 #define TWL6040_HFDACENA		(1 << 0)
 #define TWL6040_HFPGAENA		(1 << 1)
 #define TWL6040_HFDRVENA		(1 << 4)
+#define TWL6040_HFSWENA			(1 << 6)
 
 /* VIBCTLL/R (0x18/0x1A) fields */
 
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 7a744b581cc1..1f7081043566 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -987,9 +987,9 @@ static void twl6040_mute_path(struct snd_soc_codec *codec, enum twl6040_dai_id i
 		if (mute) {
 			/* Power down drivers and DACs */
 			hflctl &= ~(TWL6040_HFDACENA | TWL6040_HFPGAENA |
-				    TWL6040_HFDRVENA);
+				    TWL6040_HFDRVENA | TWL6040_HFSWENA);
 			hfrctl &= ~(TWL6040_HFDACENA | TWL6040_HFPGAENA |
-				    TWL6040_HFDRVENA);
+				    TWL6040_HFDRVENA | TWL6040_HFSWENA);
 		}
 
 		twl6040_reg_write(twl6040, TWL6040_REG_HFLCTL, hflctl);
-- 
2.8.2
