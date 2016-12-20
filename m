From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH 1/2] ASoC: nau8825: correct the function name
	of register
Date: Tue, 20 Dec 2016 16:47:06 +0800
Message-ID: <1482223627-23547-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A4462666DB
 for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2016 09:47:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Change to correct name of the register function.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 6 +++---
 sound/soc/codecs/nau8825.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index e4fb017..9c98d35 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -561,9 +561,9 @@ static void nau8825_xtalk_prepare(struct nau8825 *nau8825)
 	nau8825_xtalk_backup(nau8825);
 	/* Config IIS as master to output signal by codec */
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
-		NAU8825_I2S_MS_MASK | NAU8825_I2S_DRV_MASK |
+		NAU8825_I2S_MS_MASK | NAU8825_I2S_LRC_DIV_MASK |
 		NAU8825_I2S_BLK_DIV_MASK, NAU8825_I2S_MS_MASTER |
-		(0x2 << NAU8825_I2S_DRV_SFT) | 0x1);
+		(0x2 << NAU8825_I2S_LRC_DIV_SFT) | 0x1);
 	/* Ramp up headphone volume to 0dB to get better performance and
 	 * avoid pop noise in headphone.
 	 */
@@ -657,7 +657,7 @@ static void nau8825_xtalk_clean(struct nau8825 *nau8825)
 		NAU8825_IRQ_RMS_EN, NAU8825_IRQ_RMS_EN);
 	/* Recover default value for IIS */
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
-		NAU8825_I2S_MS_MASK | NAU8825_I2S_DRV_MASK |
+		NAU8825_I2S_MS_MASK | NAU8825_I2S_LRC_DIV_MASK |
 		NAU8825_I2S_BLK_DIV_MASK, NAU8825_I2S_MS_SLAVE);
 	/* Restore value of specific register for cross talk */
 	nau8825_xtalk_restore(nau8825);
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 5732ce1..4b390c4 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -248,8 +248,8 @@
 
 /* I2S_PCM_CTRL2 (0x1d) */
 #define NAU8825_I2S_TRISTATE	(1 << 15) /* 0 - normal mode, 1 - Hi-Z output */
-#define NAU8825_I2S_DRV_SFT	12
-#define NAU8825_I2S_DRV_MASK	(0x3 << NAU8825_I2S_DRV_SFT)
+#define NAU8825_I2S_LRC_DIV_SFT	12
+#define NAU8825_I2S_LRC_DIV_MASK	(0x3 << NAU8825_I2S_LRC_DIV_SFT)
 #define NAU8825_I2S_MS_SFT	3
 #define NAU8825_I2S_MS_MASK	(1 << NAU8825_I2S_MS_SFT)
 #define NAU8825_I2S_MS_MASTER	(1 << NAU8825_I2S_MS_SFT)
-- 
2.6.4
