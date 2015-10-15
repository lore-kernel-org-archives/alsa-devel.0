From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 1/2] ALSA: firewire-tascam: fix an LED bug
Date: Thu, 15 Oct 2015 21:16:30 +0300
Message-ID: <20151015181630.GA3163@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We recently tried to add some new code to support turning the LED on and
off but the code in snd_tscm_transaction_reregister() is unreachable.

Fixes: e65e2cb99e44 ('ALSA: firewire-tascam: Turn on/off FireWire LED')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 1c9a88b..45c3ce3 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -249,7 +249,7 @@ int snd_tscm_transaction_reregister(struct snd_tscm *tscm)
 
 	/* Turn on messaging. */
 	reg = cpu_to_be32(0x00000001);
-	return snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
 				  TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_TX_ON,
 				  &reg, sizeof(reg), 0);
 	if (err < 0)
