From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: dice: unuse second stream for MIDI
	conformant data channel for TC Electronic models
Date: Sun, 27 May 2018 10:13:30 +0900
Message-ID: <20180527011330.9817-3-o-takashi@sakamocchi.jp>
References: <20180527011330.9817-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f65.google.com (mail-pl0-f65.google.com
 [209.85.160.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FB2A2670BE
 for <alsa-devel@alsa-project.org>; Sun, 27 May 2018 03:14:06 +0200 (CEST)
Received: by mail-pl0-f65.google.com with SMTP id ay10-v6so5220878plb.1
 for <alsa-devel@alsa-project.org>; Sat, 26 May 2018 18:14:06 -0700 (PDT)
In-Reply-To: <20180527011330.9817-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

At present, all of models produced by TC Electronic except for Konnekt Live
are supported with hard-coded their stream formats. Studio Konnekt 48 is
sore model to support dual streams for both directions. The second stream
has no MIDI conformant data channel in its data block. But current
implementation transfers the second stream with MIDI conformant data
channel.

This commit fixes this issue.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-tcelectronic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/dice/dice-tcelectronic.c b/sound/firewire/dice/dice-tcelectronic.c
index a4cbe2da8c15..a8875d24ba2a 100644
--- a/sound/firewire/dice/dice-tcelectronic.c
+++ b/sound/firewire/dice/dice-tcelectronic.c
@@ -95,11 +95,9 @@ int snd_dice_detect_tcelectronic_formats(struct snd_dice *dice)
 	memcpy(dice->rx_pcm_chs, entry->spec->rx_pcm_chs,
 	       MAX_STREAMS * SND_DICE_RATE_MODE_COUNT * sizeof(unsigned int));
 
-	for (i = 0; i < MAX_STREAMS; ++i) {
-		if (entry->spec->has_midi) {
-			dice->tx_midi_ports[i] = 1;
-			dice->rx_midi_ports[i] = 1;
-		}
+	if (entry->spec->has_midi) {
+		dice->tx_midi_ports[0] = 1;
+		dice->rx_midi_ports[0] = 1;
 	}
 
 	return 0;
-- 
2.14.1
