From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH RFC V2 4/5] drm: sti: connect audio driver
Date: Thu, 1 Oct 2015 18:50:20 +0200
Message-ID: <1443718221-5120-5-git-send-email-arnaud.pouliquen@st.com>
References: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id F0B9F2667EB
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 18:51:04 +0200 (CEST)
In-Reply-To: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: moinejf@free.fr, linux@arm.linux.org.uk, bcousson@baylibre.com, David Airlie <airlied@linux.ie>, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, Takashi Iwai <tiwai@suse.de>, tony@atomide.com, broonie@kernel.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

Registeur Asoc codec and implement audio bridge ops.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 184 ++++++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/sti/sti_hdmi.h |   3 +
 2 files changed, 176 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 06595e9..cf0e307 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -17,6 +17,8 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
 
+#include <sound/hdmi_drm.h>
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
@@ -109,6 +116,29 @@
 
 #define HDMI_STA_SW_RST                 BIT(1)
 
+#define HDMI_AUD_CFG_8CH		BIT(0)
+#define HDMI_AUD_CFG_SPDIF_DIV_2	BIT(1)
+#define HDMI_AUD_CFG_SPDIF_DIV_3	BIT(2)
+#define HDMI_AUD_CFG_SPDIF_CLK_DIV_4	(BIT(1) | BIT(2))
+#define HDMI_AUD_CFG_CTS_CLK_256FS	BIT(12)
+#define HDMI_AUD_CFG_DTS_INVALID	BIT(16)
+#define HDMI_AUD_CFG_ONE_BIT_INVALID	(BIT(18) | BIT(19) | BIT(20) |  BIT(21))
+#define HDMI_AUD_CFG_CH12_VALID		BIT(28)
+#define HDMI_AUD_CFG_CH34_VALID		BIT(29)
+#define HDMI_AUD_CFG_CH56_VALID		BIT(30)
+#define HDMI_AUD_CFG_CH78_VALID		BIT(31)
+
+/* sample flat mask */
+#define HDMI_SAMPLE_FLAT_NO	 0
+#define HDMI_SAMPLE_FLAT_SP0 BIT(0)
+#define HDMI_SAMPLE_FLAT_SP1 BIT(1)
+#define HDMI_SAMPLE_FLAT_SP2 BIT(2)
+#define HDMI_SAMPLE_FLAT_SP3 BIT(3)
+#define HDMI_SAMPLE_FLAT_ALL (HDMI_SAMPLE_FLAT_SP0 \
+				  | HDMI_SAMPLE_FLAT_SP1 \
+				  | HDMI_SAMPLE_FLAT_SP2 \
+				  | HDMI_SAMPLE_FLAT_SP3)
+
 #define HDMI_INFOFRAME_HEADER_TYPE(x)    (((x) & 0xff) <<  0)
 #define HDMI_INFOFRAME_HEADER_VERSION(x) (((x) & 0xff) <<  8)
 #define HDMI_INFOFRAME_HEADER_LEN(x)     (((x) & 0x0f) << 16)
