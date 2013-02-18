From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/4] compress: cache the config values passed
Date: Mon, 18 Feb 2013 19:45:14 +0530
Message-ID: <1361196915-12121-3-git-send-email-vinod.koul@intel.com>
References: <1361196915-12121-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E41C265094
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 15:16:03 +0100 (CET)
In-Reply-To: <1361196915-12121-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The library should not rely on users pointer for config data, so cache it for
use afterwards

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 compress.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/compress.c b/compress.c
index d98517d..b035e4a 100644
--- a/compress.c
+++ b/compress.c
@@ -211,25 +211,28 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 		return &bad_compress;
 	}
 
-	compress->config = config;
+	compress->config = calloc(1, sizeof(*config));
+	if (!compress->config)
+		goto input_fail;
+	memcpy(compress->config, config, sizeof(*compress->config));
 
 	snprintf(fn, sizeof(fn), "/dev/snd/comprC%uD%u", card, device);
 
 	compress->flags = flags;
 	if (!((flags & COMPRESS_OUT) || (flags & COMPRESS_IN))) {
 		oops(&bad_compress, -EINVAL, "can't deduce device direction from given flags");
-		goto input_fail;
+		goto config_fail;
 	}
 	if (flags & COMPRESS_OUT) {
 		/* this should be removed once we have capture tested */
 		oops(&bad_compress, -EINVAL, "this version doesnt support capture");
-		goto input_fail;
+		goto config_fail;
 	}
 
 	compress->fd = open(fn, O_WRONLY);
 	if (compress->fd < 0) {
 		oops(&bad_compress, errno, "cannot open device '%s'", fn);
-		goto input_fail;
+		goto config_fail;
 	}
 #if 0
 	/* FIXME need to turn this On when DSP supports
@@ -252,6 +255,8 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 codec_fail:
 	close(compress->fd);
 	compress->fd = -1;
+config_fail:
+	free(compress->config);
 input_fail:
 	free(compress);
 	return &bad_compress;
@@ -266,6 +271,7 @@ void compress_close(struct compress *compress)
 		close(compress->fd);
 	compress->running = 0;
 	compress->fd = -1;
+	free(compress->config);
 	free(compress);
 }
 
@@ -301,7 +307,6 @@ int compress_write(struct compress *compress, char *buf, unsigned int size)
 	fds.fd = compress->fd;
 	fds.events = POLLOUT;
 
-
 	/*TODO: treat auto start here first */
 	while (size) {
 		if (ioctl(compress->fd, SNDRV_COMPRESS_AVAIL, &avail))
-- 
1.7.0.4
