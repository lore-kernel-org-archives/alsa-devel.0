From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ASoC: SOF: xtensa: fix undefined references
Date: Tue,  7 May 2019 11:32:35 -0500
Message-ID: <20190507163236.8783-2-pierre-louis.bossart@linux.intel.com>
References: <20190507163236.8783-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6BEFAF89671
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 18:32:45 +0200 (CEST)
In-Reply-To: <20190507163236.8783-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, kbuild-all@01.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The SND_SOC_INTEL_COMMON Kconfig was removed months ago from SOF
Kconfig files but is still selected instead of the correct
SND_SOC_SOF_INTEL_COMMON kconfig which does select xtensa stuff,
leading to the following errors.

ld: sound/soc/sof/sof-acpi-dev.o:(.rodata+0x120): undefined reference
to `sof_xtensa_arch_ops'
ld: sound/soc/sof/sof-acpi-dev.o:(.rodata+0x180): undefined reference
to `sof_xtensa_arch_ops'
ld: sound/soc/sof/sof-acpi-dev.o:(.rodata+0x1e0): undefined reference
to `sof_xtensa_arch_ops'

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 32ee0fabab92..603e0db4f012 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -36,7 +36,7 @@ config SND_SOC_SOF_INTEL_HIFI_EP_IPC
 
 config SND_SOC_SOF_INTEL_ATOM_HIFI_EP
 	tristate
-	select SND_SOC_INTEL_COMMON
+	select SND_SOC_SOF_INTEL_COMMON
 	select SND_SOC_SOF_INTEL_HIFI_EP_IPC
 	help
 	  This option is not user-selectable but automagically handled by
-- 
2.17.1
