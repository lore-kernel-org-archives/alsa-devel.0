From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 3/3] ALSA: hdspm - DRY cleanup of snd_pcm_ops
Date: Tue, 17 Feb 2015 00:05:06 +0100
Message-ID: <1424127906-7530-4-git-send-email-adi@drcomp.erfurt.thur.de>
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
snd_hdspm_{capture,playback}_ops. No semantic changes intended, this is
purely cosmetic.

Signed-off-by: Adrian Knoth <aknoth@google.com>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 4e1cfb9..cb666c7 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6354,19 +6354,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 	return 0;
 }
 
-static struct snd_pcm_ops snd_hdspm_playback_ops = {
-	.open = snd_hdspm_open,
-	.close = snd_hdspm_release,
-	.ioctl = snd_hdspm_ioctl,
-	.hw_params = snd_hdspm_hw_params,
-	.hw_free = snd_hdspm_hw_free,
-	.prepare = snd_hdspm_prepare,
-	.trigger = snd_hdspm_trigger,
-	.pointer = snd_hdspm_hw_pointer,
-	.page = snd_pcm_sgbuf_ops_page,
-};
-
-static struct snd_pcm_ops snd_hdspm_capture_ops = {
+static struct snd_pcm_ops snd_hdspm_ops = {
 	.open = snd_hdspm_open,
 	.close = snd_hdspm_release,
 	.ioctl = snd_hdspm_ioctl,
@@ -6462,9 +6450,9 @@ static int snd_hdspm_create_pcm(struct snd_card *card,
 	strcpy(pcm->name, hdspm->card_name);
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
-			&snd_hdspm_playback_ops);
+			&snd_hdspm_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
-			&snd_hdspm_capture_ops);
+			&snd_hdspm_ops);
 
 	pcm->info_flags = SNDRV_PCM_INFO_JOINT_DUPLEX;
 
-- 
2.1.0
