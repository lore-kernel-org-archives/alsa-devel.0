From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH v5 04/13] IIO: inkern: API for manipulating channel attributes
Date: Tue, 28 Nov 2017 16:05:48 +0100
Message-ID: <1511881557-28596-5-git-send-email-arnaud.pouliquen@st.com>
References: <1511881557-28596-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511881557-28596-1-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Extend the inkern API with functions for reading and writing
attribute of iio channels.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
---
 drivers/iio/inkern.c         | 18 +++++++++++++-----
 include/linux/iio/consumer.h | 26 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 069defc..f2e7824 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -664,9 +664,8 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 }
 EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
 
-static int iio_read_channel_attribute(struct iio_channel *chan,
-				      int *val, int *val2,
-				      enum iio_chan_info_enum attribute)
+int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
+			       enum iio_chan_info_enum attribute)
 {
 	int ret;
 
@@ -682,6 +681,8 @@ static int iio_read_channel_attribute(struct iio_channel *chan,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iio_read_channel_attribute);
+
 
 int iio_read_channel_offset(struct iio_channel *chan, int *val, int *val2)
 {
@@ -850,7 +851,8 @@ static int iio_channel_write(struct iio_channel *chan, int val, int val2,
 						chan->channel, val, val2, info);
 }
 
-int iio_write_channel_raw(struct iio_channel *chan, int val)
+int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
+				enum iio_chan_info_enum attribute)
 {
 	int ret;
 
@@ -860,12 +862,18 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
 		goto err_unlock;
 	}
 
-	ret = iio_channel_write(chan, val, 0, IIO_CHAN_INFO_RAW);
+	ret = iio_channel_write(chan, val, val2, attribute);
 err_unlock:
 	mutex_unlock(&chan->indio_dev->info_exist_lock);
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iio_write_channel_attribute);
+
+int iio_write_channel_raw(struct iio_channel *chan, int val)
+{
+	return iio_write_channel_attribute(chan, val, 0, IIO_CHAN_INFO_RAW);
+}
 EXPORT_SYMBOL_GPL(iio_write_channel_raw);
 
 unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 5e347a9..2017f35 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -216,6 +216,32 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val);
 int iio_read_channel_processed(struct iio_channel *chan, int *val);
 
 /**
+ * iio_write_channel_attribute() - Write values to the device attribute.
+ * @chan:	The channel being queried.
+ * @val:	Value being written.
+ * @val2:	Value being written.val2 use depends on attribute type.
+ * @attribute:	info attribute to be read.
+ *
+ * Returns an error code or 0.
+ */
+int iio_write_channel_attribute(struct iio_channel *chan, int val,
+				int val2, enum iio_chan_info_enum attribute);
+
+/**
+ * iio_read_channel_attribute() - Read values from the device attribute.
+ * @chan:	The channel being queried.
+ * @val:	Value being written.
+ * @val2:	Value being written.Val2 use depends on attribute type.
+ * @attribute:	info attribute to be written.
+ *
+ * Returns an error code if failed. Else returns a description of what is in val
+ * and val2, such as IIO_VAL_INT_PLUS_MICRO telling us we have a value of val
+ * + val2/1e6
+ */
+int iio_read_channel_attribute(struct iio_channel *chan, int *val,
+			       int *val2, enum iio_chan_info_enum attribute);
+
+/**
  * iio_write_channel_raw() - write to a given channel
  * @chan:		The channel being queried.
  * @val:		Value being written.
-- 
2.7.4
