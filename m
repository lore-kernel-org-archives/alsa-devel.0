From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] rawmidi: remove undefined functions.
Date: Thu, 20 Feb 2014 23:59:24 +0900
Message-ID: <1392908364-8301-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 003B42657B2
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 15:59:33 +0100 (CET)
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

'snd_rawmidi_transmit_reset()' and 'snd_rawmidi_receive_reset()' are declared
but not defined.

This state has been continue over 10 years. So let us remove them.
---
 include/sound/rawmidi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index adf0885..311dafe 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -157,10 +157,8 @@ void snd_rawmidi_set_ops(struct snd_rawmidi *rmidi, int stream,
 
 /* callbacks */
 
-void snd_rawmidi_receive_reset(struct snd_rawmidi_substream *substream);
 int snd_rawmidi_receive(struct snd_rawmidi_substream *substream,
 			const unsigned char *buffer, int count);
-void snd_rawmidi_transmit_reset(struct snd_rawmidi_substream *substream);
 int snd_rawmidi_transmit_empty(struct snd_rawmidi_substream *substream);
 int snd_rawmidi_transmit_peek(struct snd_rawmidi_substream *substream,
 			      unsigned char *buffer, int count);
-- 
1.8.3.2
