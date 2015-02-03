From: Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH v3 05/15] drm: bridge/dw_hdmi: combine hdmi_set_clock_regenerator_n() and hdmi_regenerate_cts()
Date: Tue,  3 Feb 2015 10:12:20 -0500
Message-ID: <1422976340-30118-1-git-send-email-ykk@rock-chips.com>
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
- Combine hdmi_set_clock_regenerator_n() and hdmi_regenerate_cts()

Changes in v2: None

 drivers/gpu/drm/bridge/dw_hdmi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 7b5b664..262163f 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -196,19 +196,16 @@ static void hdmi_mask_writeb(struct dw_hdmi *hdmi, u8 data, unsigned int reg,
 	hdmi_modb(hdmi, data << shift, mask, reg);
 }
 
-static void hdmi_set_clock_regenerator_n(struct dw_hdmi *hdmi,
-					 unsigned int value)
+static void hdmi_set_clock_regenerator(struct dw_hdmi *hdmi,
+				       unsigned int n, unsigned int cts)
 {
-	hdmi_writeb(hdmi, value & 0xff, HDMI_AUD_N1);
-	hdmi_writeb(hdmi, (value >> 8) & 0xff, HDMI_AUD_N2);
-	hdmi_writeb(hdmi, (value >> 16) & 0x0f, HDMI_AUD_N3);
+	hdmi_writeb(hdmi, n & 0xff, HDMI_AUD_N1);
+	hdmi_writeb(hdmi, (n >> 8) & 0xff, HDMI_AUD_N2);
+	hdmi_writeb(hdmi, (n >> 16) & 0x0f, HDMI_AUD_N3);
 
 	/* nshift factor = 0 */
 	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_N_SHIFT_MASK, HDMI_AUD_CTS3);
-}
 
-static void hdmi_regenerate_cts(struct dw_hdmi *hdmi, unsigned int cts)
-{
 	/* Must be set/cleared first */
 	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3);
 
@@ -374,8 +371,7 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
 		__func__, hdmi->sample_rate, hdmi->ratio,
 		pixel_clk, clk_n, clk_cts);
 
-	hdmi_set_clock_regenerator_n(hdmi, clk_n);
-	hdmi_regenerate_cts(hdmi, clk_cts);
+	hdmi_set_clock_regenerator(hdmi, clk_n, clk_cts);
 }
 
 static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
-- 
2.1.2
