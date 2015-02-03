From: Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH v3 03/15] drm: rockchip/dw_hdmi_rockchip: add resume/suspend support
Date: Tue,  3 Feb 2015 10:08:59 -0500
Message-ID: <1422976139-30024-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Russell King <rmk+kernel@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Rob Clark <robdclark@gmail.com>, Mark Yao <mark.yao@rock-chips.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sean Cross <xobs@kosagi.com>, Jyri Sarha <jsarha@ti.com>, Ben Zhang <benzh@chromium.org>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, djkurtz@chromium.org, mmind00@googlemail.com, dianders@chromium.org, marcheu@chromium.org, linux-rockchip@lists.infradead.org, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3:
- Setting the .pm member instead of suspend/resume

Changes in v2:
- Add suspend/resume support for dw_hdmi_rockchip driver

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index d236faa..fc1d02e 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -323,11 +323,27 @@ static int dw_hdmi_rockchip_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int dw_hdmi_rockchip_suspend(struct device *dev)
+{
+	return dw_hdmi_suspend(dev);
+}
+
+static int dw_hdmi_rockchip_resume(struct device *dev)
+{
+	return dw_hdmi_resume(dev);
+}
+
+static const struct dev_pm_ops dw_hdmi_rockchip_pm = {
+	.resume = dw_hdmi_rockchip_resume,
+	.suspend = dw_hdmi_rockchip_suspend,
+};
+
 static struct platform_driver dw_hdmi_rockchip_pltfm_driver = {
 	.probe  = dw_hdmi_rockchip_probe,
 	.remove = dw_hdmi_rockchip_remove,
 	.driver = {
 		.name = "dwhdmi-rockchip",
+		.pm = &dw_hdmi_rockchip_pm,
 		.of_match_table = dw_hdmi_rockchip_dt_ids,
 	},
 };
-- 
2.1.2
