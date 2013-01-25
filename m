From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH - TINYCOMPRESS 3/4] compress: Return error
	messages correctly from compress_open
Date: Fri, 25 Jan 2013 10:43:13 +0000
Message-ID: <1359110594-20163-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1359110594-20163-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1359110594-20163-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org, vinod.koul@linux.intel.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The allocated compress object will be freed and bad_compress will be
returned, so error messages written to the allocated compress struct
will be lost. This patch writes error messages to bad_compress for error
paths in compress_open, ensuring that error messages are returned
correctly.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

diff --git a/compress.c b/compress.c
index 51455fc..c575acd 100644
--- a/compress.c
+++ b/compress.c
@@ -218,18 +218,18 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 
 	compress->flags = flags;
 	if (!((flags & COMPRESS_OUT) || (flags & COMPRESS_IN))) {
-		oops(compress, -EINVAL, "can't deduce device direction from given flags\n");
+		oops(&bad_compress, -EINVAL, "can't deduce device direction from given flags\n");
 		goto input_fail;
 	}
 	if (flags & COMPRESS_OUT) {
 		/* this should be removed once we have capture tested */
-		oops(compress, -EINVAL, "this version doesnt support capture\n");
+		oops(&bad_compress, -EINVAL, "this version doesnt support capture\n");
 		goto input_fail;
 	}
 
 	compress->fd = open(fn, O_WRONLY);
 	if (compress->fd < 0) {
-		oops(compress, errno, "cannot open device '%s'", fn);
+		oops(&bad_compress, errno, "cannot open device '%s'", fn);
 		goto input_fail;
 	}
 #if 0
@@ -237,14 +237,14 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 	 * and treat in no support case
 	 */
 	if (_is_codec_supported(compress, config) == false) {
-		oops(compress, errno, "codec not supported\n");
+		oops(&bad_compress, errno, "codec not supported\n");
 		goto codec_fail;
 	}
 #endif
 	fill_compress_params(config, &params);
 
 	if (ioctl(compress->fd, SNDRV_COMPRESS_SET_PARAMS, &params)) {
-		oops(compress, errno, "cannot set device");
+		oops(&bad_compress, errno, "cannot set device");
 		goto codec_fail;
 	}
 
-- 
1.7.2.5
