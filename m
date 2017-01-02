From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/4] ASoC: Intel: remove ignored dependencies
Date: Mon,  2 Jan 2017 17:20:16 +0200
Message-ID: <20170102152017.13938-4-andriy.shevchenko@linux.intel.com>
References: <20170102152017.13938-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id B564B2667F9
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 16:21:22 +0100 (CET)
In-Reply-To: <20170102152017.13938-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, dmaengine <dmaengine@vger.kernel.org>, Jie Yang <yang.jie@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

For selected only options the explicit dependencies do not make much sense
becase Kbuild ignores them anyway. Remove them explicitly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 7b60689a22d4..7da8b9ceb728 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -31,7 +31,6 @@ config SND_SOC_INTEL_SST
 	tristate
 	select SND_SOC_INTEL_SST_ACPI if ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
-	depends on (X86 || COMPILE_TEST)
 
 config SND_SOC_INTEL_SST_FIRMWARE
 	tristate
-- 
2.11.0
