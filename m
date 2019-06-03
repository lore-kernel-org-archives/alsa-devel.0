From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 3/7] drm/bridge/synopsys: dw-hdmi: Add HDMI notifier support
Date: Mon,  3 Jun 2019 12:32:47 +0800
Message-ID: <20190603043251.226549-4-cychiang@chromium.org>
References: <20190603043251.226549-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190603043251.226549-1-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, dgreid@chromium.org, tzungbi@chromium.org, linux-media@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kern
List-Id: alsa-devel@alsa-project.org

Use hdmi-notifier to notify codec driver that there is HDMI plug/unplug
event.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 drivers/gpu/drm/bridge/synopsys/Kconfig   |  1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 28 +++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
index 3cc53b44186e..43192d9d7357 100644
--- a/drivers/gpu/drm/bridge/synopsys/Kconfig
+++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
@@ -3,6 +3,7 @@ config DRM_DW_HDMI
 	select DRM_KMS_HELPER
 	select REGMAP_MMIO
 	select CEC_CORE if CEC_NOTIFIER
+	select HDMI_NOTIFIERS
 
 config DRM_DW_HDMI_AHB_AUDIO
 	tristate "Synopsys Designware AHB Audio interface"
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index ab7968c8f6a2..53701921eb1f 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/hdmi.h>
+#include <linux/hdmi-notifier.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
@@ -190,6 +191,7 @@ struct dw_hdmi {
 	void (*disable_audio)(struct dw_hdmi *hdmi);
 
 	struct cec_notifier *cec_notifier;
+	struct hdmi_notifier *hdmi_notifier;
 };
 
 #define HDMI_IH_PHY_STAT0_RX_SENSE \
@@ -2301,8 +2303,15 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 	}
 
 	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
-		dev_dbg(hdmi->dev, "EVENT=%s\n",
-			phy_int_pol & HDMI_PHY_HPD ? "plugin" : "plugout");
+		if (phy_int_pol & HDMI_PHY_HPD) {
+			dev_dbg(hdmi->dev, "EVENT=plugin\n");
+			if (hdmi->hdmi_notifier)
+				hdmi_event_connect(hdmi->hdmi_notifier);
+		} else {
+			dev_dbg(hdmi->dev, "EVENT=plugout\n");
+			if (hdmi->hdmi_notifier)
+				hdmi_event_disconnect(hdmi->hdmi_notifier);
+		}
 		if (hdmi->bridge.dev)
 			drm_helper_hpd_irq_event(hdmi->bridge.dev);
 	}
@@ -2606,6 +2615,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		goto err_iahb;
 	}
 
+	hdmi->hdmi_notifier = hdmi_notifier_get(dev);
+	if (!hdmi->hdmi_notifier) {
+		ret = -ENOMEM;
+		goto err_iahb;
+	}
+
 	/*
 	 * To prevent overflows in HDMI_IH_FC_STAT2, set the clk regenerator
 	 * N and cts values before enabling phy
@@ -2696,6 +2711,9 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	if (hdmi->cec_notifier)
 		cec_notifier_put(hdmi->cec_notifier);
 
+	if (hdmi->hdmi_notifier)
+		hdmi_notifier_put(hdmi->hdmi_notifier);
+
 	clk_disable_unprepare(hdmi->iahb_clk);
 	if (hdmi->cec_clk)
 		clk_disable_unprepare(hdmi->cec_clk);
@@ -2709,6 +2727,9 @@ __dw_hdmi_probe(struct platform_device *pdev,
 
 static void __dw_hdmi_remove(struct dw_hdmi *hdmi)
 {
+	if (hdmi->hdmi_notifier)
+		hdmi_event_disconnect(hdmi->hdmi_notifier);
+
 	if (hdmi->audio && !IS_ERR(hdmi->audio))
 		platform_device_unregister(hdmi->audio);
 	if (!IS_ERR(hdmi->cec))
@@ -2720,6 +2741,9 @@ static void __dw_hdmi_remove(struct dw_hdmi *hdmi)
 	if (hdmi->cec_notifier)
 		cec_notifier_put(hdmi->cec_notifier);
 
+	if (hdmi->hdmi_notifier)
+		hdmi_notifier_put(hdmi->hdmi_notifier);
+
 	clk_disable_unprepare(hdmi->iahb_clk);
 	clk_disable_unprepare(hdmi->isfr_clk);
 	if (hdmi->cec_clk)
-- 
2.22.0.rc1.257.g3120a18244-goog
