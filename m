From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: assign DAC Ch to match headset
	L/R
Date: Wed, 30 Mar 2016 14:57:11 +0800
Message-ID: <1459321031-2365-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A7D3B2605C3
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 08:57:05 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

The default value of DAC channel select is reverse in codec.
For normal usage, switch the channel select when codec bootup.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 5 +++++
 sound/soc/codecs/nau8825.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 3e7bee2..1a99a25 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -905,6 +905,11 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 		NAU8825_RDAC_CLK_DELAY_MASK | NAU8825_RDAC_VREF_MASK,
 		(0x2 << NAU8825_RDAC_CLK_DELAY_SFT) |
 		(0x3 << NAU8825_RDAC_VREF_SFT));
+	/* Config L/R channel */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_DACL_CTRL,
+		NAU8825_DACL_CH_SEL_MASK, NAU8825_DACL_CH_SEL_L);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_DACR_CTRL,
+		NAU8825_DACL_CH_SEL_MASK, NAU8825_DACL_CH_SEL_R);
 }
 
 static const struct regmap_config nau8825_regmap_config = {
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 5fe009d..fcf0d0a 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -256,9 +256,15 @@
 
 /* DACL_CTRL (0x33) */
 #define NAU8825_DACL_CH_SEL_SFT	9
+#define NAU8825_DACL_CH_SEL_MASK (0x1 << NAU8825_DACL_CH_SEL_SFT)
+#define NAU8825_DACL_CH_SEL_L    (0x0 << NAU8825_DACL_CH_SEL_SFT)
+#define NAU8825_DACL_CH_SEL_R    (0x1 << NAU8825_DACL_CH_SEL_SFT)
 
 /* DACR_CTRL (0x34) */
 #define NAU8825_DACR_CH_SEL_SFT	9
+#define NAU8825_DACR_CH_SEL_MASK (0x1 << NAU8825_DACR_CH_SEL_SFT)
+#define NAU8825_DACR_CH_SEL_L    (0x0 << NAU8825_DACR_CH_SEL_SFT)
+#define NAU8825_DACR_CH_SEL_R    (0x1 << NAU8825_DACR_CH_SEL_SFT)
 
 /* CLASSG_CTRL (0x50) */
 #define NAU8825_CLASSG_TIMER_SFT	8
-- 
2.6.4
