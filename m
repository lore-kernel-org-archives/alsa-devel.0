From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 05/37] ALSA: firewire-lib: schedule
	tasklet again when MIDI substream has rest of MIDI messages
Date: Sat, 11 Jul 2015 23:12:16 +0900
Message-ID: <1436623968-10780-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 43BE026055C
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:04 +0200 (CEST)
In-Reply-To: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Two MIDI trigger callbacks can be called immediately. This can postpone
second MIDI transaction till next trigger callback.

To avoid this delay, this commit schedules tasklet again at response
handling callback if the MIDI substream still includes untransferred
MIDI messages.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index a66e011..e309b9b 100644
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
