From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/15] ALSA: oxfw: Add support AMDTP in-stream
Date: Sun,  7 Dec 2014 22:19:05 +0900
Message-ID: <1417958348-30333-13-git-send-email-o-takashi@sakamocchi.jp>
References: <1417958348-30333-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id CDD83260688
 for <alsa-devel@alsa-project.org>; Sun,  7 Dec 2014 14:19:16 +0100 (CET)
In-Reply-To: <1417958348-30333-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Previous commit adds support for some devices which can capture PCM samples.
These devices transmit AMDTP stream in non-blocking mode. This commit adds
functionality to handle AMDTP incoming stream.

OXFW seems to have two quirks:
 - Transmits packets with non-zero dbc in its beginning
 - Transmits packets with wrong values in syt field

For the first quirk, this commit adds CIP_SKIP_INIT_DBC_CHECK flag for
incoming stream to skip first check of dbc.

For the second quirk, this commit doesn't add duplex stream which
Fireworks/BeBoB drivers use. So OXFW driver generates syt value for outgoing
stream.

Here are examples of a sequence of packets transmitted by Behringer F-Control
Audio 202. There are differences between sequences of syt value when OXFW
driver transfers outgoing stream or not.

When driver gives no outgoing stream:
Index   Payload CIP_Header_0    CIP_Header_1
38      14      00020092        900103D1
39      12      00020098        900102FF
40      12      0002009D        9001027F
41      14      000200A2        90010396
42      14      000200A8        900102E8
43      12      000200AE        90010219
44      14      000200B3        90010331
45      12      000200B9        9001025F
46      14      000200BE        90010376
47      12      000200C4        900102A1
00      12      000200C9        9001023E
01      14      000200CE        90010358
02      12      000200D4        90010289
03      16      000200D9        900103A3
04      12      000200E0        900102DD
05      14      000200E5        900103F1
06      12      000200EB        90010335
07      12      000200F0        90010263
08      14      000200F5        9001037C
09      12      000200FB        900102AE

When driver gives outgoing stream:
Index   Payload CIP_Header_0    CIP_Header_1
38      12      000200BD        900104A8
39      14      000200C2        900104A8
40      12      000200C8        900104AC
41      14      000200CD        900104A9
42      12      000200D3        900104B1
43      14      000200D8        900104A8
44      12      000200DE        900104AA
45      14      000200E3        900104A9
46      14      000200E9        900104AE
47      12      000200EF        900104A8
00      14      000200F4        900104AD
01      12      000200FA        900104A7
02      14      000200FF        900104A9
03      12      00020005        900104A9
04      14      0002000A        900104B1
05      12      00020010        900104AA
06      14      00020015        900104AD
07      12      0002001B        900104A7
08      14      00020020        900104AC
09      12      00020026        900104A7

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-pcm.c    |   6 +-
 sound/firewire/oxfw/oxfw-proc.c   |  29 ++++
 sound/firewire/oxfw/oxfw-stream.c | 270 +++++++++++++++++++++++++++++---------
 sound/firewire/oxfw/oxfw.c        |  25 +++-
 sound/firewire/oxfw/oxfw.h        |  24 +++-
 5 files changed, 279 insertions(+), 75 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index ea2b439..a78339c 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -177,7 +177,7 @@ static int pcm_hw_free(struct snd_pcm_substream *substream)
 	struct snd_oxfw *oxfw = substream->private_data;
 
 	mutex_lock(&oxfw->mutex);
-	snd_oxfw_stream_stop_simplex(oxfw);
+	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->rx_stream);
 	mutex_unlock(&oxfw->mutex);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
@@ -190,8 +190,8 @@ static int pcm_prepare(struct snd_pcm_substream *substream)
 	int err;
 
 	mutex_lock(&oxfw->mutex);
-	err = snd_oxfw_stream_start_simplex(oxfw, runtime->rate,
-					    runtime->channels);
+	err = snd_oxfw_stream_start_simplex(oxfw, &oxfw->rx_stream,
+					    runtime->rate, runtime->channels);
 	mutex_unlock(&oxfw->mutex);
 	if (err < 0)
 		goto end;
diff --git a/sound/firewire/oxfw/oxfw-proc.c b/sound/firewire/oxfw/oxfw-proc.c
index 18e0305..604808e 100644
--- a/sound/firewire/oxfw/oxfw-proc.c
+++ b/sound/firewire/oxfw/oxfw-proc.c
@@ -44,6 +44,35 @@ static void proc_read_formation(struct snd_info_entry *entry,
 			    formation.rate, formation.pcm, formation.midi);
 	}
 
