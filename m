From: jeeja.kp@intel.com
Subject: [PATCH v2 07/11] ASoC: Intel: Skylake: remove hard
	coded ACPI path
Date: Fri, 24 Mar 2017 23:10:30 +0530
Message-ID: <1490377234-30257-8-git-send-email-jeeja.kp@intel.com>
References: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 248842674F3
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 18:28:45 +0100 (CET)
In-Reply-To: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

We should not hard code the ACPI path to get acpi_handle. Instead use
ACPI_HANDLE macro to do the job.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 7eb9c41..e3f0667 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -24,8 +24,6 @@
 static u8 OSC_UUID[16] = {0x6E, 0x88, 0x9F, 0xA6, 0xEB, 0x6C, 0x94, 0x45,
 				0xA4, 0x1F, 0x7B, 0x5D, 0xCE, 0x24, 0xC5, 0x53};
 
-#define DSDT_NHLT_PATH "\\_SB.PCI0.HDAS"
-
 struct nhlt_acpi_table *skl_nhlt_init(struct device *dev)
 {
 	acpi_handle handle;
@@ -33,8 +31,9 @@ struct nhlt_acpi_table *skl_nhlt_init(struct device *dev)
 	struct nhlt_resource_desc  *nhlt_ptr = NULL;
 	struct nhlt_acpi_table *nhlt_table = NULL;
 
-	if (ACPI_FAILURE(acpi_get_handle(NULL, DSDT_NHLT_PATH, &handle))) {
-		dev_err(dev, "Requested NHLT device not found\n");
+	handle = ACPI_HANDLE(dev);
+	if (!handle) {
+		dev_err(dev, "Didn't find ACPI_HANDLE\n");
 		return NULL;
 	}
 
-- 
2.5.0
