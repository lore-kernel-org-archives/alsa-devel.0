From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH TINYCOMPRESS 1/14 v2] compress:
	Add	function to get timestamp in samples
Date: Fri, 22 Feb 2013 15:56:18 +0000
Message-ID: <20130222155618.GA21174@opensource.wolfsonmicro.com>
References: <20130210000227.GA31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64B27265378
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 16:56:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130210000227.GA31139@opensource.wolfsonmicro.com>
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
returns the raw sample count.

---
 compress.c                          |   16 ++++++++++++++++
 include/tinycompress/tinycompress.h |   14 ++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/compress.c b/compress.c
index 27c03d9..01fb3f0 100644
--- a/compress.c
+++ b/compress.c
@@ -296,6 +296,22 @@ int compress_get_hpointer(struct compress *compress,
 	return 0;
 }
 
+int compress_get_tstamp(struct compress *compress,
+			unsigned long *samples, unsigned int *sampling_rate)
+{
+	struct snd_compr_tstamp ktstamp;
+
+	if (!is_compress_ready(compress))
+		return oops(compress, -ENODEV, "device not ready");
+
+	if (ioctl(compress->fd, SNDRV_COMPRESS_TSTAMP, &ktstamp))
+		return oops(compress, errno, "cannot get tstamp");
+
+	*samples = ktstamp.pcm_io_frames;
+	*sampling_rate = ktstamp.sampling_rate;
+	return 0;
+}
+
 int compress_write(struct compress *compress, char *buf, unsigned int size)
 {
 	struct snd_compr_avail avail;
diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index 13dea3e..b1fbc65 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -73,6 +73,7 @@ struct compr_config {
 #define COMPRESS_IN         0x10000000
 
 struct compress;
+struct snd_compr_tstamp;
 
 /*
  * compress_open: open a new compress stream
@@ -103,6 +104,19 @@ void compress_close(struct compress *compress);
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
+ * @samples: number of decoded samples played
+ * @sampling_rate: sampling rate of decoded samples
+ */
+int compress_get_tstamp(struct compress *compress,
+		unsigned long *samples, unsigned int *sampling_rate);
+
 /*
  * compress_write: write data to the compress stream
  * return bytes written on success, negative on error
-- 
1.7.2.5
