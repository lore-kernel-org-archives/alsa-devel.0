From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v3 1/3] mfd: cros_ec: Add commands to control codec
Date: Wed, 26 Dec 2018 15:03:15 +0800
Message-ID: <20181226070317.72022-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

Add EC host commands to control codec on EC.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
Note: This patch is merged to mfd tree for-mfd-next branch already.
But this is still needed on sound tree for-next branch in order to
compile cros_ec_codec driver.

 include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 9a9631f0559e2..fc91082d4c357 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2790,6 +2790,100 @@ struct ec_response_battery_vendor_param {
 	uint32_t value;
 } __packed;
 
+/*****************************************************************************/
+/* Commands for I2S recording on audio codec. */
+
+#define EC_CMD_CODEC_I2S 0x00BC
+
+enum ec_codec_i2s_subcmd {
+	EC_CODEC_SET_SAMPLE_DEPTH = 0x0,
+	EC_CODEC_SET_GAIN = 0x1,
+	EC_CODEC_GET_GAIN = 0x2,
+	EC_CODEC_I2S_ENABLE = 0x3,
+	EC_CODEC_I2S_SET_CONFIG = 0x4,
+	EC_CODEC_I2S_SET_TDM_CONFIG = 0x5,
+	EC_CODEC_I2S_SET_BCLK = 0x6,
+};
+
+enum ec_sample_depth_value {
+	EC_CODEC_SAMPLE_DEPTH_16 = 0,
+	EC_CODEC_SAMPLE_DEPTH_24 = 1,
+};
+
+enum ec_i2s_config {
+	EC_DAI_FMT_I2S = 0,
+	EC_DAI_FMT_RIGHT_J = 1,
+	EC_DAI_FMT_LEFT_J = 2,
+	EC_DAI_FMT_PCM_A = 3,
+	EC_DAI_FMT_PCM_B = 4,
+	EC_DAI_FMT_PCM_TDM = 5,
+};
+
+struct ec_param_codec_i2s {
+	/*
+	 * enum ec_codec_i2s_subcmd
+	 */
+	uint8_t cmd;
+	union {
+		/*
+		 * EC_CODEC_SET_SAMPLE_DEPTH
+		 * Value should be one of ec_sample_depth_value.
+		 */
+		uint8_t depth;
+
+		/*
+		 * EC_CODEC_SET_GAIN
+		 * Value should be 0~43 for both channels.
+		 */
+		struct ec_param_codec_i2s_set_gain {
+			uint8_t left;
+			uint8_t right;
+		} __packed gain;
+
+		/*
+		 * EC_CODEC_I2S_ENABLE
+		 * 1 to enable, 0 to disable.
+		 */
+		uint8_t i2s_enable;
+
+		/*
+		 * EC_CODEC_I2S_SET_COFNIG
+		 * Value should be one of ec_i2s_config.
+		 */
+		uint8_t i2s_config;
+
+		/*
+		 * EC_CODEC_I2S_SET_TDM_CONFIG
+		 * Value should be one of ec_i2s_config.
+		 */
+		struct ec_param_codec_i2s_tdm {
+			/*
+			 * 0 to 496
+			 */
+			int16_t ch0_delay;
+			/*
+			 * -1 to 496
+			 */
+			int16_t ch1_delay;
+			uint8_t adjacent_to_ch0;
+			uint8_t adjacent_to_ch1;
+		} __packed tdm_param;
+
+		/*
+		 * EC_CODEC_I2S_SET_BCLK
+		 */
+		uint32_t bclk;
+	};
+} __packed;
+
+/*
+ * For subcommand EC_CODEC_GET_GAIN.
+ */
+struct ec_response_codec_gain {
+	uint8_t left;
+	uint8_t right;
+} __packed;
+
 /*****************************************************************************/
 /* System commands */
 
-- 
2.20.1.415.g653613c723-goog
