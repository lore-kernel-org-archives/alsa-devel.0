From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 4/5] ASoC: meson: axg-card: add basic codec-to-codec link support
Date: Wed, 15 May 2019 15:18:57 +0200
Message-ID: <20190515131858.32130-5-jbrunet@baylibre.com>
References: <20190515131858.32130-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515131858.32130-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add basic support for codec-to-codec link in the axg sound card.
The cpu side of these links is expected to properly set the hw_params
and format of the link.

ATM, only the tohdmitx glue is supported but others (like the
internal DAC glue) should follow.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-card.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 5c8deee8d512..db0a7fc18928 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -29,6 +29,18 @@ struct axg_dai_link_tdm_data {
 	struct axg_dai_link_tdm_mask *codec_masks;
 };
 
+/*
+ * Base params for the codec to codec links
+ * Those will be over-written by the CPU side of the link
+ */
+static const struct snd_soc_pcm_stream codec_params = {
+	.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	.rate_min = 5525,
+	.rate_max = 192000,
+	.channels_min = 1,
+	.channels_max = 8,
+};
+
 #define PREFIX "amlogic,"
 
 static int axg_card_reallocate_links(struct axg_card *priv,
@@ -517,6 +529,11 @@ static int axg_card_cpu_is_tdm_iface(struct device_node *np)
 	return of_device_is_compatible(np, PREFIX "axg-tdm-iface");
 }
 
+static int axg_card_cpu_is_codec(struct device_node *np)
+{
+	return of_device_is_compatible(np, PREFIX "g12a-tohdmitx");
+}
+
 static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 			     int *index)
 {
@@ -540,6 +557,8 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 
 	if (axg_card_cpu_is_tdm_iface(dai_link->cpu_of_node))
 		ret = axg_card_parse_tdm(card, np, index);
+	else if (axg_card_cpu_is_codec(dai_link->cpu_of_node))
+		dai_link->params = &codec_params;
 
 	return ret;
 }
-- 
2.20.1
