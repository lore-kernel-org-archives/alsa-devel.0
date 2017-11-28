From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v5 03/13] IIO: hw_consumer: add devm_iio_hw_consumer_alloc
Date: Tue, 28 Nov 2017 16:05:47 +0100
Message-ID: <1511881557-28596-4-git-send-email-arnaud.pouliquen@st.com>
References: <1511881557-28596-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1511881557-28596-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-iio@vger.kernel.org, arnaud.pouliquen@st.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add devm_iio_hw_consumer_alloc function that calls iio_hw_consumer_free
when the device is unbound from the bus.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
V4->V5 No delta.

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
