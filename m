From: Michele Curti <michele.curti@gmail.com>
Subject: [PATCH] ASoC: Intel Kconfig: add SND_SOC_INTEL_BOARDS
	option
Date: Thu, 18 Jun 2015 21:59:39 +0200
Message-ID: <1434657579-21581-1-git-send-email-michele.curti@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 by alsa0.perex.cz (Postfix) with ESMTP id DAF472662CA
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 22:00:21 +0200 (CEST)
Received: by wiga1 with SMTP id a1so3926306wig.0
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 13:00:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com
Cc: Michele Curti <michele.curti@gmail.com>, alsa-devel@alsa-project.org, tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, jarkko.nikula@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Machine drivers under boards folder must be available for both
SND_SST_MFLD_PLATFORM and SND_SOC_INTEL_SST.  This patch adds a
new kernel option SND_SOC_INTEL_BOARD to permit this.

Signed-off-by: Michele Curti <michele.curti@gmail.com>
---
 sound/soc/intel/Kconfig  | 5 +++++
 sound/soc/intel/Makefile | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index f3060a4..c442cd7 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -10,7 +10,11 @@ config SND_MFLD_MACHINE
           Say Y if you have such a device
           If unsure select "N".
 
+config SND_SOC_INTEL_BOARDS
+	tristate
+
 config SND_SST_MFLD_PLATFORM
+	select SND_SOC_INTEL_BOARDS
 	tristate
 
 config SND_SST_IPC
@@ -28,6 +32,7 @@ config SND_SST_IPC_ACPI
 config SND_SOC_INTEL_SST
 	tristate "ASoC support for Intel(R) Smart Sound Technology"
 	select SND_SOC_INTEL_SST_ACPI if ACPI
+	select SND_SOC_INTEL_BOARDS
 	depends on (X86 || COMPILE_TEST)
 	depends on DW_DMAC_CORE
 	help
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 3853ec2..4c4bf74 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
 obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += atom/
 
 # Machine support
-obj-$(CONFIG_SND_SOC_INTEL_SST) += boards/
+obj-$(CONFIG_SND_SOC_INTEL_BOARDS) += boards/
-- 
2.4.3
