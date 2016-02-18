From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [RFC v4 1/8] drm/mediatek: hdmi: Add audio interface to the
 hdmi-codec driver
Date: Thu, 18 Feb 2016 15:58:39 +0100
Message-ID: <1455807526-16918-2-git-send-email-p.zabel@pengutronix.de>
References: <1455807526-16918-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1455807526-16918-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jie Qiu <jie.qiu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add the interface needed by Jyri's generic hdmi-codec driver [1] to start
or stop audio playback and to retrieve ELD (EDID like data) to limit the
supported audio formats to the HDMI sink capabilities.

[1] https://patchwork.kernel.org/patch/7215271/ ("ASoC: hdmi-codec: Add
    hdmi-codec for external HDMI-encoders")

Signed-off-by: Jie Qiu <jie.qiu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/gpu/drm/mediatek/Kconfig            |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c | 145 ++++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi.c         |  89 +++++++++--------
 drivers/gpu/drm/mediatek/mtk_hdmi.h         |  10 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_hw.c      |  94 +++---------------
 drivers/gpu/drm/mediatek/mtk_hdmi_hw.h      |   4 +-
 6 files changed, 207 insertions(+), 136 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index 829ab66..93b7ca9 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -17,6 +17,7 @@ config DRM_MEDIATEK
 config DRM_MEDIATEK_HDMI
 	tristate "DRM HDMI Support for Mediatek SoCs"
 	depends on DRM_MEDIATEK
+	select SND_SOC_HDMI_CODEC if SND_SOC
 	select GENERIC_PHY
 	help
 	  DRM/KMS HDMI driver for Mediatek SoCs
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c
index ff661e0..96ad53a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c
@@ -26,6 +26,7 @@
 #include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <sound/hdmi-codec.h>
 #include "mtk_cec.h"
 #include "mtk_hdmi.h"
 #include "mtk_hdmi_hw.h"
@@ -421,6 +422,148 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	return 0;
 }
 
