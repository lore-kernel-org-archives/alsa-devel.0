From: Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 23/30] mfd: cros_ec: Add I2C passthru protection API
Date: Mon,  3 Jun 2019 11:33:54 -0700
Message-ID: <20190603183401.151408-24-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: enric.balletbo@collabora.com, bleung@chromium.org, groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org, broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com, fabien.lahoudere@collabora.com
Cc: linux-iio@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
List-Id: alsa-devel@alsa-project.org

Prevent direct i2c access to device behind EC when not in development mode.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 49ea905cfd18..59ad6bae3f9b 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4316,6 +4316,28 @@ struct ec_params_entering_mode {
 #define VBOOT_MODE_DEVELOPER 1
 #define VBOOT_MODE_RECOVERY  2
 
+/*****************************************************************************/
+/*
+ * I2C passthru protection command: Protects I2C tunnels against access on
+ * certain addresses (board-specific).
+ */
+#define EC_CMD_I2C_PASSTHRU_PROTECT 0x00B7
+
+enum ec_i2c_passthru_protect_subcmd {
+	EC_CMD_I2C_PASSTHRU_PROTECT_STATUS = 0x0,
+	EC_CMD_I2C_PASSTHRU_PROTECT_ENABLE = 0x1,
+};
+
+struct ec_params_i2c_passthru_protect {
+	uint8_t subcmd;
+	uint8_t port;		/* I2C port number */
+} __ec_align1;
+
+struct ec_response_i2c_passthru_protect {
+	uint8_t status;		/* Status flags (0: unlocked, 1: locked) */
+} __ec_align1;
+
+
 /*****************************************************************************/
 /*
  * HDMI CEC commands
-- 
2.21.0.1020.gf2820cf01a-goog