+	if (!oxfw->has_output)
+		return;
+
+	/* Show output. */
+	err = snd_oxfw_stream_get_current_formation(oxfw,
+						    AVC_GENERAL_PLUG_DIR_OUT,
+						    &curr);
+	if (err < 0)
+		return;
+
+	snd_iprintf(buffer, "Output Stream from device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		format = oxfw->tx_stream_formats[i];
+		if (format == NULL)
+			continue;
+
+		err = snd_oxfw_stream_parse_format(format, &formation);
+		if (err < 0)
+			continue;
+
+		if (memcmp(&formation, &curr, sizeof(curr)) == 0)
+			flag = '*';
+		else
+			flag = ' ';
+
+		snd_iprintf(buffer, "%c\t%d\t%d\t%d\n", flag,
+			    formation.rate, formation.pcm, formation.midi);
+	}
 }
 
 static void add_node(struct snd_oxfw *oxfw, struct snd_info_entry *root,
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 1820497..1d15428 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -39,6 +39,22 @@ static const unsigned int avc_stream_rate_table[] = {
 	[5] = 0x07,
 };
 
+static int set_rate(struct snd_oxfw *oxfw, unsigned int rate)
+{
+	int err;
+
+	err = avc_general_set_sig_fmt(oxfw->unit, rate,
+				      AVC_GENERAL_PLUG_DIR_IN, 0);
+	if (err < 0)
+		goto end;
+
+	if (oxfw->has_output)
+		err = avc_general_set_sig_fmt(oxfw->unit, rate,
+					      AVC_GENERAL_PLUG_DIR_OUT, 0);
+end:
+	return err;
+}
+
 static int set_stream_format(struct snd_oxfw *oxfw, struct amdtp_stream *s,
 			     unsigned int rate, unsigned int pcm_channels)
 {
@@ -47,8 +63,13 @@ static int set_stream_format(struct snd_oxfw *oxfw, struct amdtp_stream *s,
 	enum avc_general_plug_dir dir;
 	unsigned int i, err, len;
 
-	formats = oxfw->rx_stream_formats;
-	dir = AVC_GENERAL_PLUG_DIR_IN;
+	if (s == &oxfw->tx_stream) {
+		formats = oxfw->tx_stream_formats;
+		dir = AVC_GENERAL_PLUG_DIR_OUT;
+	} else {
+		formats = oxfw->rx_stream_formats;
+		dir = AVC_GENERAL_PLUG_DIR_IN;
+	}
 
 	/* Seek stream format for requirements. */
 	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
@@ -64,8 +85,7 @@ static int set_stream_format(struct snd_oxfw *oxfw, struct amdtp_stream *s,
 
 	/* If assumed, just change rate. */
 	if (oxfw->assumed)
-		return avc_general_set_sig_fmt(oxfw->unit, rate,
-					       AVC_GENERAL_PLUG_DIR_IN, 0);
+		return set_rate(oxfw, rate);
 
 	/* Calculate format length. */
 	len = 5 + formats[i][4] * 2;
@@ -80,47 +100,35 @@ static int set_stream_format(struct snd_oxfw *oxfw, struct amdtp_stream *s,
 	return 0;
 }
 
-int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw)
+static void stop_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 {
-	int err;
-
-	err = cmp_connection_init(&oxfw->in_conn, oxfw->unit,
-				  CMP_INPUT, 0);
-	if (err < 0)
-		goto end;
+	amdtp_stream_pcm_abort(stream);
+	amdtp_stream_stop(stream);
 
-	err = amdtp_stream_init(&oxfw->rx_stream, oxfw->unit,
-				AMDTP_OUT_STREAM, CIP_NONBLOCKING);
-	if (err < 0) {
-		amdtp_stream_destroy(&oxfw->rx_stream);
-		cmp_connection_destroy(&oxfw->in_conn);
-	}
-end:
-	return err;
-}
-
-static void stop_stream(struct snd_oxfw *oxfw)
-{
-	amdtp_stream_pcm_abort(&oxfw->rx_stream);
-	amdtp_stream_stop(&oxfw->rx_stream);
-	cmp_connection_break(&oxfw->in_conn);
+	if (stream == &oxfw->tx_stream)
+		cmp_connection_break(&oxfw->out_conn);
+	else
+		cmp_connection_break(&oxfw->in_conn);
 }
 
-static int start_stream(struct snd_oxfw *oxfw, unsigned int rate,
-			unsigned int pcm_channels)
+static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream,
+			unsigned int rate, unsigned int pcm_channels)
 {
 	u8 **formats;
 	struct cmp_connection *conn;
 	struct snd_oxfw_stream_formation formation;
 	unsigned int i, midi_ports;
-	struct amdtp_stream *stream;
 	int err;
 
-	stream = &oxfw->rx_stream;
-	formats = oxfw->rx_stream_formats;
-	conn = &oxfw->in_conn;
+	if (stream == &oxfw->rx_stream) {
+		formats = oxfw->rx_stream_formats;
+		conn = &oxfw->in_conn;
+	} else {
+		formats = oxfw->tx_stream_formats;
+		conn = &oxfw->out_conn;
+	}
 
-	/* Get stream formation */
+	/* Get stream format */
 	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
 		if (formats[i] == NULL)
 			break;
@@ -164,67 +172,196 @@ static int start_stream(struct snd_oxfw *oxfw, unsigned int rate,
 	/* Wait first packet */
 	err = amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT);
 	if (err < 0)
-		stop_stream(oxfw);
+		stop_stream(oxfw, stream);
 end:
 	return err;
 }
 
-int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw, unsigned int rate,
-				  unsigned int pcm_channels)
+static int check_connection_used_by_others(struct snd_oxfw *oxfw,
+					   struct amdtp_stream *stream)
 {
+	struct cmp_connection *conn;
+	bool used;
+	int err;
+
+	if (stream == &oxfw->tx_stream)
+		conn = &oxfw->out_conn;
+	else
+		conn = &oxfw->in_conn;
+
+	err = cmp_connection_check_used(conn, &used);
+	if ((err >= 0) && used && !amdtp_stream_running(stream)) {
+		dev_err(&oxfw->unit->device,
+			"Connection established by others: %cPCR[%d]\n",
+			(conn->direction == CMP_OUTPUT) ? 'o' : 'i',
+			conn->pcr_index);
+		err = -EBUSY;
+	}
+
+	return err;
+}
+
+int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw,
+				 struct amdtp_stream *stream)
+{
+	struct cmp_connection *conn;
+	enum cmp_direction c_dir;
+	enum amdtp_stream_direction s_dir;
+	int err;
+
+	if (stream == &oxfw->tx_stream) {
+		conn = &oxfw->out_conn;
+		c_dir = CMP_OUTPUT;
+		s_dir = AMDTP_IN_STREAM;
+	} else {
+		conn = &oxfw->in_conn;
+		c_dir = CMP_INPUT;
+		s_dir = AMDTP_OUT_STREAM;
+	}
+
+	err = cmp_connection_init(conn, oxfw->unit, c_dir, 0);
+	if (err < 0)
+		goto end;
+
+	err = amdtp_stream_init(stream, oxfw->unit, s_dir, CIP_NONBLOCKING);
+	if (err < 0) {
+		amdtp_stream_destroy(stream);
+		cmp_connection_destroy(conn);
+		goto end;
+	}
+
+	/* OXFW starts to transmit packets with non-zero dbc. */
+	if (stream == &oxfw->tx_stream)
+		oxfw->tx_stream.flags |= CIP_SKIP_INIT_DBC_CHECK;
+end:
+	return err;
+}
+
+int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
+				  struct amdtp_stream *stream,
+				  unsigned int rate, unsigned int pcm_channels)
+{
+	struct amdtp_stream *opposite;
 	struct snd_oxfw_stream_formation formation;
+	enum avc_general_plug_dir dir;
+	unsigned int substreams, opposite_substreams;
 	int err = 0;
 
+	if (stream == &oxfw->tx_stream) {
+		substreams = oxfw->capture_substreams;
+		opposite = &oxfw->rx_stream;
+		opposite_substreams = oxfw->playback_substreams;
+		dir = AVC_GENERAL_PLUG_DIR_OUT;
+	} else {
+		substreams = oxfw->playback_substreams;
+		opposite_substreams = oxfw->capture_substreams;
+
+		if (oxfw->has_output)
+			opposite = &oxfw->rx_stream;
+		else
+			opposite = NULL;
+
+		dir = AVC_GENERAL_PLUG_DIR_IN;
+	}
+
+	if (substreams == 0)
+		goto end;
+
+	/*
+	 * Considering JACK/FFADO streaming:
+	 * TODO: This can be removed hwdep functionality becomes popular.
+	 */
+	err = check_connection_used_by_others(oxfw, stream);
+	if (err < 0)
+		goto end;
+
 	/* packet queueing error */
-	if (amdtp_streaming_error(&oxfw->rx_stream))
-		stop_stream(oxfw);
+	if (amdtp_streaming_error(stream))
+		stop_stream(oxfw, stream);
 
-	err = snd_oxfw_stream_get_current_formation(oxfw,
-						    AVC_GENERAL_PLUG_DIR_IN,
-						    &formation);
+	err = snd_oxfw_stream_get_current_formation(oxfw, dir, &formation);
 	if (err < 0)
 		goto end;
 
 	if ((formation.rate != rate) || (formation.pcm != pcm_channels)) {
-		stop_stream(oxfw);
+		if (opposite != NULL) {
+			err = check_connection_used_by_others(oxfw, opposite);
+			if (err < 0)
+				goto end;
+			stop_stream(oxfw, opposite);
+		}
+		stop_stream(oxfw, stream);
 
-		/* arrange sampling rate */
-		err = set_stream_format(oxfw, &oxfw->rx_stream, rate,
-					pcm_channels);
+		err = set_stream_format(oxfw, stream, rate, pcm_channels);
 		if (err < 0) {
 			dev_err(&oxfw->unit->device,
 				"fail to set stream format: %d\n", err);
 			goto end;
 		}
+
+		/* Start opposite stream if needed. */
+		if (opposite && !amdtp_stream_running(opposite) &&
+		    (opposite_substreams > 0)) {
+			err = start_stream(oxfw, opposite, rate, 0);
+			if (err < 0) {
+				dev_err(&oxfw->unit->device,
+					"fail to restart stream: %d\n", err);
+				goto end;
+			}
+		}
 	}
 
-	err = start_stream(oxfw, rate, pcm_channels);
-	if (err < 0)
-		dev_err(&oxfw->unit->device,
-			"fail to start stream: %d\n", err);
+	/* Start requested stream. */
+	if (!amdtp_stream_running(stream)) {
+		err = start_stream(oxfw, stream, rate, pcm_channels);
+		if (err < 0)
+			dev_err(&oxfw->unit->device,
+				"fail to start stream: %d\n", err);
+	}
 end:
 	return err;
 }
 
