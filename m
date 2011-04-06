From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Set left channel volume update bits for
	WM8994
Date: Wed,  6 Apr 2011 10:53:37 +0900
Message-ID: <1302054817-28864-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AF09A10384A
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 16:01:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ensures that we apply volume updates that don't affect the right channel.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 03ef624..b6d47e7 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2977,20 +2977,36 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	wm8994_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch volume updates (right only; we always do left then right). */
+	snd_soc_update_bits(codec, WM8994_AIF1_DAC1_LEFT_VOLUME,
+			    WM8994_AIF1DAC1_VU, WM8994_AIF1DAC1_VU);
 	snd_soc_update_bits(codec, WM8994_AIF1_DAC1_RIGHT_VOLUME,
 			    WM8994_AIF1DAC1_VU, WM8994_AIF1DAC1_VU);
+	snd_soc_update_bits(codec, WM8994_AIF1_DAC2_LEFT_VOLUME,
+			    WM8994_AIF1DAC2_VU, WM8994_AIF1DAC2_VU);
 	snd_soc_update_bits(codec, WM8994_AIF1_DAC2_RIGHT_VOLUME,
 			    WM8994_AIF1DAC2_VU, WM8994_AIF1DAC2_VU);
+	snd_soc_update_bits(codec, WM8994_AIF2_DAC_LEFT_VOLUME,
+			    WM8994_AIF2DAC_VU, WM8994_AIF2DAC_VU);
 	snd_soc_update_bits(codec, WM8994_AIF2_DAC_RIGHT_VOLUME,
 			    WM8994_AIF2DAC_VU, WM8994_AIF2DAC_VU);
+	snd_soc_update_bits(codec, WM8994_AIF1_ADC1_LEFT_VOLUME,
+			    WM8994_AIF1ADC1_VU, WM8994_AIF1ADC1_VU);
 	snd_soc_update_bits(codec, WM8994_AIF1_ADC1_RIGHT_VOLUME,
 			    WM8994_AIF1ADC1_VU, WM8994_AIF1ADC1_VU);
+	snd_soc_update_bits(codec, WM8994_AIF1_ADC2_LEFT_VOLUME,
+			    WM8994_AIF1ADC2_VU, WM8994_AIF1ADC2_VU);
 	snd_soc_update_bits(codec, WM8994_AIF1_ADC2_RIGHT_VOLUME,
 			    WM8994_AIF1ADC2_VU, WM8994_AIF1ADC2_VU);
+	snd_soc_update_bits(codec, WM8994_AIF2_ADC_LEFT_VOLUME,
+			    WM8994_AIF2ADC_VU, WM8994_AIF1ADC2_VU);
 	snd_soc_update_bits(codec, WM8994_AIF2_ADC_RIGHT_VOLUME,
 			    WM8994_AIF2ADC_VU, WM8994_AIF1ADC2_VU);
+	snd_soc_update_bits(codec, WM8994_DAC1_LEFT_VOLUME,
+			    WM8994_DAC1_VU, WM8994_DAC1_VU);
 	snd_soc_update_bits(codec, WM8994_DAC1_RIGHT_VOLUME,
 			    WM8994_DAC1_VU, WM8994_DAC1_VU);
+	snd_soc_update_bits(codec, WM8994_DAC2_LEFT_VOLUME,
+			    WM8994_DAC2_VU, WM8994_DAC2_VU);
 	snd_soc_update_bits(codec, WM8994_DAC2_RIGHT_VOLUME,
 			    WM8994_DAC2_VU, WM8994_DAC2_VU);
 
-- 
1.7.4.1
