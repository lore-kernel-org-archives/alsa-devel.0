From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/8] ALSA: fireface: share register for async
	transaction of MIDI messages
Date: Tue, 11 Dec 2018 19:17:32 +0900
Message-ID: <20181211101735.13735-6-o-takashi@sakamocchi.jp>
References: <20181211101735.13735-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by alsa0.perex.cz (Postfix) with ESMTP id C17F1267B8B
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 11:17:53 +0100 (CET)
Received: by mail-pg1-f196.google.com with SMTP id n2so6431714pgm.3
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 02:17:53 -0800 (PST)
In-Reply-To: <20181211101735.13735-1-o-takashi@sakamocchi.jp>
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

As long as investigating packet dumps from Fireface 400/800, a register
to receive asynchronous transactions for MIDI messages is the same. For
Fireface 800, minor register is used.

This commit declares macros for the transactions and obsoletes
model-specific parameters.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-ff400.c | 4 ----
 sound/firewire/fireface/ff-transaction.c    | 7 +++++--
 sound/firewire/fireface/ff.h                | 2 --
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-ff400.c b/sound/firewire/fireface/ff-protocol-ff400.c
index d2fbb0382223..5cbaff9d6a40 100644
--- a/sound/firewire/fireface/ff-protocol-ff400.c
+++ b/sound/firewire/fireface/ff-protocol-ff400.c
@@ -16,8 +16,6 @@
 #define FF400_ISOC_COMM_STOP	0x000080100510ull
 
 #define FF400_MIDI_HIGH_ADDR	0x0000801003f4ull
-#define FF400_MIDI_RX_PORT_0	0x000080180000ull
-#define FF400_MIDI_RX_PORT_1	0x000080190000ull
 
 static int ff400_begin_session(struct snd_ff *ff, unsigned int rate)
 {
@@ -115,6 +113,4 @@ const struct snd_ff_protocol snd_ff_protocol_ff400 = {
 	.switch_fetching_mode	= ff400_switch_fetching_mode,
 
 	.midi_high_addr_reg	= FF400_MIDI_HIGH_ADDR,
-	.midi_rx_port_0_reg	= FF400_MIDI_RX_PORT_0,
-	.midi_rx_port_1_reg	= FF400_MIDI_RX_PORT_1,
 };
diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index 751662b62389..fa0bc956696f 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -8,6 +8,9 @@
 
 #include "ff.h"
 
+#define SND_FF_REG_MIDI_RX_PORT_0	0x000080180000ull
+#define SND_FF_REG_MIDI_RX_PORT_1	0x000080190000ull
+
 int snd_ff_transaction_get_clock(struct snd_ff *ff, unsigned int *rate,
 				 enum snd_ff_clock_src *src)
 {
@@ -153,10 +156,10 @@ static void transmit_midi_msg(struct snd_ff *ff, unsigned int port)
 		fill_midi_buf(ff, port, i, buf[i]);
 
 	if (port == 0) {
-		addr = ff->spec->protocol->midi_rx_port_0_reg;
+		addr = SND_FF_REG_MIDI_RX_PORT_0;
 		callback = finish_transmit_midi0_msg;
 	} else {
-		addr = ff->spec->protocol->midi_rx_port_1_reg;
+		addr = SND_FF_REG_MIDI_RX_PORT_1;
 		callback = finish_transmit_midi1_msg;
 	}
 
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 95cf90b4b533..ea905285beab 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -107,8 +107,6 @@ struct snd_ff_protocol {
 	int (*switch_fetching_mode)(struct snd_ff *ff, bool enable);
 
 	u64 midi_high_addr_reg;
-	u64 midi_rx_port_0_reg;
-	u64 midi_rx_port_1_reg;
 };
 
 extern const struct snd_ff_protocol snd_ff_protocol_ff400;
-- 
2.19.1
