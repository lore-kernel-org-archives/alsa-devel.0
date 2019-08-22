From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 1/4] ASoC: Intel: Haswell: Adjust machine
	device private context
Date: Thu, 22 Aug 2019 13:36:13 +0200
Message-ID: <20190822113616.22702-2-cezary.rojewski@intel.com>
References: <20190822113616.22702-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3049DF80147
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 13:36:52 +0200 (CEST)
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

Apart from Haswell machines, all other devices have their private data
set to snd_soc_acpi_mach instance.

Changes for HSW/ BDW boards introduced with series:
https://patchwork.kernel.org/cover/10782035/

added support for dai_link platform_name adjustments within card probe
routines. These take for granted private_data points to
snd_soc_acpi_mach whereas for Haswell, it's sst_pdata instead. Change
private context of platform_device - representing machine board - to
address this.

Fixes: e87055d732e3 ("ASoC: Intel: haswell: platform name fixup support")
Fixes: 7e40ddcf974a ("ASoC: Intel: bdw-rt5677: platform name fixup support")
Fixes: 2d067b2807f9 ("ASoC: Intel: broadwell: platform name fixup support")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/common/sst-acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 15f2b27e643f..c34f628c7987 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -109,11 +109,12 @@ int sst_acpi_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, sst_acpi);
+	mach->pdata = sst_pdata;
 
 	/* register machine driver */
 	sst_acpi->pdev_mach =
 		platform_device_register_data(dev, mach->drv_name, -1,
-					      sst_pdata, sizeof(*sst_pdata));
+					      mach, sizeof(*mach));
 	if (IS_ERR(sst_acpi->pdev_mach))
 		return PTR_ERR(sst_acpi->pdev_mach);
 
-- 
2.17.1
