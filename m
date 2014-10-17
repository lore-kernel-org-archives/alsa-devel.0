From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Add new dependency for
	Broadwell machine
Date: Thu, 16 Oct 2014 18:22:01 -0700
Message-ID: <1413508922-27567-2-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1413508922-27567-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 24221260640
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 03:24:12 +0200 (CEST)
In-Reply-To: <1413508922-27567-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, alsa-devel@alsa-project.org, "Glenn P. Williamson" <glenn.p.williamson@intel.com>
List-Id: alsa-devel@alsa-project.org

I2C support for the RT286 codec is provided through the Designware I2C
platform adapter in this machine. Thus, the adapter driver must be present.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 sound/soc/intel/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index f5b4a9c7..83d5ed1 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -61,7 +61,8 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 
 config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
-	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && DW_DMAC
+	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && DW_DMAC && \\
+		   I2C_DESIGNWARE_PLATFORM
 	select SND_SOC_INTEL_HASWELL
 	select SND_COMPRESS_OFFLOAD
 	select SND_SOC_RT286
-- 
1.9.1
