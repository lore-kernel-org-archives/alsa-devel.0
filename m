From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 03/11] drm: bridge/dw_hdmi: simplify
 hdmi_config_AVI() a little
Date: Mon, 30 Mar 2015 20:40:11 +0100
Message-ID: <E1YcfXf-0002ue-If@rmk-PC.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id A1BA92605D3
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 21:40:16 +0200 (CEST)
In-Reply-To: <20150330193911.GM24899@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, David Airlie <airlied@linux.ie>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

When a YCBCR format is selected, we can merely copy the colorimetry
information directly as we use the same definitions for both the
unpacked AVI info frame and the hdmi_data_info structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 44c63883db19..fd02a220ad5b 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -944,10 +944,7 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
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
