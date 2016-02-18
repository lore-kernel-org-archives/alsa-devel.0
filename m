From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [RFC v4 5/8] drm/mediatek: hdmi: issue notifications
Date: Thu, 18 Feb 2016 16:02:18 +0100
Message-ID: <1455807741-19122-3-git-send-email-p.zabel@pengutronix.de>
References: <1455807526-16918-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1455807526-16918-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Issue hot-plug detection, EDID update, and ELD update notifications
from the CEC and HDMI drivers.

Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/gpu/drm/mediatek/mtk_cec.c          | 11 +++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
index cba3647..c309920 100644
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
@@ -79,6 +80,12 @@ void mtk_cec_set_hpd_event(struct device *dev,
 
 	cec->hdmi_dev = hdmi_dev;
 	cec->hpd_event = hpd_event;
+
+	/* Initial notification event to set jack state */
+	if (mtk_cec_hpd_high(dev))
+		hdmi_event_connect(hdmi_dev);
+	else
+		hdmi_event_disconnect(hdmi_dev);
 }
 
 bool mtk_cec_hpd_high(struct device *dev)
@@ -160,6 +167,10 @@ static irqreturn_t mtk_cec_htplg_isr_thread(int irq, void *arg)
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
index 96ad53a..e7562fb 100644
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
 	hdmi->dvi_mode = !drm_detect_monitor_audio(edid);
 
 	drm_mode_connector_update_edid_property(conn, edid);
+	hdmi_event_new_edid(hdmi->dev, edid, sizeof(*edid));
 
 	ret = drm_add_edid_modes(conn, edid);
 	drm_edid_to_eld(conn, edid);
+	hdmi_event_new_eld(hdmi->dev, conn->eld);
 	kfree(edid);
 	return ret;
 }
-- 
2.7.0
