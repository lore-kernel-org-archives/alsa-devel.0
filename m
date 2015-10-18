From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] ALSA: oxfw: calculating MIDI ports in
	stream discover
Date: Sun, 18 Oct 2015 17:09:38 +0900
Message-ID: <1445155780-7600-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1445155780-7600-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id AD616261583
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 10:09:44 +0200 (CEST)
In-Reply-To: <1445155780-7600-1-git-send-email-o-takashi@sakamocchi.jp>
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

Current OXFW driver calculates the number of MIDI ports just before adding
ALSA MIDI ports. It's convenient for some devices with quirks to move
these codes before handling quirks.

This commit implements this idea.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-midi.c   | 24 +++---------------------
 sound/firewire/oxfw/oxfw-stream.c | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-midi.c b/sound/firewire/oxfw/oxfw-midi.c
index 37a86cf..8665e10 100644
--- a/sound/firewire/oxfw/oxfw-midi.c
+++ b/sound/firewire/oxfw/oxfw-midi.c
@@ -142,29 +142,11 @@ static void set_midi_substream_names(struct snd_oxfw *oxfw,
 
 int snd_oxfw_create_midi(struct snd_oxfw *oxfw)
 {
-	struct snd_oxfw_stream_formation formation;
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_str *str;
-	u8 *format;
-	int i, err;
-
-	/* If its stream has MIDI conformant data channel, add one MIDI port */
-	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
-		format = oxfw->tx_stream_formats[i];
-		if (format != NULL) {
-			err = snd_oxfw_stream_parse_format(format, &formation);
-			if (err >= 0 && formation.midi > 0)
-				oxfw->midi_input_ports = 1;
-		}
-
-		format = oxfw->rx_stream_formats[i];
-		if (format != NULL) {
-			err = snd_oxfw_stream_parse_format(format, &formation);
-			if (err >= 0 && formation.midi > 0)
-				oxfw->midi_output_ports = 1;
-		}
-	}
-	if ((oxfw->midi_input_ports == 0) && (oxfw->midi_output_ports == 0))
+	int err;
+
+	if (oxfw->midi_input_ports == 0 && oxfw->midi_output_ports == 0)
 		return 0;
 
 	/* create midi ports */
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 2c63058..4879808 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -629,6 +629,9 @@ end:
 int snd_oxfw_stream_discover(struct snd_oxfw *oxfw)
 {
 	u8 plugs[AVC_PLUG_INFO_BUF_BYTES];
+	struct snd_oxfw_stream_formation formation;
+	u8 *format;
+	unsigned int i;
 	int err;
 
 	/* the number of plugs for isoc in/out, ext in/out  */
@@ -648,12 +651,42 @@ int snd_oxfw_stream_discover(struct snd_oxfw *oxfw)
 		err = fill_stream_formats(oxfw, AVC_GENERAL_PLUG_DIR_OUT, 0);
 		if (err < 0)
 			goto end;
+
+		for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+			format = oxfw->tx_stream_formats[i];
+			if (format == NULL)
+				continue;
+			err = snd_oxfw_stream_parse_format(format, &formation);
+			if (err < 0)
+				continue;
+
+			/* Add one MIDI port. */
+			if (formation.midi > 0)
+				oxfw->midi_input_ports = 1;
+		}
+
 		oxfw->has_output = true;
 	}
 
 	/* use iPCR[0] if exists */
-	if (plugs[0] > 0)
+	if (plugs[0] > 0) {
 		err = fill_stream_formats(oxfw, AVC_GENERAL_PLUG_DIR_IN, 0);
+		if (err < 0)
+			goto end;
+
+		for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+			format = oxfw->rx_stream_formats[i];
+			if (format == NULL)
+				continue;
+			err = snd_oxfw_stream_parse_format(format, &formation);
+			if (err < 0)
+				continue;
+
+			/* Add one MIDI port. */
+			if (formation.midi > 0)
+				oxfw->midi_output_ports = 1;
+		}
+	}
 end:
 	return err;
 }
-- 
2.1.4
