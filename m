From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: Add help text for
	SND_SOC_INTEL_SST_TOPLEVEL
Date: Wed, 15 Nov 2017 10:11:02 +0530
Message-ID: <1510720862-12507-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id C4FCD26751C
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 05:37:54 +0100 (CET)
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Symbol SND_SOC_INTEL_SST_TOPLEVEL is user selectable so add the
help text for this symbol.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index bb8be10b8437..7b49d04e3c60 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -34,6 +34,11 @@ config SND_SOC_INTEL_SST_TOPLEVEL
 	depends on X86 || COMPILE_TEST
 	select SND_SOC_INTEL_MACH
 	select SND_SOC_INTEL_COMMON
+	help
+          Intel ASoC Audio Drivers. If you have a Intel machine that
+          has audio controller with a DSP and I2S or DMIC port, then
+          enable this option by saying Y or M
+          If unsure select "N".
 
 config SND_SOC_INTEL_HASWELL
 	tristate "Intel ASoC SST driver for Haswell/Broadwell"
-- 
2.7.4
