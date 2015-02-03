From: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 01/15] drm: bridge/dw_hdmi: add irq control to suspend/resume
Date: Tue,  3 Feb 2015 10:01:13 -0500
Message-ID: <1422975673-13456-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422975418-13302-1-git-send-email-ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Yao <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Ben Zhang <benzh-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dbehr-ph2c+iIn4itg9hUCZPvPmw@public.gmane.org, mmind00-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

when kernel enter into suspend, cpus will shutdown, hdmi registers
will reset invisibly. After kernel resume, drm core will call the
bridge enable function. All of hdmi registers will be setup again
except the interrupt registers. In that case we should mute all the
interrupt in suspend stage, and umnute the interrupt we need in the
resume stage.

Signed-off-by: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
Changes in v3:
- Clear Hotplug interrupts before dw_hdmi_fb_register

Changes in v2:
- Add irq control to suspend/resume interfaces

 drivers/gpu/drm/bridge/dw_hdmi.c | 41 ++++++++++++++++++++++++++++++++++++++++
 include/drm/bridge/dw_hdmi.h     |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index cd6a706..dc314f5 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -1699,6 +1699,47 @@ void dw_hdmi_unbind(struct device *dev, struct device *master, void *data)
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
 
+int dw_hdmi_suspend(struct device *dev)
+{
+	struct dw_hdmi *hdmi = dev_get_drvdata(dev);
+	u8 ih_mute;
+
+	/* Disable all interrupts */
+	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
+
+	 /* Disable top level interrupt bits in HDMI block */
+	ih_mute = hdmi_readb(hdmi, HDMI_IH_MUTE) |
+		  HDMI_IH_MUTE_MUTE_WAKEUP_INTERRUPT |
+		  HDMI_IH_MUTE_MUTE_ALL_INTERRUPT;
+
+	hdmi_writeb(hdmi, ih_mute, HDMI_IH_MUTE);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_suspend);
+
+int dw_hdmi_resume(struct device *dev)
+{
+	struct dw_hdmi *hdmi = dev_get_drvdata(dev);
+
+	/*
+	 * Configure registers related to HDMI interrupt
+	 * generation before registering IRQ.
+	 */
+	hdmi_writeb(hdmi, HDMI_PHY_HPD, HDMI_PHY_POL0);
+
+	/* Clear Hotplug interrupts */
+	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
+
+	dw_hdmi_fb_registered(hdmi);
+
+	/* Unmute interrupts */
+	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_resume);
+
 MODULE_AUTHOR("Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
 MODULE_AUTHOR("Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>");
 MODULE_AUTHOR("Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>");
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 5a4f490..e8cfe1c 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -53,6 +53,8 @@ struct dw_hdmi_plat_data {
 					   struct drm_display_mode *mode);
 };
 
+int dw_hdmi_resume(struct device *dev);
+int dw_hdmi_suspend(struct device *dev);
 void dw_hdmi_unbind(struct device *dev, struct device *master, void *data);
 int dw_hdmi_bind(struct device *dev, struct device *master,
 		 void *data, struct drm_encoder *encoder,
-- 
2.1.2


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
