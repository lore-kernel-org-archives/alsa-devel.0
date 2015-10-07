From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] ALSA: firewire-lib: schedule work again
	when MIDI substream has rest of MIDI messages
Date: Wed,  7 Oct 2015 09:19:37 +0900
Message-ID: <1444177179-8082-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1444177179-8082-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 12D622659B5
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 02:19:44 +0200 (CEST)
In-Reply-To: <1444177179-8082-1-git-send-email-o-takashi@sakamocchi.jp>
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

Currently, when two MIDI trigger callbacks are called immediately,
transactions for the second MIDI messages are postpone till next trigger
callback. This is not good for real-time message transmission.

This commit schedules work again at response handling callback if the
MIDI substream still includes untransferred MIDI messages.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index ddc3e88..3e9afd7 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -78,6 +78,9 @@ static void async_midi_port_callback(struct fw_card *card, int rcode,
 		snd_rawmidi_transmit_ack(substream, port->consume_bytes);
 
 	port->idling = true;
+
+	if (!snd_rawmidi_transmit_empty(substream))
+		schedule_work(&port->work);
 }
 
 static void midi_port_work(struct work_struct *work)
-- 
2.1.4
