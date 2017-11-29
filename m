From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH v2 3/7] ASoC: Intel: document what Kconfig
	options do
Date: Tue, 28 Nov 2017 19:45:47 -0600
Message-ID: <20171129014551.30552-4-pierre-louis.bossart@linux.intel.com>
References: <20171129014551.30552-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FF68267396
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 02:46:10 +0100 (CET)
In-Reply-To: <20171129014551.30552-1-pierre-louis.bossart@linux.intel.com>
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
Cc: arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

Document in comments what the options are supposed to mean, before
clean-up in next patch.

No functionality change here.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index a982bc2fde62..2542e71a0e6a 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -15,16 +15,26 @@ if SND_SOC_INTEL_SST_TOPLEVEL
 
 config SND_SST_IPC
 	tristate
+	# This option controls the IPC core for HiFi2 platforms
 
 config SND_SST_IPC_PCI
 	tristate
 	select SND_SST_IPC
+	# This option controls the PCI-based IPC for HiFi2 platforms
+	#  (Medfield, Merrifield).
 
 config SND_SST_IPC_ACPI
 	tristate
 	select SND_SST_IPC
 	select SND_SOC_INTEL_SST
 	select IOSF_MBI
+	# This option controls the ACPI-based IPC for HiFi2 platforms
+	# (Baytrail, Cherrytrail)
+
+config SND_SOC_INTEL_SST_ACPI
+	tristate
+	# This option controls ACPI-based probing on Haswell/Broadwell/
+	#  Baytrail legacy and will be set when these platforms are enabled
 
 config SND_SOC_INTEL_SST
 	tristate
@@ -33,9 +43,8 @@ config SND_SOC_INTEL_SST
 config SND_SOC_INTEL_SST_FIRMWARE
 	tristate
 	select DW_DMAC_CORE
-
-config SND_SOC_INTEL_SST_ACPI
-	tristate
+	# This option controls firmware download on Haswell/Broadwell/
+	# Baytrail legacy and will be set when these platforms are enabled
 
 config SND_SOC_INTEL_HASWELL
 	tristate "Intel ASoC SST driver for Haswell/Broadwell"
-- 
2.14.1
