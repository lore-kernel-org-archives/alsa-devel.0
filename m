From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Add I2C depends for SKL
	machine
Date: Wed, 18 Nov 2015 19:11:46 +0530
Message-ID: <1447854106-6473-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CF10265AB8
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 14:38:06 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The i2c is dependency for the i2c codec drivers, so machine should depend on
i2c. WIthout this we get build failures if I2C is not selected

   sound/soc/codecs/rl6347a.c: In function 'rl6347a_hw_write':
>> sound/soc/codecs/rl6347a.c:66:8: error: implicit declaration of function
>> 'i2c_master_send' [-Werror=implicit-function-declaration]
     ret = i2c_master_send(client, data, 4);
           ^
   sound/soc/codecs/rl6347a.c: In function 'rl6347a_hw_read':
>> sound/soc/codecs/rl6347a.c:114:8: error: implicit declaration of function
>> 'i2c_transfer' [-Werror=implicit-function-declaration]
     ret = i2c_transfer(client->adapter, xfer, 2);

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 13a762172b5d..2903823ebee1 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -145,7 +145,7 @@ config SND_SOC_INTEL_SKYLAKE
 
 config SND_SOC_INTEL_SKL_RT286_MACH
 	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
-	depends on X86 && ACPI
+	depends on X86 && ACPI && I2C
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT286
-- 
1.9.1
