From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: aloop: Reduced duplicated PCM ops
	definition
Date: Sun, 27 May 2018 14:17:12 +0200
Message-ID: <20180527121712.11982-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B5ED267252
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 17:42:29 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1E1D0AD67
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 15:42:28 +0000 (UTC)
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

The PCM ops defined for playback and capture are identical.  Just use
the single one for both.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/aloop.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index eab7f594ebe7..78a2fdc38531 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -768,20 +768,7 @@ static int loopback_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static const struct snd_pcm_ops loopback_playback_ops = {
-	.open =		loopback_open,
-	.close =	loopback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	loopback_hw_params,
-	.hw_free =	loopback_hw_free,
-	.prepare =	loopback_prepare,
-	.trigger =	loopback_trigger,
-	.pointer =	loopback_pointer,
-	.page =		snd_pcm_lib_get_vmalloc_page,
-	.mmap =		snd_pcm_lib_mmap_vmalloc,
-};
-
-static const struct snd_pcm_ops loopback_capture_ops = {
+static const struct snd_pcm_ops loopback_pcm_ops = {
 	.open =		loopback_open,
 	.close =	loopback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -804,8 +791,8 @@ static int loopback_pcm_new(struct loopback *loopback,
 			  substreams, substreams, &pcm);
 	if (err < 0)
 		return err;
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &loopback_playback_ops);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &loopback_capture_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &loopback_pcm_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &loopback_pcm_ops);
 
 	pcm->private_data = loopback;
 	pcm->info_flags = 0;
-- 
2.16.3
