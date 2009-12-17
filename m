From: jassisinghbrar@gmail.com
Subject: [PATCH 2/2] ALSA: pcm - specify amount of data needed
	in wait_for_avail_min
Date: Thu, 17 Dec 2009 15:00:09 +0900
Message-ID: <1261029609-14437-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id BA4A010382C
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 07:07:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

For better accuracy, make the waiting time more specific. That helps
avoiding users of wait_for_avail_min(i.e, snd_pcm_lib_write1/read1) to
wait until atleast avail_min amount is available, whereas all that might
be needed is just 1 frame(for example).

Since the waiting is not for avail_min, the name has been changed to
reflect that. The users of the new function are also updated to pass
exact minimum data needed.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/core/pcm_lib.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index ee2d7b9..4a92804 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1664,12 +1664,12 @@ void snd_pcm_period_elapsed(struct snd_pcm_substream *substream)
 EXPORT_SYMBOL(snd_pcm_period_elapsed);
 
 /*
- * Wait until avail_min data becomes available
+ * Wait until atleast the requested amount(*availp) of data becomes available
  * Returns a negative error code if any error occurs during operation.
  * The available space is stored on availp.  When err = 0 and avail = 0
  * on the capture stream, it indicates the stream is in DRAINING state.
  */
-static int wait_for_avail_min(struct snd_pcm_substream *substream,
+static int wait_for_min(struct snd_pcm_substream *substream,
 			      snd_pcm_uframes_t *availp)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -1719,7 +1719,7 @@ static int wait_for_avail_min(struct snd_pcm_substream *substream,
 			avail = snd_pcm_playback_avail(runtime);
 		else
 			avail = snd_pcm_capture_avail(runtime);
-		if (avail >= runtime->control->avail_min)
+		if (avail >= *availp)
 			break;
 	}
  _endloop:
@@ -1794,7 +1794,8 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 				err = -EAGAIN;
 				goto _end_unlock;
 			}
-			err = wait_for_avail_min(substream, &avail);
+			avail = size;
+			err = wait_for_min(substream, &avail);
 			if (err < 0)
 				goto _end_unlock;
 		}
@@ -2016,7 +2017,8 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 				err = -EAGAIN;
 				goto _end_unlock;
 			}
-			err = wait_for_avail_min(substream, &avail);
+			avail = size;
+			err = wait_for_min(substream, &avail);
 			if (err < 0)
 				goto _end_unlock;
 			if (!avail)
-- 
1.6.2.5
