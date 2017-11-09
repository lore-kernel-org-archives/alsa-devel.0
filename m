From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH v4 10/12] IIO: consumer: allow to set buffer sizes
Date: Thu, 9 Nov 2017 11:12:32 +0100
Message-ID: <1510222354-15290-11-git-send-email-arnaud.pouliquen@st.com>
References: <1510222354-15290-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1510222354-15290-1-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Add iio consumer API to set buffer size and watermark according
to sysfs API.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
---
V3 -> V4 changes:
 - Set only the Watermark not the buffer lenght
 - Rename functions to replace "params" with "watermark"

 drivers/iio/buffer/industrialio-buffer-cb.c | 11 +++++++++++
 include/linux/iio/consumer.h                | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 4847534..ea63c83 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -104,6 +104,17 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iio_channel_get_all_cb);
 
+int iio_channel_cb_set_buffer_watermark(struct iio_cb_buffer *cb_buff,
+					size_t watermark)
+{
+	if (!watermark)
+		return -EINVAL;
+	cb_buff->buffer.watermark = watermark;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_channel_cb_set_buffer_watermark);
+
 int iio_channel_start_all_cb(struct iio_cb_buffer *cb_buff)
 {
 	return iio_update_buffers(cb_buff->indio_dev, &cb_buff->buffer,
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 5e347a9..0d94557 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -134,6 +134,17 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 						       void *private),
 					     void *private);
 /**
+ * iio_channel_cb_set_buffer_watermark() - set the buffer watermark.
+ * @cb_buffer:		The callback buffer from whom we want the channel
+ *			information.
+ * @watermark: buffer watermark in bytes.
+ *
+ * This function allows to configure the buffer watermark.
+ */
+int iio_channel_cb_set_buffer_watermark(struct iio_cb_buffer *cb_buffer,
+					size_t watermark);
+
+/**
  * iio_channel_release_all_cb() - release and unregister the callback.
  * @cb_buffer:		The callback buffer that was allocated.
  */
-- 
2.7.4
