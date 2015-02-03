From: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 07/15] drm: bridge/dw_hdmi: set ncts_atomic_write & cts_manual
Date: Tue,  3 Feb 2015 10:13:49 -0500
Message-ID: <1422976429-30212-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422975418-13302-1-git-send-email-ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Yao <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Ben Zhang <benzh-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mmind00-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The ncts_atomic_write & cts_manual bits are present when design id
equal to 0x20. After set the ncts_atomic_write, then the new N and
CTS values are only used when aud_n1 register is updated. After set
cts_manual bit, the new CTS value can set by AudCTS registers.

- write N3 ncts_atomic_write = 1
- write CTS3 CTS_manual = 1

Signed-off-by: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
Changes in v3:
- Set ncts_atomic_write & cts_manual

Changes in v2: None

 drivers/gpu/drm/bridge/dw_hdmi.c | 13 +++++++++++--
 drivers/gpu/drm/bridge/dw_hdmi.h |  6 ++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 81309df..b0b2605 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -199,8 +199,15 @@ static void hdmi_mask_writeb(struct dw_hdmi *hdmi, u8 data, unsigned int reg,
 static void hdmi_set_clock_regenerator(struct dw_hdmi *hdmi,
 				       unsigned int n, unsigned int cts)
 {
+	if (hdmi->id.design == 0x20) {
+		/* set ncts_atomic_write */
+		hdmi_writeb(hdmi, HDMI_AUD_N3_NCTS_ATOMIC_WRITE_SET,
+			    HDMI_AUD_N3);
+	}
+
 	/* Must be set/cleared first */
-	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3);
+	hdmi_modb(hdmi, HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3_CTS_MANUAL,
+		  HDMI_AUD_CTS3);
 
 	/* nshift factor = 0 */
 	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_N_SHIFT_MASK, HDMI_AUD_CTS3);
@@ -210,7 +217,9 @@ static void hdmi_set_clock_regenerator(struct dw_hdmi *hdmi,
 	hdmi_writeb(hdmi, (cts >> 8) & 0xff, HDMI_AUD_CTS2);
 	hdmi_writeb(hdmi, cts & 0xff, HDMI_AUD_CTS1);
 
-	hdmi_writeb(hdmi, (n >> 16) & 0x0f, HDMI_AUD_N3);
+	/* set n values */
+	hdmi_modb(hdmi, (n >> 16) & HDMI_AUD_N3_AUDN19_16_MASK,
+		  HDMI_AUD_N3_AUDN19_16_MASK, HDMI_AUD_N3);
 	hdmi_writeb(hdmi, (n >> 8) & 0xff, HDMI_AUD_N2);
 	hdmi_writeb(hdmi, n & 0xff, HDMI_AUD_N1);
 }
diff --git a/drivers/gpu/drm/bridge/dw_hdmi.h b/drivers/gpu/drm/bridge/dw_hdmi.h
index e4ba634..29e4bee 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.h
+++ b/drivers/gpu/drm/bridge/dw_hdmi.h
@@ -907,6 +907,12 @@ enum {
 	HDMI_PHY_I2CM_CTLINT_ADDR_ARBITRATION_POL = 0x08,
 	HDMI_PHY_I2CM_CTLINT_ADDR_ARBITRATION_MASK = 0x04,
 
+/* AUD_N3 field values */
+	HDMI_AUD_N3_NCTS_ATOMIC_WRITE_MASK = 0x80,
+	HDMI_AUD_N3_NCTS_ATOMIC_WRITE_SET = 0x80,
+	HDMI_AUD_N3_NCTS_ATOMIC_WRITE_CLEAR = 0x00,
+	HDMI_AUD_N3_AUDN19_16_MASK = 0x0f,
+
 /* AUD_CTS3 field values */
 	HDMI_AUD_CTS3_N_SHIFT_OFFSET = 5,
 	HDMI_AUD_CTS3_N_SHIFT_MASK = 0xe0,
-- 
2.1.2


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
