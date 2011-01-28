From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 6/7] ASoC: Tegra: utils: Don't use global
	variables
Date: Fri, 28 Jan 2011 14:26:40 -0700
Message-ID: <1296250001-6348-6-git-send-email-swarren@nvidia.com>
References: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 21941103809
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 22:27:04 +0100 (CET)
In-Reply-To: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
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

Instead, have the machine driver provide storage for the utility data
somehow.

For Harmony in particular, store this within struct tegra_harmony, itself
referenced by snd_soc_card's drvdata.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/harmony.c          |   11 +++--
 sound/soc/tegra/tegra_asoc_utils.c |   91 +++++++++++++++++------------------
 sound/soc/tegra/tegra_asoc_utils.h |   20 +++++++-
 3 files changed, 68 insertions(+), 54 deletions(-)

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
index 76793a9..d1faa63 100644
--- a/sound/soc/tegra/harmony.c
+++ b/sound/soc/tegra/harmony.c
@@ -50,6 +50,7 @@
 #define DRV_NAME "tegra-snd-harmony"
 
 struct tegra_harmony {
+	struct tegra_asoc_utils_data util_data;
 	struct harmony_audio_platform_data *pdata;
 	int gpio_spkr_en_requested;
 };
@@ -62,6 +63,7 @@ static int harmony_asoc_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_card *card = codec->card;
+	struct tegra_harmony *harmony = snd_soc_card_get_drvdata(card);
 	int srate, mclk, mclk_change;
 	int err;
 
@@ -80,7 +82,8 @@ static int harmony_asoc_hw_params(struct snd_pcm_substream *substream,
 	while (mclk < 6000000)
 		mclk *= 2;
 
-	err = tegra_asoc_utils_set_rate(srate, mclk, &mclk_change);
+	err = tegra_asoc_utils_set_rate(&harmony->util_data, srate, mclk,
+					&mclk_change);
 	if (err < 0) {
 		dev_err(card->dev, "Can't configure clocks\n");
 		return err;
@@ -226,7 +229,7 @@ static __devinit int tegra_snd_harmony_probe(struct platform_device *pdev)
 
 	harmony->pdata = pdata;
 
-	ret = tegra_asoc_utils_init();
+	ret = tegra_asoc_utils_init(&harmony->util_data, &pdev->dev);
 	if (ret)
 		goto err_free_harmony;
 
@@ -247,7 +250,7 @@ err_clear_drvdata:
 	snd_soc_card_set_drvdata(card, NULL);
 	platform_set_drvdata(pdev, NULL);
 	card->dev = NULL;
-	tegra_asoc_utils_fini();
+	tegra_asoc_utils_fini(&harmony->util_data);
 err_free_harmony:
 	kfree(harmony);
 	return ret;
@@ -265,7 +268,7 @@ static int __devexit tegra_snd_harmony_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	card->dev = NULL;
 
-	tegra_asoc_utils_fini();
+	tegra_asoc_utils_fini(&harmony->util_data);
 
 	if (harmony->gpio_spkr_en_requested)
 		gpio_free(pdata->gpio_spkr_en);
diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
index cfe2ea8..cb4fc13 100644
--- a/sound/soc/tegra/tegra_asoc_utils.c
+++ b/sound/soc/tegra/tegra_asoc_utils.c
@@ -21,20 +21,14 @@
  */
 
 #include <linux/clk.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 
 #include "tegra_asoc_utils.h"
 
-#define PREFIX "ASoC Tegra: "
-
-static struct clk *clk_pll_a;
-static struct clk *clk_pll_a_out0;
-static struct clk *clk_cdev1;
-
-static int set_baseclock, set_mclk;
-
-int tegra_asoc_utils_set_rate(int srate, int mclk, int *mclk_change)
+int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
+			      int mclk, int *mclk_change)
 {
 	int new_baseclock;
 	int err;
@@ -58,95 +52,98 @@ int tegra_asoc_utils_set_rate(int srate, int mclk, int *mclk_change)
 		return -EINVAL;
 	}
 
-	*mclk_change = ((new_baseclock != set_baseclock) ||
-			(mclk != set_mclk));
+	*mclk_change = ((new_baseclock != data->set_baseclock) ||
+			(mclk != data->set_mclk));
 	if (!*mclk_change)
 	    return 0;
 
-	set_baseclock = 0;
-	set_mclk = 0;
+	data->set_baseclock = 0;
+	data->set_mclk = 0;
 
-	clk_disable(clk_cdev1);
-	clk_disable(clk_pll_a_out0);
-	clk_disable(clk_pll_a);
+	clk_disable(data->clk_cdev1);
+	clk_disable(data->clk_pll_a_out0);
+	clk_disable(data->clk_pll_a);
 
-	err = clk_set_rate(clk_pll_a, new_baseclock);
+	err = clk_set_rate(data->clk_pll_a, new_baseclock);
 	if (err) {
-		pr_err(PREFIX "Can't set pll_a rate: %d\n", err);
+		dev_err(data->dev, "Can't set pll_a rate: %d\n", err);
 		return err;
 	}
 
-	err = clk_set_rate(clk_pll_a_out0, mclk);
+	err = clk_set_rate(data->clk_pll_a_out0, mclk);
 	if (err) {
-		pr_err(PREFIX "Can't set pll_a_out0 rate: %d\n", err);
+		dev_err(data->dev, "Can't set pll_a_out0 rate: %d\n", err);
 		return err;
 	}
 
 	/* Don't set cdev1 rate; its locked to pll_a_out0 */
 
-	err = clk_enable(clk_pll_a);
+	err = clk_enable(data->clk_pll_a);
 	if (err) {
-		pr_err(PREFIX "Can't enable pll_a: %d\n", err);
+		dev_err(data->dev, "Can't enable pll_a: %d\n", err);
 		return err;
 	}
 
-	err = clk_enable(clk_pll_a_out0);
+	err = clk_enable(data->clk_pll_a_out0);
 	if (err) {
-		pr_err(PREFIX "Can't enable pll_a_out0: %d\n", err);
+		dev_err(data->dev, "Can't enable pll_a_out0: %d\n", err);
 		return err;
 	}
 
-	err = clk_enable(clk_cdev1);
+	err = clk_enable(data->clk_cdev1);
 	if (err) {
-		pr_err(PREFIX "Can't enable cdev1: %d\n", err);
+		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
 		return err;
 	}
 
-	set_baseclock = new_baseclock;
-	set_mclk = mclk;
+	data->set_baseclock = new_baseclock;
+	data->set_mclk = mclk;
 
 	return 0;
 }
 
