From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: explicitly request exclusive reset control" to the asoc tree
Date: Wed, 19 Jul 2017 17:08:20 +0100
Message-ID: <E1dXrWO-0001BH-MP@debutante>
References: <20170719152646.25903-99-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-99-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.orgLiam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>Maxime Coquelin <mcoquelin.stm32@gmail.com>Alexandre Torgue <alexandre.torgue@st.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: explicitly request exclusive reset control

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

>From 635eac1e54d82c59f621a0f38a9bffae50f150c7 Mon Sep 17 00:00:00 2001
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 19 Jul 2017 17:26:42 +0200
Subject: [PATCH] ASoC: stm32: explicitly request exclusive reset control

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c     | 2 +-
 sound/soc/stm/stm32_sai.c     | 2 +-
 sound/soc/stm/stm32_spdifrx.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 8052629a89df..6d0bf78d114d 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -840,7 +840,7 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	}
 
 	/* Reset */
-	rst = devm_reset_control_get(&pdev->dev, NULL);
+	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (!IS_ERR(rst)) {
 		reset_control_assert(rst);
 		udelay(2);
diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index f7713314913b..1258bef4dcb3 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -85,7 +85,7 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	}
 
 	/* reset */
-	rst = reset_control_get(&pdev->dev, NULL);
+	rst = reset_control_get_exclusive(&pdev->dev, NULL);
 	if (!IS_ERR(rst)) {
 		reset_control_assert(rst);
 		udelay(2);
diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 4e4250bdb75a..84cc5678beba 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -930,7 +930,7 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	rst = devm_reset_control_get(&pdev->dev, NULL);
+	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (!IS_ERR(rst)) {
 		reset_control_assert(rst);
 		udelay(2);
-- 
2.13.2
