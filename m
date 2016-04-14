From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm : Call kill_fasync() in stream lock
Date: Thu, 14 Apr 2016 18:11:36 +0200
Message-ID: <1460650296-16883-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7158B260870
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2016 18:11:39 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4435BAB08
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2016 16:11:36 +0000 (UTC)
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

Currently kill_fasync() is called outside the stream lock in
snd_pcm_period_elapsed().  This is potentially racy, since the stream
may get released even during the irq handler is running.  Although
snd_pcm_release_substream() calls snd_pcm_drop(), this doesn't
guarantee that the irq handler finishes, thus the kill_fasync() call
outside the stream spin lock may be invoked after the substream is
detached, as recently reported by KASAN.

As a quick workaround, move kill_fasync() call inside the stream
lock.  The fasync is rarely used interface, so this shouldn't have a
big impact from the performance POV.

Ideally, we should implement some sync mechanism for the proper finish
of stream and irq handler.  But this oneliner should suffice for most
cases, so far.

Reported-by: Baozeng Ding <sploving1@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 3a9b66c6e09c..0aca39762ed0 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1886,8 +1886,8 @@ void snd_pcm_period_elapsed(struct snd_pcm_substream *substream)
 		snd_timer_interrupt(substream->timer, 1);
 #endif
  _end:
-	snd_pcm_stream_unlock_irqrestore(substream, flags);
 	kill_fasync(&runtime->fasync, SIGIO, POLL_IN);
+	snd_pcm_stream_unlock_irqrestore(substream, flags);
 }
 
 EXPORT_SYMBOL(snd_pcm_period_elapsed);
-- 
2.8.1
