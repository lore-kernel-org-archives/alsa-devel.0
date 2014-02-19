From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCHv2] ASoC: Intel: Fix build for sst-dsp.c on PPC
	architecture
Date: Wed, 19 Feb 2014 16:45:57 +0000
Message-ID: <1392828357-7610-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id D8E76265AAC
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 17:47:05 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Disable build on non X86 architectures except for compile testing. This fixes
the following build errors on PPC and adds an option for testing the build on other
architectures as suggested by Mark Brown :-

sound/soc/intel/sst-dsp.c: In function 'sst_dsp_outbox_write':
sound/soc/intel/sst-dsp.c:218:2: error: implicit declaration of function 'memcpy_toio' [-Werror=implicit-function-declaration]
  memcpy_toio(sst->mailbox.out_base, message, bytes);
  ^
sound/soc/intel/sst-dsp.c: In function 'sst_dsp_outbox_read':
sound/soc/intel/sst-dsp.c:231:2: error: implicit declaration of function 'memcpy_fromio' [-Werror=implicit-function-declaration]
  memcpy_fromio(message, sst->mailbox.out_base, bytes);
  ^

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/Kconfig   | 1 +
 sound/soc/intel/sst-dsp.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index c962432..4bb802b 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -15,6 +15,7 @@ config SND_SST_MFLD_PLATFORM
 config SND_SOC_INTEL_SST
 	tristate "ASoC support for Intel(R) Smart Sound Technology"
 	select SND_SOC_INTEL_SST_ACPI if ACPI
+	depends on (X86 || COMPILE_TEST)
 	help
           This adds support for Intel(R) Smart Sound Technology (SST).
           Say Y if you have such a device
diff --git a/sound/soc/intel/sst-dsp.c b/sound/soc/intel/sst-dsp.c
index e0ad2e5..6e22c12 100644
--- a/sound/soc/intel/sst-dsp.c
+++ b/sound/soc/intel/sst-dsp.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/io.h>
 
 #include "sst-dsp.h"
 #include "sst-dsp-priv.h"
-- 
1.8.3.2
