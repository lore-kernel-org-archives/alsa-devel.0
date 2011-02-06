From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH] ASoC: mid-x86: Fix dependency on intel_sst
	driver
Date: Sun,  6 Feb 2011 15:35:48 +0530
Message-ID: <1296986748-22614-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 18D17243EA
	for <alsa-devel@alsa-project.org>; Sun,  6 Feb 2011 10:58:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

Enabling medfield asoc driver causes compliation error when intel_sst
is not selected
ERROR: "register_sst_card" [sound/soc/mid-x86/snd-soc-sst-platform.ko]
undefined!

This patch puts proper dependency to elimate build error

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
Reported-by: Andrew Morton <akpm@linux-foundation.org>
---
 sound/soc/mid-x86/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mid-x86/Kconfig b/sound/soc/mid-x86/Kconfig
index 1ad7538..2935042 100644
--- a/sound/soc/mid-x86/Kconfig
+++ b/sound/soc/mid-x86/Kconfig
@@ -1,6 +1,7 @@
 config SND_MFLD_MACHINE
 	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
 	depends on INTEL_SCU_IPC
+	depends on SND_INTEL_SST
 	select SND_SOC_SN95031
 	select SND_SST_PLATFORM
 	help
@@ -11,4 +12,3 @@ config SND_MFLD_MACHINE
 
 config SND_SST_PLATFORM
 	tristate
-	depends on SND_INTEL_SST
-- 
1.7.2.3
