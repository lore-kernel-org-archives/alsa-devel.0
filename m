From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH TINYCOMPRESS 1/14] compress: Add function to
	get timestamp	in samples
Date: Sun, 10 Feb 2013 00:02:27 +0000
Message-ID: <20130210000227.GA31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 994E42615F2
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 01:02:30 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The compress_get_hpointer() converts the timestamp into actual
time. But Android needs it in samples. To avoid the inefficiency
of using compress_get_hpointer() and converting into time and then
back into samples, this change adds compress_get_tstamp() which
returns the raw struct snd_compr_tstamp.

diff --git a/compress.c b/compress.c
index faef982..19b9366 100644
--- a/compress.c
+++ b/compress.c
@@ -287,6 +287,18 @@ int compress_get_hpointer(struct compress *compress,
 	return 0;
 }

+int compress_get_tstamp(struct compress *compress,
+			struct snd_compr_tstamp *tstamp )
+{
+	if (!is_compress_ready(compress))
+		return oops(compress, -ENODEV, "device not ready");
+
+	if (ioctl(compress->fd, SNDRV_COMPRESS_TSTAMP, tstamp))
+		return oops(compress, errno, "cannot get avail");
+
+	return 0;
+}
+
 int compress_write(struct compress *compress, char *buf, unsigned int size)
 {
 	struct snd_compr_avail avail;
diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index 13dea3e..8a98527 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -73,6 +73,7 @@ struct compr_config {
 #define COMPRESS_IN         0x10000000

 struct compress;
+struct snd_compr_tstamp;

 /*
  * compress_open: open a new compress stream
@@ -103,6 +104,18 @@ void compress_close(struct compress *compress);
  */
 int compress_get_hpointer(struct compress *compress,
 		unsigned int *avail, struct timespec *tstamp);
+
+
+/*
+ * compress_get_tstamp: get the raw hw timestamp
+ * return 0 on success, negative on error
+ *
+ * @compress: compress stream on which query is made
+ * @tstamp: timestamp information
+ */
+int compress_get_tstamp(struct compress *compress,
+						struct snd_compr_tstamp *tstamp );
+
 /*
  * compress_write: write data to the compress stream
  * return bytes written on success, negative on error
--
1.7.2.5
