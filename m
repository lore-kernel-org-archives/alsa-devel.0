From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/6] ALSA: fireface: add model-dependent
	parameter for address range to receive async transaction
Date: Tue, 22 Jan 2019 22:17:01 +0900
Message-ID: <20190122131705.23213-3-o-takashi@sakamocchi.jp>
References: <20190122131705.23213-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id B1D4626749F
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 14:17:18 +0100 (CET)
Received: by mail-pg1-f194.google.com with SMTP id g189so11060323pgc.5
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 05:17:17 -0800 (PST)
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

In Fireface series, drivers can register destination address for
asynchronous transaction which transfers MIDI messages from device.

In former models, all of the transactions arrive at the registered
address without any offset. In latter models, each of the transaction
arrives at the registered address with sequential offset within 0x00
to 0x7f. This seems to be for discontinuity detection.

This commit adds model-dependent member for the address range.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-transaction.c | 2 +-
 sound/firewire/fireface/ff.c             | 2 ++
 sound/firewire/fireface/ff.h             | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index d3fde813ce17..0506755891ce 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -156,7 +156,7 @@ static int allocate_own_address(struct snd_ff *ff, int i)
 	struct fw_address_region midi_msg_region;
 	int err;
 
-	ff->async_handler.length = SND_FF_MAXIMIM_MIDI_QUADS * 4;
+	ff->async_handler.length = ff->spec->midi_addr_range;
 	ff->async_handler.address_callback = handle_midi_msg;
 	ff->async_handler.callback_data = ff;
 
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index fd9c980e3cf4..c09a4875aa86 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -159,6 +159,7 @@ static const struct snd_ff_spec spec_ff800 = {
 	.midi_out_ports = 1,
 	.protocol = &snd_ff_protocol_ff800,
 	.midi_high_addr = 0x000200000320ull,
+	.midi_addr_range = 12,
 };
 
 static const struct snd_ff_spec spec_ff400 = {
@@ -169,6 +170,7 @@ static const struct snd_ff_spec spec_ff400 = {
 	.midi_out_ports = 2,
 	.protocol = &snd_ff_protocol_ff400,
 	.midi_high_addr = 0x0000801003f4ull,
+	.midi_addr_range = SND_FF_MAXIMIM_MIDI_QUADS * 4,
 };
 
 static const struct snd_ff_spec spec_ucx = {
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index ddcffb8d85c6..b86ca4fb7d9b 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -54,6 +54,7 @@ struct snd_ff_spec {
 
 	const struct snd_ff_protocol *protocol;
 	u64 midi_high_addr;
+	u8 midi_addr_range;
 };
 
 struct snd_ff {
-- 
2.19.1
