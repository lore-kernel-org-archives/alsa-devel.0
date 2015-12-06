From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 17/17] ALSA: oxfw: add stream format quirk for
	SCS.1 models
Date: Sun,  6 Dec 2015 13:18:25 +0900
Message-ID: <1449375505-2704-18-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 55242265329
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:33 +0100 (CET)
In-Reply-To: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
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

As long as I investigate SCS.1m, this model reports to transfer/receive
PCM data channels/MIDI conformant data channels in tx/rx AMDTP packet.
There's a contradiction that this model actually has no analog/digital
capture port for PCM frames and no physical MIDI ports.

I guess that SCS.1d also has the contradiction. This model has no
analog/digital ports for PCM frames and no physical MIDI ports, thus it
requires no streaming functionality.

This commit adds some modification codes to handle the contradiction,
as much as possible. Unfortunately, this module adds one PCM playback
substream for SCS.1d so as SCS.1m.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index e7f2698..abedc22 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -164,8 +164,16 @@ static int detect_quirks(struct snd_oxfw *oxfw)
 	 * Stanton models supports asynchronous transactions for unique MIDI
 	 * messages.
 	 */
-	if (oxfw->entry->vendor_id == OUI_STANTON)
+	if (oxfw->entry->vendor_id == OUI_STANTON) {
+		/* No physical MIDI ports. */
+		oxfw->midi_input_ports = 0;
+		oxfw->midi_output_ports = 0;
+
+		/* Output stream exists but no data channels are useful. */
+		oxfw->has_output = false;
+
 		return snd_oxfw_scs1x_add(oxfw);
+	}
 
 	/*
 	 * TASCAM FireOne has physical control and requires a pair of additional
-- 
2.5.0
