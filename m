From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 384/493] sound: remove use of __devinitconst
Date: Mon, 19 Nov 2012 13:25:33 -0500
Message-ID: <1353349642-3677-384-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viridian.itc.virginia.edu (viridian.itc.virginia.edu
 [128.143.12.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 357D32625D9
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 19:28:24 +0100 (CET)
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

CONFIG_HOTPLUG is going away as an option so __devinitconst is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Jaroslav Kysela <perex@perex.cz> 
Cc: Takashi Iwai <tiwai@suse.de> 
Cc: patches@opensource.wolfsonmicro.com 
Cc: alsa-devel@alsa-project.org 
---
 sound/soc/codecs/wm5100.c       | 2 +-
 sound/soc/soc-core.c            | 2 +-
 sound/soc/tegra/tegra20_das.c   | 2 +-
 sound/soc/tegra/tegra20_i2s.c   | 4 ++--
 sound/soc/tegra/tegra20_spdif.c | 2 +-
 sound/soc/tegra/tegra30_ahub.c  | 6 +++---
 sound/soc/tegra/tegra30_i2s.c   | 4 ++--
 sound/soc/tegra/tegra_alc5632.c | 2 +-
 sound/soc/tegra/tegra_wm8753.c  | 2 +-
 sound/soc/tegra/tegra_wm8903.c  | 2 +-
 sound/soc/tegra/trimslice.c     | 2 +-
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index ee4e4b2..d5d8b52 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -1233,7 +1233,7 @@ static const struct snd_soc_dapm_route wm5100_dapm_routes[] = {
 	{ "PWM2", NULL, "PWM2 Driver" },
 };
 
-static const __devinitconst struct reg_default wm5100_reva_patches[] = {
+static const struct reg_default wm5100_reva_patches[] = {
 	{ WM5100_AUDIO_IF_1_10, 0 },
 	{ WM5100_AUDIO_IF_1_11, 1 },
 	{ WM5100_AUDIO_IF_1_12, 2 },
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 10d21be..2153e19 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4007,7 +4007,7 @@ int snd_soc_register_codec(struct device *dev,
 		codec->reg_size = reg_size;
 		/* it is necessary to make a copy of the default register cache
 		 * because in the case of using a compression type that requires
-		 * the default register cache to be marked as __devinitconst the
+		 * the default register cache to be marked as the
 		 * kernel might have freed the array by the time we initialize
 		 * the cache.
 		 */
diff --git a/sound/soc/tegra/tegra20_das.c b/sound/soc/tegra/tegra20_das.c
index b0c29eb..7b0a1f5 100644
--- a/sound/soc/tegra/tegra20_das.c
+++ b/sound/soc/tegra/tegra20_das.c
@@ -210,7 +210,7 @@ static int __devexit tegra20_das_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id tegra20_das_of_match[] __devinitconst = {
+static const struct of_device_id tegra20_das_of_match[] = {
 	{ .compatible = "nvidia,tegra20-das", },
 	{},
 };
diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index 256607f..34557d3 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -463,12 +463,12 @@ static int __devexit tegra20_i2s_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id tegra20_i2s_of_match[] __devinitconst = {
+static const struct of_device_id tegra20_i2s_of_match[] = {
 	{ .compatible = "nvidia,tegra20-i2s", },
 	{},
 };
 
-static const struct dev_pm_ops tegra20_i2s_pm_ops __devinitconst = {
+static const struct dev_pm_ops tegra20_i2s_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra20_i2s_runtime_suspend,
 			   tegra20_i2s_runtime_resume, NULL)
 };
diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 8df9ab0..a2f9fe8 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -373,7 +373,7 @@ static int __devexit tegra20_spdif_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct dev_pm_ops tegra20_spdif_pm_ops __devinitconst = {
+static const struct dev_pm_ops tegra20_spdif_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra20_spdif_runtime_suspend,
 			   tegra20_spdif_runtime_resume, NULL)
 };
diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index b9c2008..e1cc576 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -287,7 +287,7 @@ int tegra30_ahub_unset_rx_cif_source(enum tegra30_ahub_rxcif rxcif)
 }
 EXPORT_SYMBOL_GPL(tegra30_ahub_unset_rx_cif_source);
 
-static const char * const configlink_clocks[] __devinitconst = {
+static const char * const configlink_clocks[] = {
 	"i2s0",
 	"i2s1",
 	"i2s2",
@@ -602,12 +602,12 @@ static int __devexit tegra30_ahub_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id tegra30_ahub_of_match[] __devinitconst = {
+static const struct of_device_id tegra30_ahub_of_match[] = {
 	{ .compatible = "nvidia,tegra30-ahub", },
 	{},
 };
 
-static const struct dev_pm_ops tegra30_ahub_pm_ops __devinitconst = {
+static const struct dev_pm_ops tegra30_ahub_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra30_ahub_runtime_suspend,
 			   tegra30_ahub_runtime_resume, NULL)
 };
diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index af2c187..18d6847 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -508,12 +508,12 @@ static int __devexit tegra30_i2s_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id tegra30_i2s_of_match[] __devinitconst = {
+static const struct of_device_id tegra30_i2s_of_match[] = {
 	{ .compatible = "nvidia,tegra30-i2s", },
 	{},
 };
 
-static const struct dev_pm_ops tegra30_i2s_pm_ops __devinitconst = {
+static const struct dev_pm_ops tegra30_i2s_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra30_i2s_runtime_suspend,
 			   tegra30_i2s_runtime_resume, NULL)
 };
diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index bf40691..b2e3c00 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -242,7 +242,7 @@ static int __devexit tegra_alc5632_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id tegra_alc5632_of_match[] __devinitconst = {
+static const struct of_device_id tegra_alc5632_of_match[] = {
 	{ .compatible = "nvidia,tegra-audio-alc5632", },
 	{},
 };
diff --git a/sound/soc/tegra/tegra_wm8753.c b/sound/soc/tegra/tegra_wm8753.c
index f5ea8a9..53008b0 100644
--- a/sound/soc/tegra/tegra_wm8753.c
+++ b/sound/soc/tegra/tegra_wm8753.c
@@ -200,7 +200,7 @@ static int __devexit tegra_wm8753_driver_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id tegra_wm8753_of_match[] __devinitconst = {
+static const struct of_device_id tegra_wm8753_of_match[] = {
 	{ .compatible = "nvidia,tegra-audio-wm8753", },
 	{},
 };
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index fa838d3..2599252 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -417,7 +417,7 @@ static int __devexit tegra_wm8903_driver_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id tegra_wm8903_of_match[] __devinitconst = {
+static const struct of_device_id tegra_wm8903_of_match[] = {
 	{ .compatible = "nvidia,tegra-audio-wm8903", },
 	{},
 };
diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index 5f98970..055fd0e 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -195,7 +195,7 @@ static int __devexit tegra_snd_trimslice_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id trimslice_of_match[] __devinitconst = {
+static const struct of_device_id trimslice_of_match[] = {
 	{ .compatible = "nvidia,tegra-audio-trimslice", },
 	{},
 };
-- 
1.8.0
