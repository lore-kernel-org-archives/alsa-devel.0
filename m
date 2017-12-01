From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH v6 03/13] IIO: hw_consumer: add devm_iio_hw_consumer_alloc
Date: Fri, 1 Dec 2017 18:40:10 +0100
Message-ID: <1512150020-20335-4-git-send-email-arnaud.pouliquen@st.com>
References: <1512150020-20335-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512150020-20335-1-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Add devm_iio_hw_consumer_alloc function that calls iio_hw_consumer_free
when the device is unbound from the bus.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
---
 drivers/iio/buffer/industrialio-hw-consumer.c | 66 +++++++++++++++++++++++++++
 include/linux/iio/hw-consumer.h               |  2 +
 2 files changed, 68 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 0253be1..e980a79 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -138,6 +138,72 @@ void iio_hw_consumer_free(struct iio_hw_consumer *hwc)
 }
 EXPORT_SYMBOL_GPL(iio_hw_consumer_free);
 
+static void devm_iio_hw_consumer_release(struct device *dev, void *res)
+{
+	iio_hw_consumer_free(*(struct iio_hw_consumer **)res);
+}
+
+static int devm_iio_hw_consumer_match(struct device *dev, void *res, void *data)
+{
+	struct iio_hw_consumer **r = res;
+
+	if (!r || !*r) {
+		WARN_ON(!r || !*r);
+		return 0;
+	}
+	return *r == data;
+}
+
+/**
+ * devm_iio_hw_consumer_alloc - Resource-managed iio_hw_consumer_alloc()
+ * @dev: Pointer to consumer device.
+ *
+ * Managed iio_hw_consumer_alloc. iio_hw_consumer allocated with this function
+ * is automatically freed on driver detach.
+ *
+ * If an iio_hw_consumer allocated with this function needs to be freed
+ * separately, devm_iio_hw_consumer_free() must be used.
+ *
+ * returns pointer to allocated iio_hw_consumer on success, NULL on failure.
+ */
+struct iio_hw_consumer *devm_iio_hw_consumer_alloc(struct device *dev)
+{
+	struct iio_hw_consumer **ptr, *iio_hwc;
+
+	ptr = devres_alloc(devm_iio_hw_consumer_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	iio_hwc = iio_hw_consumer_alloc(dev);
+	if (IS_ERR(iio_hwc)) {
+		devres_free(ptr);
+	} else {
+		*ptr = iio_hwc;
+		devres_add(dev, ptr);
+	}
+
+	return iio_hwc;
+}
+EXPORT_SYMBOL_GPL(devm_iio_hw_consumer_alloc);
+
+/**
+ * devm_iio_hw_consumer_free - Resource-managed iio_hw_consumer_free()
+ * @dev: Pointer to consumer device.
+ * @hwc: iio_hw_consumer to free.
+ *
+ * Free iio_hw_consumer allocated with devm_iio_hw_consumer_alloc().
+ */
+void devm_iio_hw_consumer_free(struct device *dev, struct iio_hw_consumer *hwc)
+{
+	int rc;
+
+	rc = devres_release(dev, devm_iio_hw_consumer_release,
+			    devm_iio_hw_consumer_match, hwc);
+	WARN_ON(rc);
+}
+EXPORT_SYMBOL_GPL(devm_iio_hw_consumer_free);
+
 /**
  * iio_hw_consumer_enable() - Enable IIO hardware consumer
  * @hwc: iio_hw_consumer to enable.
diff --git a/include/linux/iio/hw-consumer.h b/include/linux/iio/hw-consumer.h
index f16791b..90ecfce 100644
--- a/include/linux/iio/hw-consumer.h
+++ b/include/linux/iio/hw-consumer.h
@@ -14,6 +14,8 @@ struct iio_hw_consumer;
 
 struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev);
 void iio_hw_consumer_free(struct iio_hw_consumer *hwc);
+struct iio_hw_consumer *devm_iio_hw_consumer_alloc(struct device *dev);
+void devm_iio_hw_consumer_free(struct device *dev, struct iio_hw_consumer *hwc);
 int iio_hw_consumer_enable(struct iio_hw_consumer *hwc);
 void iio_hw_consumer_disable(struct iio_hw_consumer *hwc);
 
-- 
2.7.4
