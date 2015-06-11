From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: Intel: Added I2C dependency to two BSW
	machine drivers
Date: Thu, 11 Jun 2015 15:51:59 -0700
Message-ID: <1434063119-8849-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C5A1226663E
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 00:52:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: "Fang, Yang A" <yang.a.fang@intel.com>, alsa-devel@alsa-project.org, fengguang.wu@intel.com, sathyanarayana.nujella@intel.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

Fixed below error/warnings

   sound/built-in.o: In function `rt5645_i2c_probe':
>> rt5645.c:(.text+0xe38f5): undefined reference to
>> `devm_regmap_init_i2c'
   sound/built-in.o: In function `rt5645_i2c_driver_exit':
>> rt5645.c:(.exit.text+0x60e): undefined reference to `i2c_del_driver'
   sound/built-in.o: In function `rt5645_i2c_driver_init':
>> rt5645.c:(.init.text+0x1a90): undefined reference to
>> `i2c_register_driver'

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 791953f..f3060a4 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -112,7 +112,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
 
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
-	depends on X86_INTEL_LPSS
+	depends on X86_INTEL_LPSS && I2C
 	select SND_SOC_RT5645
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
@@ -123,7 +123,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 
 config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with MAX98090 & TI codec"
-	depends on X86_INTEL_LPSS
+	depends on X86_INTEL_LPSS && I2C
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
 	select SND_SST_MFLD_PLATFORM
-- 
1.7.9.5
