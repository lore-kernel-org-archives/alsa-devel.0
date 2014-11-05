From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/6] ASoC: wm8961: Use table based DAPM and
	control setup
Date: Wed,  5 Nov 2014 10:46:35 +0100
Message-ID: <1415180796-31129-5-git-send-email-lars@metafoo.de>
References: <1415180796-31129-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-084.synserver.de (smtp-out-084.synserver.de
 [212.40.185.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 119DC2625D7
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 10:46:42 +0100 (CET)
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

Makes the code a bit cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8961.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 41d23e9..e077bb2 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -835,7 +835,6 @@ static struct snd_soc_dai_driver wm8961_dai = {
 
 static int wm8961_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	u16 reg;
 
 	/* Enable class W */
@@ -873,12 +872,6 @@ static int wm8961_probe(struct snd_soc_codec *codec)
 
 	wm8961_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	snd_soc_add_codec_controls(codec, wm8961_snd_controls,
-				ARRAY_SIZE(wm8961_snd_controls));
-	snd_soc_dapm_new_controls(dapm, wm8961_dapm_widgets,
-				  ARRAY_SIZE(wm8961_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
-
 	return 0;
 }
 
@@ -915,6 +908,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8961 = {
 	.suspend =	wm8961_suspend,
 	.resume =	wm8961_resume,
 	.set_bias_level = wm8961_set_bias_level,
+
+	.controls = wm8961_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8961_snd_controls),
+	.dapm_widgets = wm8961_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8961_dapm_widgets),
+	.dapm_routes = audio_paths,
+	.num_dapm_routes = ARRAY_SIZE(audio_paths),
 };
 
 static const struct regmap_config wm8961_regmap = {
-- 
1.8.0
