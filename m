From: Yakir Yang <ykk@rock-chips.com>
Subject: [RFC PATCH 2/3] drm: bridge/dw_hdmi_rockchip: improve hdmi eye-diagram test
Date: Tue, 10 Feb 2015 22:18:22 +0800
Message-ID: <1423577902-19357-1-git-send-email-ykk@rock-chips.com>
References: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Russell King <rmk+kernel@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Rob Clark <robdclark@gmail.com>, Mark Yao <mark.yao@rock-chips.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sean Cross <xobs@kosagi.com>, Jyri Sarha <jsarha@ti.com>, Ben Zhang <benzh@chromium.org>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, djkurtz@chromium.org, mmind00@googlemail.com, dianders@chromium.org, marcheu@chromium.org, linux-rockchip@lists.infradead.org, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

As for 1920x1080 display resolution, we should turn on the Transmitter
Trailer-B, and adjust slopeboost to 25%-35% decrease.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index e46e1d9..51030ca 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -142,7 +142,7 @@ static const struct dw_hdmi_curr_ctrl rockchip_cur_ctr[] = {
 static const struct dw_hdmi_sym_term rockchip_sym_term[] = {
 	/*pixelclk   symbol   term*/
 	{ 74250000,  0x8009, 0x0004 },
-	{ 148500000, 0x8029, 0x0004 },
+	{ 148500000, 0x803b, 0x0004 },
 	{ 297000000, 0x8039, 0x0005 },
 	{ ~0UL,	     0x0000, 0x0000 }
 };
-- 
1.7.9.5
