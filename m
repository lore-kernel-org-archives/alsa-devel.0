From: Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH] ASoC: tlv320aic3x: add input clock selection
Date: Tue, 10 Jul 2012 14:36:58 +0200
Message-ID: <1341923818-8406-1-git-send-email-jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from router.aksignal.cz (router.aksignal.cz [188.175.113.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 1388B24AB9
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 14:37:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
List-Id: alsa-devel@alsa-project.org

This patch adds input selection of main codec clock - from what pin.
Both registers set same value since codec uses clock divider or pll at one time.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 sound/soc/codecs/tlv320aic3x.c |    6 ++++++
 sound/soc/codecs/tlv320aic3x.h |    8 ++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 11e195f..5bc5543 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1030,6 +1030,12 @@ static int aic3x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 
+	/* set clock on MCLK or GPIO2 or BCLK */
+	snd_soc_update_bits(codec, AIC3X_CLKGEN_CTRL_REG, PLLCLK_IN_MASK,
+				clk_id << PLLCLK_IN_SHIFT);
+	snd_soc_update_bits(codec, AIC3X_CLKGEN_CTRL_REG, CLKDIV_IN_MASK,
+				clk_id << CLKDIV_IN_SHIFT);
+
 	aic3x->sysclk = freq;
 	return 0;
 }
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 586c5d5..ed4a788 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -195,6 +195,14 @@
 #define PLL_CLKIN_SHIFT		4
 #define MCLK_SOURCE		0x0
 #define PLL_CLKDIV_SHIFT	0
+#define PLLCLK_IN_MASK		0x30
+#define PLLCLK_IN_SHIFT		4
+#define CLKDIV_IN_MASK		0xc0
+#define CLKDIV_IN_SHIFT		6
+/* clock in source */
+#define CLKIN_MCLK		0
+#define CLKIN_GPIO2		1
+#define CLKIN_BCLK		2
 
 /* Software reset register bits */
 #define SOFT_RESET		0x80
-- 
1.7.7
