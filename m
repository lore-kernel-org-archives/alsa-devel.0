From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 4/6] ALSA: dice: enclose identifiers
	referred by single function
Date: Thu,  5 Jan 2017 21:48:10 +0900
Message-ID: <20170105124812.11283-5-o-takashi@sakamocchi.jp>
References: <20170105124812.11283-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E3D96266646
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2017 13:48:17 +0100 (CET)
In-Reply-To: <20170105124812.11283-1-o-takashi@sakamocchi.jp>
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

Some identifiers are referred just by one functions. In this case, they
can be put into the function definition. This brings two merits; readers
can easily follow codes related to the identifiers, developers are free
from name conflict.

This commit moves such identifiers to each function definition.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-midi.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/dice/dice-midi.c b/sound/firewire/dice/dice-midi.c
index a040617..cdf71c2 100644
--- a/sound/firewire/dice/dice-midi.c
+++ b/sound/firewire/dice/dice-midi.c
@@ -78,18 +78,6 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_unlock_irqrestore(&dice->lock, flags);
 }
 
-static struct snd_rawmidi_ops capture_ops = {
-	.open		= midi_open,
-	.close		= midi_close,
-	.trigger	= midi_capture_trigger,
-};
-
-static struct snd_rawmidi_ops playback_ops = {
-	.open		= midi_open,
-	.close		= midi_close,
-	.trigger	= midi_playback_trigger,
-};
-
 static void set_midi_substream_names(struct snd_dice *dice,
 				     struct snd_rawmidi_str *str)
 {
@@ -103,6 +91,16 @@ static void set_midi_substream_names(struct snd_dice *dice,
 
 int snd_dice_create_midi(struct snd_dice *dice)
 {
+	static struct snd_rawmidi_ops capture_ops = {
+		.open		= midi_open,
+		.close		= midi_close,
+		.trigger	= midi_capture_trigger,
+	};
+	static struct snd_rawmidi_ops playback_ops = {
+		.open		= midi_open,
+		.close		= midi_close,
+		.trigger	= midi_playback_trigger,
+	};
 	__be32 reg;
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_str *str;
-- 
2.9.3
