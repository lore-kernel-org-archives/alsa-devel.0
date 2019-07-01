From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib/fireworks: fix miss detection of received MIDI messages
Date: Mon,  1 Jul 2019 19:59:27 +0900
Message-ID: <20190701105927.13998-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In IEC 61883-6, 8 MIDI data streams are multiplexed into single
MIDI conformant data channel. The index of stream is calculated by
modulo 8 of the value of data block counter.

In fireworks, the value of data block counter in CIP header has a quirk
with firmware version v5.0.0, v5.7.3 and v5.8.0. This brings ALSA
IEC 61883-1/6 packet streaming engine to miss detection of MIDI
messages.

This commit fixes the miss detection to modify the value of data block
counter for the modulo calculation.

For maintainers, this bug exists since a commit 18f5ed365d3f ("ALSA:
fireworks/firewire-lib: add support for recent firmware quirk") in Linux
kernel v4.2. There're many changes since the commit.  This fix can be
backported to Linux kernel v4.4 or later. I tagged a base commit to the
backport for your convenience.

Besides, my work for Linux kernel v5.3 brings heavy code refactoring and
some structure members are renamed in 'sound/firewire/amdtp-stream.h'.
The content of this patch brings conflict when merging -rc tree with
this patch to the latest tree. I request maintainers to solve the
conflict by replacing 'tx_first_dbc' with 'ctx_data.tx.first_dbc'.

Fixes: df075feefbd3 ("ALSA: firewire-lib: complete AM824 data block processing layer")
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-am824.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/firewire/amdtp-am824.c b/sound/firewire/amdtp-am824.c
index 4210e5c6262e..4d677fcb4fc2 100644
--- a/sound/firewire/amdtp-am824.c
+++ b/sound/firewire/amdtp-am824.c
@@ -321,6 +321,7 @@ static void read_midi_messages(struct amdtp_stream *s,
 	u8 *b;
 
 	for (f = 0; f < frames; f++) {
+		port = (8 - s->tx_first_dbc + s->data_block_counter + f) % 8;
 		port = (s->data_block_counter + f) % 8;
 		b = (u8 *)&buffer[p->midi_position];
 
-- 
2.20.1
