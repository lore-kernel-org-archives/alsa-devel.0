From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 4/5] drm: sti: connect audio driver
Date: Mon, 21 Sep 2015 15:19:55 +0200
Message-ID: <1442841596-1323-5-git-send-email-arnaud.pouliquen@st.com>
References: <1442841596-1323-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 3A6F1261497
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 15:21:22 +0200 (CEST)
In-Reply-To: <1442841596-1323-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: moinejf@free.fr, linux@arm.linux.org.uk, Takashi Iwai <tiwai@suse.de>, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, airlied@linux.ie, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org

Add management of the audio bridge

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 146 +++++++++++++++++++++++++++++++++++++----
 drivers/gpu/drm/sti/sti_hdmi.h |   3 +
 2 files changed, 137 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 06595e9..d324e0a 100644
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
@@ -52,6 +59,7 @@
 #define HDMI_SW_DI_2_PKT_WORD5          0x0618
 #define HDMI_SW_DI_2_PKT_WORD6          0x061C
 
+
 #define HDMI_IFRAME_SLOT_AVI            1
 #define HDMI_IFRAME_SLOT_AUDIO          2
 
@@ -109,6 +117,27 @@
 
 #define HDMI_STA_SW_RST                 BIT(1)
 
+#define HDMI_AUD_CFG_8CH        BIT(0)
+#define HDMI_AUD_CFG_SPDIF_DIV_2  BIT(1)
+#define HDMI_AUD_CFG_SPDIF_DIV_3  BIT(2)
+#define HDMI_AUD_CFG_SPDIF_CLK_DIV_4 (BIT(1) | BIT(1))
+#define HDMI_AUD_CFG_CTS_CLK_128FS  BIT(17)
+#define HDMI_AUD_CFG_CH12_VALID BIT(28)
+#define HDMI_AUD_CFG_CH34_VALID BIT(29)
+#define HDMI_AUD_CFG_CH56_VALID BIT(30)
+#define HDMI_AUD_CFG_CH78_VALID BIT(31)
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
@@ -380,19 +409,13 @@ static int hdmi_avi_infoframe_config(struct sti_hdmi *hdmi)
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
-
-	infofame.channels = 2;
+	infoframe = &hdmi->audio.infoframe;
 
-	ret = hdmi_audio_infoframe_pack(&infofame, buffer, sizeof(buffer));
+	ret = hdmi_audio_infoframe_pack(infoframe, buffer, sizeof(buffer));
 	if (ret < 0) {
 		DRM_ERROR("failed to pack audio infoframe: %d\n", ret);
 		return ret;
@@ -404,6 +427,56 @@ static int hdmi_audio_infoframe_config(struct sti_hdmi *hdmi)
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
+	hdmi->audio.infoframe = *info;
+
+	if (!hdmi->enabled)
+		return 0;
+
+	/* update HDMI registers according to configuration */
+	audio_cfg = HDMI_AUD_CFG_SPDIF_DIV_3 | HDMI_AUD_CFG_CTS_CLK_128FS;
+
+	switch (info->channels) {
+	case 8:
+		audio_cfg |= HDMI_AUD_CFG_CH78_VALID;
+	case 6:
+		audio_cfg |= HDMI_AUD_CFG_CH56_VALID;
+	case 4:
+		audio_cfg |= HDMI_AUD_CFG_CH34_VALID | HDMI_AUD_CFG_8CH;
+	case 2:
+		audio_cfg = HDMI_AUD_CFG_CH12_VALID;
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
+				       hdmi->mode.clock * 1000, &n_cts);
+
+	DRM_DEBUG_DRIVER("n= %d, cts = %d\n", n_cts.n, n_cts.cts);
+
+	/* clear interrupt status */
+	hdmi_write(hdmi, n_cts.n, HDMI_AUDN);
+
+	return 0;
+}
+
+/**
  * Software reset of the hdmi subsystem
  *
  * @hdmi: pointer on the hdmi internal structure
@@ -462,7 +535,6 @@ static void sti_hdmi_disable(struct drm_bridge *bridge)
 	/* Disable HDMI */
 	val &= ~HDMI_CFG_DEVICE_EN;
 	hdmi_write(hdmi, val, HDMI_CFG);
-
 	hdmi_write(hdmi, 0xffffffff, HDMI_INT_CLR);
 
 	/* Stop the phy */
@@ -520,8 +592,9 @@ static void sti_hdmi_pre_enable(struct drm_bridge *bridge)
 		DRM_ERROR("Unable to configure AVI infoframe\n");
 
 	/* Program AUDIO infoframe */
