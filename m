From: Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH v3 11/15] drm: bridge/dw_hdmi: add audio clock control interfaces
Date: Tue,  3 Feb 2015 10:16:54 -0500
Message-ID: <1422976614-30400-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Russell King <rmk+kernel@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Rob Clark <robdclark@gmail.com>, Mark Yao <mark.yao@rock-chips.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sean Cross <xobs@kosagi.com>, Jyri Sarha <jsarha@ti.com>, Ben Zhang <benzh@chromium.org>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, djkurtz@chromium.org, mmind00@googlemail.com, dianders@chromium.org, marcheu@chromium.org, linux-rockchip@lists.infradead.org, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Add audio clock enable/disable/restore interfacess, those functions
can be called concurrently on multiple different threads of execution
to change the hdmi audio enable state.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3:
- Delete hdmi_audio_config interface and modify audio clock control functions

Changes in v2:
- Add audio config interfaces to dw_hdmi driver

 drivers/gpu/drm/bridge/dw_hdmi.c | 60 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 44e95f3..92fc12d 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/hdmi.h>
+#include <linux/mutex.h>
 #include <linux/of_device.h>
 
 #include <drm/drm_of.h>
@@ -146,6 +147,9 @@ struct dw_hdmi {
 	void __iomem *regs;
 
 	unsigned int sample_rate;
+	struct mutex audio_mutex;
+	bool audio_enable;
+
 	int ratio;
 
 	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
@@ -1234,6 +1238,53 @@ static void dw_hdmi_phy_disable(struct dw_hdmi *hdmi)
 	hdmi->phy_enabled = false;
 }
 
+static void dw_hdmi_audio_clk_enable(struct dw_hdmi *hdmi)
+{
+	hdmi_modb(hdmi, 0, HDMI_MC_CLKDIS_AUDCLK_DISABLE, HDMI_MC_CLKDIS);
+}
+
+static void dw_hdmi_audio_clk_disable(struct dw_hdmi *hdmi)
+{
+	hdmi_modb(hdmi, HDMI_MC_CLKDIS_AUDCLK_DISABLE,
+			HDMI_MC_CLKDIS_AUDCLK_DISABLE, HDMI_MC_CLKDIS);
+}
+
+static void hdmi_audio_restore(struct dw_hdmi *hdmi)
+{
+	mutex_lock(&hdmi->audio_mutex);
+
+	if (hdmi->audio_enable)
+		dw_hdmi_audio_clk_enable(hdmi);
+	else
+		dw_hdmi_audio_clk_disable(hdmi);
+
+	mutex_unlock(&hdmi->audio_mutex);
+}
+
+static void hdmi_audio_enable(struct dw_hdmi *hdmi)
+{
+	mutex_lock(&hdmi->audio_mutex);
+
+	if (!hdmi->audio_enable) {
+		hdmi->audio_enable = true;
+		dw_hdmi_audio_clk_enable(hdmi);
+	}
+
+	mutex_unlock(&hdmi->audio_mutex);
+}
+
+static void hdmi_audio_disable(struct dw_hdmi *hdmi)
+{
+	mutex_lock(&hdmi->audio_mutex);
+
+	if (hdmi->audio_enable) {
+		hdmi->audio_enable = false;
+		dw_hdmi_audio_clk_disable(hdmi);
+	}
+
+	mutex_unlock(&hdmi->audio_mutex);
+}
+
 /* HDMI Initialization Step B.4 */
 static void dw_hdmi_enable_video_path(struct dw_hdmi *hdmi)
 {
@@ -1264,11 +1315,6 @@ static void dw_hdmi_enable_video_path(struct dw_hdmi *hdmi)
 	}
 }
 
-static void hdmi_enable_audio_clk(struct dw_hdmi *hdmi)
-{
-	hdmi_modb(hdmi, 0, HDMI_MC_CLKDIS_AUDCLK_DISABLE, HDMI_MC_CLKDIS);
-}
-
 /* Workaround to clear the overflow condition */
 static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
 {
@@ -1364,7 +1410,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 
 		/* HDMI Initialization Step E - Configure audio */
 		hdmi_clk_regenerator_update_pixel_clock(hdmi);
-		hdmi_enable_audio_clk(hdmi);
+		hdmi_audio_restore(hdmi);
 
 		/* HDMI Initialization Step F - Configure AVI InfoFrame */
 		hdmi_config_AVI(hdmi);
@@ -1758,6 +1804,8 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 	hdmi->sample_rate = 48000;
 	hdmi->ratio = 100;
 	hdmi->encoder = encoder;
+	hdmi->audio_enable = false;
+	mutex_init(&hdmi->audio_mutex);
 
 	of_property_read_u32(np, "reg-io-width", &val);
 
-- 
2.1.2
