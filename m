From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/15] oxfw: Add support AMDTP in-stream and PCM capture
Date: Tue, 13 May 2014 23:27:50 +0900
Message-ID: <1399991272-5807-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Previous commit adds support for some devices which can capture PCM samples.
These devices transmit AMDTP stream in non-blocking mode. This commit adds
functionality to handle AMDTP incoming stream and to capture PCM samples.

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
Index	Payload	CIP_Header_0	CIP_Header_1
38	14	00020092	900103D1
39	12	00020098	900102FF
40	12	0002009D	9001027F
41	14	000200A2	90010396
42	14	000200A8	900102E8
43	12	000200AE	90010219
44	14	000200B3	90010331
45	12	000200B9	9001025F
46	14	000200BE	90010376
47	12	000200C4	900102A1
00	12	000200C9	9001023E
01	14	000200CE	90010358
02	12	000200D4	90010289
03	16	000200D9	900103A3
04	12	000200E0	900102DD
05	14	000200E5	900103F1
06	12	000200EB	90010335
07	12	000200F0	90010263
08	14	000200F5	9001037C
09	12	000200FB	900102AE

When driver gives outgoing stream:
Index	Payload	CIP_Header_0	CIP_Header_1
38	12	000200BD	900104A8
39	14	000200C2	900104A8
40	12	000200C8	900104AC
41	14	000200CD	900104A9
42	12	000200D3	900104B1
43	14	000200D8	900104A8
44	12	000200DE	900104AA
45	14	000200E3	900104A9
46	14	000200E9	900104AE
47	12	000200EF	900104A8
00	14	000200F4	900104AD
01	12	000200FA	900104A7
02	14	000200FF	900104A9
03	12	00020005	900104A9
04	14	0002000A	900104B1
05	12	00020010	900104AA
06	14	00020015	900104AD
07	12	0002001B	900104A7
08	14	00020020	900104AC
09	12	00020026	900104A7

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c        |  19 ++-
 sound/firewire/oxfw/oxfw.h        |  28 ++++-
 sound/firewire/oxfw/oxfw_pcm.c    | 164 +++++++++++++++++++++-----
 sound/firewire/oxfw/oxfw_proc.c   |  14 ++-
 sound/firewire/oxfw/oxfw_stream.c | 236 ++++++++++++++++++++++++++++++--------
 5 files changed, 370 insertions(+), 91 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 0c9b8e2..a9e21c0 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -140,13 +140,20 @@ static int oxfw_probe(struct fw_unit *unit,
 
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
@@ -162,14 +169,18 @@ static void oxfw_bus_reset(struct fw_unit *unit)
 	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
 
 	fcp_bus_reset(oxfw->unit);
-	snd_oxfw_stream_update_simplex(oxfw);
+	snd_oxfw_stream_update_simplex(oxfw, &oxfw->rx_stream);
+	if (oxfw->has_output)
+		snd_oxfw_stream_update_simplex(oxfw, &oxfw->tx_stream);
 }
 
 static void oxfw_remove(struct fw_unit *unit)
 {
 	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
 
-	snd_oxfw_stream_destroy_simplex(oxfw);
+	snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
+	if (oxfw->has_output)
+		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
 
 	snd_card_disconnect(oxfw->card);
 	snd_card_free_when_closed(oxfw->card);
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index b21dfce..81b6627 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -48,10 +48,17 @@ struct snd_oxfw {
 	const struct device_info *device_info;
 	struct mutex mutex;
 
+	bool has_output;
+	struct snd_oxfw_stream_formation
+		tx_stream_formations[SND_OXFW_STREAM_FORMAT_ENTRIES];
 	struct snd_oxfw_stream_formation
 		rx_stream_formations[SND_OXFW_STREAM_FORMAT_ENTRIES];
+	struct cmp_connection out_conn;
 	struct cmp_connection in_conn;
+	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
+	atomic_t capture_substreams;
+	atomic_t playback_substreams;
 
 	bool mute;
 	s16 volume[6];
@@ -90,12 +97,21 @@ int avc_general_inquiry_sig_fmt(struct fw_unit *unit, unsigned int rate,
 				enum avc_general_plug_dir dir,
 				unsigned short pid);
 
-int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw);
-int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw, unsigned int rate,
-				  unsigned int pcm_channels);
-void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw);
-void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw);
-void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw);
+int snd_oxfw_stream_get_rate(struct snd_oxfw *oxfw, unsigned int *rate);
+int snd_oxfw_stream_set_rate(struct snd_oxfw *oxfw, unsigned int rate);
+
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
+
 int snd_oxfw_stream_discover(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
diff --git a/sound/firewire/oxfw/oxfw_pcm.c b/sound/firewire/oxfw/oxfw_pcm.c
index 8f65e10..e763eef 100644
--- a/sound/firewire/oxfw/oxfw_pcm.c
+++ b/sound/firewire/oxfw/oxfw_pcm.c
@@ -105,22 +105,31 @@ static void limit_period_and_buffer(struct snd_pcm_hardware *hw)
 	hw->buffer_bytes_max = hw->period_bytes_max * hw->periods_min;
 }
 
