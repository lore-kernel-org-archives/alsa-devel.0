From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 06/11] ASoC: Intel: Skylake: Check for NHLT
	ACPI header signature
Date: Tue,  7 Nov 2017 16:16:21 +0530
Message-ID: <20171107104626.25800-7-guneshwor.o.singh@intel.com>
References: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 02E2C267388
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 11:47:27 +0100 (CET)
In-Reply-To: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>

In certain buggy BIOS acpi_evaluate_dsm() may not return the correct
NHLT table, so check the NHLT table header signature before accessing
it.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index e7d766d56c8e..d14c50a60289 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -20,6 +20,8 @@
 #include <linux/pci.h>
 #include "skl.h"
 
+#define NHLT_ACPI_HEADER_SIG	"NHLT"
+
 /* Unique identification for getting NHLT blobs */
 static guid_t osc_guid =
 	GUID_INIT(0xA69F886E, 0x6CEB, 0x4594,
@@ -45,6 +47,13 @@ struct nhlt_acpi_table *skl_nhlt_init(struct device *dev)
 				memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
 				MEMREMAP_WB);
 		ACPI_FREE(obj);
+		if (nhlt_table && (strncmp(nhlt_table->header.signature,
+					NHLT_ACPI_HEADER_SIG,
+					strlen(NHLT_ACPI_HEADER_SIG)) != 0)) {
+			memunmap(nhlt_table);
+			dev_err(dev, "NHLT ACPI header signature incorrect\n");
+			return NULL;
+		}
 		return nhlt_table;
 	}
 
-- 
2.14.2
