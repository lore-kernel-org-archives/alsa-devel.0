From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 2/2] ASoC: intel: byt: Add headset jack
Date: Thu, 19 Oct 2017 12:03:23 +0100
Message-ID: <20171019110323.23751-3-carlo@caione.org>
References: <20171019110323.23751-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019110323.23751-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, albertchen@realtek.com, edgar_shen@realtek.com
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

Introduce an headset jack in the machine driver and register it to the
codec driver.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 1dad5c98c9ef..0fc850e20fc0 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -49,6 +49,8 @@ struct byt_rt5651_private {
 	struct clk *mclk;
 };
 
+static struct snd_soc_jack jack;
+
 static unsigned long byt_rt5651_quirk = BYT_RT5651_DMIC_MAP |
 					BYT_RT5651_DMIC_EN |
 					BYT_RT5651_MCLK_EN;
@@ -177,6 +179,17 @@ static const struct snd_kcontrol_new byt_rt5651_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speaker"),
 };
 
+static struct snd_soc_jack_pin bytcr_jack_pins[] = {
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
 static int byt_rt5651_aif1_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
@@ -244,6 +257,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_card *card = runtime->card;
+	struct snd_soc_codec *codec = runtime->codec;
 	struct byt_rt5651_private *priv = snd_soc_card_get_drvdata(card);
 	const struct snd_soc_dapm_route *custom_map;
 	int num_routes;
@@ -301,6 +315,16 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 			dev_err(card->dev, "unable to set MCLK rate\n");
 	}
 
+	ret = snd_soc_card_jack_new(runtime->card, "Headset",
+				    SND_JACK_HEADSET, &jack,
+				    bytcr_jack_pins, ARRAY_SIZE(bytcr_jack_pins));
+	if (ret) {
+		dev_err(runtime->dev, "Headset jack creation failed %d\n", ret);
+		return ret;
+	}
+
+	rt5651_set_jack_detect(codec, &jack);
+
 	return ret;
 }
 
-- 
2.14.2
