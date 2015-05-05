From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: Intel: Enabled button jack for BSW
	platform with rt5650 codec
Date: Mon,  4 May 2015 17:19:20 -0700
Message-ID: <1430785160-72477-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id AC86D2606D9
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 02:20:02 +0200 (CEST)
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
 Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

rt5650 codec supports 4 buttons detections so enabled it

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 8f96c21..1468c3d 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -43,6 +43,7 @@ struct cht_acpi_card {
 struct cht_mc_private {
 	struct snd_soc_jack hp_jack;
 	struct snd_soc_jack mic_jack;
+	struct snd_soc_jack btn_jack;
 	struct cht_acpi_card *acpi_card;
 };
 
@@ -182,6 +183,7 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_dai *codec_dai = runtime->codec_dai;
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
+	struct snd_soc_jack *btn_jack;
 
 	/* Select clk_i2s1_asrc as ASRC clock source */
 	rt5645_sel_asrc_clk_src(codec,
@@ -214,7 +216,26 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
-	rt5645_set_jack_detect(codec, &ctx->hp_jack, &ctx->mic_jack, NULL);
+	if (ctx->acpi_card->codec_type == CODEC_TYPE_RT5650) {
+
+		ret = snd_soc_card_jack_new(runtime->card, "Button Jack",
+						SND_JACK_BTN_0 |
+						SND_JACK_BTN_1 |
+						SND_JACK_BTN_2 |
+						SND_JACK_BTN_3, &ctx->btn_jack,
+						NULL, 0);
+		if (ret) {
+			dev_err(runtime->dev,
+					"Btn jack creation failed %d\n", ret);
+			return ret;
+		}
+
+		btn_jack = &ctx->btn_jack;
+	} else {
+		btn_jack = NULL;
+	}
+
+	rt5645_set_jack_detect(codec, &ctx->hp_jack, &ctx->mic_jack, btn_jack);
 
 	return ret;
 }
-- 
1.7.9.5
