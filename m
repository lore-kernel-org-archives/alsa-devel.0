From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH 2/3] ASoC: nau8540: PGA short to ground
Date: Tue, 7 Nov 2017 15:23:18 +0800
Message-ID: <1510039399-12807-2-git-send-email-KCHSU0@nuvoton.com>
References: <1510039399-12807-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 11061266E15
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 08:23:24 +0100 (CET)
In-Reply-To: <1510039399-12807-1-git-send-email-KCHSU0@nuvoton.com>
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
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Change channel PGA input mode selection for better recording quality.
The patch shorts the inputs to ground with 12kOhm differentially
terminated.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8540.c |  7 +++++++
 sound/soc/codecs/nau8540.h | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index 2efa431..572bea2 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -737,6 +737,13 @@ static void nau8540_init_regs(struct nau8540 *nau8540)
 	regmap_update_bits(regmap, NAU8540_REG_ADC_SAMPLE_RATE,
 		NAU8540_CH_SYNC | NAU8540_ADC_OSR_MASK,
 		NAU8540_CH_SYNC | NAU8540_ADC_OSR_64);
+	/* PGA input mode selection */
+	regmap_update_bits(regmap, NAU8540_REG_FEPGA1,
+		NAU8540_FEPGA1_MODCH2_SHT | NAU8540_FEPGA1_MODCH1_SHT,
+		NAU8540_FEPGA1_MODCH2_SHT | NAU8540_FEPGA1_MODCH1_SHT);
+	regmap_update_bits(regmap, NAU8540_REG_FEPGA2,
+		NAU8540_FEPGA2_MODCH4_SHT | NAU8540_FEPGA2_MODCH3_SHT,
+		NAU8540_FEPGA2_MODCH4_SHT | NAU8540_FEPGA2_MODCH3_SHT);
 }
 
 static int __maybe_unused nau8540_suspend(struct snd_soc_codec *codec)
diff --git a/sound/soc/codecs/nau8540.h b/sound/soc/codecs/nau8540.h
index 5e0dd18..9595663 100644
--- a/sound/soc/codecs/nau8540.h
+++ b/sound/soc/codecs/nau8540.h
@@ -189,6 +189,18 @@
 #define NAU8540_PRECHARGE_DIS		(0x1 << 13)
 #define NAU8540_GLOBAL_BIAS_EN	(0x1 << 12)
 
+/* FEPGA1 (0x69) */
+#define NAU8540_FEPGA1_MODCH2_SHT_SFT	7
+#define NAU8540_FEPGA1_MODCH2_SHT	(0x1 << NAU8540_FEPGA1_MODCH2_SHT_SFT)
+#define NAU8540_FEPGA1_MODCH1_SHT_SFT	3
+#define NAU8540_FEPGA1_MODCH1_SHT	(0x1 << NAU8540_FEPGA1_MODCH1_SHT_SFT)
+
+/* FEPGA2 (0x6A) */
+#define NAU8540_FEPGA2_MODCH4_SHT_SFT	7
+#define NAU8540_FEPGA2_MODCH4_SHT	(0x1 << NAU8540_FEPGA2_MODCH4_SHT_SFT)
+#define NAU8540_FEPGA2_MODCH3_SHT_SFT	3
+#define NAU8540_FEPGA2_MODCH3_SHT	(0x1 << NAU8540_FEPGA2_MODCH3_SHT_SFT)
+
 
 /* System Clock Source */
 enum {
-- 
2.6.4
