From: Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH v3 02/15] drm: bridge/dw_hdmi: wrap irq control in fucntions
Date: Tue,  3 Feb 2015 10:02:21 -0500
Message-ID: <1422975741-13503-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Russell King <rmk+kernel@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Rob Clark <robdclark@gmail.com>, Mark Yao <mark.yao@rock-chips.com>, Daniel Vetter <daniel@ffwll.ch>, Yakir Yang <ykk@rock-chips.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sean Cross <xobs@kosagi.com>, Jyri Sarha <jsarha@ti.com>, Ben Zhang <benzh@chromium.org>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, djkurtz@chromium.org, dbehr@chromoum.org, mmind00@googlemail.com, dianders@chromium.org, marcheu@chromium.org, linux-rockchip@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Wrap irq control in functions, and then we can call in dw_hdmi_bind /
dw_hdmi_unbind / dw_hdmi_resume / dw_hdmi_suspend functions.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3:
- Wrap irq control in fucntions

Changes in v2: None

 drivers/gpu/drm/bridge/dw_hdmi.c | 75 ++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index dc314f5..08f10da 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -1330,6 +1330,40 @@ static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
 	hdmi_writeb(hdmi, ih_mute, HDMI_IH_MUTE);
 }
 
+static void hdmi_mute_interrupts(struct dw_hdmi *hdmi)
+{
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
+}
+
+static void hdmi_unmute_interrupts(struct dw_hdmi *hdmi)
+{
+	initialize_hdmi_ih_mutes(hdmi);
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
+}
+
 static void dw_hdmi_poweron(struct dw_hdmi *hdmi)
 {
 	dw_hdmi_setup(hdmi, &hdmi->previous_mode);
@@ -1650,25 +1684,11 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 	 */
 	hdmi_init_clk_regenerator(hdmi);
 
-	/*
-	 * Configure registers related to HDMI interrupt
-	 * generation before registering IRQ.
-	 */
-	hdmi_writeb(hdmi, HDMI_PHY_HPD, HDMI_PHY_POL0);
-
-	/* Clear Hotplug interrupts */
-	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
-
-	ret = dw_hdmi_fb_registered(hdmi);
-	if (ret)
-		goto err_iahb;
-
 	ret = dw_hdmi_register(drm, hdmi);
 	if (ret)
 		goto err_iahb;
 
-	/* Unmute interrupts */
-	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
+	hdmi_unmute_interrupts(hdmi);
 
 	dev_set_drvdata(dev, hdmi);
 
@@ -1702,17 +1722,8 @@ EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
 int dw_hdmi_suspend(struct device *dev)
 {
 	struct dw_hdmi *hdmi = dev_get_drvdata(dev);
-	u8 ih_mute;
-
-	/* Disable all interrupts */
-	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
-
-	 /* Disable top level interrupt bits in HDMI block */
-	ih_mute = hdmi_readb(hdmi, HDMI_IH_MUTE) |
-		  HDMI_IH_MUTE_MUTE_WAKEUP_INTERRUPT |
-		  HDMI_IH_MUTE_MUTE_ALL_INTERRUPT;
 
-	hdmi_writeb(hdmi, ih_mute, HDMI_IH_MUTE);
+	hdmi_mute_interrupts(hdmi);
 
 	return 0;
 }
@@ -1722,19 +1733,7 @@ int dw_hdmi_resume(struct device *dev)
 {
 	struct dw_hdmi *hdmi = dev_get_drvdata(dev);
 
-	/*
-	 * Configure registers related to HDMI interrupt
-	 * generation before registering IRQ.
-	 */
-	hdmi_writeb(hdmi, HDMI_PHY_HPD, HDMI_PHY_POL0);
-
-	/* Clear Hotplug interrupts */
-	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
-
-	dw_hdmi_fb_registered(hdmi);
-
-	/* Unmute interrupts */
-	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
+	hdmi_unmute_interrupts(hdmi);
 
 	return 0;
 }
-- 
2.1.2
