From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Error out if we can't generate a LRCLK
	at all for WM8994
Date: Mon, 28 Nov 2011 22:07:32 +0000
Message-ID: <1322518052-12388-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 408AC103A56
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 23:07:34 +0100 (CET)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2c7a90c..607f4fc 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2313,6 +2313,11 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 	bclk |= best << WM8994_AIF1_BCLK_DIV_SHIFT;
 
 	lrclk = bclk_rate / params_rate(params);
+	if (!lrclk) {
+		dev_err(dai->dev, "Unable to generate LRCLK from %dHz BCLK\n",
+			bclk_rate);
+		return -EINVAL;
+	}
 	dev_dbg(dai->dev, "Using LRCLK rate %d for actual LRCLK %dHz\n",
 		lrclk, bclk_rate / lrclk);
 
-- 
1.7.7.3
