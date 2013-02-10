From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH TINYCOMPRESS 9/14] compress: Allow client to
	pass "don't	care" for fragment size/number
Date: Sun, 10 Feb 2013 00:16:46 +0000
Message-ID: <20130210001646.GI31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1681E26161F
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 01:16:49 +0100 (CET)
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

Client cannot know what is a sensible fragment size and count
for the device unless it has prior knowledge of the precise
hardware. To allow for generic clients not hardcoded for particular
hardware, this change allows fragment_size and fragments to be
passed as 0, meaning "don't care" and tinycompress will choose
default values read from the driver.

diff --git a/compress.c b/compress.c
index 7457550..7c8ddc8 100644
--- a/compress.c
+++ b/compress.c
@@ -123,19 +123,14 @@ int is_compress_ready(struct compress *compress)
 	return (compress->fd > 0) ? 1 : 0;
 }
 
-static bool _is_codec_supported(struct compress *compress, struct compr_config *config)
+static bool _is_codec_supported(struct compress *compress, struct compr_config *config,
+				const struct snd_compr_caps *caps)
 {
-	struct snd_compr_caps caps;
 	bool codec = false;
 	unsigned int i;
 
-	if (ioctl(compress->fd, SNDRV_COMPRESS_GET_CAPS, &caps)) {
-		oops(compress, errno, "cannot get device caps");
-		return false;
-	}
-
-	for (i = 0; i < caps.num_codecs; i++) {
-		if (caps.codecs[i] == config->codec->id) {
+	for (i = 0; i < caps->num_codecs; i++) {
+		if (caps->codecs[i] == config->codec->id) {
 			/* found the codec */
 			codec = true;
 			break;
@@ -146,24 +141,24 @@ static bool _is_codec_supported(struct compress *compress, struct compr_config *
 		return false;
 	}
 
-	if (config->fragment_size < caps.min_fragment_size) {
+	if (config->fragment_size < caps->min_fragment_size) {
 		oops(compress, -EINVAL, "requested fragment size %d is below min supported %d\n",
-				config->fragment_size, caps.min_fragment_size);
+			config->fragment_size, caps->min_fragment_size);
 		return false;
 	}
-	if (config->fragment_size > caps.max_fragment_size) {
+	if (config->fragment_size > caps->max_fragment_size) {
 		oops(compress, -EINVAL, "requested fragment size %d is above max supported %d\n",
-				config->fragment_size, caps.max_fragment_size);
+			config->fragment_size, caps->max_fragment_size);
 		return false;
 	}
-	if (config->fragments < caps.min_fragments) {
+	if (config->fragments < caps->min_fragments) {
 		oops(compress, -EINVAL, "requested fragments %d are below min supported %d\n",
-				config->fragments, caps.min_fragments);
+			config->fragments, caps->min_fragments);
 		return false;
 	}
-	if (config->fragments > caps.max_fragments) {
+	if (config->fragments > caps->max_fragments) {
 		oops(compress, -EINVAL, "requested fragments %d are above max supported %d\n",
-				config->fragments, caps.max_fragments);
+			config->fragments, caps->max_fragments);
 		return false;
 	}
 
@@ -213,9 +208,6 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 	if (!compress || !config)
 		return &bad_compress;
 
-	/* take a local copy of config */
-	compress->config = *config;
-
 	snprintf(fn, sizeof(fn), "/dev/snd/comprC%uD%u", card, device);
 
 	compress->max_poll_wait_ms = DEFAULT_MAX_POLL_WAIT_MS;
@@ -236,11 +228,27 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 		oops(compress, errno, "cannot open device '%s'", fn);
 		goto input_fail;
 	}
+
+	struct snd_compr_caps caps;
+	if (ioctl(compress->fd, SNDRV_COMPRESS_GET_CAPS, &caps)) {
+		oops(compress, errno, "cannot get device caps");
+		goto codec_fail;
+	}
+
+	/* If caller passed "don't care" fill in default values */
+	if ((config->fragment_size == 0) || (config->fragments == 0)) {
+		config->fragment_size = caps.min_fragment_size;
+		config->fragments = caps.max_fragments;
+	}
+
+	/* take a local copy of config */
+	compress->config = *config;
+
 #if 0
 	/* FIXME need to turn this On when DSP supports
 	 * and treat in no support case
 	 */
-	if (_is_codec_supported(compress, config) == false) {
+	if (_is_codec_supported(compress, config, &caps) == false) {
 		oops(compress, errno, "codec not supported\n");
 		goto codec_fail;
 	}
diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index 1ab53c6..1309d65 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -58,6 +58,8 @@ extern "C" {
 #endif
 /*
  * struct compr_config: config structure, needs to be filled by app
+ * If fragment_size or fragments are zero, this means "don't care"
+ * and tinycompress will choose values that the driver supports
  *
  * @fragment_size: size of fragment requested, in bytes
  * @fragments: number of fragments
@@ -78,11 +80,14 @@ struct snd_compr_tstamp;
 /*
  * compress_open: open a new compress stream
  * returns the valid struct compress on success, NULL on failure
+ * If config does not specify a requested fragment size, on return
+ * it will be updated with the size and number of fragments that
+ * were configured
  *
  * @card: sound card number
  * @device: device number
  * @flags: device flags can be COMPRESS_OUT or COMPRESS_IN
- * @config: stream config requested
+ * @config: stream config requested. Returns actual fragment config
  */
 struct compress *compress_open(unsigned int card, unsigned int device,
 		unsigned int flags, struct compr_config *config);
-- 
1.7.2.5
