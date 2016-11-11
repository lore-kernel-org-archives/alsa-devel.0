From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: Disable short Frame Sync
	detection logic
Date: Fri, 11 Nov 2016 12:34:12 +0800
Message-ID: <1478838852-11047-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8292B266C2E
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2016 05:34:16 +0100 (CET)
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

If the short Frame Sync detection logic enabled, the logic will check the
short frame sync threshold. If frame sync is less than the setting;
for example, frame sync less than 252 MCLK, the short frame sync signal is
flagged, digital filter temporary mute and skip that data.

If the system was intended for sampling rate change which could create
temporary short frame sync and not enough MIPS to run the digital filter.
But the situation doesn't happen in ALSA architecure. Thus the Frame Sync
is always stable, then no require to do the detection. Therefore,
the dirver disables the function for better performance.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 3 +++
 sound/soc/codecs/nau8825.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 8f2608a..3f9137f 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1883,6 +1883,9 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 		NAU8825_DACL_CH_SEL_MASK, NAU8825_DACL_CH_SEL_L);
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_DACR_CTRL,
 		NAU8825_DACL_CH_SEL_MASK, NAU8825_DACL_CH_SEL_R);
+	/* Disable short Frame Sync detection logic */
+	regmap_update_bits(regmap, NAU8825_REG_LEFT_TIME_SLOT,
+		NAU8825_DIS_FS_SHORT_DET, NAU8825_DIS_FS_SHORT_DET);
 }
 
 static const struct regmap_config nau8825_regmap_config = {
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 46cd1a6..0672a25 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -255,6 +255,11 @@
 #define NAU8825_I2S_MS_SLAVE	(0 << NAU8825_I2S_MS_SFT)
 #define NAU8825_I2S_BLK_DIV_MASK	0x7
 
+/* LEFT_TIME_SLOT (0x1e) */
+#define NAU8825_FS_ERR_CMP_SEL_SFT	14
+#define NAU8825_FS_ERR_CMP_SEL_MASK	(0x3 << NAU8825_FS_ERR_CMP_SEL_SFT)
+#define NAU8825_DIS_FS_SHORT_DET	(1 << 13)
+
 /* BIQ_CTRL (0x20) */
 #define NAU8825_BIQ_WRT_SFT   4
 #define NAU8825_BIQ_WRT_EN     (1 << NAU8825_BIQ_WRT_SFT)
-- 
2.6.4
