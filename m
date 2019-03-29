From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/3] ASoC: cros_ec_codec: Rename ec_response_codec_gain into ec_codec_i2s_gain
Date: Fri, 29 Mar 2019 10:56:36 -0700
Message-ID: <CAPUE2usk3unTTp+3mpL7TgZ02u9fJtB5gLTLBMfMwHErwyeOsw@mail.gmail.com>
References: <CAPUE2uti=fketJ4vJw34et_y9L_gsEUwXNDdjg0sG8Z27ir1Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPUE2uti=fketJ4vJw34et_y9L_gsEUwXNDdjg0sG8Z27ir1Hg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: enric.balletbo@collabora.com, bleung@chromium.org, groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org, broonie@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Gwendal Grignou <gwendal@chromium.org>
List-Id: alsa-devel@alsa-project.org

In preparation to update cros_ec_commands.h to match ChromeOS EC code
base, rename data structure that will be merged together.

TEST=compile.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 2 +-
 sound/soc/codecs/cros_ec_codec.c     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h
b/include/linux/mfd/cros_ec_commands.h
index fc91082d4c35..c9b58b1133e9 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2879,7 +2879,7 @@ struct ec_param_codec_i2s {
 /*
  * For subcommand EC_CODEC_GET_GAIN.
  */
-struct ec_response_codec_gain {
+struct ec_codec_i2s_gain {
 	uint8_t left;
 	uint8_t right;
 } __packed;
diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 99a3af8a15ff..87830ed5ebf4 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -38,21 +38,21 @@ static const DECLARE_TLV_DB_SCALE(ec_mic_gain_tlv,
0, 100, 0);

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

@@ -226,7 +226,7 @@ static int get_ec_mic_gain(struct
snd_soc_component *component,
 			   u8 *left, u8 *right)
 {
 	struct ec_param_codec_i2s param;
-	struct ec_response_codec_gain resp;
+	struct ec_codec_i2s_gain resp;
 	int ret;

 	param.cmd = EC_CODEC_GET_GAIN;
-- 
2.21.0.392.gf8f6787159e-goog
