From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC v2 4/6] drm: sti: Add ASoC generic hdmi codec
	support.
Date: Fri, 22 Jan 2016 18:48:30 +0100
Message-ID: <1453484912-24547-5-git-send-email-arnaud.pouliquen@st.com>
References: <1453484912-24547-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D93DE2604AF
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 18:49:00 +0100 (CET)
In-Reply-To: <1453484912-24547-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, arnaud.pouliquen@st.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add the interface needed by Jyri's generic hdmi-codec driver [1].

[1] https://patchwork.kernel.org/patch/7215271/ ("ASoC: hdmi-codec: Add
        hdmi-codec for external HDMI-encoders")

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/gpu/drm/sti/Kconfig    |   1 +
 drivers/gpu/drm/sti/sti_hdmi.c | 248 ++++++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/sti/sti_hdmi.h |  10 ++
 3 files changed, 242 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/sti/Kconfig b/drivers/gpu/drm/sti/Kconfig
index 10c1b19..d739938 100644
--- a/drivers/gpu/drm/sti/Kconfig
+++ b/drivers/gpu/drm/sti/Kconfig
@@ -7,5 +7,6 @@ config DRM_STI
 	select DRM_KMS_CMA_HELPER
 	select DRM_PANEL
 	select FW_LOADER
+	select SND_SOC_HDMI_CODEC if SND_SOC
 	help
 	  Choose this option to enable DRM on STM stiH41x chipset
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index cd50156..9c69f78 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -17,6 +17,8 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
 
+#include <sound/hdmi-codec.h>
+
 #include "sti_hdmi.h"
 #include "sti_hdmi_tx3g4c28phy.h"
 #include "sti_hdmi_tx3g0c55phy.h"
@@ -34,6 +36,8 @@
 #define HDMI_DFLT_CHL0_DAT              0x0110
 #define HDMI_DFLT_CHL1_DAT              0x0114
 #define HDMI_DFLT_CHL2_DAT              0x0118
+#define HDMI_AUDIO_CFG                  0x0200
+#define HDMI_SPDIF_FIFO_STATUS          0x0204
 #define HDMI_SW_DI_1_HEAD_WORD          0x0210
 #define HDMI_SW_DI_1_PKT_WORD0          0x0214
 #define HDMI_SW_DI_1_PKT_WORD1          0x0218
@@ -43,6 +47,9 @@
 #define HDMI_SW_DI_1_PKT_WORD5          0x0228
 #define HDMI_SW_DI_1_PKT_WORD6          0x022C
 #define HDMI_SW_DI_CFG                  0x0230
+#define HDMI_SAMPLE_FLAT_MASK           0x0244
+#define HDMI_AUDN                       0x0400
+#define HDMI_AUD_CTS                    0x0404
 #define HDMI_SW_DI_2_HEAD_WORD          0x0600
 #define HDMI_SW_DI_2_PKT_WORD0          0x0604
 #define HDMI_SW_DI_2_PKT_WORD1          0x0608
@@ -91,6 +98,7 @@
 #define HDMI_INT_DLL_LCK                BIT(5)
 #define HDMI_INT_NEW_FRAME              BIT(6)
 #define HDMI_INT_GENCTRL_PKT            BIT(7)
+#define HDMI_INT_AUDIO_FIFO_XRUN        BIT(8)
 #define HDMI_INT_SINK_TERM_PRESENT      BIT(11)
 
 #define HDMI_DEFAULT_INT (HDMI_INT_SINK_TERM_PRESENT \
@@ -99,6 +107,7 @@
 			| HDMI_INT_GLOBAL)
 
 #define HDMI_WORKING_INT (HDMI_INT_SINK_TERM_PRESENT \
+			| HDMI_INT_AUDIO_FIFO_XRUN \
 			| HDMI_INT_GENCTRL_PKT \
 			| HDMI_INT_NEW_FRAME \
 			| HDMI_INT_DLL_LCK \
@@ -109,6 +118,27 @@
 
 #define HDMI_STA_SW_RST                 BIT(1)
 
