From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 3/4] ASoC: Intel: bdw-rt5677: Simplify device
	probe
Date: Thu, 22 Aug 2019 13:36:15 +0200
Message-ID: <20190822113616.22702-4-cezary.rojewski@intel.com>
References: <20190822113616.22702-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88449F8036E
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 13:36:53 +0200 (CEST)
In-Reply-To: <20190822113616.22702-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

With legacy ADSP private context adjusted, there is no need for double
safety.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/boards/bdw-rt5677.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index e8e9c3dc82a5..4a4d3353e26d 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -340,7 +340,6 @@ static int bdw_rt5677_probe(struct platform_device *pdev)
 {
 	struct bdw_rt5677_priv *bdw_rt5677;
 	struct snd_soc_acpi_mach *mach;
-	const char *platform_name = NULL;
 	int ret;
 
 	bdw_rt5677_card.dev = &pdev->dev;
@@ -355,11 +354,8 @@ static int bdw_rt5677_probe(struct platform_device *pdev)
 
 	/* override plaform name, if required */
 	mach = (&pdev->dev)->platform_data;
-	if (mach) /* extra check since legacy does not pass parameters */
-		platform_name = mach->mach_params.platform;
-
 	ret = snd_soc_fixup_dai_links_platform_name(&bdw_rt5677_card,
-						    platform_name);
+						    mach->mach_params.platform);
 	if (ret)
 		return ret;
 
-- 
2.17.1
