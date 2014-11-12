From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Add DSP_B and LEFT_J mode
	support
Date: Wed, 12 Nov 2014 16:12:46 +0000
Message-ID: <1415808766-18364-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 613BA265756
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 17:20:39 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 1e352d8..9550d74 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -61,6 +61,11 @@
 #define ARIZONA_FLL_MIN_OUTDIV 2
 #define ARIZONA_FLL_MAX_OUTDIV 7
 
+#define ARIZONA_FMT_DSP_MODE_A          0
+#define ARIZONA_FMT_DSP_MODE_B          1
+#define ARIZONA_FMT_I2S_MODE            2
+#define ARIZONA_FMT_LEFT_JUSTIFIED_MODE 3
+
 #define arizona_fll_err(_fll, fmt, ...) \
 	dev_err(_fll->arizona->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
 #define arizona_fll_warn(_fll, fmt, ...) \
@@ -946,10 +951,26 @@ static int arizona_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
-		mode = 0;
+		mode = ARIZONA_FMT_DSP_MODE_A;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		if ((fmt & SND_SOC_DAIFMT_MASTER_MASK)
+				!= SND_SOC_DAIFMT_CBM_CFM) {
+			arizona_aif_err(dai, "DSP_B not valid in slave mode\n");
+			return -EINVAL;
+		}
+		mode = ARIZONA_FMT_DSP_MODE_B;
 		break;
 	case SND_SOC_DAIFMT_I2S:
-		mode = 2;
+		mode = ARIZONA_FMT_I2S_MODE;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		if ((fmt & SND_SOC_DAIFMT_MASTER_MASK)
+				!= SND_SOC_DAIFMT_CBM_CFM) {
+			arizona_aif_err(dai, "LEFT_J not valid in slave mode\n");
+			return -EINVAL;
+		}
+		mode = ARIZONA_FMT_LEFT_JUSTIFIED_MODE;
 		break;
 	default:
 		arizona_aif_err(dai, "Unsupported DAI format %d\n",
@@ -1298,7 +1319,8 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 
 	/* Force multiple of 2 channels for I2S mode */
 	val = snd_soc_read(codec, base + ARIZONA_AIF_FORMAT);
-	if ((channels & 1) && (val & ARIZONA_AIF1_FMT_MASK)) {
+	val &= ARIZONA_AIF1_FMT_MASK;
+	if ((channels & 1) && (val == ARIZONA_FMT_I2S_MODE)) {
 		arizona_aif_dbg(dai, "Forcing stereo mode\n");
 		bclk_target /= channels;
 		bclk_target *= channels + 1;
-- 
1.7.2.5
