From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img: explicitly request exclusive reset control" to the asoc tree
Date: Wed, 19 Jul 2017 17:08:25 +0100
Message-ID: <E1dXrWT-0001CP-Ko@debutante>
References: <20170719152646.25903-98-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-98-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>Liam Girdwood <lgirdwood@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: img: explicitly request exclusive reset control

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

>From 3a4e1b93110362f0ca6f81c564b04b2aa4bab853 Mon Sep 17 00:00:00 2001
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 19 Jul 2017 17:26:41 +0200
Subject: [PATCH] ASoC: img: explicitly request exclusive reset control

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/img/img-i2s-in.c       | 2 +-
 sound/soc/img/img-i2s-out.c      | 2 +-
 sound/soc/img/img-parallel-out.c | 2 +-
 sound/soc/img/img-spdif-in.c     | 2 +-
 sound/soc/img/img-spdif-out.c    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index 0389203f8560..567f9767fb73 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -443,7 +443,7 @@ static int img_i2s_in_probe(struct platform_device *pdev)
 		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE;
 	i2s->dai_driver.ops = &img_i2s_in_dai_ops;
 
-	rst = devm_reset_control_get(dev, "rst");
+	rst = devm_reset_control_get_exclusive(dev, "rst");
 	if (IS_ERR(rst)) {
 		if (PTR_ERR(rst) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
diff --git a/sound/soc/img/img-i2s-out.c b/sound/soc/img/img-i2s-out.c
index 5f997135a8ae..78b7f6cd675b 100644
--- a/sound/soc/img/img-i2s-out.c
+++ b/sound/soc/img/img-i2s-out.c
@@ -446,7 +446,7 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 
 	i2s->channel_base = base + (max_i2s_chan_pow_2 * 0x20);
 
-	i2s->rst = devm_reset_control_get(&pdev->dev, "rst");
+	i2s->rst = devm_reset_control_get_exclusive(&pdev->dev, "rst");
 	if (IS_ERR(i2s->rst)) {
 		if (PTR_ERR(i2s->rst) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "No top level reset found\n");
diff --git a/sound/soc/img/img-parallel-out.c b/sound/soc/img/img-parallel-out.c
index 33ceb207ee70..23b0f0f6ec9c 100644
--- a/sound/soc/img/img-parallel-out.c
+++ b/sound/soc/img/img-parallel-out.c
@@ -224,7 +224,7 @@ static int img_prl_out_probe(struct platform_device *pdev)
 
 	prl->base = base;
 
-	prl->rst = devm_reset_control_get(&pdev->dev, "rst");
+	prl->rst = devm_reset_control_get_exclusive(&pdev->dev, "rst");
 	if (IS_ERR(prl->rst)) {
 		if (PTR_ERR(prl->rst) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "No top level reset found\n");
diff --git a/sound/soc/img/img-spdif-in.c b/sound/soc/img/img-spdif-in.c
index 4d9953d318af..8adfd65d4390 100644
--- a/sound/soc/img/img-spdif-in.c
+++ b/sound/soc/img/img-spdif-in.c
@@ -727,7 +727,7 @@ static int img_spdif_in_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	rst = devm_reset_control_get(&pdev->dev, "rst");
+	rst = devm_reset_control_get_exclusive(&pdev->dev, "rst");
 	if (IS_ERR(rst)) {
 		if (PTR_ERR(rst) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
diff --git a/sound/soc/img/img-spdif-out.c b/sound/soc/img/img-spdif-out.c
index 08f93a5dadfe..383655da2e60 100644
--- a/sound/soc/img/img-spdif-out.c
+++ b/sound/soc/img/img-spdif-out.c
@@ -334,7 +334,7 @@ static int img_spdif_out_probe(struct platform_device *pdev)
 
 	spdif->base = base;
 
-	spdif->rst = devm_reset_control_get(&pdev->dev, "rst");
+	spdif->rst = devm_reset_control_get_exclusive(&pdev->dev, "rst");
 	if (IS_ERR(spdif->rst)) {
 		if (PTR_ERR(spdif->rst) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "No top level reset found\n");
-- 
2.13.2