+#define HDMI_AUD_CFG_8CH		BIT(0)
+#define HDMI_AUD_CFG_SPDIF_DIV_2	BIT(1)
+#define HDMI_AUD_CFG_SPDIF_DIV_3	BIT(2)
+#define HDMI_AUD_CFG_SPDIF_CLK_DIV_4	(BIT(1) | BIT(2))
+#define HDMI_AUD_CFG_CTS_CLK_256FS	BIT(12)
+#define HDMI_AUD_CFG_DTS_INVALID	BIT(16)
+#define HDMI_AUD_CFG_ONE_BIT_INVALID	(BIT(18) | BIT(19) | BIT(20) |  BIT(21))
+#define HDMI_AUD_CFG_CH12_VALID	BIT(28)
+#define HDMI_AUD_CFG_CH34_VALID	BIT(29)
+#define HDMI_AUD_CFG_CH56_VALID	BIT(30)
+#define HDMI_AUD_CFG_CH78_VALID	BIT(31)
+
+/* sample flat mask */
+#define HDMI_SAMPLE_FLAT_NO	 0
+#define HDMI_SAMPLE_FLAT_SP0 BIT(0)
+#define HDMI_SAMPLE_FLAT_SP1 BIT(1)
+#define HDMI_SAMPLE_FLAT_SP2 BIT(2)
+#define HDMI_SAMPLE_FLAT_SP3 BIT(3)
+#define HDMI_SAMPLE_FLAT_ALL (HDMI_SAMPLE_FLAT_SP0 | HDMI_SAMPLE_FLAT_SP1  |\
+			      HDMI_SAMPLE_FLAT_SP2 | HDMI_SAMPLE_FLAT_SP3)
+
 #define HDMI_INFOFRAME_HEADER_TYPE(x)    (((x) & 0xff) <<  0)
 #define HDMI_INFOFRAME_HEADER_VERSION(x) (((x) & 0xff) <<  8)
 #define HDMI_INFOFRAME_HEADER_LEN(x)     (((x) & 0x0f) << 16)
@@ -157,6 +187,10 @@ static irqreturn_t hdmi_irq_thread(int irq, void *arg)
 		wake_up_interruptible(&hdmi->wait_event);
 	}
 
+	/* Audio FIFO underrun IRQ */
+	if (hdmi->irq_status & HDMI_INT_AUDIO_FIFO_XRUN)
+		DRM_ERROR("audio FIFO underrun occurs");
+
 	return IRQ_HANDLED;
 }
 
@@ -380,26 +414,29 @@ static int hdmi_avi_infoframe_config(struct sti_hdmi *hdmi)
  */
 static int hdmi_audio_infoframe_config(struct sti_hdmi *hdmi)
 {
-	struct hdmi_audio_infoframe infofame;
+	struct hdmi_audio_params *audio = &hdmi->audio;
 	u8 buffer[HDMI_INFOFRAME_SIZE(AUDIO)];
-	int ret;
-
-	ret = hdmi_audio_infoframe_init(&infofame);
-	if (ret < 0) {
-		DRM_ERROR("failed to setup audio infoframe: %d\n", ret);
-		return ret;
-	}
-
-	infofame.channels = 2;
-
-	ret = hdmi_audio_infoframe_pack(&infofame, buffer, sizeof(buffer));
-	if (ret < 0) {
-		DRM_ERROR("failed to pack audio infoframe: %d\n", ret);
-		return ret;
+	int ret, val;
+
+	DRM_DEBUG_DRIVER("enter %s, AIF %s\n", __func__,
+			 audio->enabled ? "enable" : "disable");
+	if (audio->enabled) {
+		/* set audio parameters stored*/
+		ret = hdmi_audio_infoframe_pack(&audio->cea, buffer,
+						sizeof(buffer));
+		if (ret < 0) {
+			DRM_ERROR("failed to pack audio infoframe: %d\n", ret);
+			return ret;
+		}
+		hdmi_infoframe_write_infopack(hdmi, buffer);
+	} else {
+		/*disable audio info frame transmission */
+		val = hdmi_read(hdmi, HDMI_SW_DI_CFG);
+		val &= ~HDMI_IFRAME_CFG_DI_N(HDMI_IFRAME_MASK,
+					     HDMI_IFRAME_SLOT_AUDIO);
+		hdmi_write(hdmi, val, HDMI_SW_DI_CFG);
 	}
 
-	hdmi_infoframe_write_infopack(hdmi, buffer);
-
 	return 0;
 }
 
@@ -583,6 +620,7 @@ static int sti_hdmi_connector_get_modes(struct drm_connector *connector)
 
 	count = drm_add_edid_modes(connector, edid);
 	drm_mode_connector_update_edid_property(connector, edid);
+	drm_edid_to_eld(connector, edid);
 
 	kfree(edid);
 	return count;
@@ -686,6 +724,167 @@ static struct drm_encoder *sti_hdmi_find_encoder(struct drm_device *dev)
 	return NULL;
 }
 
