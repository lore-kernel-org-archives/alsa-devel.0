From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 12/15] ASoC: Intel: cht_bsw_rt5672: platform
	name fixup support
Date: Fri, 25 Jan 2019 14:35:06 -0600
Message-ID: <20190125203509.22994-13-pierre-louis.bossart@linux.intel.com>
References: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 019C826799C
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:35:24 +0100 (CET)
In-Reply-To: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add helper to override dailink platform name, if passed as parameter

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 9de64f447e7b..f1c1f9dd5353 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -400,6 +400,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	int ret_val = 0;
 	struct cht_mc_private *drv;
 	struct snd_soc_acpi_mach *mach = pdev->dev.platform_data;
+	const char *platform_name;
 	const char *i2c_name;
 	int i;
 
@@ -426,6 +427,14 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* override plaform name, if required */
+	platform_name = mach->mach_params.platform;
+
+	ret_val = snd_soc_fixup_dai_links_platform_name(&snd_soc_card_cht,
+							platform_name);
+	if (ret_val)
+		return ret_val;
+
 	drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
 	if (IS_ERR(drv->mclk)) {
 		dev_err(&pdev->dev,
-- 
2.17.1
