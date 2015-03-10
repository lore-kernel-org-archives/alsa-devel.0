From: Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] ASoC: Intel: move sysclk source setting to
	platform_clock_control for balance.
Date: Tue, 10 Mar 2015 09:05:38 +0800
Message-ID: <1425949538-20068-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 627562614C2
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 01:59:36 +0100 (CET)
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
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, yao.jin@linux.intel.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

A playback noise happens after suspend/resume on Braswell. The issue is due to
the codec PLL and codec ASRC are not enabled correctly due to the incorrect
sysclk setting after resume. This patch resets the sysclk source setting in
platform clock control widget handler.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 sound/soc/intel/cht_bsw_rt5672.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/cht_bsw_rt5672.c b/sound/soc/intel/cht_bsw_rt5672.c
index bc8dcac..279df4c 100644
--- a/sound/soc/intel/cht_bsw_rt5672.c
+++ b/sound/soc/intel/cht_bsw_rt5672.c
@@ -50,6 +50,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dai *codec_dai;
+	int ret;
 
 	codec_dai = cht_get_codec_dai(card);
 	if (!codec_dai) {
@@ -57,17 +58,31 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		return -EIO;
 	}
 
-	if (!SND_SOC_DAPM_EVENT_OFF(event))
-		return 0;
-
-	/* Set codec sysclk source to its internal clock because codec PLL will
-	 * be off when idle and MCLK will also be off by ACPI when codec is
-	 * runtime suspended. Codec needs clock for jack detection and button
-	 * press.
-	 */
-	snd_soc_dai_set_sysclk(codec_dai, RT5670_SCLK_S_RCCLK,
-			       0, SND_SOC_CLOCK_IN);
-
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		/* set codec PLL source to the 19.2MHz platform clock (MCLK) */
+		ret = snd_soc_dai_set_pll(codec_dai, 0, RT5670_PLL1_S_MCLK,
+				CHT_PLAT_CLK_3_HZ, 48000 * 512);
+		if (ret < 0) {
+			dev_err(card->dev, "can't set codec pll: %d\n", ret);
+			return ret;
+		}
+
+		/* set codec sysclk source to PLL */
+		ret = snd_soc_dai_set_sysclk(codec_dai, RT5670_SCLK_S_PLL1,
+			48000 * 512, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(card->dev, "can't set codec sysclk: %d\n", ret);
+			return ret;
+		}
+	} else {
+		/* Set codec sysclk source to its internal clock because codec
+		 * PLL will be off when idle and MCLK will also be off by ACPI
+		 * when codec is runtime suspended. Codec needs clock for jack
+		 * detection and button press.
+		 */
+		snd_soc_dai_set_sysclk(codec_dai, RT5670_SCLK_S_RCCLK,
+				       48000 * 512, SND_SOC_CLOCK_IN);
+	}
 	return 0;
 }
 
@@ -77,7 +92,8 @@ static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
-			platform_clock_control, SND_SOC_DAPM_POST_PMD),
+			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route cht_audio_map[] = {
-- 
1.9.1
