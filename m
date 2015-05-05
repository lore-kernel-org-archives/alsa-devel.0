From: yang.a.fang@intel.com
Subject: [PATCH v2] ASoC: Intel: Enabled button jack for BSW
	platform with rt5650 codec
Date: Tue,  5 May 2015 16:55:34 -0700
Message-ID: <1430870135-68604-1-git-send-email-yang.a.fang@intel.com>
References: <1430785160-72477-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 806852604BE
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 01:56:17 +0200 (CEST)
In-Reply-To: <1430785160-72477-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, denny.iriawan@intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, bardliao@realtek.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

rt5650 codec supports 4 buttons detections so enabled it

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 8f96c21..bdcaf46 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -41,8 +41,7 @@ struct cht_acpi_card {
 };
 
 struct cht_mc_private {
-	struct snd_soc_jack hp_jack;
-	struct snd_soc_jack mic_jack;
+	struct snd_soc_jack jack;
 	struct cht_acpi_card *acpi_card;
 };
 
@@ -179,6 +178,7 @@ static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
 static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 {
 	int ret;
+	int jack_type;
 	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_dai *codec_dai = runtime->codec_dai;
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
@@ -198,23 +198,22 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new(runtime->card, "Headphone Jack",
-				    SND_JACK_HEADPHONE, &ctx->hp_jack,
-				    NULL, 0);
-	if (ret) {
-		dev_err(runtime->dev, "HP jack creation failed %d\n", ret);
-		return ret;
-	}
+	if (ctx->acpi_card->codec_type == CODEC_TYPE_RT5650)
+		jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+					SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					SND_JACK_BTN_2 | SND_JACK_BTN_3;
+	else
+		jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE;
 
-	ret = snd_soc_card_jack_new(runtime->card, "Mic Jack",
-				    SND_JACK_MICROPHONE, &ctx->mic_jack,
+	ret = snd_soc_card_jack_new(runtime->card, "Headset Jack",
+				    jack_type, &ctx->jack,
 				    NULL, 0);
 	if (ret) {
-		dev_err(runtime->dev, "Mic jack creation failed %d\n", ret);
+		dev_err(runtime->dev, "Headset jack creation failed %d\n", ret);
 		return ret;
 	}
 
-	rt5645_set_jack_detect(codec, &ctx->hp_jack, &ctx->mic_jack, NULL);
+	rt5645_set_jack_detect(codec, &ctx->jack, &ctx->jack, &ctx->jack);
 
 	return ret;
 }
-- 
1.7.9.5
