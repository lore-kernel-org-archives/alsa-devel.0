From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: wm8770: Conver to table based DAPM
	and control init
Date: Wed, 10 Oct 2012 20:43:39 +0900
Message-ID: <1349869419-10357-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1349869419-10357-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4DBC26507F
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 09:11:57 +0200 (CEST)
In-Reply-To: <1349869419-10357-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8770.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 9092031..0b690ba 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -614,13 +614,6 @@ static int wm8770_probe(struct snd_soc_codec *codec)
 	/* mute all DACs */
 	snd_soc_update_bits(codec, WM8770_DACMUTE, 0x10, 0x10);
 
-	snd_soc_add_codec_controls(codec, wm8770_snd_controls,
-			     ARRAY_SIZE(wm8770_snd_controls));
-	snd_soc_dapm_new_controls(&codec->dapm, wm8770_dapm_widgets,
-				  ARRAY_SIZE(wm8770_dapm_widgets));
-	snd_soc_dapm_add_routes(&codec->dapm, wm8770_intercon,
-				ARRAY_SIZE(wm8770_intercon));
-
 err_reg_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8770->supplies), wm8770->supplies);
 	return ret;
@@ -630,6 +623,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8770 = {
 	.probe = wm8770_probe,
 	.set_bias_level = wm8770_set_bias_level,
 	.idle_bias_off = true,
+
+	.controls = wm8770_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8770_snd_controls),
+	.dapm_widgets = wm8770_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8770_dapm_widgets),
+	.dapm_routes = wm8770_intercon,
+	.num_dapm_routes = ARRAY_SIZE(wm8770_intercon),
 };
 
 static const struct of_device_id wm8770_of_match[] = {
-- 
1.7.10.4
