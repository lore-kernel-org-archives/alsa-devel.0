From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [RFC v2 1/6] drm/mediatek: hdmi: Add audio interface
	to the hdmi-codec driver
Date: Mon,  4 Jan 2016 20:09:06 +0100
Message-ID: <1451934551-21333-2-git-send-email-p.zabel@pengutronix.de>
References: <1451934551-21333-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id BB8A9260522
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2016 20:09:14 +0100 (CET)
In-Reply-To: <1451934551-21333-1-git-send-email-p.zabel@pengutronix.de>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Koro Chen <koro.chen@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Cawa Cheng <cawa.cheng@mediatek.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add the interface needed by Jyri's generic hdmi-codec driver [1] to start
or stop audio playback and to retrieve ELD (EDID like data) to limit the
supported audio formats to the HDMI sink capabilities.

[1] https://patchwork.kernel.org/patch/7215271/ ("ASoC: hdmi-codec: Add
    hdmi-codec for external HDMI-encoders")

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/mediatek/Kconfig            |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c | 189 ++++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi.c         |  26 ++++
 drivers/gpu/drm/mediatek/mtk_hdmi.h         |   4 +
 4 files changed, 220 insertions(+)

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
index 5c1ec96..1a07ef3 100644
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
@@ -437,6 +438,192 @@ static irqreturn_t hdmi_flt_n_5v_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
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
+	if (!hdmi->bridge.encoder || !hdmi->bridge.encoder->crtc)
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
+		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_32000;
+		hdmi_params.iec_frame_fs = HDMI_IEC_32K;
+		/* channel status byte 3: fs and clock accuracy */
+		hdmi_params.hdmi_l_channel_state[3] = 0x3;
+		break;
+	case 44100:
+		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_44100;
+		hdmi_params.iec_frame_fs = HDMI_IEC_44K;
+		/* channel status byte 3: fs and clock accuracy */
+		hdmi_params.hdmi_l_channel_state[3] = 0;
+		break;
+	case 48000:
+		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_48000;
+		hdmi_params.iec_frame_fs = HDMI_IEC_48K;
+		/* channel status byte 3: fs and clock accuracy */
+		hdmi_params.hdmi_l_channel_state[3] = 0x2;
+		break;
+	case 88200:
+		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_88200;
+		hdmi_params.iec_frame_fs = HDMI_IEC_88K;
+		/* channel status byte 3: fs and clock accuracy */
+		hdmi_params.hdmi_l_channel_state[3] = 0x8;
+		break;
+	case 96000:
+		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_96000;
+		hdmi_params.iec_frame_fs = HDMI_IEC_96K;
+		/* channel status byte 3: fs and clock accuracy */
+		hdmi_params.hdmi_l_channel_state[3] = 0xa;
+		break;
+	case 176400:
+		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_176400;
+		hdmi_params.iec_frame_fs = HDMI_IEC_176K;
+		/* channel status byte 3: fs and clock accuracy */
+		hdmi_params.hdmi_l_channel_state[3] = 0xc;
+		break;
+	case 192000:
+		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_192000;
+		hdmi_params.iec_frame_fs = HDMI_IEC_192K;
+		/* channel status byte 3: fs and clock accuracy */
+		hdmi_params.hdmi_l_channel_state[3] = 0xe;
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
+		dev_err(hdmi->dev, "%s: Invalid format %d\n", __func__,
+			daifmt->fmt);
+		return -EINVAL;
+	}
+
+	/* channel status */
+	/* byte 0: no copyright is asserted, mode 0 */
+	hdmi_params.hdmi_l_channel_state[0] = 1 << 2;
+	/* byte 1: category code */
+	hdmi_params.hdmi_l_channel_state[1] = 0;
+	/* byte 2: source/channel number don't take into account */
+	hdmi_params.hdmi_l_channel_state[2] = 0;
+	/* byte 4: word length 16bits */
+	hdmi_params.hdmi_l_channel_state[4] = 0x2;
+	memcpy(hdmi_params.hdmi_r_channel_state,
+	       hdmi_params.hdmi_l_channel_state,
+	       sizeof(hdmi_params.hdmi_l_channel_state));
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
@@ -485,6 +672,8 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	mtk_hdmi_register_audio_driver(dev);
+
 	hdmi->bridge.funcs = &mtk_hdmi_bridge_funcs;
 	hdmi->bridge.of_node = pdev->dev.of_node;
 	ret = drm_bridge_add(&hdmi->bridge);
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 342beab..535a4d7 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -441,6 +441,32 @@ void mtk_hdmi_power_off(struct mtk_hdmi *hdmi)
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
+	dev_info(hdmi->dev, "codec:%d, input:%d, channel:%d, fs:%d\n",
+		 param->aud_codec, param->aud_input_type,
+		 param->aud_input_chan_type, param->aud_hdmi_fs);
+	memcpy(&hdmi->aud_param, param, sizeof(*param));
+	return mtk_hdmi_aud_output_config(hdmi, &hdmi->mode);
+}
+
 int mtk_hdmi_output_set_display_mode(struct mtk_hdmi *hdmi,
 				     struct drm_display_mode *mode)
 {
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.h b/drivers/gpu/drm/mediatek/mtk_hdmi.h
index c072bcc..12e5614 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.h
@@ -211,6 +211,10 @@ int mtk_hdmi_output_set_display_mode(struct mtk_hdmi *hdmi,
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
-- 
2.6.2
