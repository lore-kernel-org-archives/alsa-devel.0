From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] ASoC: meson: imply clock and reset controllers
Date: Tue, 28 Aug 2018 14:17:21 +0200
Message-ID: <20180828121721.26488-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add audio clock controller and ARB reset controller module
implication for the device using them

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 8af8bc358a90..2ccbadc387de 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -4,6 +4,8 @@ menu "ASoC support for Amlogic platforms"
 config SND_MESON_AXG_FIFO
 	tristate
 	select REGMAP_MMIO
+	imply COMMON_CLK_AXG_AUDIO
+	imply RESET_MESON_AUDIO_ARB
 
 config SND_MESON_AXG_FRDDR
 	tristate "Amlogic AXG Playback FIFO support"
@@ -22,6 +24,7 @@ config SND_MESON_AXG_TODDR
 config SND_MESON_AXG_TDM_FORMATTER
 	tristate
 	select REGMAP_MMIO
+	imply COMMON_CLK_AXG_AUDIO
 
 config SND_MESON_AXG_TDM_INTERFACE
 	tristate
@@ -58,6 +61,7 @@ config SND_MESON_AXG_SPDIFOUT
 	tristate "Amlogic AXG SPDIF Output Support"
 	select SND_PCM_IEC958
 	imply SND_SOC_SPDIF
+	imply COMMON_CLK_AXG_AUDIO
 	help
 	  Select Y or M to add support for SPDIF output serializer embedded
 	  in the Amlogic AXG SoC family
-- 
2.17.1
