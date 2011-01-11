From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: tegra: s/IS_ERR_OR_NULL/IS_ERR/ for
	clk_get_sys
Date: Tue, 11 Jan 2011 12:48:53 -0700
Message-ID: <1294775333-8372-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B0780103A77
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 20:49:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

A recent discussion on linux-arm-kernel noted that the value returned by
clk_get_sys is an opaque token, and not strictly a pointer; it is
meaningful only to the clock API, clients should not dereference the value,
and the clock API must accept any non-IS_ERR value it returned.

Hence, only IS_ERR is appropriate to interpret the result, not
IS_ERR_OR_NULL.

I checked that clk_get_sys in both ASoC's for-next and Tegra's for-next
do behave as described; NULL is not returned in the case of error.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra_asoc_utils.c |   20 +++++++++-----------
 sound/soc/tegra/tegra_i2s.c        |    2 +-
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
index 711ab7f..cfe2ea8 100644
--- a/sound/soc/tegra/tegra_asoc_utils.c
+++ b/sound/soc/tegra/tegra_asoc_utils.c
@@ -113,35 +113,33 @@ int tegra_asoc_utils_init(void)
 	int ret;
 
 	clk_pll_a = clk_get_sys(NULL, "pll_a");
-	if (IS_ERR_OR_NULL(clk_pll_a)) {
+	if (IS_ERR(clk_pll_a)) {
 		pr_err(PREFIX "Can't retrieve clk pll_a\n");
 		ret = PTR_ERR(clk_pll_a);
 		goto err;
 	}
 
 	clk_pll_a_out0 = clk_get_sys(NULL, "pll_a_out0");
-	if (IS_ERR_OR_NULL(clk_pll_a_out0)) {
+	if (IS_ERR(clk_pll_a_out0)) {
 		pr_err(PREFIX "Can't retrieve clk pll_a_out0\n");
 		ret = PTR_ERR(clk_pll_a_out0);
-		goto err;
+		goto err_put_pll_a;
 	}
 
 	clk_cdev1 = clk_get_sys(NULL, "cdev1");
-	if (IS_ERR_OR_NULL(clk_cdev1)) {
+	if (IS_ERR(clk_cdev1)) {
 		pr_err(PREFIX "Can't retrieve clk cdev1\n");
 		ret = PTR_ERR(clk_cdev1);
-		goto err;
+		goto err_put_pll_a_out0;
 	}
 
 	return 0;
 
+err_put_pll_a_out0:
+	clk_put(clk_pll_a_out0);
+err_put_pll_a:
+	clk_put(clk_pll_a);
 err:
-	if (!IS_ERR_OR_NULL(clk_cdev1))
-		clk_put(clk_cdev1);
-	if (!IS_ERR_OR_NULL(clk_pll_a_out0))
-		clk_put(clk_pll_a_out0);
-	if (!IS_ERR_OR_NULL(clk_pll_a))
-		clk_put(clk_pll_a);
 	return ret;
 }
 
diff --git a/sound/soc/tegra/tegra_i2s.c b/sound/soc/tegra/tegra_i2s.c
index 9b7a22a..75d3bfe 100644
--- a/sound/soc/tegra/tegra_i2s.c
+++ b/sound/soc/tegra/tegra_i2s.c
@@ -385,7 +385,7 @@ static __devinit int tegra_i2s_platform_probe(struct platform_device *pdev)
 
 	snprintf(clk_name, sizeof(clk_name), DRV_NAME ".%d", pdev->id);
 	i2s->clk_i2s = clk_get_sys(clk_name, NULL);
-	if (IS_ERR_OR_NULL(i2s->clk_i2s)) {
+	if (IS_ERR(i2s->clk_i2s)) {
 		pr_err("Can't retrieve i2s clock\n");
 		ret = PTR_ERR(i2s->clk_i2s);
 		goto err_free;
-- 
1.7.0.4