-static int pcm_open(struct snd_pcm_substream *substream)
+static int init_hw_params(struct snd_oxfw *oxfw,
+			  struct snd_pcm_substream *substream)
 {
-	struct snd_oxfw *oxfw = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_oxfw_stream_formation *formations;
-	unsigned int rate;
+	struct amdtp_stream *stream;
 	int err;
 
-	formations = oxfw->rx_stream_formations;
-
 	runtime->hw.info = SNDRV_PCM_INFO_BATCH |
 			   SNDRV_PCM_INFO_BLOCK_TRANSFER |
 			   SNDRV_PCM_INFO_INTERLEAVED |
+			   SNDRV_PCM_INFO_JOINT_DUPLEX |
 			   SNDRV_PCM_INFO_MMAP |
 			   SNDRV_PCM_INFO_MMAP_VALID;
 
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		runtime->hw.formats = AMDTP_IN_PCM_FORMAT_BITS;
+		stream = &oxfw->tx_stream;
+		formations = oxfw->tx_stream_formations;
+	} else {
+		runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
+		stream = &oxfw->rx_stream;
+		formations = oxfw->rx_stream_formations;
+	}
+
 	limit_channels_and_rates(&runtime->hw, formations);
 	limit_period_and_buffer(&runtime->hw);
 
@@ -136,7 +145,18 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_add_pcm_hw_constraints(&oxfw->rx_stream, runtime);
+	err = amdtp_stream_add_pcm_hw_constraints(stream, runtime);
+end:
+	return err;
+}
+
+static int pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+	unsigned int rate;
+	int err;
+
+	err = init_hw_params(oxfw, substream);
 	if (err < 0)
 		goto end;
 
@@ -144,16 +164,16 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	 * When any PCM streams are already running, the available sampling
 	 * rate is limited at current value.
 	 */
-	if (amdtp_stream_pcm_running(&oxfw->rx_stream)) {
-		err = avc_general_get_sig_fmt(oxfw->unit, &rate,
-					      AVC_GENERAL_PLUG_DIR_IN, 0);
+	if (amdtp_stream_pcm_running(&oxfw->tx_stream) ||
+	    amdtp_stream_pcm_running(&oxfw->rx_stream)) {
+		err = snd_oxfw_stream_get_rate(oxfw, &rate);
 		if (err < 0) {
 			dev_err(&oxfw->unit->device,
 				"fail to get sampling rate: %d\n", err);
 			goto end;
 		}
-		runtime->hw.rate_min = rate;
-		runtime->hw.rate_max = rate;
+		substream->runtime->hw.rate_min = rate;
+		substream->runtime->hw.rate_max = rate;
 	}
 
 	snd_pcm_set_sync(substream);
@@ -166,33 +186,77 @@ static int pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int pcm_hw_params(struct snd_pcm_substream *substream,
-			 struct snd_pcm_hw_params *hw_params)
+static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
 
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+		atomic_inc(&oxfw->capture_substreams);
+	amdtp_stream_set_pcm_format(&oxfw->tx_stream, params_format(hw_params));
+
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
+}
+static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+		atomic_inc(&oxfw->playback_substreams);
 	amdtp_stream_set_pcm_format(&oxfw->rx_stream, params_format(hw_params));
