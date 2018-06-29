From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 4/5] ASoC: es7134: Add VDD and AVDD power supplies
Date: Fri, 29 Jun 2018 17:09:23 +0200
Message-ID: <20180629150924.18197-5-jbrunet@baylibre.com>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180629150924.18197-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add the VDD and AVDD power supplies to the DAPM graph as some board may
need to enable a regulator to turn them on.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/es7134.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 698289dc3e22..5ad59c38fed1 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -167,11 +167,15 @@ static const struct snd_soc_dapm_widget es7134_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("AOUTL"),
 	SND_SOC_DAPM_OUTPUT("AOUTR"),
 	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("VDD", 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("AVDD", 0, 0),
 };
 
 static const struct snd_soc_dapm_route es7134_dapm_routes[] = {
 	{ "AOUTL", NULL, "DAC" },
 	{ "AOUTR", NULL, "DAC" },
+	{ "Playback", NULL, "VDD" },
+	{ "DAC", NULL, "AVDD" },
 };
 
 static const struct snd_soc_component_driver es7134_component_driver = {
-- 
2.14.4
