From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] alsa: snd_pcm_new api cleanup
Date: Thu, 5 Feb 2009 13:01:54 +0100
Message-ID: <20090205130154.2839e1cc@thinkpad>
References: <s5hfxit6s0m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 60C561037FD
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 13:01:54 +0100 (CET)
In-Reply-To: <s5hfxit6s0m.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Impact: cleanup

snd_pcm_new takes a char *id argument, although it is not modifying
the string. it can therefore be declared as const char *id.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 include/sound/pcm.h |    2 +-
 sound/core/pcm.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 40c5a6f..ee0e887 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -451,7 +451,7 @@ struct snd_pcm_notify {
 
 extern const struct file_operations snd_pcm_f_ops[2];
 
-int snd_pcm_new(struct snd_card *card, char *id, int device,
+int snd_pcm_new(struct snd_card *card, const char *id, int device,
 		int playback_count, int capture_count,
 		struct snd_pcm **rpcm);
 int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count);
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 192a433..583453e 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -692,7 +692,7 @@ EXPORT_SYMBOL(snd_pcm_new_stream);
  *
  * Returns zero if successful, or a negative error code on failure.
  */
-int snd_pcm_new(struct snd_card *card, char *id, int device,
+int snd_pcm_new(struct snd_card *card, const char *id, int device,
 		int playback_count, int capture_count,
 	        struct snd_pcm ** rpcm)
 {
-- 
1.5.6.3
