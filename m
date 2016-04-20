From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v7 4/9] video: rmk's HDMI notification prototype
Date: Wed, 20 Apr 2016 10:59:59 +0200
Message-ID: <1461142804-26728-5-git-send-email-p.zabel@pengutronix.de>
References: <1461142804-26728-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1461142804-26728-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This is Russell's HDMI notification prototype [1], currently waiting
for the HDMI CEC situation to resolve.

The use case for the notifications on MediaTek MT8173 is to let the
(dis)connection notifications control an ALSA jack object.

No Signed-off-by since this is not my code, and still up for discussion.

[1] https://patchwork.kernel.org/patch/8351501/
---
 drivers/video/Kconfig         |  3 +++
 drivers/video/Makefile        |  1 +
 drivers/video/hdmi-notifier.c | 61 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/hdmi-notifier.h | 44 +++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)
 create mode 100644 drivers/video/hdmi-notifier.c
 create mode 100644 include/linux/hdmi-notifier.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e0606c0..193649c 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -40,6 +40,9 @@ config VIDEOMODE_HELPERS
 config HDMI
 	bool
 
+config HDMI_NOTIFIERS
+	bool
+
 if VT
 	source "drivers/video/console/Kconfig"
 endif
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 9ad3c17..65f5649 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_VGASTATE)            += vgastate.o
 obj-$(CONFIG_HDMI)                += hdmi.o
+obj-$(CONFIG_HDMI_NOTIFIERS)      += hdmi-notifier.o
 
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
diff --git a/drivers/video/hdmi-notifier.c b/drivers/video/hdmi-notifier.c
new file mode 100644
index 0000000..a233359
--- /dev/null
+++ b/drivers/video/hdmi-notifier.c
@@ -0,0 +1,61 @@
+#include <linux/export.h>
+#include <linux/hdmi-notifier.h>
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
diff --git a/include/linux/hdmi-notifier.h b/include/linux/hdmi-notifier.h
new file mode 100644
index 0000000..9c5ad49
--- /dev/null
+++ b/include/linux/hdmi-notifier.h
@@ -0,0 +1,44 @@
+#ifndef LINUX_HDMI_NOTIFIER_H
+#define LINUX_HDMI_NOTIFIER_H
+
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
+
+#endif
-- 
2.8.0.rc3