@@ -380,19 +410,15 @@ static int hdmi_avi_infoframe_config(struct sti_hdmi *hdmi)
  */
 static int hdmi_audio_infoframe_config(struct sti_hdmi *hdmi)
 {
-	struct hdmi_audio_infoframe infofame;
+	struct hdmi_audio_infoframe *infoframe;
 	u8 buffer[HDMI_INFOFRAME_SIZE(AUDIO)];
 	int ret;
 
-	ret = hdmi_audio_infoframe_init(&infofame);
-	if (ret < 0) {
-		DRM_ERROR("failed to setup audio infoframe: %d\n", ret);
-		return ret;
-	}
+	DRM_DEBUG_DRIVER("enter %s\n", __func__);
 
-	infofame.channels = 2;
+	infoframe = &hdmi->audio.infoframe;
 
-	ret = hdmi_audio_infoframe_pack(&infofame, buffer, sizeof(buffer));
+	ret = hdmi_audio_infoframe_pack(infoframe, buffer, sizeof(buffer));
 	if (ret < 0) {
 		DRM_ERROR("failed to pack audio infoframe: %d\n", ret);
 		return ret;
@@ -404,6 +430,60 @@ static int hdmi_audio_infoframe_config(struct sti_hdmi *hdmi)
 }
 
 /**
+ * set audio frame rate
+ *
+ * @hdmi: pointer on the hdmi internal structure
+ *
+ */
+static int hdmi_audio_set_infoframe(struct sti_hdmi *hdmi,
+				    struct hdmi_audio_infoframe *info)
+{
+	struct hdmi_audio_n_cts n_cts;
+	int ret, audio_cfg;
+
+	DRM_DEBUG_DRIVER("enter %s\n", __func__);
+
+	hdmi->audio.infoframe = *info;
+
+	if (!hdmi->enabled)
+		return 0;
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
+	/* update N parameter */
+	ret = hdmi_audio_compute_n_cts(info->sample_frequency,
+				       hdmi->mode.clock, &n_cts);
+
+	DRM_DEBUG_DRIVER("sample_frequency= %d, pix clock = %d\n",
+			 info->sample_frequency, hdmi->mode.clock);
+	DRM_DEBUG_DRIVER("n= %d, cts = %d\n", n_cts.n, n_cts.cts);
+
+	hdmi_write(hdmi, n_cts.n, HDMI_AUDN);
+
+	return hdmi_audio_infoframe_config(hdmi);
+}
+
+/**
  * Software reset of the hdmi subsystem
  *
  * @hdmi: pointer on the hdmi internal structure
@@ -462,7 +542,6 @@ static void sti_hdmi_disable(struct drm_bridge *bridge)
 	/* Disable HDMI */
 	val &= ~HDMI_CFG_DEVICE_EN;
 	hdmi_write(hdmi, val, HDMI_CFG);
-
 	hdmi_write(hdmi, 0xffffffff, HDMI_INT_CLR);
 
 	/* Stop the phy */
@@ -567,6 +646,53 @@ static const struct drm_bridge_funcs sti_hdmi_bridge_funcs = {
 	.mode_set = sti_hdmi_set_mode,
 };
 
+static int sti_hdmi_audio_disable(struct drm_bridge *bridge)
+{
+	struct sti_hdmi *hdmi = bridge->driver_private;
+
+	DRM_DEBUG_DRIVER("enter %s\n", __func__);
+	/* mute */
+	hdmi_write(hdmi, HDMI_SAMPLE_FLAT_ALL, HDMI_SAMPLE_FLAT_MASK);
+
+	return 0;
+}
+
+static int sti_hdmi_audio_set_mode(struct drm_bridge *bridge,
+			    struct hdmi_audio_mode *mode)
+{
+	struct sti_hdmi *hdmi = bridge->driver_private;
+
+	DRM_DEBUG_DRIVER("enter %s\n", __func__);
+	hdmi_audio_set_infoframe(hdmi, &mode->infoframe);
+
+	return 0;
+}
+
+static int sti_hdmi_audio_bridge_enable(struct drm_bridge *bridge)
+{
+	struct sti_hdmi *hdmi = bridge->driver_private;
+
+	DRM_DEBUG_DRIVER("enter %s\n", __func__);
+	/* unmute */
+	hdmi_write(hdmi, HDMI_SAMPLE_FLAT_NO, HDMI_SAMPLE_FLAT_MASK);
+
+	return 0;
+}
+
+static uint8_t *sti_hdmi_audio_get_mode(struct drm_bridge *bridge)
+{
+	struct sti_hdmi *hdmi = bridge->driver_private;
+
+	return hdmi->drm_connector->eld;
+}
+
+static const struct drm_audio_bridge_funcs sti_hdmi_audio_bridge_funcs = {
+	.enable = sti_hdmi_audio_bridge_enable,
+	.disable = sti_hdmi_audio_disable,
+	.mode_set = sti_hdmi_audio_set_mode,
+	.mode_get = sti_hdmi_audio_get_mode,
+};
+
 static int sti_hdmi_connector_get_modes(struct drm_connector *connector)
 {
 	struct sti_hdmi_connector *hdmi_connector
@@ -583,6 +709,7 @@ static int sti_hdmi_connector_get_modes(struct drm_connector *connector)
 
 	count = drm_add_edid_modes(connector, edid);
 	drm_mode_connector_update_edid_property(connector, edid);
+	drm_edid_to_eld(connector, edid);
 
 	kfree(edid);
 	return count;
@@ -657,10 +784,13 @@ static void sti_hdmi_connector_destroy(struct drm_connector *connector)
 {
 	struct sti_hdmi_connector *hdmi_connector
 		= to_sti_hdmi_connector(connector);
+	struct sti_hdmi *hdmi = hdmi_connector->hdmi;
 
+	drm_bridge_remove(connector->encoder->bridge);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 	kfree(hdmi_connector);
+	hdmi->drm_connector = NULL;
 }
 
 static struct drm_connector_funcs sti_hdmi_connector_funcs = {
@@ -698,6 +828,9 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	/* Set the drm device handle */
 	hdmi->drm_dev = drm_dev;
 
+	/* initialise audio infoframe */
+	hdmi_audio_infoframe_init(&hdmi->audio.infoframe);
+
 	encoder = sti_hdmi_find_encoder(drm_dev);
 	if (!encoder)
 		goto err_adapt;
@@ -705,8 +838,6 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	connector = devm_kzalloc(dev, sizeof(*connector), GFP_KERNEL);
 	if (!connector)
 		goto err_adapt;
-
-
 	connector->hdmi = hdmi;
 
 	bridge = devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
@@ -715,8 +846,14 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 
 	bridge->driver_private = hdmi;
 	bridge->funcs = &sti_hdmi_bridge_funcs;
+	bridge->audio_funcs = &sti_hdmi_audio_bridge_funcs;
 	drm_bridge_attach(drm_dev, bridge);
 
+	bridge->of_node = dev->of_node;
+	err = drm_bridge_add(bridge);
+	if (err)
+		goto err_adapt;
+
 	encoder->bridge = bridge;
 	connector->encoder = encoder;
 
@@ -733,6 +870,8 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (err)
 		goto err_connector;
 
+	hdmi->drm_connector = drm_connector;
+
 	err = drm_mode_connector_attach_encoder(drm_connector, encoder);
 	if (err) {
 		DRM_ERROR("Failed to attach a connector to a encoder\n");
@@ -748,6 +887,8 @@ err_sysfs:
 	drm_connector_unregister(drm_connector);
 err_connector:
 	drm_connector_cleanup(drm_connector);
+	drm_bridge_remove(bridge);
+	hdmi->drm_connector = NULL;
 err_adapt:
 	put_device(&hdmi->ddc_adapt->dev);
 	return -EINVAL;
@@ -777,6 +918,25 @@ static const struct of_device_id hdmi_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, hdmi_of_match);
 
+static void sti_hdmi_register_audio_driver(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *np_child;
+	struct platform_device *pdev;
+
+	np_child = of_get_child_by_name(np, "sound-dai");
+	if (!np_child)
+		return;
+
+	pdev = platform_device_register_data(dev,
+					     HDMI_DRM_CODEC_DRV_NAME,
+					     PLATFORM_DEVID_AUTO, NULL, 0);
+	if (IS_ERR(pdev))
+		return;
+
+	DRM_INFO("%s driver bound to HDMI\n", HDMI_DRM_CODEC_DRV_NAME);
+}
+
 static int sti_hdmi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -877,6 +1037,8 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hdmi);
 
+	sti_hdmi_register_audio_driver(dev);
+
 	return component_add(&pdev->dev, &sti_hdmi_ops);
 }
 
diff --git a/drivers/gpu/drm/sti/sti_hdmi.h b/drivers/gpu/drm/sti/sti_hdmi.h
index 3d22390..54bd824 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.h
+++ b/drivers/gpu/drm/sti/sti_hdmi.h
@@ -36,6 +36,7 @@ struct hdmi_phy_ops {
  * @clk_tmds: hdmi tmds clock
  * @clk_phy: hdmi phy clock
  * @clk_audio: hdmi audio clock
+ * @audio: hdmi audio state
  * @irq: hdmi interrupt number
  * @irq_status: interrupt status register
  * @phy_ops: phy start/stop operations
@@ -55,6 +56,7 @@ struct sti_hdmi {
 	struct clk *clk_tmds;
 	struct clk *clk_phy;
 	struct clk *clk_audio;
+	struct hdmi_audio_mode audio;
 	int irq;
 	u32 irq_status;
 	struct hdmi_phy_ops *phy_ops;
@@ -64,6 +66,7 @@ struct sti_hdmi {
 	bool event_received;
 	struct reset_control *reset;
 	struct i2c_adapter *ddc_adapt;
+	struct drm_connector *drm_connector;
 };
 
 u32 hdmi_read(struct sti_hdmi *hdmi, int offset);
-- 
1.9.1
