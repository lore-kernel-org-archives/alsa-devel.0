From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] ASoC: wm8995: Use table based DAPM and
	control setup
Date: Wed,  5 Nov 2014 10:46:36 +0100
Message-ID: <1415180796-31129-6-git-send-email-lars@metafoo.de>
References: <1415180796-31129-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-084.synserver.de (smtp-out-084.synserver.de
 [212.40.185.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A9DE262626
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 10:46:43 +0100 (CET)
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
 sound/soc/codecs/wm8995.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 1288ede..e40c8a6 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -2102,13 +2102,6 @@ static int wm8995_probe(struct snd_soc_codec *codec)
 
 	wm8995_update_class_w(codec);
 
-	snd_soc_add_codec_controls(codec, wm8995_snd_controls,
-			     ARRAY_SIZE(wm8995_snd_controls));
-	snd_soc_dapm_new_controls(&codec->dapm, wm8995_dapm_widgets,
-				  ARRAY_SIZE(wm8995_dapm_widgets));
-	snd_soc_dapm_add_routes(&codec->dapm, wm8995_intercon,
-				ARRAY_SIZE(wm8995_intercon));
-
 	return 0;
 
 err_reg_enable:
@@ -2205,6 +2198,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8995 = {
 	.remove = wm8995_remove,
 	.set_bias_level = wm8995_set_bias_level,
 	.idle_bias_off = true,
+
+	.controls = wm8995_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8995_snd_controls),
+	.dapm_widgets = wm8995_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8995_dapm_widgets),
+	.dapm_routes = wm8995_intercon,
+	.num_dapm_routes = ARRAY_SIZE(wm8995_intercon),
 };
 
 static struct regmap_config wm8995_regmap = {
-- 
1.8.0
