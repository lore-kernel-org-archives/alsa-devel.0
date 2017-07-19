From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 097/102] ASoC: img: explicitly request
	exclusive reset control
Date: Wed, 19 Jul 2017 17:26:41 +0200
Message-ID: <20170719152646.25903-98-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 3CCD126733F
 for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2017 17:30:08 +0200 (CEST)
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/img/img-i2s-in.c       | 2 +-
 sound/soc/img/img-i2s-out.c      | 2 +-
 sound/soc/img/img-parallel-out.c | 2 +-
 sound/soc/img/img-spdif-in.c     | 2 +-
 sound/soc/img/img-spdif-out.c    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index 0389203f85608..567f9767fb73e 100644
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
index 5f997135a8aec..78b7f6cd675b7 100644
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
index 33ceb207ee704..23b0f0f6ec9cb 100644
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
index 4d9953d318af4..8adfd65d43902 100644
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
index 08f93a5dadfe9..383655da2e60d 100644
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
2.11.0
