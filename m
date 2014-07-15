From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v2] ASoC: Intel: Update FW version readback
Date: Tue, 15 Jul 2014 08:51:12 +0800
Message-ID: <1405385472-32743-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BFFC2650A4
 for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2014 02:51:53 +0200 (CEST)
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
Cc: mengdong.lin@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Update FW version readback. IPC_GLB_GET_FW_VERSION reads back
the ABI version whilst the release version is in the mailbox.
Update to use mailbox version for info logging.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 4342363..96373ab 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -183,7 +183,7 @@ struct sst_hsw_ipc_fw_ready {
 	u32 inbox_size;
 	u32 outbox_size;
 	u32 fw_info_size;
-	u8 fw_info[1];
+	u8 fw_info[IPC_MAX_MAILBOX_BYTES - 5 * sizeof(u32)];
 } __attribute__((packed));
 
 struct ipc_message {
@@ -569,6 +569,9 @@ static void hsw_fw_ready(struct sst_hsw *hsw, u32 header)
 {
 	struct sst_hsw_ipc_fw_ready fw_ready;
 	u32 offset;
+	u8 fw_info[IPC_MAX_MAILBOX_BYTES - 5 * sizeof(u32)];
+	char *tmp[5], *pinfo;
+	int i = 0;
 
 	offset = (header & 0x1FFFFFFF) << 3;
 
@@ -589,6 +592,19 @@ static void hsw_fw_ready(struct sst_hsw *hsw, u32 header)
 		fw_ready.inbox_offset, fw_ready.inbox_size);
 	dev_dbg(hsw->dev, " mailbox downstream 0x%x - size 0x%x\n",
 		fw_ready.outbox_offset, fw_ready.outbox_size);
+	if (fw_ready.fw_info_size < sizeof(fw_ready.fw_info)) {
+		fw_ready.fw_info[fw_ready.fw_info_size] = 0;
+		dev_dbg(hsw->dev, " Firmware info: %s \n", fw_ready.fw_info);
+
+		/* log the FW version info got from the mailbox here. */
+		memcpy(fw_info, fw_ready.fw_info, fw_ready.fw_info_size);
+		pinfo = &fw_info[0];
+		for (i = 0; i < sizeof(tmp) / sizeof(char *); i++)
+			tmp[i] = strsep(&pinfo, " ");
+		dev_info(hsw->dev, "FW loaded, mailbox readback FW info: type %s, - "
+			"version: %s.%s, build %s, source commit id: %s\n",
+			tmp[0], tmp[1], tmp[2], tmp[3], tmp[4]);
+	}
 }
 
 static void hsw_notification_work(struct work_struct *work)
@@ -1775,8 +1791,6 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 
 	/* get the FW version */
 	sst_hsw_fw_get_version(hsw, &version);
-	dev_info(hsw->dev, "FW loaded: type %d - version: %d.%d build %d\n",
-		version.type, version.major, version.minor, version.build);
 
 	/* get the globalmixer */
 	ret = sst_hsw_mixer_get_info(hsw);
-- 
1.8.3.2
