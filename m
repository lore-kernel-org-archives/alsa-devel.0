From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/2] ALSA: firewire-tascam: off by one in handle_midi_tx()
Date: Thu, 15 Oct 2015 21:17:11 +0300
Message-ID: <20151015181711.GB3163@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

My static checker complains because tscm->spec->midi_capture_ports is
either 2 or 4 but the tscm->tx_midi_substreams[] array has 4 elements so
this is possibly off by one.  I have looked at the code and I think it
should be >= instead of > as well.

Fixes: 107cc0129a68 ('ALSA: firewire-tascam: add support for incoming MIDI messages by asynchronous transaction')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 45c3ce3..d4f64ae 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -158,7 +158,7 @@ static void handle_midi_tx(struct fw_card *card, struct fw_request *request,
 
 		port = b[0] >> 4;
 		/* TODO: support virtual MIDI ports. */
-		if (port > tscm->spec->midi_capture_ports)
+		if (port >= tscm->spec->midi_capture_ports)
 			goto end;
 
 		/* Assume the message length. */