+/**
+ * set audio  info frame
+ *
+ * @hdmi: pointer on the hdmi internal structure
+ *
+ */
+static int hdmi_audio_configure(struct sti_hdmi *hdmi,
+				struct hdmi_audio_params *params)
+{
+	int audio_cfg, n;
+	struct hdmi_audio_infoframe *info = &params->cea;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	if (!hdmi->enabled)
+		return 0;
+
+	/* update N parameter */
+	n = hdmi_audio_get_non_coherent_n(params->sample_rate);
+
+	DRM_DEBUG_DRIVER("audio rate = %d Hz, TMDS clock = %d Hz, n = %d\n",
+			 params->sample_rate, hdmi->mode.clock * 1000, n);
+	hdmi_write(hdmi, n, HDMI_AUDN);
+
+	/* update HDMI registers according to configuration */
+	audio_cfg = HDMI_AUD_CFG_SPDIF_DIV_2 | HDMI_AUD_CFG_DTS_INVALID |
+		    HDMI_AUD_CFG_ONE_BIT_INVALID;
+
+	switch (info->channels) {
+	case 8:
+		audio_cfg |= HDMI_AUD_CFG_CH78_VALID;
+	case 6:
+		audio_cfg |= HDMI_AUD_CFG_CH56_VALID;
+	case 4:
+		audio_cfg |= HDMI_AUD_CFG_CH34_VALID | HDMI_AUD_CFG_8CH;
+	case 2:
+		audio_cfg |= HDMI_AUD_CFG_CH12_VALID;
+		break;
+	default:
+		DRM_ERROR("ERROR: Unsupported number of channels (%d)!\n",
+			  info->channels);
+		return -EINVAL;
+	}
+
+	hdmi_write(hdmi, audio_cfg, HDMI_AUDIO_CFG);
+
+	hdmi->audio = *params;
+
+	return hdmi_audio_infoframe_config(hdmi);
+}
+
+static void hdmi_audio_shutdown(struct device *dev)
+{
+	struct sti_hdmi *hdmi = dev_get_drvdata(dev);
+	int audio_cfg;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	/* disable audio */
+	audio_cfg = HDMI_AUD_CFG_SPDIF_DIV_2 | HDMI_AUD_CFG_DTS_INVALID |
+		    HDMI_AUD_CFG_ONE_BIT_INVALID;
+	hdmi_write(hdmi, audio_cfg, HDMI_AUDIO_CFG);
+
+	hdmi->audio.enabled = 0;
+	hdmi_audio_infoframe_config(hdmi);
+}
+
+static int hdmi_audio_hw_params(struct device *dev,
+				struct hdmi_codec_daifmt *daifmt,
+				struct hdmi_codec_params *params)
+{
+	struct sti_hdmi *hdmi = dev_get_drvdata(dev);
+	int ret;
+	struct hdmi_audio_params audio = {
+		.sample_width = params->sample_width,
+		.sample_rate = params->sample_rate,
+		.cea = params->cea,
+	};
+
+	DRM_DEBUG_DRIVER("\n");
+
+	if (!hdmi->enabled)
+		return 0;
+
+	if ((daifmt->fmt != HDMI_I2S) || daifmt->bit_clk_inv ||
+	    daifmt->frame_clk_inv || daifmt->bit_clk_master ||
+	    daifmt->frame_clk_master) {
+		dev_err(dev, "%s: Bad flags %d %d %d %d\n", __func__,
+			daifmt->bit_clk_inv, daifmt->frame_clk_inv,
+			daifmt->bit_clk_master,
+			daifmt->frame_clk_master);
+		return -EINVAL;
+	}
+
+	audio.enabled = 1;
+
+	ret = hdmi_audio_configure(hdmi, &audio);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int hdmi_audio_digital_mute(struct device *dev, bool enable)
+{
+	struct sti_hdmi *hdmi = dev_get_drvdata(dev);
+
+	DRM_DEBUG_DRIVER("%s\n", enable ? "enable" : "disable");
+
+	if (enable)
+		hdmi_write(hdmi, HDMI_SAMPLE_FLAT_ALL, HDMI_SAMPLE_FLAT_MASK);
+	else
+		hdmi_write(hdmi, HDMI_SAMPLE_FLAT_NO, HDMI_SAMPLE_FLAT_MASK);
+
+	return 0;
+}
+
+static int hdmi_audio_get_eld(struct device *dev, uint8_t *buf, size_t len)
+{
+	struct sti_hdmi *hdmi = dev_get_drvdata(dev);
+	struct drm_connector *connector = hdmi->drm_connector;
+
+	DRM_DEBUG_DRIVER("\n");
+	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+
+	return 0;
+}
+
+static const struct hdmi_codec_ops audio_codec_ops = {
+	.hw_params = hdmi_audio_hw_params,
+	.audio_shutdown = hdmi_audio_shutdown,
+	.digital_mute = hdmi_audio_digital_mute,
+	.get_eld = hdmi_audio_get_eld,
+};
+
+static int sti_hdmi_register_audio_driver(struct device *dev,
+					  struct sti_hdmi *hdmi)
+{
+	struct hdmi_codec_pdata codec_data = {
+		.ops = &audio_codec_ops,
+		.max_i2s_channels = 8,
+		.i2s = 1,
+		.iec_ctl = 1
+	};
+
+	DRM_DEBUG_DRIVER("\n");
+
+	hdmi->audio.enabled = 0;
+
+	hdmi->audio_pdev = platform_device_register_data(
+		dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
+		&codec_data, sizeof(codec_data));
+
+	if (IS_ERR(hdmi->audio_pdev))
+		return PTR_ERR(hdmi->audio_pdev);
+
+	DRM_INFO("%s driver bound %s\n", HDMI_CODEC_DRV_NAME, dev_name(dev));
+
+	return 0;
+}
+
 static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct sti_hdmi *hdmi = dev_get_drvdata(dev);
@@ -733,12 +932,23 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (err)
 		goto err_connector;
 
+	hdmi->drm_connector = drm_connector;
+
 	err = drm_mode_connector_attach_encoder(drm_connector, encoder);
 	if (err) {
 		DRM_ERROR("Failed to attach a connector to a encoder\n");
 		goto err_sysfs;
 	}
 
+	err = sti_hdmi_register_audio_driver(dev, hdmi);
+	if (err) {
+		DRM_ERROR("Failed to attach an audio codec\n");
+		goto err_sysfs;
+	}
+
+	/* initialise audio infoframe */
+	hdmi_audio_infoframe_init(&hdmi->audio.cea);
+
 	/* Enable default interrupts */
 	hdmi_write(hdmi, HDMI_DEFAULT_INT, HDMI_INT_EN);
 
@@ -746,6 +956,7 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 
 err_sysfs:
 	drm_connector_unregister(drm_connector);
+	hdmi->drm_connector = NULL;
 err_connector:
 	drm_connector_cleanup(drm_connector);
 
@@ -895,6 +1106,9 @@ static int sti_hdmi_remove(struct platform_device *pdev)
 	struct sti_hdmi *hdmi = dev_get_drvdata(&pdev->dev);
 
 	i2c_put_adapter(hdmi->ddc_adapt);
+
+	if (hdmi->audio_pdev)
+		platform_device_unregister(hdmi->audio_pdev);
 	component_del(&pdev->dev, &sti_hdmi_ops);
 
 	return 0;
diff --git a/drivers/gpu/drm/sti/sti_hdmi.h b/drivers/gpu/drm/sti/sti_hdmi.h
index 3d22390..afc4927 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.h
+++ b/drivers/gpu/drm/sti/sti_hdmi.h
@@ -24,6 +24,13 @@ struct hdmi_phy_ops {
 	void (*stop)(struct sti_hdmi *hdmi);
 };
 
+struct hdmi_audio_params {
+	bool enabled;
+	unsigned sample_width;
+	unsigned sample_rate;
+	struct hdmi_audio_infoframe cea;
+};
+
 /**
  * STI hdmi structure
  *
@@ -64,6 +71,9 @@ struct sti_hdmi {
 	bool event_received;
 	struct reset_control *reset;
 	struct i2c_adapter *ddc_adapt;
+	struct platform_device *audio_pdev;
+	struct hdmi_audio_params audio;
+	struct drm_connector *drm_connector;
 };
 
 u32 hdmi_read(struct sti_hdmi *hdmi, int offset);
-- 
1.9.1
