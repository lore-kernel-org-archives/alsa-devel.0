From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/25] ALSA: firewire-lib: schedule tasklet
	again when MIDI substream has rest of MIDI messages
Date: Sat, 22 Aug 2015 18:19:21 +0900
Message-ID: <1440235181-18181-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1440235181-18181-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id E70E6260580
 for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2015 11:19:47 +0200 (CEST)
In-Reply-To: <1440235181-18181-1-git-send-email-o-takashi@sakamocchi.jp>
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

When two MIDI trigger callbacks can be called immediately, transactions
for the second MIDI messages can be postpone till next trigger callback.

This commit schedules tasklet again at response handling callback if the
MIDI substream still includes untransferred MIDI messages.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index 9da8894..83d20b6 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -78,6 +78,9 @@ static void async_midi_port_callback(struct fw_card *card, int rcode,
 		snd_rawmidi_transmit_ack(substream, port->consume_bytes);
 
 	port->idling = true;
+
+	if (!snd_rawmidi_transmit_empty(substream))
+		tasklet_schedule(&port->tasklet);
 }
 
 static void midi_port_tasklet(unsigned long data)
-- 
2.1.4