-int tegra_asoc_utils_init(void)
+int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
+			  struct device *dev)
 {
 	int ret;
 
-	clk_pll_a = clk_get_sys(NULL, "pll_a");
-	if (IS_ERR(clk_pll_a)) {
-		pr_err(PREFIX "Can't retrieve clk pll_a\n");
-		ret = PTR_ERR(clk_pll_a);
+	data->dev = dev;
+
+	data->clk_pll_a = clk_get_sys(NULL, "pll_a");
+	if (IS_ERR(data->clk_pll_a)) {
+		dev_err(data->dev, "Can't retrieve clk pll_a\n");
+		ret = PTR_ERR(data->clk_pll_a);
 		goto err;
 	}
 
-	clk_pll_a_out0 = clk_get_sys(NULL, "pll_a_out0");
-	if (IS_ERR(clk_pll_a_out0)) {
-		pr_err(PREFIX "Can't retrieve clk pll_a_out0\n");
-		ret = PTR_ERR(clk_pll_a_out0);
+	data->clk_pll_a_out0 = clk_get_sys(NULL, "pll_a_out0");
+	if (IS_ERR(data->clk_pll_a_out0)) {
+		dev_err(data->dev, "Can't retrieve clk pll_a_out0\n");
+		ret = PTR_ERR(data->clk_pll_a_out0);
 		goto err_put_pll_a;
 	}
 
-	clk_cdev1 = clk_get_sys(NULL, "cdev1");
-	if (IS_ERR(clk_cdev1)) {
-		pr_err(PREFIX "Can't retrieve clk cdev1\n");
-		ret = PTR_ERR(clk_cdev1);
+	data->clk_cdev1 = clk_get_sys(NULL, "cdev1");
+	if (IS_ERR(data->clk_cdev1)) {
+		dev_err(data->dev, "Can't retrieve clk cdev1\n");
+		ret = PTR_ERR(data->clk_cdev1);
 		goto err_put_pll_a_out0;
 	}
 
 	return 0;
 
 err_put_pll_a_out0:
-	clk_put(clk_pll_a_out0);
+	clk_put(data->clk_pll_a_out0);
 err_put_pll_a:
-	clk_put(clk_pll_a);
+	clk_put(data->clk_pll_a);
 err:
 	return ret;
 }
 
-void tegra_asoc_utils_fini(void)
+void tegra_asoc_utils_fini(struct tegra_asoc_utils_data *data)
 {
-	clk_put(clk_cdev1);
-	clk_put(clk_pll_a_out0);
-	clk_put(clk_pll_a);
+	clk_put(data->clk_cdev1);
+	clk_put(data->clk_pll_a_out0);
+	clk_put(data->clk_pll_a);
 }
 
diff --git a/sound/soc/tegra/tegra_asoc_utils.h b/sound/soc/tegra/tegra_asoc_utils.h
index 855f8f6..bbba7af 100644
--- a/sound/soc/tegra/tegra_asoc_utils.h
+++ b/sound/soc/tegra/tegra_asoc_utils.h
@@ -23,9 +23,23 @@
 #ifndef __TEGRA_ASOC_UTILS_H__
 #define __TEGRA_ASOC_UTILS_H_
 
-int tegra_asoc_utils_set_rate(int srate, int mclk_rate, int *mclk_change);
-int tegra_asoc_utils_init(void);
-void tegra_asoc_utils_fini(void);
+struct clk;
+struct device;
+
+struct tegra_asoc_utils_data {
+	struct device *dev;
+	struct clk *clk_pll_a;
+	struct clk *clk_pll_a_out0;
+	struct clk *clk_cdev1;
+	int set_baseclock;
+	int set_mclk;
+};
+
+int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
+			      int mclk, int *mclk_change);
+int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
+			  struct device *dev);
+void tegra_asoc_utils_fini(struct tegra_asoc_utils_data *data);
 
 #endif
 
-- 
1.7.1
