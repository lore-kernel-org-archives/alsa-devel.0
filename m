From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/6] ALSA: oxfw: simplify symbol space for
	local linkage
Date: Tue,  3 Jan 2017 21:41:18 +0900
Message-ID: <20170103124121.17143-4-o-takashi@sakamocchi.jp>
References: <20170103124121.17143-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C3DB3266E40
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 13:41:30 +0100 (CET)
In-Reply-To: <20170103124121.17143-1-o-takashi@sakamocchi.jp>
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

This module has some implementations for operation structures which sound
subsystem defines. All of them are referred just by each local function to
register corresponding operations. In this case, it's better to put them
into the function local so that symbol space in local linkage of
translation unit is kept to be simple.

This commit moves such symbols to function local.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-midi.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-midi.c b/sound/firewire/oxfw/oxfw-midi.c
index 8665e10..076a1a9 100644
--- a/sound/firewire/oxfw/oxfw-midi.c
+++ b/sound/firewire/oxfw/oxfw-midi.c
@@ -116,18 +116,6 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_unlock_irqrestore(&oxfw->lock, flags);
 }
 
-static struct snd_rawmidi_ops midi_capture_ops = {
-	.open		= midi_capture_open,
-	.close		= midi_capture_close,
-	.trigger	= midi_capture_trigger,
-};
-
-static struct snd_rawmidi_ops midi_playback_ops = {
-	.open		= midi_playback_open,
-	.close		= midi_playback_close,
-	.trigger	= midi_playback_trigger,
-};
-
 static void set_midi_substream_names(struct snd_oxfw *oxfw,
 				     struct snd_rawmidi_str *str)
 {
@@ -142,6 +130,16 @@ static void set_midi_substream_names(struct snd_oxfw *oxfw,
 
 int snd_oxfw_create_midi(struct snd_oxfw *oxfw)
 {
+	static struct snd_rawmidi_ops capture_ops = {
+		.open		= midi_capture_open,
+		.close		= midi_capture_close,
+		.trigger	= midi_capture_trigger,
+	};
+	static struct snd_rawmidi_ops playback_ops = {
+		.open		= midi_playback_open,
+		.close		= midi_playback_close,
+		.trigger	= midi_playback_trigger,
+	};
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_str *str;
 	int err;
@@ -164,7 +162,7 @@ int snd_oxfw_create_midi(struct snd_oxfw *oxfw)
 		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
 
 		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
-				    &midi_capture_ops);
+				    &capture_ops);
 
 		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
 
@@ -175,7 +173,7 @@ int snd_oxfw_create_midi(struct snd_oxfw *oxfw)
 		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
 
 		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
-				    &midi_playback_ops);
+				    &playback_ops);
 
 		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
 
-- 
2.9.3
