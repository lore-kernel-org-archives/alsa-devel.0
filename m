From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 24/30] mfd: cros_ec: Update I2S API
Date: Thu, 25 Apr 2019 09:33:34 -0700
Message-ID: <20190425163334.123710-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19D24F80C41
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2019 18:33:50 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id j11so154773pff.13
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2019 09:33:50 -0700 (PDT)
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

Improve I2S API.
Rename ec_response_codec_gain into ec_codec_i2s_gain,
update caller accordlingly.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v2:
- Change only cros_ec_codec.c as well, to fix compilation error and
  prevent bisection pain.

 include/linux/mfd/cros_ec_commands.h | 44 +++++++++++++---------------
 sound/soc/codecs/cros_ec_codec.c     |  8 ++---
 2 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 59ad6bae3f9b..c1fe64c0957b 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4417,6 +4417,7 @@ enum mkbp_cec_event {
 /* Commands for I2S recording on audio codec. */
 
 #define EC_CMD_CODEC_I2S 0x00BC
+#define EC_WOV_I2S_SAMPLE_RATE 48000
 
 enum ec_codec_i2s_subcmd {
 	EC_CODEC_SET_SAMPLE_DEPTH = 0x0,
@@ -4426,6 +4427,7 @@ enum ec_codec_i2s_subcmd {
 	EC_CODEC_I2S_SET_CONFIG = 0x4,
 	EC_CODEC_I2S_SET_TDM_CONFIG = 0x5,
 	EC_CODEC_I2S_SET_BCLK = 0x6,
+	EC_CODEC_I2S_SUBCMD_COUNT = 0x7,
 };
 
 enum ec_sample_depth_value {
@@ -4442,6 +4444,21 @@ enum ec_i2s_config {
 	EC_DAI_FMT_PCM_TDM = 5,
 };
 
+/*
+ * For subcommand EC_CODEC_GET_GAIN.
+ */
+struct __ec_align1 ec_codec_i2s_gain {
+	uint8_t left;
+	uint8_t right;
+};
+
+struct __ec_todo_unpacked ec_param_codec_i2s_tdm {
+	int16_t ch0_delay; /* 0 to 496 */
+	int16_t ch1_delay; /* -1 to 496 */
+	uint8_t adjacent_to_ch0;
+	uint8_t adjacent_to_ch1;
+};
+
 struct __ec_todo_packed ec_param_codec_i2s {
 	/* enum ec_codec_i2s_subcmd */
 	uint8_t cmd;
@@ -4456,10 +4473,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
 		 * EC_CODEC_SET_GAIN
 		 * Value should be 0~43 for both channels.
 		 */
-		struct __ec_align1 ec_param_codec_i2s_set_gain {
-			uint8_t left;
-			uint8_t right;
-		} gain;
+		struct ec_codec_i2s_gain gain;
 
 		/*
 		 * EC_CODEC_I2S_ENABLE
@@ -4468,7 +4482,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
 		uint8_t i2s_enable;
 
 		/*
-		 * EC_CODEC_I2S_SET_COFNIG
+		 * EC_CODEC_I2S_SET_CONFIG
 		 * Value should be one of ec_i2s_config.
 		 */
 		uint8_t i2s_config;
@@ -4477,18 +4491,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
 		 * EC_CODEC_I2S_SET_TDM_CONFIG
 		 * Value should be one of ec_i2s_config.
 		 */
-		struct __ec_todo_unpacked ec_param_codec_i2s_tdm {
-			/*
-			 * 0 to 496
-			 */
-			int16_t ch0_delay;
-			/*
-			 * -1 to 496
-			 */
-			int16_t ch1_delay;
-			uint8_t adjacent_to_ch0;
-			uint8_t adjacent_to_ch1;
-		} tdm_param;
+		struct ec_param_codec_i2s_tdm tdm_param;
 
 		/*
 		 * EC_CODEC_I2S_SET_BCLK
@@ -4497,13 +4500,6 @@ struct __ec_todo_packed ec_param_codec_i2s {
 	};
 };
 
-/*
- * For subcommand EC_CODEC_GET_GAIN.
- */
-struct ec_response_codec_gain {
-	uint8_t left;
-	uint8_t right;
-} __ec_align1;
 
 /*****************************************************************************/
 /* System commands */
diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 99a3af8a15ff..87830ed5ebf4 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -38,21 +38,21 @@ static const DECLARE_TLV_DB_SCALE(ec_mic_gain_tlv, 0, 100, 0);
 
 static int ec_command_get_gain(struct snd_soc_component *component,
 			       struct ec_param_codec_i2s *param,
-			       struct ec_response_codec_gain *resp)
+			       struct ec_codec_i2s_gain *resp)
 {
 	struct cros_ec_codec_data *codec_data =
 		snd_soc_component_get_drvdata(component);
 	struct cros_ec_device *ec_device = codec_data->ec_device;
 	u8 buffer[sizeof(struct cros_ec_command) +
 		  max(sizeof(struct ec_param_codec_i2s),
-		      sizeof(struct ec_response_codec_gain))];
+		      sizeof(struct ec_codec_i2s_gain))];
 	struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
 	int ret;
 
 	msg->version = 0;
 	msg->command = EC_CMD_CODEC_I2S;
 	msg->outsize = sizeof(struct ec_param_codec_i2s);
-	msg->insize = sizeof(struct ec_response_codec_gain);
+	msg->insize = sizeof(struct ec_codec_i2s_gain);
 
 	memcpy(msg->data, param, msg->outsize);
 
@@ -226,7 +226,7 @@ static int get_ec_mic_gain(struct snd_soc_component *component,
 			   u8 *left, u8 *right)
 {
 	struct ec_param_codec_i2s param;
-	struct ec_response_codec_gain resp;
+	struct ec_codec_i2s_gain resp;
 	int ret;
 
 	param.cmd = EC_CODEC_GET_GAIN;
-- 
2.20.1
