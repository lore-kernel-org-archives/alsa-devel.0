From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: fireface: comment cleanup about
	destination address of async transactions for MIDI messages
Date: Thu, 24 Jan 2019 18:32:03 +0900
Message-ID: <20190124093203.15589-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id D8C4526756F
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 10:32:11 +0100 (CET)
Received: by mail-pf1-f196.google.com with SMTP id b85so2713436pfc.3
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 01:32:11 -0800 (PST)
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

In Fireface series, registration of higher 4 bytes of destination
address for asynchronous transaction of MIDI messages is done by
a write transaction to model-specific register.

On the other hand, registration of lower 4 bytes of the address is
selectable from 4 options. A register for this registration includes
the other purpose options such as input attenuation. Thus this
driver expects userspace applications to configure the register.

Actual behaviour for the asynchronous transaction is different
depending on protocols. In former protocol, destination offset
of each transaction is the same as the registered address even if
it is block request. In latter models, destination offset of each
transaction is the offset of previous transaction plus 4 byte
and the transaction is quadlet request.

This commit cleanups comments about the above mechanism.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-former.c | 23 +++++++++++++
 sound/firewire/fireface/ff-protocol-latter.c | 18 ++++++++++
 sound/firewire/fireface/ff-transaction.c     | 36 ++++----------------
 3 files changed, 48 insertions(+), 29 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-former.c b/sound/firewire/fireface/ff-protocol-former.c
index e0acf40a02ee..8d1c2c6e907b 100644
--- a/sound/firewire/fireface/ff-protocol-former.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -396,6 +396,10 @@ static void ff800_finish_session(struct snd_ff *ff)
 			   FF800_ISOC_COMM_STOP, &reg, sizeof(reg), 0);
 }
 
+// Fireface 800 doesn't allow drivers to register lower 4 bytes of destination
+// address.
+// A write transaction to clear registered higher 4 bytes of destination address
+// has an effect to suppress asynchronous transaction from device.
 static void ff800_handle_midi_msg(struct snd_ff *ff, unsigned int offset,
 				  __le32 *buf, size_t length)
 {
@@ -525,6 +529,25 @@ static void ff400_finish_session(struct snd_ff *ff)
 			   FF400_ISOC_COMM_STOP, &reg, sizeof(reg), 0);
 }
 
+// For Fireface 400, lower 4 bytes of destination address is configured by bit
+// flag in quadlet register (little endian) at 0x'0000'801'0051c. Drivers can
+// select one of 4 options:
+//
+// bit flags: offset of destination address
+//  - 0x04000000: 0x'....'....'0000'0000
+//  - 0x08000000: 0x'....'....'0000'0080
+//  - 0x10000000: 0x'....'....'0000'0100
+//  - 0x20000000: 0x'....'....'0000'0180
+//
+// Drivers can suppress the device to transfer asynchronous transactions by
+// using below 2 bits.
+//  - 0x01000000: suppress transmission
+//  - 0x02000000: suppress transmission
+//
+// Actually, the register is write-only and includes the other options such as
+// input attenuation. This driver allocates destination address with '0000'0000
+// in its lower offset and expects userspace application to configure the
+// register for it.
 static void ff400_handle_midi_msg(struct snd_ff *ff, unsigned int offset,
 				  __le32 *buf, size_t length)
 {
diff --git a/sound/firewire/fireface/ff-protocol-latter.c b/sound/firewire/fireface/ff-protocol-latter.c
index 817af4447349..0fbc1950327f 100644
--- a/sound/firewire/fireface/ff-protocol-latter.c
+++ b/sound/firewire/fireface/ff-protocol-latter.c
@@ -266,6 +266,24 @@ static void latter_dump_status(struct snd_ff *ff, struct snd_info_buffer *buffer
 
 // NOTE: transactions are transferred within 0x00-0x7f in allocated range of
 // address. This seems to be for check of discontinuity in receiver side.
+//
+// Like Fireface 400, drivers can select one of 4 options for lower 4 bytes of
+// destination address by bit flags in quadlet register (little endian) at
+// 0x'ffff'0000'0014:
+//
+// bit flags: offset of destination address
+// - 0x00002000: 0x'....'....'0000'0000
+// - 0x00004000: 0x'....'....'0000'0080
+// - 0x00008000: 0x'....'....'0000'0100
+// - 0x00010000: 0x'....'....'0000'0180
+//
+// Drivers can suppress the device to transfer asynchronous transactions by
+// clear these bit flags.
+//
+// Actually, the register is write-only and includes the other settings such as
+// input attenuation. This driver allocates for the first option
+// (0x'....'....'0000'0000) and expects userspace application to configure the
+// register for it.
 static void latter_handle_midi_msg(struct snd_ff *ff, unsigned int offset,
 				   __le32 *buf, size_t length)
 {
diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index d8a8b01b39a1..0d6ad19363b8 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -165,35 +165,13 @@ static int allocate_own_address(struct snd_ff *ff, int i)
 	return err;
 }
 
-/*
- * Controllers are allowed to register higher 4 bytes of address to receive
- * the transactions. Different models have different registers for this purpose;
- * e.g. 0x'0000'8010'03f4 for Fireface 400.
- * The controllers are not allowed to register lower 4 bytes of the address.
- * They are forced to select one of 4 options for the part of address by writing
- * corresponding bits to 0x'0000'8010'051f.
- *
- * The 3rd-6th bits of this register are flags to indicate lower 4 bytes of
- * address to which the device transferrs the transactions. In short:
- *  - 0x20: 0x'....'....'0000'0180
- *  - 0x10: 0x'....'....'0000'0100
- *  - 0x08: 0x'....'....'0000'0080
- *  - 0x04: 0x'....'....'0000'0000
- *
- * This driver configure 0x'....'....'0000'0000 to receive MIDI messages from
- * units. The 3rd bit of the register should be configured, however this driver
- * deligates this task to userspace applications due to a restriction that this
- * register is write-only and the other bits have own effects.
- *
- * Unlike Fireface 800, Fireface 400 cancels transferring asynchronous
- * transactions when the 1st and 2nd of the register stand. These two bits have
- * the same effect.
- *  - 0x02, 0x01: cancel transferring
- *
- * On the other hand, the bits have no effect on Fireface 800. This model
- * cancels asynchronous transactions when the higher 4 bytes of address is
- * overwritten with zero.
- */
+// Controllers are allowed to register higher 4 bytes of destination address to
+// receive asynchronous transactions for MIDI messages, while the way to
+// register lower 4 bytes of address is different depending on protocols. For
+// details, please refer to comments in protocol implementations.
+//
+// This driver expects userspace applications to configure registers for the
+// lower address because in most cases such registers has the other settings.
 int snd_ff_transaction_reregister(struct snd_ff *ff)
 {
 	struct fw_card *fw_card = fw_parent_device(ff->unit)->card;
-- 
2.19.1
