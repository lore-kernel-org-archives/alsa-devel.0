From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i: explicitly request exclusive reset control" to the asoc tree
Date: Wed, 19 Jul 2017 17:08:17 +0100
Message-ID: <E1dXrWL-0001A8-AW@debutante>
References: <20170719152646.25903-100-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-100-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.orgLiam Girdwood <lgirdwood@gmail.com>Chen-Yu Tsai <wens@csie.org>Mark Brown <broonie@kernel.org>Maxime Ripard <maxime.ripard@free-electrons.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i: explicitly request exclusive reset control

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 72bfa2117bdb4bb5b07dd5ed833ff3c318fc70b6 Mon Sep 17 00:00:00 2001
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 19 Jul 2017 17:26:43 +0200
Subject: [PATCH] ASoC: sun4i: explicitly request exclusive reset control

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 3 ++-
 sound/soc/sunxi/sun4i-i2s.c   | 2 +-
 sound/soc/sunxi/sun4i-spdif.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 4c37231f254b..73d054f466c2 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1573,7 +1573,8 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	}
 
 	if (quirks->has_reset) {
-		scodec->rst = devm_reset_control_get(&pdev->dev, NULL);
+		scodec->rst = devm_reset_control_get_exclusive(&pdev->dev,
+							       NULL);
 		if (IS_ERR(scodec->rst)) {
 			dev_err(&pdev->dev, "Failed to get reset control\n");
 			return PTR_ERR(scodec->rst);
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 3635bbc72cbc..62b307b0c846 100644
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
index eaefd07a5ed0..c49f3757b686 100644
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
2.13.2