+
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
 						params_buffer_bytes(hw_params));
 }
 
-static int pcm_hw_free(struct snd_pcm_substream *substream)
+static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
 
-	snd_oxfw_stream_stop_simplex(oxfw);
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		atomic_dec(&oxfw->capture_substreams);
+
+	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->tx_stream);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
+static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
 
-static int pcm_prepare(struct snd_pcm_substream *substream)
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		atomic_dec(&oxfw->playback_substreams);
+
+	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->rx_stream);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int pcm_capture_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
-	err = snd_oxfw_stream_start_simplex(oxfw, runtime->rate,
-					    runtime->channels);
+	err = snd_oxfw_stream_start_simplex(oxfw, &oxfw->tx_stream,
+					    runtime->rate, runtime->channels);
+	if (err < 0)
+		goto end;
+
+	amdtp_stream_pcm_prepare(&oxfw->tx_stream);
+end:
+	return err;
+}
+static int pcm_playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	err = snd_oxfw_stream_start_simplex(oxfw, &oxfw->rx_stream,
+					    runtime->rate, runtime->channels);
 	if (err < 0)
 		goto end;
 
@@ -201,7 +265,23 @@ end:
 	return err;
 }
 
-static int pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+static int pcm_capture_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&oxfw->tx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&oxfw->tx_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+static int pcm_playback_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
 
@@ -218,35 +298,61 @@ static int pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
-static snd_pcm_uframes_t pcm_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t pcm_capture_pointer(struct snd_pcm_substream *sbstm)
 {
-	struct snd_oxfw *oxfw = substream->private_data;
+	struct snd_oxfw *oxfw = sbstm->private_data;
+
+	return amdtp_stream_pcm_pointer(&oxfw->tx_stream);
+}
+static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstm)
+{
+	struct snd_oxfw *oxfw = sbstm->private_data;
 
 	return amdtp_stream_pcm_pointer(&oxfw->rx_stream);
 }
 
 int snd_oxfw_create_pcm(struct snd_oxfw *oxfw)
 {
-	static struct snd_pcm_ops ops = {
+	static struct snd_pcm_ops capture_ops = {
 		.open      = pcm_open,
 		.close     = pcm_close,
 		.ioctl     = snd_pcm_lib_ioctl,
-		.hw_params = pcm_hw_params,
-		.hw_free   = pcm_hw_free,
-		.prepare   = pcm_prepare,
-		.trigger   = pcm_trigger,
-		.pointer   = pcm_pointer,
+		.hw_params = pcm_capture_hw_params,
+		.hw_free   = pcm_capture_hw_free,
+		.prepare   = pcm_capture_prepare,
+		.trigger   = pcm_capture_trigger,
+		.pointer   = pcm_capture_pointer,
+		.page      = snd_pcm_lib_get_vmalloc_page,
+		.mmap      = snd_pcm_lib_mmap_vmalloc,
+	};
+	static struct snd_pcm_ops playback_ops = {
+		.open      = pcm_open,
+		.close     = pcm_close,
+		.ioctl     = snd_pcm_lib_ioctl,
+		.hw_params = pcm_playback_hw_params,
+		.hw_free   = pcm_playback_hw_free,
+		.prepare   = pcm_playback_prepare,
+		.trigger   = pcm_playback_trigger,
+		.pointer   = pcm_playback_pointer,
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
+	unsigned int cap = 0;
 	int err;
 
-	err = snd_pcm_new(oxfw->card, oxfw->card->driver, 0, 1, 0, &pcm);
+	if (oxfw->has_output)
+		cap = 1;
+
+	err = snd_pcm_new(oxfw->card, oxfw->card->driver, 0, 1, cap, &pcm);
 	if (err < 0)
 		return err;
+
 	pcm->private_data = oxfw;
 	strcpy(pcm->name, oxfw->card->shortname);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &playback_ops);
+	if (cap > 0)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &capture_ops);
+
 	return 0;
 }
