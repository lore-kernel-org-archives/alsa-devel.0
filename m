From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] ALSA: firewire-tascam: Turn on/off
	FireWire LED
Date: Mon, 12 Oct 2015 19:10:24 +0900
Message-ID: <1444644625-30189-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 72D66261295
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 12:10:30 +0200 (CEST)
In-Reply-To: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

TASCAM FireWire series has some LEDs on its surface. These LEDs can be
turned on/off by receiving asynchronous transactions to a certain
address. One of the LEDs is labels as 'FireWire'. It's better to light it
up when this driver starts to work. Besides, the LED for 'FireWire' is
turned off at bus reset.

This commit implements this idea.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 14 ++++++++++++++
 sound/firewire/tascam/tascam.h             |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 6b74fb5..1c9a88b 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -252,6 +252,14 @@ int snd_tscm_transaction_reregister(struct snd_tscm *tscm)
 	return snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
 				  TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_TX_ON,
 				  &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	/* Turn on FireWire LED. */
+	reg = cpu_to_be32(0x0001008e);
+	return snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  TSCM_ADDR_BASE + TSCM_OFFSET_LED_POWER,
+				  &reg, sizeof(reg), 0);
 }
 
 void snd_tscm_transaction_unregister(struct snd_tscm *tscm)
@@ -259,6 +267,12 @@ void snd_tscm_transaction_unregister(struct snd_tscm *tscm)
 	__be32 reg;
 	unsigned int i;
 
+	/* Turn off FireWire LED. */
+	reg = cpu_to_be32(0x0000008e);
+	snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   TSCM_ADDR_BASE + TSCM_OFFSET_LED_POWER,
+			   &reg, sizeof(reg), 0);
+
 	/* Turn off messaging. */
 	reg = cpu_to_be32(0x00000000);
 	snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index b86bb7f..2d028d2 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -101,6 +101,8 @@ struct snd_tscm {
 #define TSCM_OFFSET_MIDI_TX_ADDR_HI	0x0304
 #define TSCM_OFFSET_MIDI_TX_ADDR_LO	0x0308
 
+#define TSCM_OFFSET_LED_POWER		0x0404
+
 #define TSCM_OFFSET_MIDI_RX_QUAD	0x4000
 
 enum snd_tscm_clock {
-- 
2.1.4
