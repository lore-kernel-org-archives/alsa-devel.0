From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/3] ALSA: hdspm - DRY cleanup in .open
	callbacks
Date: Tue, 17 Feb 2015 00:05:04 +0100
Message-ID: <1424127906-7530-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1424127906-7530-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1424127906-7530-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: adi@drcomp.erfurt.thur.de, alsa-devel@alsa-project.org, Adrian Knoth <aknoth@google.com>
List-Id: alsa-devel@alsa-project.org

From: Adrian Knoth <aknoth@google.com>

This commit removes code duplication between
snd_hdspm_{capture,playback}_open. No semantic changes intended, this is
purely cosmetic.

Signed-off-by: Adrian Knoth <aknoth@google.com>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index ca67f89..51e9841 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6043,23 +6043,30 @@ hdspm_hw_constraints_aes32_sample_rates = {
 	.mask = 0
 };
 
-static int snd_hdspm_playback_open(struct snd_pcm_substream *substream)
+static int snd_hdspm_open(struct snd_pcm_substream *substream)
 {
 	struct hdspm *hdspm = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	bool playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
 	spin_lock_irq(&hdspm->lock);
-
 	snd_pcm_set_sync(substream);
+	runtime->hw = (playback) ? snd_hdspm_playback_subinfo :
+		snd_hdspm_capture_subinfo;
 
+	if (playback) {
+		if (hdspm->capture_substream == NULL)
+			hdspm_stop_audio(hdspm);
 
-	runtime->hw = snd_hdspm_playback_subinfo;
-
-	if (hdspm->capture_substream == NULL)
-		hdspm_stop_audio(hdspm);
+		hdspm->playback_pid = current->pid;
+		hdspm->playback_substream = substream;
+	} else {
+		if (hdspm->playback_substream == NULL)
+			hdspm_stop_audio(hdspm);
 
-	hdspm->playback_pid = current->pid;
-	hdspm->playback_substream = substream;
+		hdspm->capture_pid = current->pid;
+		hdspm->capture_substream = substream;
+	}
 
 	spin_unlock_irq(&hdspm->lock);
 
@@ -6094,16 +6101,20 @@ static int snd_hdspm_playback_open(struct snd_pcm_substream *substream)
 				&hdspm_hw_constraints_aes32_sample_rates);
 	} else {
 		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				snd_hdspm_hw_rule_rate_out_channels, hdspm,
+				(playback ?
+				 snd_hdspm_hw_rule_rate_out_channels :
+				 snd_hdspm_hw_rule_rate_in_channels), hdspm,
 				SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	}
 
 	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-			snd_hdspm_hw_rule_out_channels, hdspm,
+			(playback ? snd_hdspm_hw_rule_out_channels :
+			 snd_hdspm_hw_rule_in_channels), hdspm,
 			SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 
 	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-			snd_hdspm_hw_rule_out_channels_rate, hdspm,
+			(playback ? snd_hdspm_hw_rule_out_channels_rate :
+			 snd_hdspm_hw_rule_in_channels_rate), hdspm,
 			SNDRV_PCM_HW_PARAM_RATE, -1);
 
 	return 0;
@@ -6123,69 +6134,6 @@ static int snd_hdspm_playback_release(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-
-static int snd_hdspm_capture_open(struct snd_pcm_substream *substream)
-{
-	struct hdspm *hdspm = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	spin_lock_irq(&hdspm->lock);
-	snd_pcm_set_sync(substream);
-	runtime->hw = snd_hdspm_capture_subinfo;
-
-	if (hdspm->playback_substream == NULL)
-		hdspm_stop_audio(hdspm);
-
-	hdspm->capture_pid = current->pid;
-	hdspm->capture_substream = substream;
-
-	spin_unlock_irq(&hdspm->lock);
-
-	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
-	snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
-
-	switch (hdspm->io_type) {
-	case AIO:
-	case RayDAT:
-		snd_pcm_hw_constraint_minmax(runtime,
-					     SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-					     32, 4096);
-		snd_pcm_hw_constraint_minmax(runtime,
-					     SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
-					     16384, 16384);
-		break;
-
-	default:
-		snd_pcm_hw_constraint_minmax(runtime,
-					     SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-					     64, 8192);
-		snd_pcm_hw_constraint_minmax(runtime,
-					     SNDRV_PCM_HW_PARAM_PERIODS,
-					     2, 2);
-		break;
-	}
-
-	if (AES32 == hdspm->io_type) {
-		runtime->hw.rates |= SNDRV_PCM_RATE_KNOT;
-		snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				&hdspm_hw_constraints_aes32_sample_rates);
-	} else {
-		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				snd_hdspm_hw_rule_rate_in_channels, hdspm,
-				SNDRV_PCM_HW_PARAM_CHANNELS, -1);
-	}
-
-	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-			snd_hdspm_hw_rule_in_channels, hdspm,
-			SNDRV_PCM_HW_PARAM_CHANNELS, -1);
-
-	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-			snd_hdspm_hw_rule_in_channels_rate, hdspm,
-			SNDRV_PCM_HW_PARAM_RATE, -1);
-
-	return 0;
-}
-
 static int snd_hdspm_capture_release(struct snd_pcm_substream *substream)
 {
 	struct hdspm *hdspm = snd_pcm_substream_chip(substream);
@@ -6414,7 +6362,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 }
 
 static struct snd_pcm_ops snd_hdspm_playback_ops = {
-	.open = snd_hdspm_playback_open,
+	.open = snd_hdspm_open,
 	.close = snd_hdspm_playback_release,
 	.ioctl = snd_hdspm_ioctl,
 	.hw_params = snd_hdspm_hw_params,
@@ -6426,7 +6374,7 @@ static struct snd_pcm_ops snd_hdspm_playback_ops = {
 };
 
 static struct snd_pcm_ops snd_hdspm_capture_ops = {
-	.open = snd_hdspm_capture_open,
+	.open = snd_hdspm_open,
 	.close = snd_hdspm_capture_release,
 	.ioctl = snd_hdspm_ioctl,
 	.hw_params = snd_hdspm_hw_params,
-- 
2.1.0
