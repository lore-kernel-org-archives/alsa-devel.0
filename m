From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 3/7] ASoC: Intel: document what Kconfig
	options do
Date: Fri, 17 Nov 2017 18:01:58 -0600
Message-ID: <20171118000202.22302-4-pierre-louis.bossart@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E7F1267233
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 01:02:27 +0100 (CET)
In-Reply-To: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
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

Document what the options are supposed to mean, before clean-up in
next patch.

No functionality change here.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 175b2965ca21..136426d60da0 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -15,16 +15,30 @@ if SND_SOC_INTEL_SST_TOPLEVEL
 
 config SND_SST_IPC
 	tristate
+	help
+	  This option controls the IPC core for HiFi2 platforms
 
 config SND_SST_IPC_PCI
 	tristate
 	select SND_SST_IPC
+	help
+	  This option controls the PCI-based IPC for HiFi2 platforms
+	  (Medfield, Merrifield).
 
 config SND_SST_IPC_ACPI
 	tristate
 	select SND_SST_IPC
 	select SND_SOC_INTEL_SST
 	select IOSF_MBI
+	help
+	 This option controls the ACPI-based IPC for HiFi2 platforms
+	 (Baytrail, Cherrytrail)
+
+config SND_SOC_INTEL_SST_ACPI
+	tristate
+	help
+	  This option controls ACPI-based probing on Haswell/Broadwell/
+	  Baytrail legacy and will be set when these platforms are enabled
 
 config SND_SOC_INTEL_SST
 	tristate
@@ -33,9 +47,9 @@ config SND_SOC_INTEL_SST
 config SND_SOC_INTEL_SST_FIRMWARE
 	tristate
 	select DW_DMAC_CORE
-
-config SND_SOC_INTEL_SST_ACPI
-	tristate
+	help
+	  This option controls firmware download on Haswell/Broadwell/
+	  Baytrail legacy and will be set when these platforms are enabled
 
 config SND_SOC_INTEL_HASWELL
 	tristate "Intel ASoC SST driver for Haswell/Broadwell"
-- 
2.14.1
