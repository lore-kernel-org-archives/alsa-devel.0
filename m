From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/6] ASoC: tas2552: Use table based DAPM setup
Date: Wed,  5 Nov 2014 10:46:32 +0100
Message-ID: <1415180796-31129-2-git-send-email-lars@metafoo.de>
References: <1415180796-31129-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-084.synserver.de (smtp-out-084.synserver.de
 [212.40.185.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B818261AA1
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 10:46:38 +0100 (CET)
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
 sound/soc/codecs/tas2552.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index f039dc8..b505212 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -345,7 +345,6 @@ static const struct reg_default tas2552_init_regs[] = {
 static int tas2552_codec_probe(struct snd_soc_codec *codec)
 {
 	struct tas2552_data *tas2552 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	tas2552->codec = codec;
@@ -390,11 +389,6 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, TAS2552_CFG_2, TAS2552_BOOST_EN |
 				  TAS2552_APT_EN | TAS2552_LIM_EN);
 
-	snd_soc_dapm_new_controls(dapm, tas2552_dapm_widgets,
-				ARRAY_SIZE(tas2552_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, tas2552_audio_map,
-				ARRAY_SIZE(tas2552_audio_map));
-
 	return 0;
 
 patch_fail:
@@ -462,6 +456,10 @@ static struct snd_soc_codec_driver soc_codec_dev_tas2552 = {
 	.resume = tas2552_resume,
 	.controls = tas2552_snd_controls,
 	.num_controls = ARRAY_SIZE(tas2552_snd_controls),
+	.dapm_widgets = tas2552_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tas2552_dapm_widgets),
+	.dapm_routes = tas2552_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(tas2552_audio_map),
 };
 
 static const struct regmap_config tas2552_regmap_config = {
-- 
1.8.0
