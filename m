From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: oxfw: enclose identifiers referred by
	single function for scs1x feature
Date: Fri, 13 Jan 2017 20:30:22 +0900
Message-ID: <20170113113022.19841-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id DF4F4266A0C
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2017 12:30:28 +0100 (CET)
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
 sound/firewire/oxfw/oxfw-scs1x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index 7940058..93209eb 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -338,12 +338,6 @@ static void midi_playback_drain(struct snd_rawmidi_substream *stream)
 	wait_event(scs->idle_wait, scs->output_idle);
 }
 
-static const struct snd_rawmidi_ops midi_playback_ops = {
-	.open    = midi_playback_open,
-	.close   = midi_playback_close,
-	.trigger = midi_playback_trigger,
-	.drain   = midi_playback_drain,
-};
 static int register_address(struct snd_oxfw *oxfw)
 {
 	struct fw_scs1x *scs = oxfw->spec;
@@ -369,6 +363,12 @@ void snd_oxfw_scs1x_update(struct snd_oxfw *oxfw)
 
 int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw)
 {
+	static const struct snd_rawmidi_ops midi_playback_ops = {
+		.open    = midi_playback_open,
+		.close   = midi_playback_close,
+		.trigger = midi_playback_trigger,
+		.drain   = midi_playback_drain,
+	};
 	struct snd_rawmidi *rmidi;
 	struct fw_scs1x *scs;
 	int err;
-- 
2.9.3
