From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/6] ALSA: bebob: code refactoring for callback
	function to rawmidi interface
Date: Sat, 15 Jun 2019 18:10:57 +0900
Message-ID: <20190615091101.7515-3-o-takashi@sakamocchi.jp>
References: <20190615091101.7515-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BDF55F89703
 for <alsa-devel@alsa-project.org>; Sat, 15 Jun 2019 11:11:13 +0200 (CEST)
In-Reply-To: <20190615091101.7515-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The pairs of rawmidi.hw_params callback functions and .hw_free callback
functions for both direction have no differences.

This commit unifies the pairs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_midi.c | 47 ++++---------------------------
 1 file changed, 6 insertions(+), 41 deletions(-)

diff --git a/sound/firewire/bebob/bebob_midi.c b/sound/firewire/bebob/bebob_midi.c
index e2d3cad39d28..f7db1f7bce86 100644
--- a/sound/firewire/bebob/bebob_midi.c
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -8,7 +8,7 @@
 
 #include "bebob.h"
 
-static int midi_capture_open(struct snd_rawmidi_substream *substream)
+static int midi_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_bebob *bebob = substream->rmidi->private_data;
 	int err;
@@ -30,42 +30,7 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 	return err;
 }
 
-static int midi_playback_open(struct snd_rawmidi_substream *substream)
-{
-	struct snd_bebob *bebob = substream->rmidi->private_data;
-	int err;
-
-	err = snd_bebob_stream_lock_try(bebob);
-	if (err < 0)
-		return err;
-
-	mutex_lock(&bebob->mutex);
-	err = snd_bebob_stream_reserve_duplex(bebob, 0);
-	if (err >= 0) {
-		++bebob->substreams_counter;
-		err = snd_bebob_stream_start_duplex(bebob);
-	}
-	mutex_unlock(&bebob->mutex);
-	if (err < 0)
-		snd_bebob_stream_lock_release(bebob);
-
-	return err;
-}
-
-static int midi_capture_close(struct snd_rawmidi_substream *substream)
-{
-	struct snd_bebob *bebob = substream->rmidi->private_data;
-
-	mutex_lock(&bebob->mutex);
-	bebob->substreams_counter--;
-	snd_bebob_stream_stop_duplex(bebob);
-	mutex_unlock(&bebob->mutex);
-
-	snd_bebob_stream_lock_release(bebob);
-	return 0;
-}
-
-static int midi_playback_close(struct snd_rawmidi_substream *substream)
+static int midi_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_bebob *bebob = substream->rmidi->private_data;
 
@@ -127,13 +92,13 @@ static void set_midi_substream_names(struct snd_bebob *bebob,
 int snd_bebob_create_midi_devices(struct snd_bebob *bebob)
 {
 	static const struct snd_rawmidi_ops capture_ops = {
-		.open		= midi_capture_open,
-		.close		= midi_capture_close,
+		.open		= midi_open,
+		.close		= midi_close,
 		.trigger	= midi_capture_trigger,
 	};
 	static const struct snd_rawmidi_ops playback_ops = {
-		.open		= midi_playback_open,
-		.close		= midi_playback_close,
+		.open		= midi_open,
+		.close		= midi_close,
 		.trigger	= midi_playback_trigger,
 	};
 	struct snd_rawmidi *rmidi;
-- 
2.20.1
