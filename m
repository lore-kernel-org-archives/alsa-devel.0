From: Christian Engelmayer <cengelma@gmx.at>
Subject: [PATCH] ASoC: Intel: sst: Fix firmware name size
	handling
Date: Sat,  7 Feb 2015 23:40:52 +0100
Message-ID: <1423348852-29466-1-git-send-email-cengelma@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F0D4260606
 for <alsa-devel@alsa-project.org>; Sat,  7 Feb 2015 23:41:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, vinod.koul@intel.com, subhransu.s.prusty@intel.com
Cc: alsa-devel@alsa-project.org, Christian Engelmayer <cengelma@gmx.at>, wsa@the-dreams.de, tiwai@suse.de, mengdong.lin@intel.com, lgirdwood@gmail.com, yang.a.fang@intel.com, yongjun_wei@trendmicro.com.cn, jarkko.nikula@linux.intel.com, kevin.strasser@linux.intel.com, fengguang.wu@intel.com
List-Id: alsa-devel@alsa-project.org

Function sst_acpi_probe() uses plain strcpy for setting member firmware_name
of a struct intel_sst_drv from member firmware of a struct sst_machines.
Thereby the destination array has got a length of 20 byte while the source may
hold 32 byte. Since eg. commit 64b9c90b8600 ("ASoC: Intel: Fix BYTCR firmware
name") increased strings from "fw_sst_0f28.bin" to "intel/fw_sst_0f28.bin"
there is an actual possibility that the 20 byte array at the end of struct
intel_sst_drv is overrun.

Thus increase the size of the destination and use the same define for both
structs. Detected by Coverity CID 1260087.

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
Compile tested only. Applies against linux-next.
---
 sound/soc/intel/sst/sst.h      | 3 ++-
 sound/soc/intel/sst/sst_acpi.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/sst/sst.h b/sound/soc/intel/sst/sst.h
index 7f4bbfc..562bc48 100644
--- a/sound/soc/intel/sst/sst.h
+++ b/sound/soc/intel/sst/sst.h
@@ -58,6 +58,7 @@ enum sst_algo_ops {
 #define SST_BLOCK_TIMEOUT	1000
 
 #define FW_SIGNATURE_SIZE	4
+#define FW_NAME_SIZE		32
 
 /* stream states */
 enum sst_stream_states {
@@ -426,7 +427,7 @@ struct intel_sst_drv {
 	 * Holder for firmware name. Due to async call it needs to be
 	 * persistent till worker thread gets called
 	 */
-	char firmware_name[20];
+	char firmware_name[FW_NAME_SIZE];
 };
 
 /* misc definitions */
diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
index 43bc1c4..0542442 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -47,7 +47,7 @@ struct sst_machines {
 	char board[32];
 	char machine[32];
 	void (*machine_quirk)(void);
-	char firmware[32];
+	char firmware[FW_NAME_SIZE];
 	struct sst_platform_info *pdata;
 
 };
-- 
1.9.1
