From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: wm8994: Tune debounce rates for jack
	detect mode
Date: Thu, 26 Apr 2012 17:25:07 +0100
Message-ID: <1335457509-31442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B7C310BB86
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 18:25:16 +0200 (CEST)
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

Use a slightly larger debounce when identifying accessory type and a
slightly smaller one when detecting buttons in response to user feedback
from large scale testing.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 9d50e76..9754904 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -70,8 +70,8 @@ static const struct wm8958_micd_rate micdet_rates[] = {
 static const struct wm8958_micd_rate jackdet_rates[] = {
 	{ 32768,       true,  0, 1 },
 	{ 32768,       false, 0, 1 },
-	{ 44100 * 256, true,  7, 10 },
-	{ 44100 * 256, false, 7, 10 },
+	{ 44100 * 256, true,  10, 10 },
+	{ 44100 * 256, false, 7, 8 },
 };
 
 static void wm8958_micd_set_rate(struct snd_soc_codec *codec)
@@ -3481,6 +3481,8 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 	if (present) {
 		dev_dbg(codec->dev, "Jack detected\n");
 
+		wm8958_micd_set_rate(codec);
+
 		snd_soc_update_bits(codec, WM8958_MICBIAS2,
 				    WM8958_MICB2_DISCH, 0);
 
-- 
1.7.10
