From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: aloop: Release cable upon open error
	path
Date: Fri,  5 Jan 2018 16:54:26 +0100
Message-ID: <20180105155428.14621-2-tiwai@suse.de>
References: <20180105155428.14621-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 42590267A56
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 16:54:31 +0100 (CET)
In-Reply-To: <20180105155428.14621-1-tiwai@suse.de>
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
Cc: Dmitry Vyukov <dvyukov@google.com>
List-Id: alsa-devel@alsa-project.org

The aloop runtime object and its assignment in the cable are left even
when opening a substream fails.  This doesn't mean any memory leak,
but it still keeps the invalid pointer that may be referred by the
another side of the cable spontaneously, which is a potential Oops
cause.

Clean up the cable assignment and the empty cable upon the error path
properly.

Fixes: 597603d615d2 ("ALSA: introduce the snd-aloop module for the PCM loopback")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/aloop.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index afac886ffa28..8b6a39cb7f06 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -658,12 +658,31 @@ static int rule_channels(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
 
+static void free_cable(struct snd_pcm_substream *substream)
+{
+	struct loopback *loopback = substream->private_data;
+	int dev = get_cable_index(substream);
+	struct loopback_cable *cable;
+
+	cable = loopback->cables[substream->number][dev];
+	if (!cable)
+		return;
+	if (cable->streams[!substream->stream]) {
+		/* other stream is still alive */
+		cable->streams[substream->stream] = NULL;
+	} else {
+		/* free the cable */
+		loopback->cables[substream->number][dev] = NULL;
+		kfree(cable);
+	}
+}
+
 static int loopback_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct loopback *loopback = substream->private_data;
 	struct loopback_pcm *dpcm;
-	struct loopback_cable *cable;
+	struct loopback_cable *cable = NULL;
 	int err = 0;
 	int dev = get_cable_index(substream);
 
@@ -681,7 +700,6 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	if (!cable) {
 		cable = kzalloc(sizeof(*cable), GFP_KERNEL);
 		if (!cable) {
-			kfree(dpcm);
 			err = -ENOMEM;
 			goto unlock;
 		}
@@ -723,6 +741,10 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	else
 		runtime->hw = cable->hw;
  unlock:
+	if (err < 0) {
+		free_cable(substream);
+		kfree(dpcm);
+	}
 	mutex_unlock(&loopback->cable_lock);
 	return err;
 }
@@ -731,20 +753,10 @@ static int loopback_close(struct snd_pcm_substream *substream)
 {
 	struct loopback *loopback = substream->private_data;
 	struct loopback_pcm *dpcm = substream->runtime->private_data;
-	struct loopback_cable *cable;
-	int dev = get_cable_index(substream);
 
 	loopback_timer_stop(dpcm);
 	mutex_lock(&loopback->cable_lock);
-	cable = loopback->cables[substream->number][dev];
-	if (cable->streams[!substream->stream]) {
-		/* other stream is still alive */
-		cable->streams[substream->stream] = NULL;
-	} else {
-		/* free the cable */
-		loopback->cables[substream->number][dev] = NULL;
-		kfree(cable);
-	}
+	free_cable(substream);
 	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
-- 
2.15.1
