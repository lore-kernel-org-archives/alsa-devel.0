From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH 5/9] pcm,
	null: use the snd_pcm_mmap_avail function
Date: Sun, 14 Sep 2014 00:30:17 +0600
Message-ID: <1410633021-20395-6-git-send-email-patrakov@gmail.com>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f50.google.com (mail-la0-f50.google.com
 [209.85.215.50])
 by alsa0.perex.cz (Postfix) with ESMTP id CE09A261B2D
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 20:30:54 +0200 (CEST)
Received: by mail-la0-f50.google.com with SMTP id ty20so2668718lab.9
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 11:30:54 -0700 (PDT)
In-Reply-To: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

instead of the open-coded equivalent

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/pcm/pcm_null.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/pcm/pcm_null.c b/src/pcm/pcm_null.c
index f11a102..0529820 100644
--- a/src/pcm/pcm_null.c
+++ b/src/pcm/pcm_null.c
@@ -86,10 +86,7 @@ static snd_pcm_sframes_t snd_pcm_null_avail_update(snd_pcm_t *pcm)
         if (null->state == SND_PCM_STATE_PREPARED) {
                 /* it is required to return the correct avail count for */
                 /* the prepared stream, otherwise the start is not called */
-                if (pcm->stream == SND_PCM_STREAM_PLAYBACK)
-                        return snd_pcm_mmap_playback_avail(pcm);
-                else
-                        return snd_pcm_mmap_capture_avail(pcm);
+                return snd_pcm_mmap_avail(pcm);
         }
 	return pcm->buffer_size;
 }
-- 
2.1.0