diff --git a/sound/firewire/oxfw/oxfw_proc.c b/sound/firewire/oxfw/oxfw_proc.c
index dd287dc..7a69aac 100644
--- a/sound/firewire/oxfw/oxfw_proc.c
+++ b/sound/firewire/oxfw/oxfw_proc.c
@@ -15,6 +15,15 @@ static void proc_read_formation(struct snd_info_entry *entry,
 	struct snd_oxfw_stream_formation *formation;
 	unsigned int i;
 
+	snd_iprintf(buffer, "Output Stream from device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	formation = oxfw->tx_stream_formations;
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		snd_iprintf(buffer,
+			"\t%d\t%d\t%d\n", formation[i].rate,
+			formation[i].pcm, formation[i].midi);
+	}
+
 	snd_iprintf(buffer, "Input Stream to device:\n");
 	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
 	formation = oxfw->rx_stream_formations;
@@ -30,11 +39,8 @@ static void proc_read_clock(struct snd_info_entry *entry,
 {
 	struct snd_oxfw *oxfw = entry->private_data;
 	unsigned int rate;
-	int err;
 
-	err = avc_general_get_sig_fmt(oxfw->unit, &rate,
-				      AVC_GENERAL_PLUG_DIR_IN, 0);
-	if (err >= 0)
+	if (snd_oxfw_stream_get_rate(oxfw, &rate) >= 0)
 		snd_iprintf(buffer, "Sampling rate: %d\n", rate);
 }
 
diff --git a/sound/firewire/oxfw/oxfw_stream.c b/sound/firewire/oxfw/oxfw_stream.c
index 4d66648..6521899 100644
--- a/sound/firewire/oxfw/oxfw_stream.c
+++ b/sound/firewire/oxfw/oxfw_stream.c
@@ -38,44 +38,73 @@ static const unsigned int avc_stream_rate_table[] = {
 	[5] = 0x07,
 };
 
-int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw)
+int snd_oxfw_stream_get_rate(struct snd_oxfw *oxfw, unsigned int *rate)
 {
+	unsigned int tx_rate, rx_rate;
 	int err;
 
-	err = cmp_connection_init(&oxfw->in_conn, oxfw->unit,
-				  CMP_INPUT, 0);
+	err = avc_general_get_sig_fmt(oxfw->unit, &rx_rate,
+				      AVC_GENERAL_PLUG_DIR_IN, 0);
 	if (err < 0)
 		goto end;
+	*rate = rx_rate;
 
-	err = amdtp_stream_init(&oxfw->rx_stream, oxfw->unit,
-				AMDTP_OUT_STREAM, CIP_NONBLOCKING);
-	if (err < 0) {
-		amdtp_stream_destroy(&oxfw->rx_stream);
-		cmp_connection_destroy(&oxfw->in_conn);
+	if (oxfw->has_output) {
+		err = avc_general_get_sig_fmt(oxfw->unit, &tx_rate,
+						AVC_GENERAL_PLUG_DIR_OUT, 0);
+		if ((err < 0) || (rx_rate == tx_rate))
+			goto end;
+
+		/* synchronize transmit stream rate to receive stream rate */
+		err = avc_general_set_sig_fmt(oxfw->unit, rx_rate,
+					AVC_GENERAL_PLUG_DIR_OUT, 0);
 	}
 end:
 	return err;
 }
 
-static int stop_stream(struct snd_oxfw *oxfw)
+int snd_oxfw_stream_set_rate(struct snd_oxfw *oxfw, unsigned int rate)
 {
-	amdtp_stream_pcm_abort(&oxfw->rx_stream);
-	amdtp_stream_stop(&oxfw->rx_stream);
-	cmp_connection_break(&oxfw->in_conn);
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
 }
 
-static int start_stream(struct snd_oxfw *oxfw, unsigned int rate,
-			unsigned int pcm_channels)
+static void stop_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
+{
+	amdtp_stream_pcm_abort(stream);
+	amdtp_stream_stop(stream);
+
+	if (stream == &oxfw->tx_stream)
+		cmp_connection_break(&oxfw->out_conn);
+	else
+		cmp_connection_break(&oxfw->in_conn);
+}
+
+static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream,
+			unsigned int rate, unsigned int pcm_channels)
 {
 	struct snd_oxfw_stream_formation *formations;
 	unsigned int i, midi_ports;
-	struct amdtp_stream *stream;
 	struct cmp_connection *conn;
 	int err;
 
-	stream = &oxfw->rx_stream;
-	formations = oxfw->rx_stream_formations;
-	conn = &oxfw->in_conn;
+	if (stream == &oxfw->rx_stream) {
+		formations = oxfw->rx_stream_formations;
+		conn = &oxfw->in_conn;
+	} else {
+		formations = oxfw->tx_stream_formations;
+		conn = &oxfw->out_conn;
+	}
 
 	/* Get stream formation */
 	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
@@ -118,20 +147,22 @@ static int start_stream(struct snd_oxfw *oxfw, unsigned int rate,
 	/* Wait first callback */
 	err = amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT);
 	if (err < 0)
-		stop_stream(oxfw);
+		stop_stream(oxfw, stream);
 end:
 	return err;
 }
 
-static int check_connection_used_by_others(struct snd_oxfw *oxfw)
+static int check_connection_used_by_others(struct snd_oxfw *oxfw,
+					   struct amdtp_stream *stream)
 {
 	struct cmp_connection *conn;
-	struct amdtp_stream *stream;
 	bool used;
 	int err;
 
-	stream = &oxfw->rx_stream;
-	conn = &oxfw->in_conn;
+	if (stream == &oxfw->tx_stream)
+		conn = &oxfw->out_conn;
+	else
+		conn = &oxfw->in_conn;
 
 	err = cmp_connection_check_used(conn, &used);
 	if ((err >= 0) && used && !amdtp_stream_running(stream)) {
@@ -145,48 +176,123 @@ static int check_connection_used_by_others(struct snd_oxfw *oxfw)
 	return err;
 }
 
-int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw, unsigned int rate,
-				  unsigned int pcm_channels)
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
+	mutex_lock(&oxfw->mutex);
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
+	mutex_unlock(&oxfw->mutex);
+	return err;
+}
+
+int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
+				  struct amdtp_stream *stream,
+				  unsigned int rate, unsigned int pcm_channels)
 {
+	struct amdtp_stream *opposite;
 	unsigned int curr_rate;
+	atomic_t *substreams, *opposite_substreams;
 	int err = 0;
 
+	if (stream == &oxfw->tx_stream) {
+		substreams = &oxfw->capture_substreams;
+		opposite = &oxfw->rx_stream;
+		opposite_substreams = &oxfw->playback_substreams;
+	} else {
+		substreams = &oxfw->playback_substreams;
+		opposite_substreams = &oxfw->capture_substreams;
+
+		if (oxfw->has_output)
+			opposite = &oxfw->rx_stream;
+		else
+			opposite = NULL;
+	}
+
+	if (atomic_read(substreams) == 0)
+		goto end;
+
 	mutex_lock(&oxfw->mutex);
 
 	/*
 	 * Considering JACK/FFADO streaming:
 	 * TODO: This can be removed hwdep functionality becomes popular.
 	 */
-	err = check_connection_used_by_others(oxfw);
+	err = check_connection_used_by_others(oxfw, stream);
 	if (err < 0)
 		goto end;
 
 	/* packet queueing error */
-	if (amdtp_streaming_error(&oxfw->rx_stream))
-		stop_stream(oxfw);
+	if (amdtp_streaming_error(stream))
+		stop_stream(oxfw, stream);
 
-	/* arrange sampling rate */
-	err = avc_general_get_sig_fmt(oxfw->unit, &curr_rate,
-				      AVC_GENERAL_PLUG_DIR_IN, 0);
+	/* stop streams if rate is different */
+	err = snd_oxfw_stream_get_rate(oxfw, &curr_rate);
 	if (err < 0) {
 		dev_err(&oxfw->unit->device,
 			"fail to get sampling rate: %d\n", err);
 		goto end;
 	}
 	if (curr_rate != rate) {
-		stop_stream(oxfw);
+		/* Stop streams safely. */
+		if (opposite != NULL) {
+			err = check_connection_used_by_others(oxfw, opposite);
+			if (err < 0)
+				goto end;
+			stop_stream(oxfw, opposite);
+		}
+		stop_stream(oxfw, stream);
 
-		err = avc_general_set_sig_fmt(oxfw->unit, rate,
-					      AVC_GENERAL_PLUG_DIR_IN, 0);
+		err = snd_oxfw_stream_set_rate(oxfw, rate);
 		if (err < 0) {
 			dev_err(&oxfw->unit->device,
 				"fail to set sampling rate: %d\n", err);
 			goto end;
 		}
+
+		/* Start opposite stream if needed. */
+		if (opposite && !amdtp_stream_running(opposite) &&
+		    (atomic_read(opposite_substreams) > 0)) {
+			err = start_stream(oxfw, opposite, rate, 0);
+			if (err < 0) {
+				dev_err(&oxfw->unit->device,
+					"fail to restart stream: %d\n", err);
+				goto end;
+			}
+		}
 	}
 
-	if (!amdtp_stream_running(&oxfw->rx_stream)) {
-		err = start_stream(oxfw, rate, pcm_channels);
+	if ((atomic_read(substreams) > 0) && !amdtp_stream_running(stream)) {
+		err = start_stream(oxfw, stream, rate, pcm_channels);
 		if (err < 0)
 			dev_err(&oxfw->unit->device,
 				"fail to start stream: %d\n", err);
@@ -196,33 +302,56 @@ end:
 	return err;
 }
 
-void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw)
+void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw,
+				  struct amdtp_stream *stream)
 {
+	if (((stream == &oxfw->tx_stream) &&
+	     (atomic_read(&oxfw->capture_substreams) > 0)) ||
+	    ((stream == &oxfw->rx_stream) &&
+	     (atomic_read(&oxfw->playback_substreams) > 0)))
+		return;
+
 	mutex_lock(&oxfw->mutex);
-	stop_stream(oxfw);
+	stop_stream(oxfw, stream);
 	mutex_unlock(&oxfw->mutex);
 }
 
