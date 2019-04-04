From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 6/6] ASoC: meson: axg-tdmout: add g12a support
Date: Thu,  4 Apr 2019 13:17:33 +0200
Message-ID: <20190404111733.28705-7-jbrunet@baylibre.com>
References: <20190404111733.28705-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404111733.28705-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Maxime Jourdan <mjourdan@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The axg tdmout driver just need a different skew offset to operate
correctly on the g12a SoC family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdmout.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/meson/axg-tdmout.c b/sound/soc/meson/axg-tdmout.c
index 3984818e2a7c..527bfc4487e0 100644
--- a/sound/soc/meson/axg-tdmout.c
+++ b/sound/soc/meson/axg-tdmout.c
@@ -243,10 +243,23 @@ static const struct axg_tdm_formatter_driver axg_tdmout_drv = {
 	},
 };
 
+static const struct axg_tdm_formatter_driver g12a_tdmout_drv = {
+	.component_drv	= &axg_tdmout_component_drv,
+	.regmap_cfg	= &axg_tdmout_regmap_cfg,
+	.ops		= &axg_tdmout_ops,
+	.quirks		= &(const struct axg_tdm_formatter_hw) {
+		.invert_sclk = true,
+		.skew_offset = 2,
+	},
+};
+
 static const struct of_device_id axg_tdmout_of_match[] = {
 	{
 		.compatible = "amlogic,axg-tdmout",
 		.data = &axg_tdmout_drv,
+	}, {
+		.compatible = "amlogic,g12a-tdmout",
+		.data = &g12a_tdmout_drv,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_tdmout_of_match);
-- 
2.20.1
