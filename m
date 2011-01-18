From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Add dependency on INTEL_SCU_IPC for
	Intel MID drivers
Date: Tue, 18 Jan 2011 19:11:48 +0530
Message-ID: <1295358108-17050-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B76110383D
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 14:39:05 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>, broonie@opensource.wolfsonmicro.com, alan@linux.intel.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/mid-x86/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/Kconfig b/sound/soc/mid-x86/Kconfig
index e0123a4..1ad7538 100644
--- a/sound/soc/mid-x86/Kconfig
+++ b/sound/soc/mid-x86/Kconfig
@@ -1,5 +1,6 @@
 config SND_MFLD_MACHINE
 	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
+	depends on INTEL_SCU_IPC
 	select SND_SOC_SN95031
 	select SND_SST_PLATFORM
 	help
-- 
1.7.2.3
