From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Rename mid-x86 directory to intel
Date: Thu, 21 Nov 2013 13:32:24 +0200
Message-ID: <1385033544-19455-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E7A372602F3
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 12:32:34 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

We have other Intel platforms coming having the Smart Sound Technology (SST)
so rename the mid-x86 directory to intel as originally directory name
reflected only Intel MID platform.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/Kconfig                           | 2 +-
 sound/soc/Makefile                          | 2 +-
 sound/soc/{mid-x86 => intel}/Kconfig        | 0
 sound/soc/{mid-x86 => intel}/Makefile       | 0
 sound/soc/{mid-x86 => intel}/mfld_machine.c | 0
 sound/soc/{mid-x86 => intel}/sst_dsp.h      | 0
 sound/soc/{mid-x86 => intel}/sst_platform.c | 0
 sound/soc/{mid-x86 => intel}/sst_platform.h | 0
 8 files changed, 2 insertions(+), 2 deletions(-)
 rename sound/soc/{mid-x86 => intel}/Kconfig (100%)
 rename sound/soc/{mid-x86 => intel}/Makefile (100%)
 rename sound/soc/{mid-x86 => intel}/mfld_machine.c (100%)
 rename sound/soc/{mid-x86 => intel}/sst_dsp.h (100%)
 rename sound/soc/{mid-x86 => intel}/sst_platform.c (100%)
 rename sound/soc/{mid-x86 => intel}/sst_platform.h (100%)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 5138b8493051..463a9e25e04f 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -42,7 +42,7 @@ source "sound/soc/jz4740/Kconfig"
 source "sound/soc/nuc900/Kconfig"
 source "sound/soc/omap/Kconfig"
 source "sound/soc/kirkwood/Kconfig"
-source "sound/soc/mid-x86/Kconfig"
+source "sound/soc/intel/Kconfig"
 source "sound/soc/mxs/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/samsung/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 8b9e70105dd2..ff291d3e60af 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_SND_SOC)	+= davinci/
 obj-$(CONFIG_SND_SOC)	+= dwc/
 obj-$(CONFIG_SND_SOC)	+= fsl/
 obj-$(CONFIG_SND_SOC)	+= jz4740/
-obj-$(CONFIG_SND_SOC)	+= mid-x86/
+obj-$(CONFIG_SND_SOC)	+= intel/
 obj-$(CONFIG_SND_SOC)	+= mxs/
 obj-$(CONFIG_SND_SOC)	+= nuc900/
 obj-$(CONFIG_SND_SOC)	+= omap/
diff --git a/sound/soc/mid-x86/Kconfig b/sound/soc/intel/Kconfig
similarity index 100%
rename from sound/soc/mid-x86/Kconfig
rename to sound/soc/intel/Kconfig
diff --git a/sound/soc/mid-x86/Makefile b/sound/soc/intel/Makefile
similarity index 100%
rename from sound/soc/mid-x86/Makefile
rename to sound/soc/intel/Makefile
diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/intel/mfld_machine.c
similarity index 100%
rename from sound/soc/mid-x86/mfld_machine.c
rename to sound/soc/intel/mfld_machine.c
diff --git a/sound/soc/mid-x86/sst_dsp.h b/sound/soc/intel/sst_dsp.h
similarity index 100%
rename from sound/soc/mid-x86/sst_dsp.h
rename to sound/soc/intel/sst_dsp.h
diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/intel/sst_platform.c
similarity index 100%
rename from sound/soc/mid-x86/sst_platform.c
rename to sound/soc/intel/sst_platform.c
diff --git a/sound/soc/mid-x86/sst_platform.h b/sound/soc/intel/sst_platform.h
similarity index 100%
rename from sound/soc/mid-x86/sst_platform.h
rename to sound/soc/intel/sst_platform.h
-- 
1.8.4.2
