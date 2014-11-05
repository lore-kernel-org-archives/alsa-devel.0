From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/6] ASoC: wm8737: Use table based DAPM and
	control setup
Date: Wed,  5 Nov 2014 10:46:34 +0100
Message-ID: <1415180796-31129-4-git-send-email-lars@metafoo.de>
References: <1415180796-31129-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-084.synserver.de (smtp-out-084.synserver.de
 [212.40.185.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 607AF2625C4
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 10:46:41 +0100 (CET)
In-Reply-To: <1415180796-31129-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, patches@opensource.wolfsonmicro.com, Dan Murphy <dmurphy@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Makes the code a bit cleaner and shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8737.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 744a422..fe41dd2b 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -277,17 +277,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "AIF", NULL, "ADCR" },
 };
 
-static int wm8737_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8737_dapm_widgets,
-				  ARRAY_SIZE(wm8737_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-
-	return 0;
-}
-
 /* codec mclk clock divider coefficients */
 static const struct {
 	u32 mclk;
@@ -593,10 +582,6 @@ static int wm8737_probe(struct snd_soc_codec *codec)
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(wm8737->supplies), wm8737->supplies);
 
-	snd_soc_add_codec_controls(codec, wm8737_snd_controls,
-			     ARRAY_SIZE(wm8737_snd_controls));
-	wm8737_add_widgets(codec);
-
 	return 0;
 
 err_enable:
@@ -617,6 +602,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8737 = {
 	.suspend	= wm8737_suspend,
 	.resume		= wm8737_resume,
 	.set_bias_level = wm8737_set_bias_level,
+
+	.controls = wm8737_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8737_snd_controls),
+	.dapm_widgets = wm8737_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8737_dapm_widgets),
+	.dapm_routes = intercon,
+	.num_dapm_routes = ARRAY_SIZE(intercon),
 };
 
 static const struct of_device_id wm8737_of_match[] = {
-- 
1.8.0
