From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2] ASoC: tegra: utils: add support for Tegra30
	devices
Date: Fri,  6 Apr 2012 11:15:55 -0600
Message-ID: <1333732555-9934-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id CEFD21041B1
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 19:16:01 +0200 (CEST)
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

Tegra30 has some additional clocks that need to be manipulated, names
some clocks differently, runs PLLs at different base rates, etc. The
utility code needs to handle this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Determine Tegra version internally to the utility code, rather than
requiring each ASoC machine driver be updated to pass in this information.

 sound/soc/tegra/tegra_asoc_utils.c |   29 ++++++++++++++++++++++++-----
 sound/soc/tegra/tegra_asoc_utils.h |    9 +++++++--
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
index f8428e4..f59e8b5 100644
--- a/sound/soc/tegra/tegra_asoc_utils.c
+++ b/sound/soc/tegra/tegra_asoc_utils.c
@@ -2,7 +2,7 @@
  * tegra_asoc_utils.c - Harmony machine ASoC driver
  *
  * Author: Stephen Warren <swarren@nvidia.com>
- * Copyright (C) 2010 - NVIDIA, Inc.
+ * Copyright (C) 2010,2012 - NVIDIA, Inc.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include "tegra_asoc_utils.h"
 
@@ -40,7 +41,10 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
 	case 22050:
 	case 44100:
 	case 88200:
-		new_baseclock = 56448000;
+		if (data->soc == TEGRA_ASOC_UTILS_SOC_TEGRA20)
+			new_baseclock = 56448000;
+		else
+			new_baseclock = 564480000;
 		break;
 	case 8000:
 	case 16000:
@@ -48,7 +52,10 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
 	case 48000:
 	case 64000:
 	case 96000:
-		new_baseclock = 73728000;
+		if (data->soc == TEGRA_ASOC_UTILS_SOC_TEGRA20)
+			new_baseclock = 73728000;
+		else
+			new_baseclock = 552960000;
 		break;
 	default:
 		return -EINVAL;
@@ -78,7 +85,7 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
 		return err;
 	}
 
-	/* Don't set cdev1 rate; its locked to pll_a_out0 */
+	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
 
 	err = clk_enable(data->clk_pll_a);
 	if (err) {
@@ -112,6 +119,15 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 
 	data->dev = dev;
 
+	if (!of_have_populated_dt())
+		data->soc = TEGRA_ASOC_UTILS_SOC_TEGRA20;
+	else if (of_machine_is_compatible("nvidia,tegra20"))
+		data->soc = TEGRA_ASOC_UTILS_SOC_TEGRA20;
+	else if (of_machine_is_compatible("nvidia,tegra30"))
+		data->soc = TEGRA_ASOC_UTILS_SOC_TEGRA30;
+	else
+		return -EINVAL;
+
 	data->clk_pll_a = clk_get_sys(NULL, "pll_a");
 	if (IS_ERR(data->clk_pll_a)) {
 		dev_err(data->dev, "Can't retrieve clk pll_a\n");
@@ -126,7 +142,10 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 		goto err_put_pll_a;
 	}
 
-	data->clk_cdev1 = clk_get_sys(NULL, "cdev1");
+	if (data->soc == TEGRA_ASOC_UTILS_SOC_TEGRA20)
+		data->clk_cdev1 = clk_get_sys(NULL, "cdev1");
+	else
+		data->clk_cdev1 = clk_get_sys("extern1", NULL);
 	if (IS_ERR(data->clk_cdev1)) {
 		dev_err(data->dev, "Can't retrieve clk cdev1\n");
 		ret = PTR_ERR(data->clk_cdev1);
diff --git a/sound/soc/tegra/tegra_asoc_utils.h b/sound/soc/tegra/tegra_asoc_utils.h
index 4818195..44db1db 100644
--- a/sound/soc/tegra/tegra_asoc_utils.h
+++ b/sound/soc/tegra/tegra_asoc_utils.h
@@ -2,7 +2,7 @@
  * tegra_asoc_utils.h - Definitions for Tegra DAS driver
  *
  * Author: Stephen Warren <swarren@nvidia.com>
- * Copyright (C) 2010 - NVIDIA, Inc.
+ * Copyright (C) 2010,2012 - NVIDIA, Inc.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -26,8 +26,14 @@
 struct clk;
 struct device;
 
+enum tegra_asoc_utils_soc {
+	TEGRA_ASOC_UTILS_SOC_TEGRA20,
+	TEGRA_ASOC_UTILS_SOC_TEGRA30,
+};
+
 struct tegra_asoc_utils_data {
 	struct device *dev;
+	enum tegra_asoc_utils_soc soc;
 	struct clk *clk_pll_a;
 	struct clk *clk_pll_a_out0;
 	struct clk *clk_cdev1;
@@ -42,4 +48,3 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 void tegra_asoc_utils_fini(struct tegra_asoc_utils_data *data);
 
 #endif
-
-- 
1.7.0.4
