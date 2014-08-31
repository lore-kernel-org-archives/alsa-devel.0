From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH alsa-lib] pcm: fix snd_pcm_mmap_hw_avail() near
	the boundary
Date: Sun, 31 Aug 2014 22:23:47 +0600
Message-ID: <1409502227-4505-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id DB0AC261B0A
 for <alsa-devel@alsa-project.org>; Sun, 31 Aug 2014 18:23:58 +0200 (CEST)
Received: by mail-lb0-f169.google.com with SMTP id l4so4811408lbv.0
 for <alsa-devel@alsa-project.org>; Sun, 31 Aug 2014 09:23:58 -0700 (PDT)
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
Cc: "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

This function returned incorrect results when hw.ptr was near the
boundary and hw.appl_ptr was near zero. Here "incorrect" means "greater
than the boundary".

The result was incorrect, because it was used as a return value of
various *_rewindable() functions and also as the delay for ioplug.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/pcm/pcm_local.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 80bbe59..74ebd60 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -461,13 +461,7 @@ static inline snd_pcm_sframes_t snd_pcm_mmap_capture_hw_avail(snd_pcm_t *pcm)
 
 static inline snd_pcm_sframes_t snd_pcm_mmap_hw_avail(snd_pcm_t *pcm)
 {
-	snd_pcm_sframes_t avail;
-	avail = *pcm->hw.ptr - *pcm->appl.ptr;
-	if (pcm->stream == SND_PCM_STREAM_PLAYBACK)
-		avail += pcm->buffer_size;
-	if (avail < 0)
-		avail += pcm->boundary;
-	return pcm->buffer_size - avail;
+	return pcm->buffer_size - snd_pcm_mmap_avail(pcm);
 }
 
 static inline const snd_pcm_channel_area_t *snd_pcm_mmap_areas(snd_pcm_t *pcm)
-- 
2.1.0
