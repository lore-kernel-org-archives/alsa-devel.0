From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 099/102] ASoC: sun4i: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:26:43 +0200
Message-ID: <20170719152646.25903-100-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 sound/soc/sunxi/sun4i-codec.c | 3 ++-
 sound/soc/sunxi/sun4i-i2s.c   | 2 +-
 sound/soc/sunxi/sun4i-spdif.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 150069987c0c3..9eec303605224 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1574,7 +1574,8 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	}
 
 	if (quirks->has_reset) {
-		scodec->rst = devm_reset_control_get(&pdev->dev, NULL);
+		scodec->rst = devm_reset_control_get_exclusive(&pdev->dev,
+							       NULL);
 		if (IS_ERR(scodec->rst)) {
 			dev_err(&pdev->dev, "Failed to get reset control\n");
 			return PTR_ERR(scodec->rst);
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 3635bbc72cbcd..62b307b0c846c 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -716,7 +716,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 	}
 
 	if (quirks->has_reset) {
-		i2s->rst = devm_reset_control_get(&pdev->dev, NULL);
+		i2s->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 		if (IS_ERR(i2s->rst)) {
 			dev_err(&pdev->dev, "Failed to get reset control\n");
 			return PTR_ERR(i2s->rst);
diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index eaefd07a5ed08..c49f3757b686e 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -520,7 +520,8 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 
 	if (quirks->has_reset) {
-		host->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
+		host->rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								      NULL);
 		if (IS_ERR(host->rst) && PTR_ERR(host->rst) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
 			dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
-- 
2.11.0
