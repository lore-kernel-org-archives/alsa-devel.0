From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 4/4] ASoC: Intel: broadwell: Simplify device
	probe
Date: Thu, 22 Aug 2019 13:36:16 +0200
Message-ID: <20190822113616.22702-5-cezary.rojewski@intel.com>
References: <20190822113616.22702-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33F30F80391
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 13:36:55 +0200 (CEST)
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
 sound/soc/intel/boards/broadwell.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index ab38ef30dfff..db7e1e87156d 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -270,18 +270,14 @@ static struct snd_soc_card broadwell_rt286 = {
 static int broadwell_audio_probe(struct platform_device *pdev)
 {
 	struct snd_soc_acpi_mach *mach;
-	const char *platform_name = NULL;
 	int ret;
 
 	broadwell_rt286.dev = &pdev->dev;
 
 	/* override plaform name, if required */
 	mach = (&pdev->dev)->platform_data;
-	if (mach) /* extra check since legacy does not pass parameters */
-		platform_name = mach->mach_params.platform;
-
 	ret = snd_soc_fixup_dai_links_platform_name(&broadwell_rt286,
-						    platform_name);
+						    mach->mach_params.platform);
 	if (ret)
 		return ret;
 
-- 
2.17.1
