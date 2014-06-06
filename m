From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Show Baytrail SST DSP firmware
	details during init
Date: Fri,  6 Jun 2014 11:10:11 +0300
Message-ID: <1402042211-13842-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 06A412651E3
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 10:10:22 +0200 (CEST)
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

DSP initialization complete message IPC_IA_FW_INIT_CMPLT is a large message
carrying firmware details in mailbox. Read and show those details during
init in order to be able to get that information to QA reports.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-ipc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/intel/sst-baytrail-ipc.c b/sound/soc/intel/sst-baytrail-ipc.c
index d207b22ea330..67673a2c0f41 100644
--- a/sound/soc/intel/sst-baytrail-ipc.c
+++ b/sound/soc/intel/sst-baytrail-ipc.c
@@ -122,6 +122,26 @@ struct sst_byt_tstamp {
 	u32 channel_peak[8];
 } __packed;
 
+struct sst_byt_fw_version {
+	u8 build;
+	u8 minor;
+	u8 major;
+	u8 type;
+} __packed;
+
+struct sst_byt_fw_build_info {
+	u8 date[16];
+	u8 time[16];
+} __packed;
+
+struct sst_byt_fw_init {
+	struct sst_byt_fw_version fw_version;
+	struct sst_byt_fw_build_info build_info;
+	u16 result;
+	u8 module_id;
+	u8 debug_info;
+} __packed;
+
 /* driver internal IPC message structure */
 struct ipc_message {
 	struct list_head list;
@@ -868,6 +888,7 @@ int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 {
 	struct sst_byt *byt;
 	struct sst_fw *byt_sst_fw;
+	struct sst_byt_fw_init init;
 	int err;
 
 	dev_dbg(dev, "initialising Byt DSP IPC\n");
@@ -929,6 +950,15 @@ int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 		goto boot_err;
 	}
 
+	/* show firmware information */
+	sst_dsp_inbox_read(byt->dsp, &init, sizeof(init));
+	dev_info(byt->dev, "FW version: %02x.%02x.%02x.%02x\n",
+		 init.fw_version.major, init.fw_version.minor,
+		 init.fw_version.build, init.fw_version.type);
+	dev_info(byt->dev, "Build type: %x\n", init.fw_version.type);
+	dev_info(byt->dev, "Build date: %s %s\n",
+		 init.build_info.date, init.build_info.time);
+
 	pdata->dsp = byt;
 	byt->fw = byt_sst_fw;
 
-- 
2.0.0.rc2