-void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw)
+void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw,
+				  struct amdtp_stream *stream)
 {
-	stop_stream(oxfw);
+	if (((stream == &oxfw->tx_stream) && (oxfw->capture_substreams > 0)) ||
+	    ((stream == &oxfw->rx_stream) && (oxfw->playback_substreams > 0)))
+		return;
+
+	stop_stream(oxfw, stream);
 }
 
-void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw)
+void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw,
+				     struct amdtp_stream *stream)
 {
-	stop_stream(oxfw);
+	struct cmp_connection *conn;
+
+	if (stream == &oxfw->tx_stream)
+		conn = &oxfw->out_conn;
+	else
+		conn = &oxfw->in_conn;
 
-	amdtp_stream_destroy(&oxfw->rx_stream);
-	cmp_connection_destroy(&oxfw->in_conn);
+	stop_stream(oxfw, stream);
+
+	amdtp_stream_destroy(stream);
+	cmp_connection_destroy(conn);
 }
 
-void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw)
+void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw,
+				    struct amdtp_stream *stream)
 {
-	if (cmp_connection_update(&oxfw->in_conn) < 0)
-		stop_stream(oxfw);
+	struct cmp_connection *conn;
+
+	if (stream == &oxfw->tx_stream)
+		conn = &oxfw->out_conn;
+	else
+		conn = &oxfw->in_conn;
+
+	if (cmp_connection_update(conn) < 0)
+		stop_stream(oxfw, stream);
 	else
-		amdtp_stream_update(&oxfw->rx_stream);
+		amdtp_stream_update(stream);
 }
 
 int snd_oxfw_stream_get_current_formation(struct snd_oxfw *oxfw,
@@ -408,7 +545,10 @@ static int fill_stream_formats(struct snd_oxfw *oxfw,
 	if (buf == NULL)
 		return -ENOMEM;
 
-	formats = oxfw->rx_stream_formats;
+	if (dir == AVC_GENERAL_PLUG_DIR_OUT)
+		formats = oxfw->tx_stream_formats;
+	else
+		formats = oxfw->rx_stream_formats;
 
 	/* get first entry */
 	len = AVC_GENERIC_FRAME_MAXIMUM_BYTES;
@@ -481,11 +621,19 @@ int snd_oxfw_stream_discover(struct snd_oxfw *oxfw)
 		"fail to get info for isoc/external in/out plugs: %d\n",
 			err);
 		goto end;
-	} else if (plugs[0] == 0) {
+	} else if ((plugs[0] == 0) && (plugs[1] == 0)) {
 		err = -ENOSYS;
 		goto end;
 	}
 
