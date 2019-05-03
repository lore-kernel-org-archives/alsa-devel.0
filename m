From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 22/30] mfd: cros_ec: Add Smart Battery
	Firmware update API
Date: Fri,  3 May 2019 15:02:25 -0700
Message-ID: <20190503220233.64546-23-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33E7EF8974B
 for <alsa-devel@alsa-project.org>; Sat,  4 May 2019 00:03:20 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id h1so3352853pgs.2
 for <alsa-devel@alsa-project.org>; Fri, 03 May 2019 15:03:20 -0700 (PDT)
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: enric.balletbo@collabora.com, bleung@chromium.org, groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org, broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc: linux-iio@vger.kernel.org, alsa-devel@alsa-project.org, Gwendal Grignou <gwendal@chromium.org>
List-Id: alsa-devel@alsa-project.org

Add API to update battery firmware.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 73 ++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 7f98c6e63ad1..49ea905cfd18 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4243,6 +4243,79 @@ struct ec_response_battery_vendor_param {
 	uint32_t value;
 } __ec_align4;
 
+/*****************************************************************************/
+/*
+ * Smart Battery Firmware Update Commands
+ */
+#define EC_CMD_SB_FW_UPDATE 0x00B5
+
+enum ec_sb_fw_update_subcmd {
+	EC_SB_FW_UPDATE_PREPARE  = 0x0,
+	EC_SB_FW_UPDATE_INFO     = 0x1, /*query sb info */
+	EC_SB_FW_UPDATE_BEGIN    = 0x2, /*check if protected */
+	EC_SB_FW_UPDATE_WRITE    = 0x3, /*check if protected */
+	EC_SB_FW_UPDATE_END      = 0x4,
+	EC_SB_FW_UPDATE_STATUS   = 0x5,
+	EC_SB_FW_UPDATE_PROTECT  = 0x6,
+	EC_SB_FW_UPDATE_MAX      = 0x7,
+};
+
+#define SB_FW_UPDATE_CMD_WRITE_BLOCK_SIZE 32
+#define SB_FW_UPDATE_CMD_STATUS_SIZE 2
+#define SB_FW_UPDATE_CMD_INFO_SIZE 8
+
+struct ec_sb_fw_update_header {
+	uint16_t subcmd;  /* enum ec_sb_fw_update_subcmd */
+	uint16_t fw_id;   /* firmware id */
+} __ec_align4;
+
+struct ec_params_sb_fw_update {
+	struct ec_sb_fw_update_header hdr;
+	union {
+		/* EC_SB_FW_UPDATE_PREPARE  = 0x0 */
+		/* EC_SB_FW_UPDATE_INFO     = 0x1 */
+		/* EC_SB_FW_UPDATE_BEGIN    = 0x2 */
+		/* EC_SB_FW_UPDATE_END      = 0x4 */
+		/* EC_SB_FW_UPDATE_STATUS   = 0x5 */
+		/* EC_SB_FW_UPDATE_PROTECT  = 0x6 */
+		/* Those have no args */
+
+		/* EC_SB_FW_UPDATE_WRITE    = 0x3 */
+		struct __ec_align4 {
+			uint8_t  data[SB_FW_UPDATE_CMD_WRITE_BLOCK_SIZE];
+		} write;
+	};
+} __ec_align4;
+
+struct ec_response_sb_fw_update {
+	union {
+		/* EC_SB_FW_UPDATE_INFO     = 0x1 */
+		struct __ec_align1 {
+			uint8_t data[SB_FW_UPDATE_CMD_INFO_SIZE];
+		} info;
+
+		/* EC_SB_FW_UPDATE_STATUS   = 0x5 */
+		struct __ec_align1 {
+			uint8_t data[SB_FW_UPDATE_CMD_STATUS_SIZE];
+		} status;
+	};
+} __ec_align1;
+
+/*
+ * Entering Verified Boot Mode Command
+ * Default mode is VBOOT_MODE_NORMAL if EC did not receive this command.
+ * Valid Modes are: normal, developer, and recovery.
+ */
+#define EC_CMD_ENTERING_MODE 0x00B6
+
+struct ec_params_entering_mode {
+	int vboot_mode;
+} __ec_align4;
+
+#define VBOOT_MODE_NORMAL    0
+#define VBOOT_MODE_DEVELOPER 1
+#define VBOOT_MODE_RECOVERY  2
+
 /*****************************************************************************/
 /*
  * HDMI CEC commands
-- 
2.21.0.1020.gf2820cf01a-goog
