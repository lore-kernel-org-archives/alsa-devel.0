From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: pcm: Simplify forward/rewind codes
Date: Fri, 19 May 2017 20:31:00 +0200
Message-ID: <20170519183100.11758-2-tiwai@suse.de>
References: <20170519183100.11758-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E0794266D04
 for <alsa-devel@alsa-project.org>; Fri, 19 May 2017 20:31:02 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 579E9ABCA
 for <alsa-devel@alsa-project.org>; Fri, 19 May 2017 18:31:02 +0000 (UTC)
In-Reply-To: <20170519183100.11758-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Factor out the common codes in snd_pcm_*_forward() and *_rewind()
functions to simplify the codes.  No functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 118 ++++++++++++++++++++----------------------------
 1 file changed, 50 insertions(+), 68 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 93bd2c662c1d..ecde57afa45a 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2455,34 +2455,58 @@ static int do_pcm_hwsync(struct snd_pcm_substream *substream)
 	}
 }
 
+/* increase the appl_ptr; returns the processed frames */
+static snd_pcm_sframes_t forward_appl_ptr(struct snd_pcm_substream *substream,
+					  snd_pcm_uframes_t frames,
+					   snd_pcm_sframes_t avail)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_sframes_t appl_ptr;
+
+	if (avail <= 0)
+		return 0;
+	if (frames > (snd_pcm_uframes_t)avail)
+		frames = avail;
+	appl_ptr = runtime->control->appl_ptr + frames;
+	if (appl_ptr >= (snd_pcm_sframes_t)runtime->boundary)
+		appl_ptr -= runtime->boundary;
+	runtime->control->appl_ptr = appl_ptr;
+	return frames;
+}
+
+/* decrease the appl_ptr; returns the processed frames */
+static snd_pcm_sframes_t rewind_appl_ptr(struct snd_pcm_substream *substream,
+					 snd_pcm_uframes_t frames,
+					 snd_pcm_sframes_t avail)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_sframes_t appl_ptr;
+
+	if (avail <= 0)
+		return 0;
+	if (frames > (snd_pcm_uframes_t)avail)
+		frames = avail;
+	appl_ptr = runtime->control->appl_ptr - frames;
+	if (appl_ptr < 0)
+		appl_ptr += runtime->boundary;
+	runtime->control->appl_ptr = appl_ptr;
+	return frames;
+}
+
 static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *substream,
 						 snd_pcm_uframes_t frames)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	snd_pcm_sframes_t appl_ptr;
 	snd_pcm_sframes_t ret;
-	snd_pcm_sframes_t hw_avail;
 
 	if (frames == 0)
 		return 0;
 
 	snd_pcm_stream_lock_irq(substream);
 	ret = do_pcm_hwsync(substream);
-	if (ret < 0)
-		goto __end;
-	hw_avail = snd_pcm_playback_hw_avail(runtime);
-	if (hw_avail <= 0) {
-		ret = 0;
-		goto __end;
-	}
-	if (frames > (snd_pcm_uframes_t)hw_avail)
-		frames = hw_avail;
-	appl_ptr = runtime->control->appl_ptr - frames;
-	if (appl_ptr < 0)
-		appl_ptr += runtime->boundary;
-	runtime->control->appl_ptr = appl_ptr;
-	ret = frames;
- __end:
+	if (!ret)
+		ret = rewind_appl_ptr(substream, frames,
+				      snd_pcm_playback_hw_avail(runtime));
 	snd_pcm_stream_unlock_irq(substream);
 	return ret;
 }
@@ -2491,30 +2515,16 @@ static snd_pcm_sframes_t snd_pcm_capture_rewind(struct snd_pcm_substream *substr
 						snd_pcm_uframes_t frames)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	snd_pcm_sframes_t appl_ptr;
 	snd_pcm_sframes_t ret;
-	snd_pcm_sframes_t hw_avail;
 
 	if (frames == 0)
 		return 0;
 
 	snd_pcm_stream_lock_irq(substream);
 	ret = do_pcm_hwsync(substream);
-	if (ret < 0)
-		goto __end;
-	hw_avail = snd_pcm_capture_hw_avail(runtime);
-	if (hw_avail <= 0) {
-		ret = 0;
-		goto __end;
-	}
-	if (frames > (snd_pcm_uframes_t)hw_avail)
-		frames = hw_avail;
-	appl_ptr = runtime->control->appl_ptr - frames;
-	if (appl_ptr < 0)
-		appl_ptr += runtime->boundary;
-	runtime->control->appl_ptr = appl_ptr;
-	ret = frames;
- __end:
+	if (!ret)
+		ret = rewind_appl_ptr(substream, frames,
+				      snd_pcm_capture_hw_avail(runtime));
 	snd_pcm_stream_unlock_irq(substream);
 	return ret;
 }
@@ -2523,30 +2533,16 @@ static snd_pcm_sframes_t snd_pcm_playback_forward(struct snd_pcm_substream *subs
 						  snd_pcm_uframes_t frames)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	snd_pcm_sframes_t appl_ptr;
 	snd_pcm_sframes_t ret;
-	snd_pcm_sframes_t avail;
 
 	if (frames == 0)
 		return 0;
 
 	snd_pcm_stream_lock_irq(substream);
 	ret = do_pcm_hwsync(substream);
-	if (ret < 0)
-		goto __end;
-	avail = snd_pcm_playback_avail(runtime);
-	if (avail <= 0) {
-		ret = 0;
-		goto __end;
-	}
-	if (frames > (snd_pcm_uframes_t)avail)
-		frames = avail;
-	appl_ptr = runtime->control->appl_ptr + frames;
-	if (appl_ptr >= (snd_pcm_sframes_t)runtime->boundary)
-		appl_ptr -= runtime->boundary;
-	runtime->control->appl_ptr = appl_ptr;
-	ret = frames;
- __end:
+	if (!ret)
+		ret = forward_appl_ptr(substream, frames,
+				       snd_pcm_playback_avail(runtime));
 	snd_pcm_stream_unlock_irq(substream);
 	return ret;
 }
@@ -2555,30 +2551,16 @@ static snd_pcm_sframes_t snd_pcm_capture_forward(struct snd_pcm_substream *subst
 						 snd_pcm_uframes_t frames)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	snd_pcm_sframes_t appl_ptr;
 	snd_pcm_sframes_t ret;
-	snd_pcm_sframes_t avail;
 
 	if (frames == 0)
 		return 0;
 
 	snd_pcm_stream_lock_irq(substream);
 	ret = do_pcm_hwsync(substream);
-	if (ret < 0)
-		goto __end;
-	avail = snd_pcm_capture_avail(runtime);
-	if (avail <= 0) {
-		ret = 0;
-		goto __end;
-	}
-	if (frames > (snd_pcm_uframes_t)avail)
-		frames = avail;
-	appl_ptr = runtime->control->appl_ptr + frames;
-	if (appl_ptr >= (snd_pcm_sframes_t)runtime->boundary)
-		appl_ptr -= runtime->boundary;
-	runtime->control->appl_ptr = appl_ptr;
-	ret = frames;
- __end:
+	if (!ret)
+		ret = forward_appl_ptr(substream, frames,
+				       snd_pcm_capture_avail(runtime));
 	snd_pcm_stream_unlock_irq(substream);
 	return ret;
 }
-- 
2.13.0
