From: Carlo Caione <carlo@caione.org>
Subject: [PATCH] ASoC: cht_bsw_rt5645: Enable jack detection
Date: Tue, 16 Feb 2016 22:27:19 +0100
Message-ID: <1455658039-4783-1-git-send-email-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, yang.a.fang@intel.com, vinod.koul@intel.com, alsa-devel@alsa-project.org, linux@endlessm.com, linux-kernel@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

Add missing DAPM pins and enable jack detection on those pins for
Cherrytrail and Braswell.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index e6cf800..c7af271 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -147,6 +147,17 @@ static const struct snd_kcontrol_new cht_mc_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Ext Spk"),
 };
 
+static struct snd_soc_jack_pin cht_bsw_jack_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
 static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
@@ -202,9 +213,9 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	else
 		jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE;
 
-	ret = snd_soc_card_jack_new(runtime->card, "Headset Jack",
+	ret = snd_soc_card_jack_new(runtime->card, "Headset",
 				    jack_type, &ctx->jack,
-				    NULL, 0);
+				    cht_bsw_jack_pins, ARRAY_SIZE(cht_bsw_jack_pins));
 	if (ret) {
 		dev_err(runtime->dev, "Headset jack creation failed %d\n", ret);
 		return ret;
-- 
1.9.1
