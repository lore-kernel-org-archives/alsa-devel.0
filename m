From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/10] ALSA: firewire-motu: unify midi callback
	function
Date: Mon, 17 Jun 2019 17:15:02 +0900
Message-ID: <20190617081510.11025-3-o-takashi@sakamocchi.jp>
References: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41E6BF896C7
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 10:15:20 +0200 (CEST)
In-Reply-To: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
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

Two sets of callbacks for rawmidi.open/close but they have the same
codes. This commit unifies each of the callbacks.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-midi.c | 49 ++++-----------------------------
 1 file changed, 6 insertions(+), 43 deletions(-)

diff --git a/sound/firewire/motu/motu-midi.c b/sound/firewire/motu/motu-midi.c
index b2d339a8ef3f..3b205386ed24 100644
--- a/sound/firewire/motu/motu-midi.c
+++ b/sound/firewire/motu/motu-midi.c
@@ -7,7 +7,7 @@
  */
 #include "motu.h"
 
-static int midi_capture_open(struct snd_rawmidi_substream *substream)
+static int midi_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_motu *motu = substream->rmidi->private_data;
 	int err;
@@ -29,44 +29,7 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 	return err;
 }
 
-static int midi_playback_open(struct snd_rawmidi_substream *substream)
-{
-	struct snd_motu *motu = substream->rmidi->private_data;
-	int err;
-
-	err = snd_motu_stream_lock_try(motu);
-	if (err < 0)
-		return err;
-
-	mutex_lock(&motu->mutex);
-
-	motu->substreams_counter++;
-	err = snd_motu_stream_start_duplex(motu, 0);
-
-	mutex_unlock(&motu->mutex);
-
-	if (err < 0)
-		snd_motu_stream_lock_release(motu);
-
-	return err;
-}
-
-static int midi_capture_close(struct snd_rawmidi_substream *substream)
-{
-	struct snd_motu *motu = substream->rmidi->private_data;
-
-	mutex_lock(&motu->mutex);
-
-	motu->substreams_counter--;
-	snd_motu_stream_stop_duplex(motu);
-
-	mutex_unlock(&motu->mutex);
-
-	snd_motu_stream_lock_release(motu);
-	return 0;
-}
-
-static int midi_playback_close(struct snd_rawmidi_substream *substream)
+static int midi_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_motu *motu = substream->rmidi->private_data;
 
@@ -129,13 +92,13 @@ static void set_midi_substream_names(struct snd_motu *motu,
 int snd_motu_create_midi_devices(struct snd_motu *motu)
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
