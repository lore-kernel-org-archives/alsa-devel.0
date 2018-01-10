From: Mark Brown <broonie@kernel.org>
Subject: Applied "IIO: consumer: allow to set buffer sizes" to
	the asoc tree
Date: Wed, 10 Jan 2018 11:12:56 +0000
Message-ID: <E1eZEJU-0004sb-VM@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 11B4E2677B3
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 12:12:58 +0100 (CET)
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

   IIO: consumer: allow to set buffer sizes

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

>From 16cbca06fa8288a4f58426fc898b141e12ee8008 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Wed, 10 Jan 2018 11:13:13 +0100
Subject: [PATCH] IIO: consumer: allow to set buffer sizes

Add iio consumer API to set buffer size and watermark according
to sysfs API.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/buffer/industrialio-buffer-cb.c | 11 +++++++++++
 include/linux/iio/consumer.h                | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 4847534700e7..ea63c838eeae 100644
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
index 2017f35db17c..9887f4f8e2a8 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -133,6 +133,17 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 					     int (*cb)(const void *data,
 						       void *private),
 					     void *private);
+/**
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
 /**
  * iio_channel_release_all_cb() - release and unregister the callback.
  * @cb_buffer:		The callback buffer that was allocated.
-- 
2.15.1
