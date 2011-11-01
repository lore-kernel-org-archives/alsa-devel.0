From: Taylor Hutt <thutt@chromium.org>
Subject: [PATCH] ASoc : Tegra : Add audio map for Asymptote
Date: Tue,  1 Nov 2011 09:32:53 -0700
Message-ID: <1320165173-3951-1-git-send-email-thutt@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thutt@chromium.org
Cc: miletus@chromium.org, swarren@nvidia.com, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Details

  Add pin connections and audio map for the Asymptote board.

Testing

  Visual inspection with Chromium OS 2.6.38 code.
  Built kernel
  Built chromium os image
  Booted image on asymptote
  Booted image on kaen

Signed-off-by: Taylor Hutt <thutt@chromium.org>
---
 sound/soc/tegra/tegra_wm8903.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index b0aef55..e0beeda 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -310,6 +310,7 @@ static void tegra_wm8903_disconnect_pins(struct snd_soc_card *card,
 {
 #define MACHINES                               \
 	M(aebl)                                 \
+	M(asymptote)                            \
 	M(harmony)                              \
 	M(kaen)                                 \
 	M(seaboard)                             \
@@ -355,6 +356,7 @@ static void tegra_wm8903_disconnect_pins(struct snd_soc_card *card,
 			CONNECT(ventana),
 			CONNECT(seaboard),
 			CONNECT(kaen),
+			CONNECT(asymptote),
 		},
 		{
 			.name = "RON",
@@ -362,6 +364,7 @@ static void tegra_wm8903_disconnect_pins(struct snd_soc_card *card,
 			CONNECT(ventana),
 			CONNECT(seaboard),
 			CONNECT(kaen),
+			CONNECT(asymptote),
 		},
 		{
 			.name = "ROP",
@@ -369,6 +372,7 @@ static void tegra_wm8903_disconnect_pins(struct snd_soc_card *card,
 			CONNECT(ventana),
 			CONNECT(seaboard),
 			CONNECT(kaen),
+			CONNECT(asymptote),
 		},
 		{
 			.name = "LOP",
@@ -376,6 +380,7 @@ static void tegra_wm8903_disconnect_pins(struct snd_soc_card *card,
 			CONNECT(ventana),
 			CONNECT(seaboard),
 			CONNECT(kaen),
+			CONNECT(asymptote),
 		},
 		{
 			.name = "LINEOUTR",
@@ -544,13 +549,14 @@ static __devinit int tegra_wm8903_driver_probe(struct platform_device *pdev)
 	if (machine_is_harmony() || machine_is_ventana()) {
 		card->dapm_routes = harmony_audio_map;
 		card->num_dapm_routes = ARRAY_SIZE(harmony_audio_map);
-	} else if (machine_is_seaboard()) {
+	} else if (machine_is_seaboard() || machine_is_asymptote()) {
 		card->dapm_routes = seaboard_audio_map;
 		card->num_dapm_routes = ARRAY_SIZE(seaboard_audio_map);
 	} else if (machine_is_kaen()) {
 		card->dapm_routes = kaen_audio_map;
 		card->num_dapm_routes = ARRAY_SIZE(kaen_audio_map);
 	} else {
+		BUG_ON(!machine_is_aebl());
 		card->dapm_routes = aebl_audio_map;
 		card->num_dapm_routes = ARRAY_SIZE(aebl_audio_map);
 	}
-- 
1.7.3.1
