From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Add bytes controls for DRC
Date: Thu, 16 Aug 2012 13:35:08 +0100
Message-ID: <1345120511-32638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 659E426603A
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 14:05:32 +0200 (CEST)
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

If DRC coefficients are not configured via platform data then add bytes
controls for them instead so they can be configured by applications. This
is the normal means of controlling things like this for newer systems, we
maintain compatibility with platform data to avoid disruption to existing
systems.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 7755ac9..2d60ed3 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -759,6 +759,18 @@ SOC_SINGLE_TLV("AIF2 EQ5 Volume", WM8994_AIF2_EQ_GAINS_2, 6, 31, 0,
 	       eq_tlv),
 };
 
+static const struct snd_kcontrol_new wm8994_drc_controls[] = {
+SND_SOC_BYTES_MASK("AIF1.1 DRC", WM8994_AIF1_DRC1_1, 5,
+		   WM8994_AIF1DAC1_DRC_ENA | WM8994_AIF1ADC1L_DRC_ENA |
+		   WM8994_AIF1ADC1R_DRC_ENA),
+SND_SOC_BYTES_MASK("AIF1.2 DRC", WM8994_AIF1_DRC2_1, 5,
+		   WM8994_AIF1DAC2_DRC_ENA | WM8994_AIF1ADC2L_DRC_ENA |
+		   WM8994_AIF1ADC2R_DRC_ENA),
+SND_SOC_BYTES_MASK("AIF2 DRC", WM8994_AIF2_DRC_1, 5,
+		   WM8994_AIF2DAC_DRC_ENA | WM8994_AIF2ADCL_DRC_ENA |
+		   WM8994_AIF2ADCR_DRC_ENA),
+};
+
 static const char *wm8958_ng_text[] = {
 	"30ms", "125ms", "250ms", "500ms",
 };
@@ -3254,14 +3266,19 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 
 		ret = snd_soc_add_codec_controls(wm8994->hubs.codec, controls,
 					   ARRAY_SIZE(controls));
-		if (ret != 0)
-			dev_err(wm8994->hubs.codec->dev,
-				"Failed to add DRC mode controls: %d\n", ret);
-
 		for (i = 0; i < WM8994_NUM_DRC; i++)
 			wm8994_set_drc(codec, i);
+	} else {
+		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
+						 wm8994_drc_controls,
+						 ARRAY_SIZE(wm8994_drc_controls));
 	}
 
+	if (ret != 0)
+		dev_err(wm8994->hubs.codec->dev,
+			"Failed to add DRC mode controls: %d\n", ret);
+
+
 	dev_dbg(codec->dev, "%d ReTune Mobile configurations\n",
 		pdata->num_retune_mobile_cfgs);
 
-- 
1.7.10.4