+/*
+ * HDMI audio codec callbacks
+ */
+
+static int mtk_hdmi_audio_hw_params(struct device *dev,
+				    struct hdmi_codec_daifmt *daifmt,
+				    struct hdmi_codec_params *params)
+{
+	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
+	struct hdmi_audio_param hdmi_params;
+	unsigned int chan = params->cea.channels;
+
+	dev_dbg(hdmi->dev, "%s: %u Hz, %d bit, %d channels\n", __func__,
+		params->sample_rate, params->sample_width, chan);
+
+	if (!hdmi->bridge.encoder)
+		return -ENODEV;
+
+	switch (chan) {
+	case 2:
+		hdmi_params.aud_input_chan_type = HDMI_AUD_CHAN_TYPE_2_0;
+		break;
+	case 4:
+		hdmi_params.aud_input_chan_type = HDMI_AUD_CHAN_TYPE_4_0;
+		break;
+	case 6:
+		hdmi_params.aud_input_chan_type = HDMI_AUD_CHAN_TYPE_5_1;
+		break;
+	case 8:
+		hdmi_params.aud_input_chan_type = HDMI_AUD_CHAN_TYPE_7_1;
+		break;
+	default:
+		dev_err(hdmi->dev, "channel[%d] not supported!\n", chan);
+		return -EINVAL;
+	}
+
+	switch (params->sample_rate) {
+	case 32000:
+	case 44100:
+	case 48000:
+	case 88200:
+	case 96000:
+	case 176400:
+	case 192000:
+		break;
+	default:
+		dev_err(hdmi->dev, "rate[%d] not supported!\n",
+			params->sample_rate);
+		return -EINVAL;
+	}
+
+	switch (daifmt->fmt) {
+	case HDMI_I2S:
+		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
+		hdmi_params.aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+		hdmi_params.aud_input_type = HDMI_AUD_INPUT_I2S;
+		hdmi_params.aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
+		hdmi_params.aud_mclk = HDMI_AUD_MCLK_128FS;
+		break;
+	default:
+		dev_err(hdmi->dev, "%s: Invalid DAI format %d\n", __func__,
+			daifmt->fmt);
+		return -EINVAL;
+	}
+
+	memcpy(&hdmi_params.codec_params, params,
+	       sizeof(hdmi_params.codec_params));
+
+	mtk_hdmi_audio_set_param(hdmi, &hdmi_params);
+
+	return 0;
+}
+
+static int mtk_hdmi_audio_startup(struct device *dev,
+				  void (*abort_cb)(struct device *dev))
+{
+	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	mtk_hdmi_audio_enable(hdmi);
+
+	return 0;
+}
+
+static void mtk_hdmi_audio_shutdown(struct device *dev)
+{
+	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	mtk_hdmi_audio_disable(hdmi);
+}
+
+int mtk_hdmi_audio_digital_mute(struct device *dev, bool enable)
+{
+	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s(%d)\n", __func__, enable);
+
+	mtk_hdmi_hw_aud_mute(hdmi, enable);
+
+	return 0;
+}
+
+static int mtk_hdmi_audio_get_eld(struct device *dev, uint8_t *buf, size_t len)
+{
+	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	memcpy(buf, hdmi->conn.eld, min(sizeof(hdmi->conn.eld), len));
+
+	return 0;
+}
+
+static const struct hdmi_codec_ops mtk_hdmi_audio_codec_ops = {
+	.hw_params = mtk_hdmi_audio_hw_params,
+	.audio_startup = mtk_hdmi_audio_startup,
+	.audio_shutdown = mtk_hdmi_audio_shutdown,
+	.digital_mute = mtk_hdmi_audio_digital_mute,
+	.get_eld = mtk_hdmi_audio_get_eld,
+};
+
+static void mtk_hdmi_register_audio_driver(struct device *dev)
+{
+	struct hdmi_codec_pdata codec_data = {
+		.ops = &mtk_hdmi_audio_codec_ops,
+		.max_i2s_channels = 2,
+		.i2s = 1,
+	};
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
+					     PLATFORM_DEVID_AUTO, &codec_data,
+					     sizeof(codec_data));
+	if (IS_ERR(pdev))
+		return;
+
+	DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
+}
+
 static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 {
 	struct mtk_hdmi *hdmi;
@@ -452,6 +595,8 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	mtk_hdmi_register_audio_driver(dev);
+
 	hdmi->bridge.funcs = &mtk_hdmi_bridge_funcs;
 	hdmi->bridge.of_node = pdev->dev.of_node;
 	ret = drm_bridge_add(&hdmi->bridge);
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 30ec7b5..573c48b 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -197,46 +197,30 @@ static int mtk_hdmi_aud_set_input(struct mtk_hdmi *hdmi)
 static int mtk_hdmi_aud_set_src(struct mtk_hdmi *hdmi,
 				struct drm_display_mode *display_mode)
 {
+	unsigned int sample_rate = hdmi->aud_param.codec_params.sample_rate;
 	mtk_hdmi_aud_on_off_hw_ncts(hdmi, false);
 
 	if (hdmi->aud_param.aud_input_type == HDMI_AUD_INPUT_I2S) {
-		switch (hdmi->aud_param.aud_hdmi_fs) {
-		case HDMI_AUDIO_SAMPLE_FREQUENCY_32000:
-		case HDMI_AUDIO_SAMPLE_FREQUENCY_44100:
-		case HDMI_AUDIO_SAMPLE_FREQUENCY_48000:
-		case HDMI_AUDIO_SAMPLE_FREQUENCY_88200:
-		case HDMI_AUDIO_SAMPLE_FREQUENCY_96000:
+		switch (sample_rate) {
+		case 32000:
+		case 44100:
+		case 48000:
+		case 88200:
+		case 96000:
 			mtk_hdmi_hw_aud_src_off(hdmi);
 			/* mtk_hdmi_hw_aud_src_enable(hdmi, false); */
-			mtk_hdmi_hw_aud_set_mclk(
-			hdmi,
-			hdmi->aud_param.aud_mclk);
+			mtk_hdmi_hw_aud_set_mclk(hdmi,
+						 hdmi->aud_param.aud_mclk);
 			mtk_hdmi_hw_aud_aclk_inv_enable(hdmi, false);
 			break;
 		default:
 			break;
 		}
 	} else {
-		switch (hdmi->aud_param.iec_frame_fs) {
-		case HDMI_IEC_32K:
-			hdmi->aud_param.aud_hdmi_fs =
-			    HDMI_AUDIO_SAMPLE_FREQUENCY_32000;
-			mtk_hdmi_hw_aud_src_off(hdmi);
-			mtk_hdmi_hw_aud_set_mclk(hdmi,
-						 HDMI_AUD_MCLK_128FS);
-			mtk_hdmi_hw_aud_aclk_inv_enable(hdmi, false);
-			break;
-		case HDMI_IEC_48K:
-			hdmi->aud_param.aud_hdmi_fs =
-			    HDMI_AUDIO_SAMPLE_FREQUENCY_48000;
-			mtk_hdmi_hw_aud_src_off(hdmi);
-			mtk_hdmi_hw_aud_set_mclk(hdmi,
-						 HDMI_AUD_MCLK_128FS);
-			mtk_hdmi_hw_aud_aclk_inv_enable(hdmi, false);
-			break;
-		case HDMI_IEC_44K:
-			hdmi->aud_param.aud_hdmi_fs =
-			    HDMI_AUDIO_SAMPLE_FREQUENCY_44100;
+		switch (sample_rate) {
+		case 32000:
+		case 44100:
+		case 48000:
 			mtk_hdmi_hw_aud_src_off(hdmi);
 			mtk_hdmi_hw_aud_set_mclk(hdmi,
 						 HDMI_AUD_MCLK_128FS);
@@ -246,20 +230,10 @@ static int mtk_hdmi_aud_set_src(struct mtk_hdmi *hdmi,
 			break;
 		}
 	}
-	mtk_hdmi_hw_aud_set_ncts(hdmi, hdmi->aud_param.aud_hdmi_fs,
-				 display_mode->clock);
 
-	mtk_hdmi_hw_aud_src_reenable(hdmi);
-	return 0;
-}
+	mtk_hdmi_hw_aud_set_ncts(hdmi, sample_rate, display_mode->clock);
 
-static int mtk_hdmi_aud_set_chnl_status(struct mtk_hdmi *hdmi)
-{
-	mtk_hdmi_hw_aud_set_channel_status(
-		hdmi,
-	   hdmi->aud_param.hdmi_l_channel_state,
-	   hdmi->aud_param.hdmi_r_channel_state,
-	   hdmi->aud_param.aud_hdmi_fs);
+	mtk_hdmi_hw_aud_src_reenable(hdmi);
 	return 0;
 }
 
@@ -271,7 +245,8 @@ static int mtk_hdmi_aud_output_config(struct mtk_hdmi *hdmi,
 
 	mtk_hdmi_aud_set_input(hdmi);
 	mtk_hdmi_aud_set_src(hdmi, display_mode);
-	mtk_hdmi_aud_set_chnl_status(hdmi);
+	mtk_hdmi_hw_aud_set_channel_status(hdmi,
+			hdmi->aud_param.codec_params.iec.status);
 
 	usleep_range(50, 100);
 
@@ -413,15 +388,11 @@ int mtk_hdmi_output_init(struct mtk_hdmi *hdmi)
 	hdmi->csp = HDMI_COLORSPACE_RGB;
 	hdmi->output = true;
 	aud_param->aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
-	aud_param->aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_48000;
 	aud_param->aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
 	aud_param->aud_input_type = HDMI_AUD_INPUT_I2S;
 	aud_param->aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
 	aud_param->aud_mclk = HDMI_AUD_MCLK_128FS;
-	aud_param->iec_frame_fs = HDMI_IEC_48K;
 	aud_param->aud_input_chan_type = HDMI_AUD_CHAN_TYPE_2_0;
-	aud_param->hdmi_l_channel_state[2] = 2;
-	aud_param->hdmi_r_channel_state[2] = 2;
 	hdmi->init = true;
 
 	return 0;
@@ -439,6 +410,32 @@ void mtk_hdmi_power_off(struct mtk_hdmi *hdmi)
 	mtk_hdmi_hw_make_reg_writable(hdmi, false);
 }
 
+void mtk_hdmi_audio_enable(struct mtk_hdmi *hdmi)
+{
+	mtk_hdmi_aud_enable_packet(hdmi, true);
+	hdmi->audio_enable = true;
+}
+
+void mtk_hdmi_audio_disable(struct mtk_hdmi *hdmi)
+{
+	mtk_hdmi_aud_enable_packet(hdmi, false);
+	hdmi->audio_enable = false;
+}
+
+int mtk_hdmi_audio_set_param(struct mtk_hdmi *hdmi,
+			     struct hdmi_audio_param *param)
+{
+	if (!hdmi->audio_enable) {
+		dev_err(hdmi->dev, "hdmi audio is in disable state!\n");
+		return -EINVAL;
+	}
+	dev_dbg(hdmi->dev, "codec:%d, input:%d, channel:%d, fs:%d\n",
+		param->aud_codec, param->aud_input_type,
+		param->aud_input_chan_type, param->codec_params.sample_rate);
+	memcpy(&hdmi->aud_param, param, sizeof(*param));
+	return mtk_hdmi_aud_output_config(hdmi, &hdmi->mode);
+}
+
 int mtk_hdmi_output_set_display_mode(struct mtk_hdmi *hdmi,
 				     struct drm_display_mode *mode)
 {
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.h b/drivers/gpu/drm/mediatek/mtk_hdmi.h
index 9403915..832f238 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.h
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <sound/hdmi-codec.h>
 
 struct clk;
 struct device;
@@ -144,15 +145,12 @@ enum hdmi_aud_channel_swap_type {
 
 struct hdmi_audio_param {
 	enum hdmi_audio_coding_type aud_codec;
-	enum hdmi_audio_sample_frequency aud_hdmi_fs;
 	enum hdmi_audio_sample_size aud_sampe_size;
 	enum hdmi_aud_input_type aud_input_type;
 	enum hdmi_aud_i2s_fmt aud_i2s_fmt;
 	enum hdmi_aud_mclk aud_mclk;
-	enum hdmi_aud_iec_frame_rate iec_frame_fs;
 	enum hdmi_aud_channel_type aud_input_chan_type;
-	u8 hdmi_l_channel_state[6];
-	u8 hdmi_r_channel_state[6];
+	struct hdmi_codec_params codec_params;
 };
 
 struct mtk_hdmi {
@@ -201,6 +199,10 @@ int mtk_hdmi_output_set_display_mode(struct mtk_hdmi *hdmi,
 				     struct drm_display_mode *mode);
 void mtk_hdmi_power_on(struct mtk_hdmi *hdmi);
 void mtk_hdmi_power_off(struct mtk_hdmi *hdmi);
+void mtk_hdmi_audio_enable(struct mtk_hdmi *hctx);
+void mtk_hdmi_audio_disable(struct mtk_hdmi *hctx);
+int mtk_hdmi_audio_set_param(struct mtk_hdmi *hctx,
+			     struct hdmi_audio_param *param);
 #if defined(CONFIG_DEBUG_FS)
 int mtk_drm_hdmi_debugfs_init(struct mtk_hdmi *hdmi);
 void mtk_drm_hdmi_debugfs_exit(struct mtk_hdmi *hdmi);
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_hw.c b/drivers/gpu/drm/mediatek/mtk_hdmi_hw.c
index ea4e35f..6acbe77 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_hw.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_hw.c
@@ -395,90 +395,18 @@ void mtk_hdmi_hw_aud_set_input_type(struct mtk_hdmi *hdmi,
 }
 
 void mtk_hdmi_hw_aud_set_channel_status(struct mtk_hdmi *hdmi,
-					u8 *l_chan_status, u8 *r_chan_status,
-					enum hdmi_audio_sample_frequency
-					aud_hdmi_fs)
-{
-	u8 l_status[5];
-	u8 r_status[5];
-	u8 val = 0;
-
-	l_status[0] = l_chan_status[0];
-	l_status[1] = l_chan_status[1];
-	l_status[2] = l_chan_status[2];
-	r_status[0] = r_chan_status[0];
-	r_status[1] = r_chan_status[1];
-	r_status[2] = r_chan_status[2];
-
-	l_status[0] &= ~0x02;
-	r_status[0] &= ~0x02;
-
-	val = l_chan_status[3] & 0xf0;
-	switch (aud_hdmi_fs) {
-	case HDMI_AUDIO_SAMPLE_FREQUENCY_32000:
-		val |= 0x03;
-		break;
-	case HDMI_AUDIO_SAMPLE_FREQUENCY_44100:
-		break;
-	case HDMI_AUDIO_SAMPLE_FREQUENCY_88200:
-		val |= 0x08;
-		break;
-	case HDMI_AUDIO_SAMPLE_FREQUENCY_96000:
-		val |= 0x0a;
-		break;
-	case HDMI_AUDIO_SAMPLE_FREQUENCY_48000:
-		val |= 0x02;
-		break;
-	default:
-		val |= 0x02;
-		break;
-	}
-	l_status[3] = val;
-	r_status[3] = val;
-
-	val = l_chan_status[4];
-	val |= ((~(l_status[3] & 0x0f)) << 4);
-	l_status[4] = val;
-	r_status[4] = val;
-
-	val = l_status[0];
-	mtk_hdmi_write(hdmi, GRL_I2S_C_STA0, val);
-	mtk_hdmi_write(hdmi, GRL_L_STATUS_0, val);
-
-	val = r_status[0];
-	mtk_hdmi_write(hdmi, GRL_R_STATUS_0, val);
-
-	val = l_status[1];
-	mtk_hdmi_write(hdmi, GRL_I2S_C_STA1, val);
-	mtk_hdmi_write(hdmi, GRL_L_STATUS_1, val);
-
-	val = r_status[1];
-	mtk_hdmi_write(hdmi, GRL_R_STATUS_1, val);
-
-	val = l_status[2];
-	mtk_hdmi_write(hdmi, GRL_I2S_C_STA2, val);
-	mtk_hdmi_write(hdmi, GRL_L_STATUS_2, val);
-
-	val = r_status[2];
-	mtk_hdmi_write(hdmi, GRL_R_STATUS_2, val);
-
-	val = l_status[3];
-	mtk_hdmi_write(hdmi, GRL_I2S_C_STA3, val);
-	mtk_hdmi_write(hdmi, GRL_L_STATUS_3, val);
-
-	val = r_status[3];
-	mtk_hdmi_write(hdmi, GRL_R_STATUS_3, val);
-
-	val = l_status[4];
-	mtk_hdmi_write(hdmi, GRL_I2S_C_STA4, val);
-	mtk_hdmi_write(hdmi, GRL_L_STATUS_4, val);
-
-	val = r_status[4];
-	mtk_hdmi_write(hdmi, GRL_R_STATUS_4, val);
+					u8 *channel_status)
+{
+	int i;
 
-	for (val = 0; val < 19; val++) {
-		mtk_hdmi_write(hdmi, GRL_L_STATUS_5 + val * 4, 0);
-		mtk_hdmi_write(hdmi, GRL_R_STATUS_5 + val * 4, 0);
+	for (i = 0; i < 5; i++) {
+		mtk_hdmi_write(hdmi, GRL_I2S_C_STA0 + i * 4, channel_status[i]);
+		mtk_hdmi_write(hdmi, GRL_L_STATUS_0 + i * 4, channel_status[i]);
+		mtk_hdmi_write(hdmi, GRL_R_STATUS_0 + i * 4, channel_status[i]);
+	}
+	for (; i < 24; i++) {
+		mtk_hdmi_write(hdmi, GRL_L_STATUS_0 + i * 4, 0);
+		mtk_hdmi_write(hdmi, GRL_R_STATUS_0 + i * 4, 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_hw.h b/drivers/gpu/drm/mediatek/mtk_hdmi_hw.h
index 9013219..a3e1bbc 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_hw.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_hw.h
@@ -46,9 +46,7 @@ void mtk_hdmi_hw_aud_set_i2s_chan_num(struct mtk_hdmi *hdmi,
 void mtk_hdmi_hw_aud_set_input_type(struct mtk_hdmi *hdmi,
 				    enum hdmi_aud_input_type input_type);
 void mtk_hdmi_hw_aud_set_channel_status(struct mtk_hdmi *hdmi,
-					u8 *l_chan_status, u8 *r_chan_staus,
-					enum hdmi_audio_sample_frequency
-					aud_hdmi_fs);
+					u8 *channel_status);
 void mtk_hdmi_hw_aud_src_enable(struct mtk_hdmi *hdmi, bool enable);
 void mtk_hdmi_hw_aud_set_mclk(struct mtk_hdmi *hdmi, enum hdmi_aud_mclk mclk);
 void mtk_hdmi_hw_aud_src_off(struct mtk_hdmi *hdmi);
-- 
2.7.0