+	/* use oPCR[0] if exists */
+	if (plugs[1] > 0) {
+		err = fill_stream_formats(oxfw, AVC_GENERAL_PLUG_DIR_OUT, 0);
+		if (err < 0)
+			goto end;
+		oxfw->has_output = true;
+	}
+
 	/* use iPCR[0] if exists */
 	if (plugs[0] > 0)
 		err = fill_stream_formats(oxfw, AVC_GENERAL_PLUG_DIR_IN, 0);
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 26ce615..bc0239c 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -111,8 +111,10 @@ static void oxfw_card_free(struct snd_card *card)
 	struct snd_oxfw *oxfw = card->private_data;
 	unsigned int i;
 
-	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++)
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		kfree(oxfw->tx_stream_formats[i]);
 		kfree(oxfw->rx_stream_formats[i]);
+	}
 
 	mutex_destroy(&oxfw->mutex);
 }
@@ -159,13 +161,20 @@ static int oxfw_probe(struct fw_unit *unit,
 
 	snd_oxfw_proc_init(oxfw);
 
-	err = snd_oxfw_stream_init_simplex(oxfw);
+	err = snd_oxfw_stream_init_simplex(oxfw, &oxfw->rx_stream);
 	if (err < 0)
 		goto error;
+	if (oxfw->has_output) {
+		err = snd_oxfw_stream_init_simplex(oxfw, &oxfw->tx_stream);
+		if (err < 0)
+			goto error;
+	}
 
 	err = snd_card_register(card);
 	if (err < 0) {
-		snd_oxfw_stream_destroy_simplex(oxfw);
+		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
+		if (oxfw->has_output)
+			snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
 		goto error;
 	}
 	dev_set_drvdata(&unit->device, oxfw);
@@ -183,7 +192,11 @@ static void oxfw_bus_reset(struct fw_unit *unit)
 	fcp_bus_reset(oxfw->unit);
 
 	mutex_lock(&oxfw->mutex);
-	snd_oxfw_stream_update_simplex(oxfw);
+
+	snd_oxfw_stream_update_simplex(oxfw, &oxfw->rx_stream);
+	if (oxfw->has_output)
+		snd_oxfw_stream_update_simplex(oxfw, &oxfw->tx_stream);
+
 	mutex_unlock(&oxfw->mutex);
 }
 
