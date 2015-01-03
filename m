From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ALSA: pcm: Remove unused functions declaration
Date: Sat,  3 Jan 2015 17:56:14 +0100
Message-ID: <1420304174-4078-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-017.synserver.de (smtp-out-017.synserver.de
 [212.40.185.17])
 by alsa0.perex.cz (Postfix) with ESMTP id F0DB02604B5
 for <alsa-devel@alsa-project.org>; Sat,  3 Jan 2015 17:56:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Remove function declarations for functions that don't have a matching
implementation.

For snd_pcm_build_linear_format the implementation was removed in
64d27f96cb719cf8 ("[ALSA] Support 3-bytes 24bit format in PCM OSS
emulation"). All the others never had one (as far as git history goes).

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/pcm.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index bf32cea..cd09c1b 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -518,7 +518,6 @@ void snd_pcm_release_substream(struct snd_pcm_substream *substream);
 int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream, struct file *file,
 			     struct snd_pcm_substream **rsubstream);
 void snd_pcm_detach_substream(struct snd_pcm_substream *substream);
-void snd_pcm_vma_notify_data(void *client, void *data);
 int snd_pcm_mmap_data(struct snd_pcm_substream *substream, struct file *file, struct vm_area_struct *area);
 
 
@@ -984,21 +983,15 @@ int snd_pcm_format_physical_width(snd_pcm_format_t format);		/* in bits */
 ssize_t snd_pcm_format_size(snd_pcm_format_t format, size_t samples);
 const unsigned char *snd_pcm_format_silence_64(snd_pcm_format_t format);
 int snd_pcm_format_set_silence(snd_pcm_format_t format, void *buf, unsigned int frames);
-snd_pcm_format_t snd_pcm_build_linear_format(int width, int unsigned, int big_endian);
 
 void snd_pcm_set_ops(struct snd_pcm * pcm, int direction,
 		     const struct snd_pcm_ops *ops);
 void snd_pcm_set_sync(struct snd_pcm_substream *substream);
-int snd_pcm_lib_interleave_len(struct snd_pcm_substream *substream);
 int snd_pcm_lib_ioctl(struct snd_pcm_substream *substream,
 		      unsigned int cmd, void *arg);                      
 int snd_pcm_update_state(struct snd_pcm_substream *substream,
 			 struct snd_pcm_runtime *runtime);
 int snd_pcm_update_hw_ptr(struct snd_pcm_substream *substream);
-int snd_pcm_playback_xrun_check(struct snd_pcm_substream *substream);
-int snd_pcm_capture_xrun_check(struct snd_pcm_substream *substream);
-int snd_pcm_playback_xrun_asap(struct snd_pcm_substream *substream);
-int snd_pcm_capture_xrun_asap(struct snd_pcm_substream *substream);
 void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_uframes_t new_hw_ptr);
 void snd_pcm_period_elapsed(struct snd_pcm_substream *substream);
 snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream,
-- 
1.8.0
