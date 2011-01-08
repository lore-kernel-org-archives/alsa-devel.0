From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 5/7] ASoC: tegra: Machine utility code
Date: Fri,  7 Jan 2011 22:36:15 -0700
Message-ID: <1294464977-25814-6-git-send-email-swarren@nvidia.com>
References: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 45EA8103965
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2011 06:36:40 +0100 (CET)
In-Reply-To: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Many portions of Tegra ASoC machine drivers will be similar or identical.
To avoid cut/paste, this file will act as a repository for all that common
code. For now, it solely includes code to reprogram the audio PLL for
44.1KHz- vs. 48KHz-based sample rates.

Signed-Off-By: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra_asoc_utils.c |  154 ++++++++++++++++++++++++++++++++++++
 sound/soc/tegra/tegra_asoc_utils.h |   31 +++++++
 2 files changed, 185 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/tegra/tegra_asoc_utils.c
 create mode 100644 sound/soc/tegra/tegra_asoc_utils.h

diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
new file mode 100644
index 0000000..711ab7f
--- /dev/null
+++ b/sound/soc/tegra/tegra_asoc_utils.c
@@ -0,0 +1,154 @@
+/*
+ * tegra_asoc_utils.c - Harmony machine ASoC driver
+ *
+ * Author: Stephen Warren <swarren@nvidia.com>
+ * Copyright (C) 2010 - NVIDIA, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+
+#include "tegra_asoc_utils.h"
+
+#define PREFIX "ASoC Tegra: "
+
+static struct clk *clk_pll_a;
+static struct clk *clk_pll_a_out0;
+static struct clk *clk_cdev1;
+
+static int set_baseclock, set_mclk;
+
+int tegra_asoc_utils_set_rate(int srate, int mclk, int *mclk_change)
+{
+	int new_baseclock;
+	int err;
+
+	switch (srate) {
+	case 11025:
+	case 22050:
+	case 44100:
+	case 88200:
+		new_baseclock = 56448000;
+		break;
+	case 8000:
+	case 16000:
+	case 32000:
+	case 48000:
+	case 64000:
+	case 96000:
+		new_baseclock = 73728000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*mclk_change = ((new_baseclock != set_baseclock) ||
+			(mclk != set_mclk));
+	if (!*mclk_change)
+	    return 0;
+
+	set_baseclock = 0;
+	set_mclk = 0;
+
+	clk_disable(clk_cdev1);
+	clk_disable(clk_pll_a_out0);
+	clk_disable(clk_pll_a);
+
+	err = clk_set_rate(clk_pll_a, new_baseclock);
+	if (err) {
+		pr_err(PREFIX "Can't set pll_a rate: %d\n", err);
+		return err;
+	}
+
+	err = clk_set_rate(clk_pll_a_out0, mclk);
+	if (err) {
+		pr_err(PREFIX "Can't set pll_a_out0 rate: %d\n", err);
+		return err;
+	}
+
+	/* Don't set cdev1 rate; its locked to pll_a_out0 */
+
+	err = clk_enable(clk_pll_a);
+	if (err) {
+		pr_err(PREFIX "Can't enable pll_a: %d\n", err);
+		return err;
+	}
+
+	err = clk_enable(clk_pll_a_out0);
+	if (err) {
+		pr_err(PREFIX "Can't enable pll_a_out0: %d\n", err);
+		return err;
+	}
+
+	err = clk_enable(clk_cdev1);
+	if (err) {
+		pr_err(PREFIX "Can't enable cdev1: %d\n", err);
+		return err;
+	}
+
+	set_baseclock = new_baseclock;
+	set_mclk = mclk;
+
+	return 0;
+}
+
+int tegra_asoc_utils_init(void)
+{
+	int ret;
+
+	clk_pll_a = clk_get_sys(NULL, "pll_a");
+	if (IS_ERR_OR_NULL(clk_pll_a)) {
+		pr_err(PREFIX "Can't retrieve clk pll_a\n");
+		ret = PTR_ERR(clk_pll_a);
+		goto err;
+	}
+
+	clk_pll_a_out0 = clk_get_sys(NULL, "pll_a_out0");
+	if (IS_ERR_OR_NULL(clk_pll_a_out0)) {
+		pr_err(PREFIX "Can't retrieve clk pll_a_out0\n");
+		ret = PTR_ERR(clk_pll_a_out0);
+		goto err;
+	}
+
+	clk_cdev1 = clk_get_sys(NULL, "cdev1");
+	if (IS_ERR_OR_NULL(clk_cdev1)) {
+		pr_err(PREFIX "Can't retrieve clk cdev1\n");
+		ret = PTR_ERR(clk_cdev1);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	if (!IS_ERR_OR_NULL(clk_cdev1))
+		clk_put(clk_cdev1);
+	if (!IS_ERR_OR_NULL(clk_pll_a_out0))
+		clk_put(clk_pll_a_out0);
+	if (!IS_ERR_OR_NULL(clk_pll_a))
+		clk_put(clk_pll_a);
+	return ret;
+}
+
+void tegra_asoc_utils_fini(void)
+{
+	clk_put(clk_cdev1);
+	clk_put(clk_pll_a_out0);
+	clk_put(clk_pll_a);
+}
+
diff --git a/sound/soc/tegra/tegra_asoc_utils.h b/sound/soc/tegra/tegra_asoc_utils.h
new file mode 100644
index 0000000..855f8f6
--- /dev/null
+++ b/sound/soc/tegra/tegra_asoc_utils.h
@@ -0,0 +1,31 @@
+/*
+ * tegra_asoc_utils.h - Definitions for Tegra DAS driver
+ *
+ * Author: Stephen Warren <swarren@nvidia.com>
+ * Copyright (C) 2010 - NVIDIA, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __TEGRA_ASOC_UTILS_H__
+#define __TEGRA_ASOC_UTILS_H_
+
+int tegra_asoc_utils_set_rate(int srate, int mclk_rate, int *mclk_change);
+int tegra_asoc_utils_init(void);
+void tegra_asoc_utils_fini(void);
+
+#endif
+
-- 
1.7.0.4
