From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Atom: fix IOSF_MBI dependency
Date: Sat,  3 Sep 2016 11:23:26 -0500
Message-ID: <1472919806-6691-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F7D126736F
 for <alsa-devel@alsa-project.org>; Sat,  3 Sep 2016 18:23:27 +0200 (CEST)
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
Cc: broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

fix issue reported by 0-Day with randconfig

The commit a68bc0d43e1b
("ASoC: Intel: Atom: auto-detection of Baytrail-CR")
added a dependency on IOSF_MBI. The code used the IS_ENABLED macro
to check for this dependency but this is not enough in case the SST
driver is built-in. This could be fixed with IS_REACHABLE but
Baytrail-CR would not be detected depending on combinations of options

Add dependency in Kconfig to solve this for good

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index a20c3df..fc6e780 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -25,6 +25,7 @@ config SND_SST_IPC_ACPI
 	tristate
 	select SND_SST_IPC
 	select SND_SOC_INTEL_SST
+	select IOSF_MBI
 
 config SND_SOC_INTEL_SST
 	tristate
-- 
2.7.4
