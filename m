From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: sb: remove needless evaluation in
	implementation for copy callback
Date: Tue, 23 May 2017 22:40:42 +0900
Message-ID: <20170523134042.1056-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 006A22670F8
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 15:40:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In design of ALSA pcm core, 'struct snd_pcm_ops.copy' is expected to
copy PCM frames, according to frame alignment on intermediate buffer for
userspace and dedicated buffer for data transmission. In this callback,
value of 'channel' argument depends on the frame alignment, which drivers
registers to runtime of PCM substream. When target devices can handle
non-interleaved buffer, this value has positive value, otherwise negative.

ALSA driver for PCM component of EMU8000 chip is programmed with local
macro to switch the frame alignment. The 'copy' operation in
non-interleaved side has evaluation of the 'channel' argument (actually
it's 'voice' argument). This is useless.

This commit remove the evaluation.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/isa/sb/emu8000_pcm.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/sound/isa/sb/emu8000_pcm.c b/sound/isa/sb/emu8000_pcm.c
index 32f234f494e5..bab796d75dbd 100644
--- a/sound/isa/sb/emu8000_pcm.c
+++ b/sound/isa/sb/emu8000_pcm.c
@@ -450,20 +450,8 @@ static int emu8k_pcm_copy(struct snd_pcm_substream *subs,
 	struct snd_emu8000 *emu = rec->emu;
 
 	snd_emu8000_write_wait(emu, 1);
-	if (voice == -1) {
-		unsigned short *buf = src;
-		int i, err;
-		count /= rec->voices;
-		for (i = 0; i < rec->voices; i++) {
-			err = emu8k_transfer_block(emu, pos + rec->loop_start[i], buf, count);
-			if (err < 0)
-				return err;
-			buf += count;
-		}
-		return 0;
-	} else {
-		return emu8k_transfer_block(emu, pos + rec->loop_start[voice], src, count);
-	}
+	return emu8k_transfer_block(emu, pos + rec->loop_start[voice], src,
+				    count);
 }
 
 /* make a channel block silence */
@@ -487,17 +475,9 @@ static int emu8k_pcm_silence(struct snd_pcm_substream *subs,
 	struct snd_emu8000 *emu = rec->emu;
 
 	snd_emu8000_write_wait(emu, 1);
-	if (voice == -1 && rec->voices == 1)
+	if (rec->voices == 1)
 		voice = 0;
-	if (voice == -1) {
-		int err;
-		err = emu8k_silence_block(emu, pos + rec->loop_start[0], count / 2);
-		if (err < 0)
-			return err;
-		return emu8k_silence_block(emu, pos + rec->loop_start[1], count / 2);
-	} else {
-		return emu8k_silence_block(emu, pos + rec->loop_start[voice], count);
-	}
+	return emu8k_silence_block(emu, pos + rec->loop_start[voice], count);
 }
 
 #else /* interleave */
-- 
2.11.0
