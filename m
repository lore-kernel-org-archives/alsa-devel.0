From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/19] ALSA: fireworks: code refactoring for
	rawmidi.open/close
Date: Wed, 12 Jun 2019 17:44:09 +0900
Message-ID: <20190612084422.5344-7-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07B05F89731
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:38 +0200 (CEST)
In-Reply-To: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
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
 sound/firewire/fireworks/fireworks_midi.c | 45 +++--------------------
 1 file changed, 6 insertions(+), 39 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
index 7e78cdfe699e..ee5dc7be70b6 100644
--- a/sound/firewire/fireworks/fireworks_midi.c
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -8,7 +8,7 @@
  */
 #include "fireworks.h"
 
-static int midi_capture_open(struct snd_rawmidi_substream *substream)
+static int midi_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_efw *efw = substream->rmidi->private_data;
 	int err;
@@ -23,44 +23,11 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 	mutex_unlock(&efw->mutex);
 	if (err < 0)
 		snd_efw_stream_lock_release(efw);
-
 end:
 	return err;
 }
 
-static int midi_playback_open(struct snd_rawmidi_substream *substream)
-{
-	struct snd_efw *efw = substream->rmidi->private_data;
-	int err;
-
-	err = snd_efw_stream_lock_try(efw);
-	if (err < 0)
-		goto end;
-
-	mutex_lock(&efw->mutex);
-	++efw->substreams_counter;
-	err = snd_efw_stream_start_duplex(efw, 0);
-	mutex_unlock(&efw->mutex);
-	if (err < 0)
-		snd_efw_stream_lock_release(efw);
-end:
-	return err;
-}
-
-static int midi_capture_close(struct snd_rawmidi_substream *substream)
-{
-	struct snd_efw *efw = substream->rmidi->private_data;
-
-	mutex_lock(&efw->mutex);
-	--efw->substreams_counter;
-	snd_efw_stream_stop_duplex(efw);
-	mutex_unlock(&efw->mutex);
-
-	snd_efw_stream_lock_release(efw);
-	return 0;
-}
-
-static int midi_playback_close(struct snd_rawmidi_substream *substream)
+static int midi_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_efw *efw = substream->rmidi->private_data;
 
@@ -121,13 +88,13 @@ static void set_midi_substream_names(struct snd_efw *efw,
 int snd_efw_create_midi_devices(struct snd_efw *efw)
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
