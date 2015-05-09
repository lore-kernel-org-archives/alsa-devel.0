From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 05/13] drm: bridge/dw_hdmi: simplify hdmi_config_AVI() a little
Date: Sat, 09 May 2015 11:26:16 +0100
Message-ID: <E1Yr1xY-0006ko-R9@rmk-PC.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150509102501.GO2067@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, David Airlie <airlied@linux.ie>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

When a YCBCR format is selected, we can merely copy the colorimetry
information directly as we use the same definitions for both the
unpacked AVI info frame and the hdmi_data_info structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 0f3ccfa3ccfc..a8bd3fbf4300 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -943,10 +943,7 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 			frame.extended_colorimetry =
 				HDMI_EXTENDED_COLORIMETRY_XV_YCC_709;
 	} else if (hdmi->hdmi_data.enc_out_format != RGB) {
-		if (hdmi->hdmi_data.colorimetry == HDMI_COLORIMETRY_ITU_601)
-			frame.colorimetry = HDMI_COLORIMETRY_ITU_601;
-		else /*hdmi->hdmi_data.colorimetry == HDMI_COLORIMETRY_ITU_709*/
-			frame.colorimetry = HDMI_COLORIMETRY_ITU_709;
+		frame.colorimetry = hdmi->hdmi_data.colorimetry;
 		frame.extended_colorimetry = HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
 	} else { /* Carries no data */
 		frame.colorimetry = HDMI_COLORIMETRY_NONE;
-- 
1.8.3.1