@@ -193,7 +206,9 @@ static void oxfw_remove(struct fw_unit *unit)
 
 	snd_card_disconnect(oxfw->card);
 
-	snd_oxfw_stream_destroy_simplex(oxfw);
+	snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
+	if (oxfw->has_output)
+		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
 
 	snd_card_free_when_closed(oxfw->card);
 }
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index c09ef38..2211d11 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -44,10 +44,16 @@ struct snd_oxfw {
 	const struct device_info *device_info;
 	struct mutex mutex;
 
+	bool has_output;
+	u8 *tx_stream_formats[SND_OXFW_STREAM_FORMAT_ENTRIES];
 	u8 *rx_stream_formats[SND_OXFW_STREAM_FORMAT_ENTRIES];
 	bool assumed;
+	struct cmp_connection out_conn;
 	struct cmp_connection in_conn;
+	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
+	unsigned int capture_substreams;
+	unsigned int playback_substreams;
 
 	bool mute;
 	s16 volume[6];
@@ -88,12 +94,17 @@ int avc_general_inquiry_sig_fmt(struct fw_unit *unit, unsigned int rate,
 				enum avc_general_plug_dir dir,
 				unsigned short pid);
 
-int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw);
-int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw, unsigned int rate,
-				  unsigned int pcm_channels);
-void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw);
-void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw);
-void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw);
+int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw,
+				 struct amdtp_stream *stream);
+int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
+				  struct amdtp_stream *stream,
+				  unsigned int rate, unsigned int pcm_channels);
+void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw,
+				  struct amdtp_stream *stream);
+void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw,
+				     struct amdtp_stream *stream);
+void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw,
+				    struct amdtp_stream *stream);
 
 struct snd_oxfw_stream_formation {
 	unsigned int rate;
@@ -105,6 +116,7 @@ int snd_oxfw_stream_parse_format(u8 *format,
 int snd_oxfw_stream_get_current_formation(struct snd_oxfw *oxfw,
 				enum avc_general_plug_dir dir,
 				struct snd_oxfw_stream_formation *formation);
+
 int snd_oxfw_stream_discover(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
-- 
2.1.0
