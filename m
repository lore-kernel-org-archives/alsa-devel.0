From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH TINYCOMPRESS 13/14] compress: Prevent
	divide-by-zero faults	in get_hpointer()
Date: Sun, 10 Feb 2013 00:22:16 +0000
Message-ID: <20130210002216.GM31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 21ED22616A0
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 01:22:18 +0100 (CET)
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

Do not assume that the returned snd_compr_avail contains a
snd_compr_tstamp with a valid sampling_rate. Check for zero
before attempting to use it.

diff --git a/compress.c b/compress.c
index cfd0219..c0e81a3 100644
--- a/compress.c
+++ b/compress.c
@@ -297,10 +297,15 @@ int compress_get_hpointer(struct compress *compress,
 	if (ioctl(compress->fd, SNDRV_COMPRESS_AVAIL, &kavail))
 		return oops(compress, errno, "cannot get avail");
 	*avail = (unsigned int)kavail.avail;
-	time = kavail.tstamp.pcm_io_frames / kavail.tstamp.sampling_rate;
-	tstamp->tv_sec = time;
-	time = kavail.tstamp.pcm_io_frames % kavail.tstamp.sampling_rate;
-	tstamp->tv_nsec = time * 1000000000 / kavail.tstamp.sampling_rate;
+	if (kavail.tstamp.sampling_rate != 0) {
+		time = kavail.tstamp.pcm_io_frames / kavail.tstamp.sampling_rate;
+		tstamp->tv_sec = time;
+		time = kavail.tstamp.pcm_io_frames % kavail.tstamp.sampling_rate;
+		tstamp->tv_nsec = time * 1000000000 / kavail.tstamp.sampling_rate;
+	} else {
+		tstamp->tv_sec = 0;
+		tstamp->tv_nsec = 0;
+	}
 	return 0;
 }
 
-- 
1.7.2.5
