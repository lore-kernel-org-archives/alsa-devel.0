From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: avoid NULL pointer
	dereference after closing MIDI port
Date: Sun, 18 Oct 2015 22:58:37 +0900
Message-ID: <1445176717-12004-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C21A7261AF6
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:58:46 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When asynchronous MIDI port is closed before callbacked, the callback
function causes NULL pointer dereference to missing MIDI substream.

This commit fixes this bug.

Fixes: e8a40d9bcb23('ALSA: firewire-lib: schedule work again when MIDI substream has rest of MIDI messages')
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index edf1c8b..f80aafa 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -74,7 +74,11 @@ static void async_midi_port_callback(struct fw_card *card, int rcode,
 	struct snd_fw_async_midi_port *port = callback_data;
 	struct snd_rawmidi_substream *substream = ACCESS_ONCE(port->substream);
 
-	if (rcode == RCODE_COMPLETE && substream != NULL)
+	/* This port is closed. */
+	if (substream == NULL)
+		return;
+
+	if (rcode == RCODE_COMPLETE)
 		snd_rawmidi_transmit_ack(substream, port->consume_bytes);
 	else if (!rcode_is_permanent_error(rcode))
 		/* To start next transaction immediately for recovery. */
-- 
2.1.4
