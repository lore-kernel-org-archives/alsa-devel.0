From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 1/2] CHROMIUM: ASoC: Tegra: Move utilities to
	separate module
Date: Tue, 22 Feb 2011 17:23:56 -0700
Message-ID: <1298420637-9230-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 237BC1038EA
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 01:24:06 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

The utilities will be required by every machine driver. Including the
utility object directly into every machine driver causes a build failure
if the modules are actually built into the kernel, since each will define
the symbols exported by the utility file. Solve this by moving the
utility object into a separate module.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/Makefile           |    3 ++-
 sound/soc/tegra/tegra_asoc_utils.c |    6 ++++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sound/soc/tegra/Makefile b/sound/soc/tegra/Makefile
index dfd2ab9..fd183d3 100644
--- a/sound/soc/tegra/Makefile
+++ b/sound/soc/tegra/Makefile
@@ -2,13 +2,14 @@
 snd-soc-tegra-das-objs := tegra_das.o
 snd-soc-tegra-pcm-objs := tegra_pcm.o
 snd-soc-tegra-i2s-objs := tegra_i2s.o
+snd-soc-tegra-utils-objs += tegra_asoc_utils.o
 
+obj-$(CONFIG_SND_TEGRA_SOC) += snd-soc-tegra-utils.o
 obj-$(CONFIG_SND_TEGRA_SOC) += snd-soc-tegra-das.o
 obj-$(CONFIG_SND_TEGRA_SOC) += snd-soc-tegra-pcm.o
 obj-$(CONFIG_SND_TEGRA_SOC_I2S) += snd-soc-tegra-i2s.o
 
 # Tegra machine Support
 snd-soc-tegra-harmony-objs := harmony.o
-snd-soc-tegra-harmony-objs += tegra_asoc_utils.o
 
 obj-$(CONFIG_SND_TEGRA_SOC_HARMONY) += snd-soc-tegra-harmony.o
diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
index cb4fc13..52f0a3f 100644
--- a/sound/soc/tegra/tegra_asoc_utils.c
+++ b/sound/soc/tegra/tegra_asoc_utils.c
@@ -101,6 +101,7 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_rate);
 
 int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 			  struct device *dev)
@@ -139,6 +140,7 @@ err_put_pll_a:
 err:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(tegra_asoc_utils_init);
 
 void tegra_asoc_utils_fini(struct tegra_asoc_utils_data *data)
 {
@@ -146,4 +148,8 @@ void tegra_asoc_utils_fini(struct tegra_asoc_utils_data *data)
 	clk_put(data->clk_pll_a_out0);
 	clk_put(data->clk_pll_a);
 }
+EXPORT_SYMBOL_GPL(tegra_asoc_utils_fini);
 
+MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
+MODULE_DESCRIPTION("Tegra ASoC utility code");
+MODULE_LICENSE("GPL");
-- 
1.7.1
