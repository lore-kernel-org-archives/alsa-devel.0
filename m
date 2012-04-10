From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: tegra: utils: Don't use
	of_have_populated_dt()
Date: Tue, 10 Apr 2012 13:11:17 -0600
Message-ID: <1334085077-11089-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C35DC247B2
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 21:11:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Recent list discussions concluded that drivers should not be calling
of_have_populated_dt(), and hence of_have_populated_dt() should not be
exported. Use a different mechanism to detect DT vs. non-DT boot.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra_asoc_utils.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
index 266189d..9515ce5 100644
--- a/sound/soc/tegra/tegra_asoc_utils.c
+++ b/sound/soc/tegra/tegra_asoc_utils.c
@@ -119,13 +119,15 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 
 	data->dev = dev;
 
-	if (!of_have_populated_dt())
-		data->soc = TEGRA_ASOC_UTILS_SOC_TEGRA20;
-	else if (of_machine_is_compatible("nvidia,tegra20"))
+	if (of_machine_is_compatible("nvidia,tegra20"))
 		data->soc = TEGRA_ASOC_UTILS_SOC_TEGRA20;
 	else if (of_machine_is_compatible("nvidia,tegra30"))
 		data->soc = TEGRA_ASOC_UTILS_SOC_TEGRA30;
+	else if (!dev->of_node)
+		/* non-DT is always Tegra20 */
+		data->soc = TEGRA_ASOC_UTILS_SOC_TEGRA20;
 	else
+		/* DT boot, but unknown SoC */
 		return -EINVAL;
 
 	data->clk_pll_a = clk_get_sys(NULL, "pll_a");
-- 
1.7.0.4
