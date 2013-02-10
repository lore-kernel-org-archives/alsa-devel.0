From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH TINYCOMPRESS 5/14] compress: Take local copy
	of	compr_config structure
Date: Sun, 10 Feb 2013 00:09:44 +0000
Message-ID: <20130210000944.GE31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B0DCE2615F2
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 01:09:46 +0100 (CET)
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

Take a copy of the compr_config structure passed by the client.
This allows the client to use a structure in temporary memory
and avoids the possibility that tinycompress can be broken by the
client changing the content of its compr_config.

diff --git a/compress.c b/compress.c
index c4f215c..871c19e 100644
--- a/compress.c
+++ b/compress.c
@@ -81,7 +81,7 @@ struct compress {
 	int fd;
 	unsigned int flags;
 	char error[COMPR_ERR_MAX];
-	struct compr_config *config;
+	struct compr_config config;
 	int running;
 };
 
@@ -209,7 +209,8 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 	if (!compress || !config)
 		return &bad_compress;
 
-	compress->config = config;
+	/* take a local copy of config */
+	compress->config = *config;
 
 	snprintf(fn, sizeof(fn), "/dev/snd/comprC%uD%u", card, device);
 
@@ -319,7 +320,7 @@ int compress_write(struct compress *compress, const void *buf, unsigned int size
 			return oops(compress, errno, "cannot get avail");
 
 		/* we will write only when avail > fragment size */
-		if (avail.avail < compress->config->fragment_size) {
+		if (avail.avail < compress->config.fragment_size) {
 			/* nothing to write so wait for 10secs */
 			ret = poll(&fds, 1, 1000000);
 			if (ret < 0)
-- 
1.7.2.5