-void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw)
+void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw,
+				     struct amdtp_stream *stream)
 {
+	struct cmp_connection *conn;
+
+	if (stream == &oxfw->tx_stream)
+		conn = &oxfw->out_conn;
+	else
+		conn = &oxfw->in_conn;
+
 	mutex_lock(&oxfw->mutex);
 
-	stop_stream(oxfw);
+	stop_stream(oxfw, stream);
 
-	amdtp_stream_destroy(&oxfw->rx_stream);
-	cmp_connection_destroy(&oxfw->in_conn);
+	amdtp_stream_destroy(stream);
+	cmp_connection_destroy(conn);
 
 	mutex_unlock(&oxfw->mutex);
 }
 
-void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw)
+void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw,
+				    struct amdtp_stream *stream)
 {
-	if (cmp_connection_update(&oxfw->in_conn) < 0) {
+	struct cmp_connection *conn;
+
+	if (stream == &oxfw->tx_stream)
+		conn = &oxfw->out_conn;
+	else
+		conn = &oxfw->in_conn;
+
+	if (cmp_connection_update(conn) < 0) {
 		mutex_lock(&oxfw->mutex);
-		stop_stream(oxfw);
+		stop_stream(oxfw, stream);
 		mutex_unlock(&oxfw->mutex);
 	} else {
-		amdtp_stream_update(&oxfw->rx_stream);
+		amdtp_stream_update(stream);
 	}
 }
 
@@ -373,7 +502,10 @@ static int fill_stream_formations(struct snd_oxfw *oxfw,
 	if (buf == NULL)
 		return -ENOMEM;
 
-	formations = oxfw->rx_stream_formations;
+	if (dir == AVC_GENERAL_PLUG_DIR_OUT)
+		formations = oxfw->tx_stream_formations;
+	else
+		formations = oxfw->rx_stream_formations;
 
 	/* get first entry */
 	len = AVC_GENERIC_FRAME_MAXIMUM_BYTES;
@@ -452,11 +584,19 @@ int snd_oxfw_stream_discover(struct snd_oxfw *oxfw)
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
+		err = fill_stream_formations(oxfw, AVC_GENERAL_PLUG_DIR_OUT, 0);
+		if (err < 0)
+			goto end;
+		oxfw->has_output = true;
+	}
+
 	/* use iPCR[0] if exists */
 	if (plugs[0] > 0)
 		err = fill_stream_formations(oxfw, AVC_GENERAL_PLUG_DIR_IN, 0);
-- 
1.8.3.2


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
