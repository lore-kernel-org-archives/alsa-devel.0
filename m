From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/3] ALSA: hdspm - DRY cleanup in .release
	callback
Date: Tue, 17 Feb 2015 00:05:05 +0100
Message-ID: <1424127906-7530-3-git-send-email-adi@drcomp.erfurt.thur.de>
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
snd_hdspm_{capture,playback}_release. No semantic changes intended, this
is purely cosmetic.

Signed-off-by: Adrian Knoth <aknoth@google.com>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 51e9841..4e1cfb9 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6120,33 +6120,26 @@ static int snd_hdspm_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int snd_hdspm_playback_release(struct snd_pcm_substream *substream)
+static int snd_hdspm_release(struct snd_pcm_substream *substream)
 {
 	struct hdspm *hdspm = snd_pcm_substream_chip(substream);
+	bool playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
 	spin_lock_irq(&hdspm->lock);
 
-	hdspm->playback_pid = -1;
-	hdspm->playback_substream = NULL;
+	if (playback) {
+		hdspm->playback_pid = -1;
+		hdspm->playback_substream = NULL;
+	} else {
+		hdspm->capture_pid = -1;
+		hdspm->capture_substream = NULL;
+	}
 
 	spin_unlock_irq(&hdspm->lock);
 
 	return 0;
 }
 
-static int snd_hdspm_capture_release(struct snd_pcm_substream *substream)
-{
-	struct hdspm *hdspm = snd_pcm_substream_chip(substream);
-
-	spin_lock_irq(&hdspm->lock);
-
-	hdspm->capture_pid = -1;
-	hdspm->capture_substream = NULL;
-
-	spin_unlock_irq(&hdspm->lock);
-	return 0;
-}
-
 static int snd_hdspm_hwdep_dummy_op(struct snd_hwdep *hw, struct file *file)
 {
 	/* we have nothing to initialize but the call is required */
@@ -6363,7 +6356,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 
 static struct snd_pcm_ops snd_hdspm_playback_ops = {
 	.open = snd_hdspm_open,
-	.close = snd_hdspm_playback_release,
+	.close = snd_hdspm_release,
 	.ioctl = snd_hdspm_ioctl,
 	.hw_params = snd_hdspm_hw_params,
 	.hw_free = snd_hdspm_hw_free,
@@ -6375,7 +6368,7 @@ static struct snd_pcm_ops snd_hdspm_playback_ops = {
 
 static struct snd_pcm_ops snd_hdspm_capture_ops = {
 	.open = snd_hdspm_open,
-	.close = snd_hdspm_capture_release,
+	.close = snd_hdspm_release,
 	.ioctl = snd_hdspm_ioctl,
 	.hw_params = snd_hdspm_hw_params,
 	.hw_free = snd_hdspm_hw_free,
-- 
2.1.0
