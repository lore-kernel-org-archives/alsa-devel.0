From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [TINYCOMPRESS][PATCH 1/1] compress: no need to set
	metadata before	calling next_track
Date: Wed, 26 Feb 2014 14:29:28 +0000
Message-ID: <20140226142829.GB2002@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 498BF2656A6
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:29:41 +0100 (CET)
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
Cc: ckeepax@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, elaurent@google.com
List-Id: alsa-devel@alsa-project.org

The metadata is mainly for MP3 gapless playback, since
the MP3 audio stream does not contain enough information
to enable gapless. Other audio formats do not necessarily
require any additional metadata so we should allow next_track
to be called without any metadata.

Signed-off-by: Zhao Weijia <weijia.zhao@capelabs.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 compress.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/compress.c b/compress.c
index 15dfdb7..0c9ecd2 100644
--- a/compress.c
+++ b/compress.c
@@ -534,8 +534,6 @@ int compress_next_track(struct compress *compress)
 	if (!is_compress_running(compress))
 		return oops(compress, ENODEV, "device not ready");
 
-	if (!compress->gapless_metadata)
-		return oops(compress, EPERM, "metadata not set");
 	if (ioctl(compress->fd, SNDRV_COMPRESS_NEXT_TRACK))
 		return oops(compress, errno, "cannot set next track\n");
 	compress->next_track = 1;
-- 
1.7.2.5
