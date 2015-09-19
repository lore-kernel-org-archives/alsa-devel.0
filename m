From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/15] ALSA: firewire-lib: add an argument for
	Dice's dual wire mode
Date: Sat, 19 Sep 2015 11:21:50 +0900
Message-ID: <1442629322-15457-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 44D882604C3
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 04:22:12 +0200 (CEST)
In-Reply-To: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
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

In IEC 61883-6, one data block represents one event. In ALSA, the event is
one PCM frame. Therefore, when processing one data block, current
implementation counts one PCM frame.

On the other hand, Dice platform has a quirk called as 'dual wire' at
higher sampling rate. In detail, see comment of commit 6eb6c81eee2a
("ALSA: dice: Split stream functionality into a file").

Currently, to handle this quirk, AMDTP stream structure has a
'double_pcm_frames' member. When this is enabled, two PCM frames are
counted. Each driver set this flag by accessing the structure member
directly.

In future commit, some members related to AM824 data block will be moved
to specific structure, to separate packet streaming layer and data block
processing layer. The access will be limited by opaque pointer.

For this reason, this commit adds an argument into
amdtp_stream_set_parameter() to set the flag.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c                      |  4 +++-
 sound/firewire/amdtp.h                      |  3 ++-
 sound/firewire/bebob/bebob_stream.c         |  6 ++++--
 sound/firewire/dice/dice-stream.c           | 12 ++++++------
 sound/firewire/fireworks/fireworks_stream.c |  2 +-
 sound/firewire/oxfw/oxfw-stream.c           |  2 +-
 6 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 2bacb51..094982f 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -193,6 +193,7 @@ EXPORT_SYMBOL(amdtp_stream_add_pcm_hw_constraints);
  * @pcm_channels: the number of PCM samples in each data block, to be encoded
  *                as AM824 multi-bit linear audio
  * @midi_ports: the number of MIDI ports (i.e., MPX-MIDI Data Channels)
+ * @double_pcm_frames: one data block transfers two PCM frames
  *
  * The parameters must be set before the stream is started, and must not be
  * changed while the stream is running.
@@ -200,7 +201,8 @@ EXPORT_SYMBOL(amdtp_stream_add_pcm_hw_constraints);
 int amdtp_stream_set_parameters(struct amdtp_stream *s,
 				unsigned int rate,
 				unsigned int pcm_channels,
-				unsigned int midi_ports)
+				unsigned int midi_ports,
+				bool double_pcm_frames)
 {
 	unsigned int i, sfc, midi_channels;
 
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 3fb8db7..2c91306 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -177,7 +177,8 @@ void amdtp_stream_destroy(struct amdtp_stream *s);
 int amdtp_stream_set_parameters(struct amdtp_stream *s,
 				unsigned int rate,
 				unsigned int pcm_channels,
-				unsigned int midi_ports);
+				unsigned int midi_ports,
+				bool double_pcm_frames);
 unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s);
 
 int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed);
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index c642b79..920a3b8 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -428,14 +428,16 @@ make_both_connections(struct snd_bebob *bebob, unsigned int rate)
 	pcm_channels = bebob->tx_stream_formations[index].pcm;
 	midi_channels = bebob->tx_stream_formations[index].midi;
 	err = amdtp_stream_set_parameters(&bebob->tx_stream, rate,
-					  pcm_channels, midi_channels * 8);
+					  pcm_channels, midi_channels * 8,
+					  false);
 	if (err < 0)
 		goto end;
 
 	pcm_channels = bebob->rx_stream_formations[index].pcm;
 	midi_channels = bebob->rx_stream_formations[index].midi;
 	err = amdtp_stream_set_parameters(&bebob->rx_stream, rate,
-					  pcm_channels, midi_channels * 8);
+					  pcm_channels, midi_channels * 8,
+					  false);
 	if (err < 0)
 		goto end;
 
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index c96306a..e4c6c20 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -100,6 +100,7 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 {
 	struct fw_iso_resources *resources;
 	unsigned int i, mode, pcm_chs, midi_ports;
+	bool double_pcm_frames;
 	int err;
 
 	err = snd_dice_stream_get_rate_mode(dice, rate, &mode);
@@ -125,19 +126,18 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 	 * For this quirk, blocking mode is required and PCM buffer size should
 	 * be aligned to SYT_INTERVAL.
 	 */
-	if (mode > 1) {
+	double_pcm_frames = mode > 1;
+	if (double_pcm_frames) {
 		rate /= 2;
 		pcm_chs *= 2;
-		stream->double_pcm_frames = true;
-	} else {
-		stream->double_pcm_frames = false;
 	}
 
-	err = amdtp_stream_set_parameters(stream, rate, pcm_chs, midi_ports);
+	err = amdtp_stream_set_parameters(stream, rate, pcm_chs, midi_ports,
+					  false);
 	if (err < 0)
 		goto end;
 
-	if (mode > 1) {
+	if (double_pcm_frames) {
 		pcm_chs /= 2;
 
 		for (i = 0; i < pcm_chs; i++) {
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index dfefccf..85a72e6 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -74,7 +74,7 @@ start_stream(struct snd_efw *efw, struct amdtp_stream *stream,
 	}
 
 	err = amdtp_stream_set_parameters(stream, sampling_rate,
-					  pcm_channels, midi_ports);
+					  pcm_channels, midi_ports, false);
 	if (err < 0)
 		goto end;
 
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index d119468..318f78e 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -156,7 +156,7 @@ static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream,
 		goto end;
 	}
 	err = amdtp_stream_set_parameters(stream, rate,
-					  pcm_channels, midi_ports);
+					  pcm_channels, midi_ports, false);
 	if (err < 0)
 		goto end;
 
-- 
2.1.4
