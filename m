From: Mark Brown <broonie@kernel.org>
Subject: Applied "IIO: inkern: API for manipulating channel
	attributes" to the asoc tree
Date: Wed, 10 Jan 2018 11:13:26 +0000
Message-ID: <E1eZEJy-000518-Ly@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2336426780D
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 12:13:27 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   IIO: inkern: API for manipulating channel attributes

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 34739a213dbb85c8d775de42d52358255059c257 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Wed, 10 Jan 2018 11:13:06 +0100
Subject: [PATCH] IIO: inkern: API for manipulating channel attributes

Extend the inkern API with functions for reading and writing
attribute of iio channels.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/inkern.c         | 17 ++++++++++++-----
 include/linux/iio/consumer.h | 26 ++++++++++++++++++++++++++
 include/linux/iio/iio.h      | 28 ----------------------------
 include/linux/iio/types.h    | 28 ++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 069defcc6d9b..ec98790e2a28 100644
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
 
@@ -682,6 +681,7 @@ static int iio_read_channel_attribute(struct iio_channel *chan,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iio_read_channel_attribute);
 
 int iio_read_channel_offset(struct iio_channel *chan, int *val, int *val2)
 {
@@ -850,7 +850,8 @@ static int iio_channel_write(struct iio_channel *chan, int val, int val2,
 						chan->channel, val, val2, info);
 }
 
-int iio_write_channel_raw(struct iio_channel *chan, int val)
+int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
+				enum iio_chan_info_enum attribute)
 {
 	int ret;
 
@@ -860,12 +861,18 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
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
index 5e347a9805fd..2017f35db17c 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -215,6 +215,32 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val);
  */
 int iio_read_channel_processed(struct iio_channel *chan, int *val);
 
+/**
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
 /**
  * iio_write_channel_raw() - write to a given channel
  * @chan:		The channel being queried.
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 20b61347ea58..f12a61be1ede 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -20,34 +20,6 @@
  * Currently assumes nano seconds.
  */
 
-enum iio_chan_info_enum {
-	IIO_CHAN_INFO_RAW = 0,
-	IIO_CHAN_INFO_PROCESSED,
-	IIO_CHAN_INFO_SCALE,
-	IIO_CHAN_INFO_OFFSET,
-	IIO_CHAN_INFO_CALIBSCALE,
-	IIO_CHAN_INFO_CALIBBIAS,
-	IIO_CHAN_INFO_PEAK,
-	IIO_CHAN_INFO_PEAK_SCALE,
-	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
-	IIO_CHAN_INFO_AVERAGE_RAW,
-	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
-	IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY,
-	IIO_CHAN_INFO_SAMP_FREQ,
-	IIO_CHAN_INFO_FREQUENCY,
-	IIO_CHAN_INFO_PHASE,
-	IIO_CHAN_INFO_HARDWAREGAIN,
-	IIO_CHAN_INFO_HYSTERESIS,
-	IIO_CHAN_INFO_INT_TIME,
-	IIO_CHAN_INFO_ENABLE,
-	IIO_CHAN_INFO_CALIBHEIGHT,
-	IIO_CHAN_INFO_CALIBWEIGHT,
-	IIO_CHAN_INFO_DEBOUNCE_COUNT,
-	IIO_CHAN_INFO_DEBOUNCE_TIME,
-	IIO_CHAN_INFO_CALIBEMISSIVITY,
-	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
-};
-
 enum iio_shared_by {
 	IIO_SEPARATE,
 	IIO_SHARED_BY_TYPE,
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 2aa7b6384d64..6eb3d683ef62 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -34,4 +34,32 @@ enum iio_available_type {
 	IIO_AVAIL_RANGE,
 };
 
+enum iio_chan_info_enum {
+	IIO_CHAN_INFO_RAW = 0,
+	IIO_CHAN_INFO_PROCESSED,
+	IIO_CHAN_INFO_SCALE,
+	IIO_CHAN_INFO_OFFSET,
+	IIO_CHAN_INFO_CALIBSCALE,
+	IIO_CHAN_INFO_CALIBBIAS,
+	IIO_CHAN_INFO_PEAK,
+	IIO_CHAN_INFO_PEAK_SCALE,
+	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
+	IIO_CHAN_INFO_AVERAGE_RAW,
+	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
+	IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY,
+	IIO_CHAN_INFO_SAMP_FREQ,
+	IIO_CHAN_INFO_FREQUENCY,
+	IIO_CHAN_INFO_PHASE,
+	IIO_CHAN_INFO_HARDWAREGAIN,
+	IIO_CHAN_INFO_HYSTERESIS,
+	IIO_CHAN_INFO_INT_TIME,
+	IIO_CHAN_INFO_ENABLE,
+	IIO_CHAN_INFO_CALIBHEIGHT,
+	IIO_CHAN_INFO_CALIBWEIGHT,
+	IIO_CHAN_INFO_DEBOUNCE_COUNT,
+	IIO_CHAN_INFO_DEBOUNCE_TIME,
+	IIO_CHAN_INFO_CALIBEMISSIVITY,
+	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
+};
+
 #endif /* _IIO_TYPES_H_ */
-- 
2.15.1
