From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: tlv320dac33: Convert to table based init
Date: Tue, 11 Oct 2011 13:11:55 +0300
Message-ID: <1318327915-7180-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 048E91038AB
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 12:12:05 +0200 (CEST)
Received: by mail-gx0-f169.google.com with SMTP id k5so5824513ggd.28
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2011 03:12:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320dac33.c |   23 +++++++----------------
 1 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 43ee3b1..3f4920d 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -627,18 +627,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"RIGHT_LO", NULL, "Codec Power"},
 };
 
-static int dac33_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, dac33_dapm_widgets,
-				  ARRAY_SIZE(dac33_dapm_widgets));
-	/* set up audio path interconnects */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	return 0;
-}
-
 static int dac33_set_bias_level(struct snd_soc_codec *codec,
 				enum snd_soc_bias_level level)
 {
@@ -1451,15 +1439,11 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 		}
 	}
 
-	snd_soc_add_controls(codec, dac33_snd_controls,
-			     ARRAY_SIZE(dac33_snd_controls));
 	/* Only add the FIFO controls, if we have valid IRQ number */
 	if (dac33->irq >= 0)
 		snd_soc_add_controls(codec, dac33_mode_snd_controls,
 				     ARRAY_SIZE(dac33_mode_snd_controls));
 
-	dac33_add_widgets(codec);
-
 err_power:
 	return ret;
 }
@@ -1502,6 +1486,13 @@ static struct snd_soc_codec_driver soc_codec_dev_tlv320dac33 = {
 	.remove = dac33_soc_remove,
 	.suspend = dac33_soc_suspend,
 	.resume = dac33_soc_resume,
+
+	.controls = dac33_snd_controls,
+	.num_controls = ARRAY_SIZE(dac33_snd_controls),
+	.dapm_widgets = dac33_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(dac33_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 #define DAC33_RATES	(SNDRV_PCM_RATE_44100 | \
-- 
1.7.7
