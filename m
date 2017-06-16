From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Fix possible inconsistent appl_ptr
	update via mmap
Date: Fri, 16 Jun 2017 22:40:55 +0200
Message-ID: <20170616204055.31036-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C7C06266CFE
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 22:41:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 288F3AC08
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 20:41:00 +0000 (UTC)
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

The ALSA PCM core refers to the appl_ptr value stored on the mmapped
page that is shared between kernel and user-space.  Although the
reference is performed in the PCM stream lock, it doesn't guarantee
the atomic access when the value gets updated concurrently from the
user-space on another CPU.

In most of codes, this is no big problem, but still there are a few
places that may result in slight inconsistencies because they access
runtime->control->appl_ptr multiple times; that is, the second read
might be a different value from the first value.  It can be even
backward or jumping, as we have no control for it.  Hence, the
calculation may give an unexpected value.  Luckily, there is no
security vulnerability by that, as far as I've checked.  But still we
should address it.

This patch tries to reduce such possible cases.  The fix is simple --
we just read once, store it to a local variable and use it for the
rest calculations.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 631cd598ba6c..cda258d91490 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -65,15 +65,16 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 
 	if (runtime->silence_size < runtime->boundary) {
 		snd_pcm_sframes_t noise_dist, n;
-		if (runtime->silence_start != runtime->control->appl_ptr) {
-			n = runtime->control->appl_ptr - runtime->silence_start;
+		snd_pcm_uframes_t appl_ptr = runtime->control->appl_ptr;
+		if (runtime->silence_start != appl_ptr) {
+			n = appl_ptr - runtime->silence_start;
 			if (n < 0)
 				n += runtime->boundary;
 			if ((snd_pcm_uframes_t)n < runtime->silence_filled)
 				runtime->silence_filled -= n;
 			else
 				runtime->silence_filled = 0;
-			runtime->silence_start = runtime->control->appl_ptr;
+			runtime->silence_start = appl_ptr;
 		}
 		if (runtime->silence_filled >= runtime->buffer_size)
 			return;
@@ -2224,7 +2225,9 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 				continue; /* draining */
 		}
 		frames = size > avail ? avail : size;
-		cont = runtime->buffer_size - runtime->control->appl_ptr % runtime->buffer_size;
+		appl_ptr = runtime->control->appl_ptr;
+		appl_ofs = appl_ptr % runtime->buffer_size;
+		cont = runtime->buffer_size - appl_ofs;
 		if (frames > cont)
 			frames = cont;
 		if (snd_BUG_ON(!frames)) {
@@ -2232,8 +2235,6 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 			snd_pcm_stream_unlock_irq(substream);
 			return -EINVAL;
 		}
-		appl_ptr = runtime->control->appl_ptr;
-		appl_ofs = appl_ptr % runtime->buffer_size;
 		snd_pcm_stream_unlock_irq(substream);
 		err = writer(substream, appl_ofs, data, offset, frames,
 			     transfer);
-- 
2.13.1
