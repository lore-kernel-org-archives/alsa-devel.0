From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v3 2/5] drm: bridge: dw-hdmi: Report connector status using callback
Date: Fri, 12 Jul 2019 18:04:40 +0800
Message-ID: <20190712100443.221322-3-cychiang@chromium.org>
References: <20190712100443.221322-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190712100443.221322-1-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, dgreid@chromium.org, tzungbi@chromium.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

Allow codec driver register callback function for plug event.

The callback registration flow:
dw-hdmi <--- hw-hdmi-i2s-audio <--- hdmi-codec

dw-hdmi-i2s-audio implements hook_plugged_cb op
so codec driver can register the callback.

dw-hdmi implements set_plugged_cb op so platform device can register the
callback.

When connector plug/unplug event happens, report this event using the
callback.

Make sure that audio and drm are using the single source of truth for
connector status.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 .../gpu/drm/bridge/synopsys/dw-hdmi-audio.h   |  3 +
 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   | 10 ++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 55 ++++++++++++++++++-
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
index 63b5756f463b..f523c590984e 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
@@ -2,6 +2,8 @@
 #ifndef DW_HDMI_AUDIO_H
 #define DW_HDMI_AUDIO_H
 
+#include <sound/hdmi-codec.h>
+
 struct dw_hdmi;
 
 struct dw_hdmi_audio_data {
@@ -17,6 +19,7 @@ struct dw_hdmi_i2s_audio_data {
 
 	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
 	u8 (*read)(struct dw_hdmi *hdmi, int offset);
+	int (*set_plugged_cb)(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn);
 };
 
 #endif
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 5cbb71a866d5..7b93cf05c985 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -104,10 +104,20 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
 	return -EINVAL;
 }
 
+static int dw_hdmi_i2s_hook_plugged_cb(struct device *dev, void *data,
+				       hdmi_codec_plugged_cb fn)
+{
+	struct dw_hdmi_i2s_audio_data *audio = data;
+	struct dw_hdmi *hdmi = audio->hdmi;
+
+	return audio->set_plugged_cb(hdmi, fn);
+}
+
 static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
 	.hw_params	= dw_hdmi_i2s_hw_params,
 	.audio_shutdown	= dw_hdmi_i2s_audio_shutdown,
 	.get_dai_id	= dw_hdmi_i2s_get_dai_id,
+	.hook_plugged_cb = dw_hdmi_i2s_hook_plugged_cb,
 };
 
 static int snd_dw_hdmi_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 045b1b13fd0e..ce6646067472 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -26,6 +26,8 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/bridge/dw_hdmi.h>
 
+#include <sound/hdmi-codec.h>
+
 #include <uapi/linux/media-bus-format.h>
 #include <uapi/linux/videodev2.h>
 
@@ -185,6 +187,9 @@ struct dw_hdmi {
 	void (*disable_audio)(struct dw_hdmi *hdmi);
 
 	struct cec_notifier *cec_notifier;
+
+	hdmi_codec_plugged_cb plugged_cb;
+	enum drm_connector_status last_connector_result;
 };
 
 #define HDMI_IH_PHY_STAT0_RX_SENSE \
@@ -209,6 +214,40 @@ static inline u8 hdmi_readb(struct dw_hdmi *hdmi, int offset)
 	return val;
 }
 
+static void handle_plugged_change(struct dw_hdmi *hdmi, bool plugged)
+{
+	struct platform_device *codec_pdev;
+
+	if (!hdmi->audio || IS_ERR(hdmi->audio))
+		return;
+	codec_pdev = platform_get_drvdata(hdmi->audio);
+	if (!codec_pdev || IS_ERR(codec_pdev))
+		return;
+	if (!hdmi->plugged_cb)
+		return;
+
+	hdmi->plugged_cb(&codec_pdev->dev, plugged);
+}
+
+static int hdmi_set_plugged_cb(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn)
+{
+	bool plugged;
+	struct platform_device *codec_pdev;
+
+	if (!hdmi->audio || IS_ERR(hdmi->audio))
+		return -EINVAL;
+	codec_pdev = platform_get_drvdata(hdmi->audio);
+	if (!codec_pdev || IS_ERR(codec_pdev))
+		return -EINVAL;
+
+	mutex_lock(&hdmi->mutex);
+	hdmi->plugged_cb = fn;
+	plugged = hdmi->last_connector_result == connector_status_connected;
+	handle_plugged_change(hdmi, plugged);
+	mutex_unlock(&hdmi->mutex);
+	return 0;
+}
+
 static void hdmi_modb(struct dw_hdmi *hdmi, u8 data, u8 mask, unsigned reg)
 {
 	regmap_update_bits(hdmi->regm, reg << hdmi->reg_shift, mask, data);
@@ -2044,6 +2083,7 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
 					     connector);
+	enum drm_connector_status result;
 
 	mutex_lock(&hdmi->mutex);
 	hdmi->force = DRM_FORCE_UNSPECIFIED;
@@ -2051,7 +2091,18 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	dw_hdmi_update_phy_mask(hdmi);
 	mutex_unlock(&hdmi->mutex);
 
-	return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
+	result = hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
+
+	mutex_lock(&hdmi->mutex);
+	if (result != hdmi->last_connector_result) {
+		dev_dbg(hdmi->dev, "read_hpd result: %d", result);
+		handle_plugged_change(hdmi,
+				      result == connector_status_connected);
+		hdmi->last_connector_result = result;
+	}
+	mutex_unlock(&hdmi->mutex);
+
+	return result;
 }
 
 static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
@@ -2460,6 +2511,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	hdmi->rxsense = true;
 	hdmi->phy_mask = (u8)~(HDMI_PHY_HPD | HDMI_PHY_RX_SENSE);
 	hdmi->mc_clkdis = 0x7f;
+	hdmi->last_connector_result = connector_status_disconnected;
 
 	mutex_init(&hdmi->mutex);
 	mutex_init(&hdmi->audio_mutex);
@@ -2653,6 +2705,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		audio.hdmi	= hdmi;
 		audio.write	= hdmi_writeb;
 		audio.read	= hdmi_readb;
+		audio.set_plugged_cb = hdmi_set_plugged_cb;
 		hdmi->enable_audio = dw_hdmi_i2s_audio_enable;
 		hdmi->disable_audio = dw_hdmi_i2s_audio_disable;
 
-- 
2.22.0.510.g264f2c817a-goog
