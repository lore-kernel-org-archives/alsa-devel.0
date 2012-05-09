From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm8994: Use regmap directly for
	wm8994_mic_work
Date: Wed,  9 May 2012 19:30:26 +0100
Message-ID: <1336588226-32725-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1336588226-32725-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8816C10454A
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 20:30:34 +0200 (CEST)
In-Reply-To: <1336588226-32725-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Make it clearer what context we're operating in.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 93d81a9..2f9870a 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3232,18 +3232,20 @@ static void wm8994_mic_work(struct work_struct *work)
 	struct wm8994_priv *priv = container_of(work,
 						struct wm8994_priv,
 						mic_work.work);
-	struct snd_soc_codec *codec = priv->codec;
-	int reg;
+	struct regmap *regmap = priv->wm8994->regmap;
+	struct device *dev = priv->wm8994->dev;
+	unsigned int reg;
+	int ret;
 	int report;
 
-	reg = snd_soc_read(codec, WM8994_INTERRUPT_RAW_STATUS_2);
-	if (reg < 0) {
-		dev_err(codec->dev, "Failed to read microphone status: %d\n",
-			reg);
+	ret = regmap_read(regmap, WM8994_INTERRUPT_RAW_STATUS_2, &reg);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read microphone status: %d\n",
+			ret);
 		return;
 	}
 
-	dev_dbg(codec->dev, "Microphone status: %x\n", reg);
+	dev_dbg(dev, "Microphone status: %x\n", reg);
 
 	report = 0;
 	if (reg & WM8994_MIC1_DET_STS) {
-- 
1.7.10
