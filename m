From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: fix inappropriate assignment between signed/unsigned type
Date: Fri, 14 Apr 2017 12:43:01 +0900
Message-ID: <20170414034301.7310-1-o-takashi@sakamocchi.jp>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net, "# 4 . 4+" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

An abstraction of asynchronous transaction for transmission of MIDI
messages was introduced in Linux v4.4. Each driver can utilize this
abstraction to transfer MIDI messages via fixed-length payload of
transaction to a certain unit address. Filling payload of the transaction
is done by callback. In this callback, each driver can return negative
error code, however current implementation assigns the return value to
unsigned variable.

This commit changes type of the variable to fix the bug.

Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: <stable@vger.kernel.org> # 4.4+
Fixes: 585d7cba5e1f ("ALSA: firewire-lib: add helper functions for asynchronous transactions to transfer MIDI messages")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/lib.h b/sound/firewire/lib.h
index f676931..c3768cd 100644
--- a/sound/firewire/lib.h
+++ b/sound/firewire/lib.h
@@ -45,7 +45,7 @@ struct snd_fw_async_midi_port {
 
 	struct snd_rawmidi_substream *substream;
 	snd_fw_async_midi_port_fill fill;
-	unsigned int consume_bytes;
+	int consume_bytes;
 };
 
 int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
-- 
2.9.3
