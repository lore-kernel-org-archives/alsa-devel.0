From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/6] ALSA: fireface: add model-dependent
	parameter for address to receive async transaction for MIDI messages
Date: Tue, 22 Jan 2019 22:17:03 +0900
Message-ID: <20190122131705.23213-5-o-takashi@sakamocchi.jp>
References: <20190122131705.23213-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D7BA2674AC
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 14:17:21 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id y1so11468253plp.9
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 05:17:21 -0800 (PST)
In-Reply-To: <20190122131705.23213-1-o-takashi@sakamocchi.jp>
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

Between former and latter models, destination address to receive
asynchronous transactions for MIDI messages is different.

This commit adds model-dependent parameter for the addresses.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-transaction.c | 7 ++-----
 sound/firewire/fireface/ff.c             | 3 +++
 sound/firewire/fireface/ff.h             | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index 0506755891ce..92ca76ab7537 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -8,9 +8,6 @@
 
 #include "ff.h"
 
-#define SND_FF_REG_MIDI_RX_PORT_0	0x000080180000ull
-#define SND_FF_REG_MIDI_RX_PORT_1	0x000080190000ull
-
 static void finish_transmit_midi_msg(struct snd_ff *ff, unsigned int port,
 				     int rcode)
 {
@@ -93,10 +90,10 @@ static void transmit_midi_msg(struct snd_ff *ff, unsigned int port)
 		fill_midi_buf(ff, port, i, buf[i]);
 
 	if (port == 0) {
-		addr = SND_FF_REG_MIDI_RX_PORT_0;
+		addr = ff->spec->midi_rx_addrs[0];
 		callback = finish_transmit_midi0_msg;
 	} else {
-		addr = SND_FF_REG_MIDI_RX_PORT_1;
+		addr = ff->spec->midi_rx_addrs[1];
 		callback = finish_transmit_midi1_msg;
 	}
 
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index a2a9fd82f27d..675c6ab556eb 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -154,6 +154,7 @@ static const struct snd_ff_spec spec_ff800 = {
 	.protocol = &snd_ff_protocol_ff800,
 	.midi_high_addr = 0x000200000320ull,
 	.midi_addr_range = 12,
+	.midi_rx_addrs = {0x000080180000ull, 0},
 };
 
 static const struct snd_ff_spec spec_ff400 = {
@@ -165,6 +166,7 @@ static const struct snd_ff_spec spec_ff400 = {
 	.protocol = &snd_ff_protocol_ff400,
 	.midi_high_addr = 0x0000801003f4ull,
 	.midi_addr_range = SND_FF_MAXIMIM_MIDI_QUADS * 4,
+	.midi_rx_addrs = {0x000080180000ull, 0x000080190000ull},
 };
 
 static const struct snd_ff_spec spec_ucx = {
@@ -175,6 +177,7 @@ static const struct snd_ff_spec spec_ucx = {
 	.protocol = &snd_ff_protocol_latter,
 	.midi_high_addr = 0xffff00000034ull,
 	.midi_addr_range = 0x80,
+	.midi_rx_addrs = {0xffff00000030ull, 0xffff00000030ull},
 };
 
 static const struct ieee1394_device_id snd_ff_id_table[] = {
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index b86ca4fb7d9b..edad75a4b260 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -55,6 +55,7 @@ struct snd_ff_spec {
 	const struct snd_ff_protocol *protocol;
 	u64 midi_high_addr;
 	u8 midi_addr_range;
+	u64 midi_rx_addrs[SND_FF_OUT_MIDI_PORTS];
 };
 
 struct snd_ff {
-- 
2.19.1
