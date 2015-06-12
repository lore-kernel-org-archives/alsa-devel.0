From: Julian Scheel <julian@jusst.de>
Subject: [PATCH] ASoC: wm8523: Set bclk ratio for master mode
Date: Fri, 12 Jun 2015 15:57:32 +0200
Message-ID: <1434117452-25223-1-git-send-email-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender163-mail.zoho.com (sender163-mail.zoho.com
 [74.201.84.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 73775266968
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 15:57:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Julian Scheel <julian@jusst.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

When running in master mode the bclk divider must be configured to generate a
sane bitclock. Pick the smallest fs multiplicator, which can hold all
transmitted bits.

Signed-off-by: Julian Scheel <julian@jusst.de>
---
 sound/soc/codecs/wm8523.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index ec1f574..9c60058 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -113,6 +113,15 @@ static struct {
 	{ 7, 1152 },
 };
 
+static struct {
+	int value;
+	int ratio;
+} bclk_ratios[WM8523_NUM_RATES] = {
+	{ 2, 32 },
+	{ 3, 64 },
+	{ 4, 128 },
+};
+
 static int wm8523_startup(struct snd_pcm_substream *substream,
 			  struct snd_soc_dai *dai)
 {
@@ -162,6 +171,23 @@ static int wm8523_hw_params(struct snd_pcm_substream *substream,
 	aifctrl2 &= ~WM8523_SR_MASK;
 	aifctrl2 |= lrclk_ratios[i].value;
 
+	if (aifctrl1 & WM8523_AIF_MSTR) {
+		/* Find a fs->bclk ratio */
+		for (i = 0; i < ARRAY_SIZE(bclk_ratios); i++)
+			if (params_width(params) * 2 <= bclk_ratios[i].ratio)
+				break;
+
+		if (i == ARRAY_SIZE(bclk_ratios)) {
+			dev_err(codec->dev,
+				"No matching BCLK/fs ratio for word length %d\n",
+				params_width(params));
+			return -EINVAL;
+		}
+
+		aifctrl2 &= ~WM8523_BCLKDIV_MASK;
+		aifctrl2 |= bclk_ratios[i].value << WM8523_BCLKDIV_SHIFT;
+	}
+
 	aifctrl1 &= ~WM8523_WL_MASK;
 	switch (params_width(params)) {
 	case 16:
-- 
2.4.0
