From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm8994: Add trace showing
	wm8958_micd_set_rate()
Date: Thu, 26 Apr 2012 17:25:09 +0100
Message-ID: <1335457509-31442-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1335457509-31442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2C73B10BB87
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 18:25:16 +0200 (CEST)
In-Reply-To: <1335457509-31442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

This can be helpful to users when tuning their systems.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 95f34af..54e7c72 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -119,6 +119,10 @@ static void wm8958_micd_set_rate(struct snd_soc_codec *codec)
 	val = rates[best].start << WM8958_MICD_BIAS_STARTTIME_SHIFT
 		| rates[best].rate << WM8958_MICD_RATE_SHIFT;
 
+	dev_dbg(codec->dev, "MICD rate %d,%d for %dHz %s\n",
+		rates[best].start, rates[best].rate, sysclk,
+		idle ? "idle" : "active");
+
 	snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
 			    WM8958_MICD_BIAS_STARTTIME_MASK |
 			    WM8958_MICD_RATE_MASK, val);
-- 
1.7.10