-	if (hdmi_audio_infoframe_config(hdmi))
-		DRM_ERROR("Unable to configure AUDIO infoframe\n");
+	if (hdmi->audio.enabled)
+		if (hdmi_audio_infoframe_config(hdmi))
+			DRM_ERROR("Unable to configure AUDIO infoframe\n");
 
 	/* Sw reset */
 	hdmi_swreset(hdmi);
@@ -567,6 +640,43 @@ static const struct drm_bridge_funcs sti_hdmi_bridge_funcs = {
 	.mode_set = sti_hdmi_set_mode,
 };
 
+void sti_hdmi_audio_disable(struct drm_bridge *bridge)
+{
+	struct sti_hdmi *hdmi = bridge->driver_private;
+
+	DRM_ERROR("enter %s\n", __func__);
+	/* mute */
+	hdmi_write(hdmi, HDMI_SAMPLE_FLAT_ALL, HDMI_SAMPLE_FLAT_MASK);
+}
+
+int sti_hdmi_audio_set_mode(struct drm_bridge *bridge,
+			       struct hdmi_audio_mode *mode)
+{
+	DRM_ERROR("enter %s\n", __func__);
+	return 0;
+}
+
+void sti_hdmi_audio_pre_enable(struct drm_bridge *bridge)
+{
+	DRM_ERROR("enter %s\n", __func__);
+}
+
+void sti_hdmi_audio_bridge_enable(struct drm_bridge *bridge)
+{
+	struct sti_hdmi *hdmi = bridge->driver_private;
+
+	DRM_ERROR("enter %s\n", __func__);
+	/* unmute */
+	hdmi_write(hdmi, HDMI_SAMPLE_FLAT_NO, HDMI_SAMPLE_FLAT_MASK);
+}
+
+static const struct drm_audio_bridge_funcs sti_hdmi_audio_bridge_funcs = {
+	.pre_enable = sti_hdmi_audio_pre_enable,
+	.enable = sti_hdmi_audio_bridge_enable,
+	.disable = sti_hdmi_audio_disable,
+	.mode_set = sti_hdmi_audio_set_mode,
+};
+
 static int sti_hdmi_connector_get_modes(struct drm_connector *connector)
 {
 	struct sti_hdmi_connector *hdmi_connector
@@ -658,6 +768,7 @@ static void sti_hdmi_connector_destroy(struct drm_connector *connector)
 	struct sti_hdmi_connector *hdmi_connector
 		= to_sti_hdmi_connector(connector);
 
+	drm_bridge_remove(connector->encoder->bridge);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 	kfree(hdmi_connector);
@@ -715,8 +826,14 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 
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
 
@@ -748,6 +865,7 @@ err_sysfs:
 	drm_connector_unregister(drm_connector);
 err_connector:
 	drm_connector_cleanup(drm_connector);
+	drm_bridge_remove(bridge);
 err_adapt:
 	put_device(&hdmi->ddc_adapt->dev);
 	return -EINVAL;
@@ -877,6 +995,10 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hdmi);
 
+	/* Register audio driver */
+	if (hdmi_drm_codec_register(dev))
+		DRM_INFO("Failed to register HDMI audio driver\n");
+
 	return component_add(&pdev->dev, &sti_hdmi_ops);
 }
 
diff --git a/drivers/gpu/drm/sti/sti_hdmi.h b/drivers/gpu/drm/sti/sti_hdmi.h
index 3d22390..3b93a63 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.h
+++ b/drivers/gpu/drm/sti/sti_hdmi.h
@@ -24,6 +24,7 @@ struct hdmi_phy_ops {
 	void (*stop)(struct sti_hdmi *hdmi);
 };
 
+
 /**
  * STI hdmi structure
  *
@@ -36,6 +37,7 @@ struct hdmi_phy_ops {
  * @clk_tmds: hdmi tmds clock
  * @clk_phy: hdmi phy clock
  * @clk_audio: hdmi audio clock
+ * @audio: hdmi audio state
  * @irq: hdmi interrupt number
  * @irq_status: interrupt status register
  * @phy_ops: phy start/stop operations
@@ -55,6 +57,7 @@ struct sti_hdmi {
 	struct clk *clk_tmds;
 	struct clk *clk_phy;
 	struct clk *clk_audio;
+	struct hdmi_audio_mode audio;
 	int irq;
 	u32 irq_status;
 	struct hdmi_phy_ops *phy_ops;
-- 
1.9.1
