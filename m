From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 3/4] ASoC: Intel: remove ignored dependencies
Date: Mon, 16 Jan 2017 15:12:28 +0200
Message-ID: <20170116131229.102820-4-andriy.shevchenko@linux.intel.com>
References: <20170116131229.102820-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 47233267076
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 14:12:37 +0100 (CET)
In-Reply-To: <20170116131229.102820-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: dmaengine <dmaengine@vger.kernel.org>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

For selected only options the explicit dependencies do not make much sense
becase Kbuild ignores them anyway. Remove them explicitly.

Acked-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 2e519fa05606..913974f8d282 100644
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
