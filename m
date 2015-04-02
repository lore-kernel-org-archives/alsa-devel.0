From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC v2 07/13] drm: bridge/dw_hdmi: introduce
 interface to setting sample rate
Date: Thu, 02 Apr 2015 10:21:51 +0100
Message-ID: <E1YdbJv-00085A-82@rmk-PC.arm.linux.org.uk>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 8201426562C
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 11:22:01 +0200 (CEST)
In-Reply-To: <20150402092050.GH24899@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, David Airlie <airlied@linux.ie>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Introduce dw_hdmi_set_sample_rate(), which allows us to configure the
audio sample rate, setting the CTS/N values appropriately.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 10 ++++++++++
 include/drm/bridge/dw_hdmi.h     |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 75728ba552d0..0369fab5c695 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -366,6 +366,16 @@ static void hdmi_clk_regenerator_update_pixel_clock(struct dw_hdmi *hdmi)
 	mutex_unlock(&hdmi->audio_mutex);
 }
 
+void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate)
+{
+	mutex_lock(&hdmi->audio_mutex);
+	hdmi->sample_rate = rate;
+	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock,
+				 hdmi->sample_rate, hdmi->ratio);
+	mutex_unlock(&hdmi->audio_mutex);
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_rate);
+
 /*
  * this submodule is responsible for the video data synchronization.
  * for example, for RGB 4:4:4 input, the data map is defined as
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index de13bfc35634..763af51e1d60 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -12,6 +12,8 @@
 
 #include <drm/drmP.h>
 
+struct dw_hdmi;
+
 enum {
 	DW_HDMI_RES_8,
 	DW_HDMI_RES_10,
@@ -59,4 +61,7 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 		 void *data, struct drm_encoder *encoder,
 		 struct resource *iores, int irq,
 		 const struct dw_hdmi_plat_data *plat_data);
+
+void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
+
 #endif /* __IMX_HDMI_H__ */
-- 
1.8.3.1
