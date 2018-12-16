From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/5] ALSA: fireface: code refactoring to handle
	model-specific registers
Date: Sun, 16 Dec 2018 17:32:33 +0900
Message-ID: <20181216083233.11358-6-o-takashi@sakamocchi.jp>
References: <20181216083233.11358-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 02BA2267946
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 09:32:58 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id u6so4683829plm.8
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 00:32:58 -0800 (PST)
In-Reply-To: <20181216083233.11358-1-o-takashi@sakamocchi.jp>
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

As a result of investigation for Fireface 800, 'struct snd_ff_spec.regs'
is just for higher address to receive tx asynchronous packets of MIDI
messages, thus it can be simplified.

This commit simplifies it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-transaction.c | 4 ++--
 sound/firewire/fireface/ff.c             | 8 ++------
 sound/firewire/fireface/ff.h             | 9 ++-------
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index d8768348067b..5f4ddfd55403 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -278,7 +278,7 @@ int snd_ff_transaction_reregister(struct snd_ff *ff)
 	addr = (fw_card->node_id << 16) | (ff->async_handler.offset >> 32);
 	reg = cpu_to_le32(addr);
 	return snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
-				  ff->spec->regs[SND_FF_REG_TYPE_MIDI_HIGH_ADDR],
+				  ff->spec->midi_high_addr,
 				  &reg, sizeof(reg), 0);
 }
 
@@ -319,7 +319,7 @@ void snd_ff_transaction_unregister(struct snd_ff *ff)
 	/* Release higher 4 bytes of address. */
 	reg = cpu_to_le32(0x00000000);
 	snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
-			   ff->spec->regs[SND_FF_REG_TYPE_MIDI_HIGH_ADDR],
+			   ff->spec->midi_high_addr,
 			   &reg, sizeof(reg), 0);
 
 	fw_core_remove_address_handler(&ff->async_handler);
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index f7a752930060..36575f4159d1 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -152,9 +152,7 @@ static const struct snd_ff_spec spec_ff800 = {
 	.midi_in_ports = 1,
 	.midi_out_ports = 1,
 	.protocol = &snd_ff_protocol_ff800,
-	.regs = {
-		[SND_FF_REG_TYPE_MIDI_HIGH_ADDR] = 0x000200000320ull,
-	},
+	.midi_high_addr = 0x000200000320ull,
 };
 
 static const struct snd_ff_spec spec_ff400 = {
@@ -164,9 +162,7 @@ static const struct snd_ff_spec spec_ff400 = {
 	.midi_in_ports = 2,
 	.midi_out_ports = 2,
 	.protocol = &snd_ff_protocol_ff400,
-	.regs = {
-		[SND_FF_REG_TYPE_MIDI_HIGH_ADDR] = 0x0000801003f4ull,
-	},
+	.midi_high_addr = 0x0000801003f4ull,
 };
 
 static const struct ieee1394_device_id snd_ff_id_table[] = {
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 9fdda4fbdbba..7dfc7745a914 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -36,7 +36,7 @@
 #define SND_FF_OUT_MIDI_PORTS		2
 
 #define SND_FF_REG_SYNC_STATUS		0x0000801c0000ull
-/* For block wriet request. */
+/* For block write request. */
 #define SND_FF_REG_FETCH_PCM_FRAMES	0x0000801c0000ull
 #define SND_FF_REG_CLOCK_CONFIG		0x0000801c0004ull
 
@@ -47,11 +47,6 @@ enum snd_ff_stream_mode {
 	SND_FF_STREAM_MODE_COUNT,
 };
 
-enum snd_ff_reg_type {
-	SND_FF_REG_TYPE_MIDI_HIGH_ADDR = 0,
-	SND_FF_REG_TYPE_COUNT,
-};
-
 struct snd_ff_protocol;
 struct snd_ff_spec {
 	const char *const name;
@@ -63,7 +58,7 @@ struct snd_ff_spec {
 	unsigned int midi_out_ports;
 
 	const struct snd_ff_protocol *protocol;
-	u64 regs[SND_FF_REG_TYPE_COUNT];
+	u64 midi_high_addr;
 };
 
 struct snd_ff {
-- 
2.19.1
