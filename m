From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [RFC v4 4/8] video: rmk's HDMI notification prototype
Date: Thu, 18 Feb 2016 16:02:17 +0100
Message-ID: <1455807741-19122-2-git-send-email-p.zabel@pengutronix.de>
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

This is extracted from Russell's food for thought HDMI notification
prototype [1]. I've put it into drivers/video for the time being because
my kernels don't have drivers/cec yet.

The current use case for the notifications on MediaTek MT8173 is to
let the (dis)connection notifications control an ALSA jack object.

Still no Signed-off-by, this patch is not supposed to be merged.

[1] https://patchwork.kernel.org/patch/7339011/
---
 drivers/video/Makefile   |  2 +-
 drivers/video/hdmi-not.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hdmi-not.h | 39 +++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/hdmi-not.c
 create mode 100644 include/linux/hdmi-not.h

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 9ad3c17..bf25760 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_VGASTATE)            += vgastate.o
-obj-$(CONFIG_HDMI)                += hdmi.o
+obj-$(CONFIG_HDMI)                += hdmi.o hdmi-not.o
 
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
diff --git a/drivers/video/hdmi-not.c b/drivers/video/hdmi-not.c
new file mode 100644
index 0000000..ba3be8a
--- /dev/null
+++ b/drivers/video/hdmi-not.c
@@ -0,0 +1,61 @@
+#include <linux/export.h>
+#include <linux/hdmi-not.h>
+#include <linux/notifier.h>
+#include <linux/string.h>
+
+static BLOCKING_NOTIFIER_HEAD(hdmi_notifier);
+
+int hdmi_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&hdmi_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(hdmi_register_notifier);
+
+int hdmi_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&hdmi_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(hdmi_unregister_notifier);
+
+void hdmi_event_connect(struct device *dev)
+{
+	struct hdmi_event_base base;
+
+	base.source = dev;
+
+	blocking_notifier_call_chain(&hdmi_notifier, HDMI_CONNECTED, &base);
+}
+EXPORT_SYMBOL_GPL(hdmi_event_connect);
+
+void hdmi_event_disconnect(struct device *dev)
+{
+	struct hdmi_event_base base;
+
+	base.source = dev;
+
+	blocking_notifier_call_chain(&hdmi_notifier, HDMI_DISCONNECTED, &base);
+}
+EXPORT_SYMBOL_GPL(hdmi_event_disconnect);
+
+void hdmi_event_new_edid(struct device *dev, const void *edid, size_t size)
+{
+	struct hdmi_event_new_edid new_edid;
+
+	new_edid.base.source = dev;
+	new_edid.edid = edid;
+	new_edid.size = size;
+
+	blocking_notifier_call_chain(&hdmi_notifier, HDMI_NEW_EDID, &new_edid);
+}
+EXPORT_SYMBOL_GPL(hdmi_event_new_edid);
+
+void hdmi_event_new_eld(struct device *dev, const void *eld)
+{
+	struct hdmi_event_new_eld new_eld;
+
+	new_eld.base.source = dev;
+	memcpy(new_eld.eld, eld, sizeof(new_eld.eld));
+
+	blocking_notifier_call_chain(&hdmi_notifier, HDMI_NEW_ELD, &new_eld);
+}
+EXPORT_SYMBOL_GPL(hdmi_event_new_eld);
diff --git a/include/linux/hdmi-not.h b/include/linux/hdmi-not.h
new file mode 100644
index 0000000..940ece45
--- /dev/null
+++ b/include/linux/hdmi-not.h
@@ -0,0 +1,39 @@
+#include <linux/types.h>
+
+enum {
+	HDMI_CONNECTED,
+	HDMI_DISCONNECTED,
+	HDMI_NEW_EDID,
+	HDMI_NEW_ELD,
+};
+
+struct hdmi_event_base {
+	struct device *source;
+};
+
+struct hdmi_event_new_edid {
+	struct hdmi_event_base base;
+	const void *edid;
+	size_t size;
+};
+
+struct hdmi_event_new_eld {
+	struct hdmi_event_base base;
+	unsigned char eld[128];
+};
+
+union hdmi_event {
+	struct hdmi_event_base base;
+	struct hdmi_event_new_edid edid;
+	struct hdmi_event_new_eld eld;
+};
+
+struct notifier_block;
+
+int hdmi_register_notifier(struct notifier_block *nb);
+int hdmi_unregister_notifier(struct notifier_block *nb);
+
+void hdmi_event_connect(struct device *dev);
+void hdmi_event_disconnect(struct device *dev);
+void hdmi_event_new_edid(struct device *dev, const void *edid, size_t size);
+void hdmi_event_new_eld(struct device *dev, const void *eld);
-- 
2.7.0
