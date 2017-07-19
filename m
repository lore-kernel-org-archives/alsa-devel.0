From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 098/102] ASoC: stm32: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:26:42 +0200
Message-ID: <20170719152646.25903-99-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/stm/stm32_i2s.c     | 2 +-
 sound/soc/stm/stm32_sai.c     | 2 +-
 sound/soc/stm/stm32_spdifrx.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 8052629a89dfd..6d0bf78d114d0 100644
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
index f7713314913b9..1258bef4dcb37 100644
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
index 4e4250bdb75a8..84cc5678beba5 100644
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
2.11.0
