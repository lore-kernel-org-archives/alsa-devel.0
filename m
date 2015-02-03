From: Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH v3 08/15] drm: bridge/dw_hdmi: add audio support for more display resolutions
Date: Tue,  3 Feb 2015 10:14:28 -0500
Message-ID: <1422976468-30259-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Russell King <rmk+kernel@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Rob Clark <robdclark@gmail.com>, Mark Yao <mark.yao@rock-chips.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sean Cross <xobs@kosagi.com>, Jyri Sarha <jsarha@ti.com>, Ben Zhang <benzh@chromium.org>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, djkurtz@chromium.org, mmind00@googlemail.com, dianders@chromium.org, marcheu@chromium.org, linux-rockchip@lists.infradead.org, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Add more n/cts values, in that case we can support audio for more
display resolutions (128 * SampleRate = PixelClock * N / CTS).

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3: None
Changes in v2:
- add more n/cts combinations for more display resolutions

 drivers/gpu/drm/bridge/dw_hdmi.c | 58 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index b0b2605..1c0515f 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -244,8 +244,24 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 	case 44100:
 		if (pixel_clk == 25170000)
 			n = 7007;
+		else if (pixel_clk == 25175000)
+			n = 28224;
+		else if (pixel_clk == 40000000)
+			n = 7056;
+		else if (pixel_clk == 54000000)
+			n = 6272;
+		else if (pixel_clk == 65000000)
+			n = 7056;
 		else if (pixel_clk == 74170000)
 			n = 17836;
+		else if (pixel_clk == 74250000)
+			n = 6272;
+		else if (pixel_clk == 83500000)
+			n = 7056;
+		else if (pixel_clk == 106500000)
+			n = 4074;
+		else if (pixel_clk == 108000000)
+			n = 4018;
 		else if (pixel_clk == 148350000)
 			n = (ratio == 150) ? 17836 : 8918;
 		else
@@ -255,10 +271,26 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
 	case 48000:
 		if (pixel_clk == 25170000)
 			n = (ratio == 150) ? 9152 : 6864;
+		else if (pixel_clk == 25175000)
+			n = 12288;
 		else if (pixel_clk == 27020000)
 			n = (ratio == 150) ? 8192 : 6144;
+		else if (pixel_clk == 40000000)
+			n = 6144;
+		else if (pixel_clk == 54000000)
+			n = 6144;
+		else if (pixel_clk == 65000000)
+			n = 6144;
 		else if (pixel_clk == 74170000)
 			n = 11648;
+		else if (pixel_clk == 74250000)
+			n = 6144;
+		else if (pixel_clk == 83500000)
+			n = 6144;
+		else if (pixel_clk == 106500000)
+			n = 6144;
+		else if (pixel_clk == 108000000)
+			n = 6144;
 		else if (pixel_clk == 148350000)
 			n = (ratio == 150) ? 11648 : 5824;
 		else
@@ -306,10 +338,18 @@ static unsigned int hdmi_compute_cts(unsigned int freq, unsigned long pixel_clk,
 	case 96000:
 	case 192000:
 		switch (pixel_clk) {
+		case 25175000:
+			cts = 50350;
+			break;
 		case 25200000:
 		case 27000000:
+		case 40000000:
 		case 54000000:
+		case 65000000:
 		case 74250000:
+		case 83500000:
+		case 106500000:
+		case 108000000:
 		case 148500000:
 			cts = pixel_clk / 1000;
 			break;
@@ -330,18 +370,36 @@ static unsigned int hdmi_compute_cts(unsigned int freq, unsigned long pixel_clk,
 	case 88200:
 	case 176400:
 		switch (pixel_clk) {
+		case 25175000:
+			cts = 125875;
+			break;
 		case 25200000:
 			cts = 28000;
 			break;
 		case 27000000:
 			cts = 30000;
 			break;
+		case 40000000:
+			cts = 50000;
+			break;
 		case 54000000:
 			cts = 60000;
 			break;
+		case 65000000:
+			cts = 81250;
+			break;
 		case 74250000:
 			cts = 82500;
 			break;
+		case 83500000:
+			cts = 104375;
+			break;
+		case 106500000:
+			cts = 88750;
+			break;
+		case 108000000:
+			cts = 76875;
+			break;
 		case 148500000:
 			cts = 165000;
 			break;
-- 
2.1.2
