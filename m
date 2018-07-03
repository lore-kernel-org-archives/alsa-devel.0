From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] jack: Allow build with older alsa-lib
Date: Tue,  3 Jul 2018 17:37:45 +0200
Message-ID: <20180703153746.31250-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CB632677A8
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 17:37:48 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 0DD05B06A
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 15:37:48 +0000 (UTC)
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

The new API snd_pcm_ioplug_avail() doesn't appear prior to alsa-lib
1.1.7.  Add an own code for allowing the build with alsa-lib 1.1.6.

It has a very slight overhead than the original snd_pcm_ioplug_avail()
but should be OK as a workaround.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 jack/pcm_jack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 98a6f7ebb82e..fbc9dafc594b 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -58,6 +58,15 @@ typedef struct {
 
 static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io);
 
+/* snd_pcm_ioplug_avail() was introduced after alsa-lib 1.1.6 */
+#if SND_LIB_VERSION < 0x10107
+static snd_pcm_uframes_t snd_pcm_ioplug_avail(const snd_pcm_ioplug_t *io,
+					      const snd_pcm_uframes_t hw_ptr,
+					      const snd_pcm_uframes_t appl_ptr)
+{
+	return io->buffer_size - snd_pcm_ioplug_hw_avail(io, hw_ptr, appl_ptr);
+}
+#endif
 
 static int pcm_poll_block_check(snd_pcm_ioplug_t *io)
 {
-- 
2.18.0
