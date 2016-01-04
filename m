From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [RFC v2 5/6] drm/mediatek: hdmi: issue notifications
Date: Mon,  4 Jan 2016 20:18:59 +0100
Message-ID: <1451935139-24814-1-git-send-email-p.zabel@pengutronix.de>
References: <1451934551-21333-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 9615226062B
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2016 20:19:01 +0100 (CET)
In-Reply-To: <1451934551-21333-1-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jean-Francois Moine <moinejf@free.fr>, Koro Chen <koro.chen@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Cawa Cheng <cawa.cheng@mediatek.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

Issue hot-plug detection, EDID update, and ELD update notifications
from the CEC and HDMI drivers.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/mediatek/mtk_cec.c          | 5 +++++
 drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
index cba3647..7c4ee7a 100644
--- a/drivers/gpu/drm/mediatek/mtk_cec.c
+++ b/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -13,6 +13,7 @@
  */
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/hdmi-not.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
@@ -160,6 +161,10 @@ static irqreturn_t mtk_cec_htplg_isr_thread(int irq, void *arg)
 	if (cec->hpd != hpd) {
 		dev_info(dev, "hotplug event!,cur hpd = %d, hpd = %d\n",
 			 cec->hpd, hpd);
+		if (hpd)
+			hdmi_event_connect(cec->hdmi_dev);
+		else
+			hdmi_event_disconnect(cec->hdmi_dev);
 		cec->hpd = hpd;
 		if (cec->hpd_event)
 			cec->hpd_event(hpd, cec->hdmi_dev);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c
index 1a07ef3..06544ee 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c
@@ -17,6 +17,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
 #include <linux/clk.h>
+#include <linux/hdmi-not.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
@@ -122,9 +123,11 @@ static int mtk_hdmi_conn_get_modes(struct drm_connector *conn)
 	hdmi->dvi_mode = !drm_detect_hdmi_monitor(edid);
 
 	drm_mode_connector_update_edid_property(conn, edid);
+	hdmi_event_new_edid(hdmi->dev, edid, sizeof(*edid));
 
 	ret = drm_add_edid_modes(conn, edid);
 	drm_edid_to_eld(conn, edid);
+	hdmi_event_new_eld(hdmi->dev, conn->eld);
 	kfree(edid);
 	return ret;
 }
-- 
2.6.2
