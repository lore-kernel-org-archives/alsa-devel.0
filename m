From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2] ASoC: tegra: set a sensible initial clock
	rate
Date: Fri,  6 Apr 2012 11:18:16 -0600
Message-ID: <1333732696-10015-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2713B104474
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 19:18:29 +0200 (CEST)
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

Initialize the audio clock tree appropriately for some reasonable rate.
This makes sure the PLLs etc. are actually programmed to something
reasonable when the audio driver is loaded.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Use 44100 as the default rate, not 48000, since it's more common,
and consistent with the clock tables in board-dt-tegra*.c.

This patch is ordered after the patch I just sent to add Tegra30 support
to the utils file. However, the dependency is just for context; this
should be independent from that patch.

 sound/soc/tegra/tegra_asoc_utils.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
index f59e8b5..266189d 100644
--- a/sound/soc/tegra/tegra_asoc_utils.c
+++ b/sound/soc/tegra/tegra_asoc_utils.c
@@ -152,8 +152,14 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 		goto err_put_pll_a_out0;
 	}
 
+	ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
+	if (ret)
+		goto err_put_cdev1;
+
 	return 0;
 
+err_put_cdev1:
+	clk_put(data->clk_cdev1);
 err_put_pll_a_out0:
 	clk_put(data->clk_pll_a_out0);
 err_put_pll_a:
-- 
1.7.0.4
