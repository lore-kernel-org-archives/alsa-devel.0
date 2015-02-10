From: Yakir Yang <ykk@rock-chips.com>
Subject: [RFC PATCH 1/3] drm: bridge/dw_hdmi: fixed codec style
Date: Tue, 10 Feb 2015 22:17:25 +0800
Message-ID: <1423577845-19301-1-git-send-email-ykk@rock-chips.com>
References: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Russell King <rmk+kernel@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Rob Clark <robdclark@gmail.com>, Mark Yao <mark.yao@rock-chips.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sean Cross <xobs@kosagi.com>, Jyri Sarha <jsarha@ti.com>, Ben Zhang <benzh@chromium.org>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, djkurtz@chromium.org, mmind00@googlemail.com, dianders@chromium.org, marcheu@chromium.org, linux-rockchip@lists.infradead.org, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

- const struct dw_hdmi_mpll_config *mpll_config =
-                                        hdmi->plat_data->mpll_cfg;
- const struct dw_hdmi_curr_ctrl *curr_ctrl = hdmi->plat_data->cur_ctr;
- const struct dw_hdmi_sym_term *sym_term =  hdmi->plat_data->sym_term;

+ const struct dw_hdmi_plat_data *plat_data = hdmi->plat_data;
+ const struct dw_hdmi_mpll_config *mpll_config = plat_data->mpll_cfg;
+ const struct dw_hdmi_curr_ctrl *curr_ctrl = plat_data->cur_ctr;
+ const struct dw_hdmi_sym_term *sym_term =  plat_data->sym_term;

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---

 drivers/gpu/drm/bridge/dw_hdmi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 14c61ee..8b3208c 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -761,10 +761,10 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
 {
 	unsigned res_idx, i;
 	u8 val, msec;
-	const struct dw_hdmi_mpll_config *mpll_config =
-						hdmi->plat_data->mpll_cfg;
-	const struct dw_hdmi_curr_ctrl *curr_ctrl = hdmi->plat_data->cur_ctr;
-	const struct dw_hdmi_sym_term *sym_term =  hdmi->plat_data->sym_term;
+	const struct dw_hdmi_plat_data *plat_data = hdmi->plat_data;
+	const struct dw_hdmi_mpll_config *mpll_config = plat_data->mpll_cfg;
+	const struct dw_hdmi_curr_ctrl *curr_ctrl = plat_data->cur_ctr;
+	const struct dw_hdmi_sym_term *sym_term =  plat_data->sym_term;
 
 	if (prep)
 		return -EINVAL;
-- 
1.7.9.5
