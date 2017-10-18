From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 1/2] ASoC: intel: byt: Enable quirk logic for custom maps
Date: Wed, 18 Oct 2017 17:07:58 +0100
Message-ID: <20171018160759.18563-2-carlo@caione.org>
References: <20171018160759.18563-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018160759.18563-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@endlessm.com, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

Enable again the quirk logic for the custom dapm routes.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 4a3516b38c2c..ec84454a232d 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -142,6 +142,12 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic1_map);
 	}
 
+	ret = snd_soc_dapm_add_routes(&card->dapm, custom_map, num_routes);
+	if (ret) {
+		dev_err(card->dev, "unable to add custom routes map\n");
+		return ret;
+	}
+
 	ret = snd_soc_add_card_controls(card, byt_rt5651_controls,
 					ARRAY_SIZE(byt_rt5651_controls));
 	if (ret) {
-- 
2.14.2
