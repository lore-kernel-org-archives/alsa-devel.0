From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: intel: Remove superfluous backslash in
	Kconfig
Date: Wed, 10 Dec 2014 11:53:47 +0100
Message-ID: <1418208827-2001-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7620A26049A
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 11:53:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The line continuation in Kconfig should be a '\' instead of '\\'.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index e989ecf046c9..f06fcf1e21a5 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -46,7 +46,7 @@ config SND_SOC_INTEL_BAYTRAIL
 
 config SND_SOC_INTEL_HASWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
-	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C && \\
+	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C && \
 		   I2C_DESIGNWARE_PLATFORM
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
@@ -76,7 +76,7 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 
 config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
-	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && DW_DMAC && \\
+	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && DW_DMAC && \
 		   I2C_DESIGNWARE_PLATFORM
 	select SND_SOC_INTEL_HASWELL
 	select SND_COMPRESS_OFFLOAD
-- 
2.2.0
