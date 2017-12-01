From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v6 04/13] IIO: inkern: API for manipulating
	channel attributes
Date: Fri, 1 Dec 2017 18:40:11 +0100
Message-ID: <1512150020-20335-5-git-send-email-arnaud.pouliquen@st.com>
References: <1512150020-20335-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id CD829267D05
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 18:40:30 +0100 (CET)
In-Reply-To: <1512150020-20335-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-iio@vger.kernel.org, arnaud.pouliquen@st.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Extend the inkern API with functions for reading and writing
attribute of iio channels.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
V5 to V6 update:
 Replace include type.h with iio.h to fix build warning

 drivers/iio/inkern.c         | 18 +++++++++++++-----
 include/linux/iio/consumer.h | 28 +++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 6 deletions(-)

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
index 5e347a9..70658b1 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -11,7 +11,7 @@
 #define _IIO_INKERN_CONSUMER_H_
 
 #include <linux/types.h>
-#include <linux/iio/types.h>
+#include <linux/iio/iio.h>
 
 struct iio_dev;
 struct iio_chan_spec;
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
