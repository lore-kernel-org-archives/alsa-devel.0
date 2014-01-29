From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 49/52] oxfw: Add support AMDTP in-stream and PCM capture
Date: Wed, 29 Jan 2014 22:44:56 +0900
Message-ID: <1391003099-7109-50-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Previous commit adds support for some devices which can capture PCM samples.
These devices transmit AMDTP stream in non-blocking mode. The stream from
these devices has a quirk for 'presentation timestamp'.

The sequence of 'presentation timestamp' is invalid even if header of packet
shows 'CIP header with SYT field'. So this driver can't reuse the timestamp
for out stream.

In this reason, this driver handles both streams separately.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c         |   8 +-
 sound/firewire/oxfw/oxfw.h         |  27 ++++-
 sound/firewire/oxfw/oxfw_command.c |  40 ++++++++
 sound/firewire/oxfw/oxfw_pcm.c     | 176 ++++++++++++++++++++++++++-------
 sound/firewire/oxfw/oxfw_proc.c    |  14 ++-
 sound/firewire/oxfw/oxfw_stream.c  | 198 ++++++++++++++++++++++++++-----------
 6 files changed, 361 insertions(+), 102 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index d45073a..fad85f0 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -124,7 +124,7 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto err_card;
 
-	err = snd_oxfw_stream_init(oxfw);
+	err = snd_oxfw_streams_init(oxfw);
 	if (err < 0)
 		goto err_card;
 
@@ -157,14 +157,16 @@ static void oxfw_bus_reset(struct fw_unit *unit)
 	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
 
 	fcp_bus_reset(oxfw->unit);
-	snd_oxfw_stream_update(oxfw);
+	snd_oxfw_stream_update(oxfw, &oxfw->rx_stream);
+	snd_oxfw_stream_update(oxfw, &oxfw->tx_stream);
 }
 
 static void oxfw_remove(struct fw_unit *unit)
 {
 	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
 
-	snd_oxfw_stream_destroy(oxfw);
+	snd_oxfw_stream_destroy(oxfw, &oxfw->rx_stream);
+	snd_oxfw_stream_destroy(oxfw, &oxfw->tx_stream);
 
 	snd_card_disconnect(oxfw->card);
 	snd_card_free_when_closed(oxfw->card);
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index fe6936e..3765f89 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -47,8 +47,12 @@ struct snd_oxfw {
 	struct mutex mutex;
 
 	struct snd_oxfw_stream_formation
+		tx_stream_formations[SND_OXFW_STREAM_TABLE_ENTRIES];
+	struct snd_oxfw_stream_formation
 		rx_stream_formations[SND_OXFW_STREAM_TABLE_ENTRIES];
+	struct cmp_connection out_conn;
 	struct cmp_connection in_conn;
+	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
 
 	bool mute;
@@ -90,11 +94,24 @@ int avc_general_inquiry_sig_fmt(struct fw_unit *unit, unsigned int rate,
 				enum avc_general_plug_dir dir,
 				unsigned short pid);
 
-int snd_oxfw_stream_init(struct snd_oxfw *oxfw);
-int snd_oxfw_stream_start(struct snd_oxfw *oxfw, unsigned int rate);
-void snd_oxfw_stream_stop(struct snd_oxfw *oxfw);
-void snd_oxfw_stream_destroy(struct snd_oxfw *oxfw);
-void snd_oxfw_stream_update(struct snd_oxfw *oxfw);
+int snd_oxfw_command_set_rate(struct snd_oxfw *oxfw,
+			       enum avc_general_plug_dir dir,
+			       unsigned int rate);
+int snd_oxfw_command_get_rate(struct snd_oxfw *oxfw,
+			       enum avc_general_plug_dir dir,
+			       unsigned int *rate);
+
+int snd_oxfw_stream_get_rate(struct snd_oxfw *oxfw, unsigned int *rate);
+int snd_oxfw_stream_set_rate(struct snd_oxfw *oxfw, unsigned int rate);
+
+int snd_oxfw_stream_start(struct snd_oxfw *oxfw,
+			  struct amdtp_stream *stream, unsigned int rate);
+void snd_oxfw_stream_stop(struct snd_oxfw *oxfw, struct amdtp_stream *stream);
+void snd_oxfw_stream_destroy(struct snd_oxfw *oxfw,
+			     struct amdtp_stream *stream);
+void snd_oxfw_stream_update(struct snd_oxfw *oxfw, struct amdtp_stream *stream);
+
+int snd_oxfw_streams_init(struct snd_oxfw *oxfw);
 
 int firewave_stream_discover(struct snd_oxfw *oxfw);
 int lacie_speakers_stream_discover(struct snd_oxfw *oxfw);
diff --git a/sound/firewire/oxfw/oxfw_command.c b/sound/firewire/oxfw/oxfw_command.c
index 5f8cb22..2392b92 100644
--- a/sound/firewire/oxfw/oxfw_command.c
+++ b/sound/firewire/oxfw/oxfw_command.c
@@ -120,3 +120,43 @@ end:
 	kfree(buf);
 	return err;
 }
+
+int snd_oxfw_command_set_rate(struct snd_oxfw *oxfw,
+			       enum avc_general_plug_dir dir,
+			       unsigned int rate)
+{
+	int err;
+
+	err = avc_general_set_sig_fmt(oxfw->unit, rate, dir, 0);
+	if (err < 0)
+		goto end;
+
+	/* ACCEPTED or INTERIM is OK */
+	if ((err != 0x0f) && (err != 0x09)) {
+		dev_err(&oxfw->unit->device,
+			"failed to set sampling rate\n");
+		err = -EIO;
+	}
+end:
+	return err;
+}
+
+int snd_oxfw_command_get_rate(struct snd_oxfw *oxfw,
+			       enum avc_general_plug_dir dir,
+			       unsigned int *rate)
+{
+	int err;
+
+	err = avc_general_get_sig_fmt(oxfw->unit, rate, dir, 0);
+	if (err < 0)
+		goto end;
+
+	/* IMPLEMENTED/STABLE is OK */
+	if (err != 0x0c) {
+		dev_err(&oxfw->unit->device,
+			"failed to get sampling rate\n");
+		err = -EIO;
+	}
+end:
+	return err;
+}
diff --git a/sound/firewire/oxfw/oxfw_pcm.c b/sound/firewire/oxfw/oxfw_pcm.c
index 6755980..17dd17a 100644
--- a/sound/firewire/oxfw/oxfw_pcm.c
+++ b/sound/firewire/oxfw/oxfw_pcm.c
@@ -66,6 +66,14 @@ static int hw_rule_channels(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(c, &t);
 }
 
+static inline int hw_rule_capture_rate(struct snd_pcm_hw_params *params,
+				       struct snd_pcm_hw_rule *rule)
+{
+	struct snd_oxfw *oxfw = rule->private;
+	return hw_rule_rate(params, rule, oxfw,
+			    oxfw->tx_stream_formations);
+}
+
 static inline int hw_rule_playback_rate(struct snd_pcm_hw_params *params,
 					struct snd_pcm_hw_rule *rule)
 {
@@ -74,6 +82,14 @@ static inline int hw_rule_playback_rate(struct snd_pcm_hw_params *params,
 			    oxfw->rx_stream_formations);
 }
 
+static inline int hw_rule_capture_channels(struct snd_pcm_hw_params *params,
+					   struct snd_pcm_hw_rule *rule)
+{
+	struct snd_oxfw *oxfw = rule->private;
+	return hw_rule_channels(params, rule, oxfw,
+				oxfw->tx_stream_formations);
+}
+
 static inline int hw_rule_playback_channels(struct snd_pcm_hw_params *params,
 					    struct snd_pcm_hw_rule *rule)
 {
@@ -117,12 +133,14 @@ static void prepare_rates(struct snd_pcm_hardware *hw,
 	return;
 }
 
-static int oxfw_open(struct snd_pcm_substream *substream)
+static int init_hw_params(struct snd_oxfw *oxfw,
+			  struct snd_pcm_substream *substream)
 {
 	static const struct snd_pcm_hardware hw = {
 		.info = SNDRV_PCM_INFO_MMAP |
 			SNDRV_PCM_INFO_BATCH |
 			SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_JOINT_DUPLEX |
 			/* for Open Sound System compatibility */
 			SNDRV_PCM_INFO_MMAP_VALID |
 			SNDRV_PCM_INFO_BLOCK_TRANSFER,
@@ -133,29 +151,39 @@ static int oxfw_open(struct snd_pcm_substream *substream)
 		/* set up later */
 		.channels_min = UINT_MAX,
 		.channels_max = 0,
-		.buffer_bytes_max = 4 * 1024 * 1024,
+		.buffer_bytes_max = 4 * 16 * 2048,
 		.period_bytes_min = 1,
-		.period_bytes_max = UINT_MAX,
+		.period_bytes_max = 4 * 16 * 2048,
 		.periods_min = 1,
 		.periods_max = UINT_MAX,
 	};
-	struct snd_oxfw *oxfw = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned int rate;
 	int err;
 
 	runtime->hw = hw;
 
 	/* add rule between channels and sampling rate */
-	prepare_rates(&runtime->hw, oxfw->rx_stream_formations);
-	prepare_channels(&runtime->hw, oxfw->rx_stream_formations);
-	runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
-	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-			    hw_rule_playback_channels, oxfw,
-			    SNDRV_PCM_HW_PARAM_RATE, -1);
-	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-			    hw_rule_playback_rate, oxfw,
-			    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		prepare_rates(&runtime->hw, oxfw->tx_stream_formations);
+		prepare_channels(&runtime->hw, oxfw->tx_stream_formations);
+		runtime->hw.formats = SNDRV_PCM_FMTBIT_S32_LE;
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				    hw_rule_capture_channels, oxfw,
+				    SNDRV_PCM_HW_PARAM_RATE, -1);
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				    hw_rule_capture_rate, oxfw,
+				    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	} else {
+		prepare_rates(&runtime->hw, oxfw->rx_stream_formations);
+		prepare_channels(&runtime->hw, oxfw->rx_stream_formations);
+		runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				    hw_rule_playback_channels, oxfw,
+				    SNDRV_PCM_HW_PARAM_RATE, -1);
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				    hw_rule_playback_rate, oxfw,
+				    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	}
 
 	/* AM824 in IEC 61883-6 can deliver 24bit data */
 	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
@@ -170,19 +198,29 @@ static int oxfw_open(struct snd_pcm_substream *substream)
 					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
 	if (err < 0)
 		goto end;
+	err = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
+end:
+	return err;
+}
 
-	/* time for period constraint */
-	err = snd_pcm_hw_constraint_minmax(runtime,
-					   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
-					   5000, UINT_MAX);
+static int oxfw_open(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+	unsigned int rate;
+	int err;
+
+	err = init_hw_params(oxfw, substream);
+	if (err < 0)
+		goto end;
 
 	/*
 	 * When any PCM streams are already running, the available sampling
 	 * rate is limited at current value.
 	 */
-	if (amdtp_stream_pcm_running(&oxfw->rx_stream)) {
-		err = avc_general_get_sig_fmt(oxfw->unit, &rate,
-					      AVC_GENERAL_PLUG_DIR_IN, 0);
+	if (amdtp_stream_pcm_running(&oxfw->tx_stream) ||
+	    amdtp_stream_pcm_running(&oxfw->rx_stream)) {
+		err = snd_oxfw_stream_get_rate(oxfw, &rate);
 		if (err < 0)
 			goto end;
 		substream->runtime->hw.rate_min = rate;
@@ -206,22 +244,45 @@ static int oxfw_hw_params(struct snd_pcm_substream *substream,
 						params_buffer_bytes(hw_params));
 }
 
-static int oxfw_hw_free(struct snd_pcm_substream *substream)
+static int oxfw_hw_free_capture(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+
+	snd_oxfw_stream_stop(oxfw, &oxfw->tx_stream);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+static int oxfw_hw_free_playback(struct snd_pcm_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
 
-	snd_oxfw_stream_stop(oxfw);
+	snd_oxfw_stream_stop(oxfw, &oxfw->rx_stream);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
 
-static int oxfw_prepare(struct snd_pcm_substream *substream)
+static int oxfw_prepare_capture(struct snd_pcm_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
-	err = snd_oxfw_stream_start(oxfw, runtime->rate);
+	err = snd_oxfw_stream_start(oxfw, &oxfw->tx_stream, runtime->rate);
+	if (err < 0)
+		goto end;
+
+	amdtp_stream_set_pcm_format(&oxfw->tx_stream, runtime->format);
+	amdtp_stream_pcm_prepare(&oxfw->tx_stream);
+end:
+	return err;
+}
+static int oxfw_prepare_playback(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	err = snd_oxfw_stream_start(oxfw, &oxfw->rx_stream, runtime->rate);
 	if (err < 0)
 		goto end;
 
@@ -231,7 +292,25 @@ end:
 	return err;
 }
 
-static int oxfw_trigger(struct snd_pcm_substream *substream, int cmd)
+static int oxfw_trigger_capture(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+	struct snd_pcm_substream *pcm;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		pcm = substream;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		pcm = NULL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	amdtp_stream_pcm_trigger(&oxfw->tx_stream, pcm);
+	return 0;
+}
+static int oxfw_trigger_playback(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
 	struct snd_pcm_substream *pcm;
@@ -250,35 +329,62 @@ static int oxfw_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
-static snd_pcm_uframes_t oxfw_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t oxfw_pointer_capture(struct snd_pcm_substream *sbstm)
 {
-	struct snd_oxfw *oxfw = substream->private_data;
+	struct snd_oxfw *oxfw = sbstm->private_data;
+
+	return amdtp_stream_pcm_pointer(&oxfw->tx_stream);
+}
+static snd_pcm_uframes_t oxfw_pointer_playback(struct snd_pcm_substream *sbstm)
+{
+	struct snd_oxfw *oxfw = sbstm->private_data;
 
 	return amdtp_stream_pcm_pointer(&oxfw->rx_stream);
 }
 
 int snd_oxfw_create_pcm(struct snd_oxfw *oxfw)
 {
-	static struct snd_pcm_ops ops = {
+	static struct snd_pcm_ops capture_ops = {
+		.open      = oxfw_open,
+		.close     = oxfw_close,
+		.ioctl     = snd_pcm_lib_ioctl,
+		.hw_params = oxfw_hw_params,
+		.hw_free   = oxfw_hw_free_capture,
+		.prepare   = oxfw_prepare_capture,
+		.trigger   = oxfw_trigger_capture,
+		.pointer   = oxfw_pointer_capture,
+		.page      = snd_pcm_lib_get_vmalloc_page,
+		.mmap      = snd_pcm_lib_mmap_vmalloc,
+	};
+	static struct snd_pcm_ops playback_ops = {
 		.open      = oxfw_open,
 		.close     = oxfw_close,
 		.ioctl     = snd_pcm_lib_ioctl,
 		.hw_params = oxfw_hw_params,
-		.hw_free   = oxfw_hw_free,
-		.prepare   = oxfw_prepare,
-		.trigger   = oxfw_trigger,
-		.pointer   = oxfw_pointer,
+		.hw_free   = oxfw_hw_free_playback,
+		.prepare   = oxfw_prepare_playback,
+		.trigger   = oxfw_trigger_playback,
+		.pointer   = oxfw_pointer_playback,
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
+	unsigned int cap = 0;
 	int err;
 
-	err = snd_pcm_new(oxfw->card, oxfw->card->driver, 0, 1, 0, &pcm);
+	/* 44.1kHz is the most popular */
+	if (oxfw->tx_stream_formations[1].pcm > 0)
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
index e8d80d5..a90dfdb 100644
--- a/sound/firewire/oxfw/oxfw_proc.c
+++ b/sound/firewire/oxfw/oxfw_proc.c
@@ -16,6 +16,15 @@ proc_read_formation(struct snd_info_entry *entry,
 	struct snd_oxfw_stream_formation *formation;
 	unsigned int i;
 
+	snd_iprintf(buffer, "Output Stream from device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	formation = oxfw->tx_stream_formations;
+	for (i = 0; i < SND_OXFW_STREAM_TABLE_ENTRIES; i++) {
+		snd_iprintf(buffer,
+			"\t%d\t%d\t%d\n", snd_oxfw_rate_table[i],
+			formation[i].pcm, formation[i].midi);
+	}
+
 	snd_iprintf(buffer, "Input Stream to device:\n");
 	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
 	formation = oxfw->rx_stream_formations;
@@ -32,11 +41,8 @@ proc_read_clock(struct snd_info_entry *entry,
 {
 	struct snd_oxfw *oxfw = entry->private_data;
 	unsigned int rate;
-	int err;
 
-	err = avc_general_get_sig_fmt(oxfw->unit, &rate,
-				      AVC_GENERAL_PLUG_DIR_IN, 0);
-	if ((err < 0) && (err == 0x09))
+	if (snd_oxfw_stream_get_rate(oxfw, &rate) >= 0)
 		snd_iprintf(buffer, "Sampling rate: %d\n", rate);
 }
 
diff --git a/sound/firewire/oxfw/oxfw_stream.c b/sound/firewire/oxfw/oxfw_stream.c
index 4431571..d4f019c 100644
--- a/sound/firewire/oxfw/oxfw_stream.c
+++ b/sound/firewire/oxfw/oxfw_stream.c
@@ -38,27 +38,77 @@ static const unsigned int avc_stream_rate_table[] = {
 	[6] = 0x07,
 };
 
-int snd_oxfw_stream_init(struct snd_oxfw *oxfw)
+int snd_oxfw_stream_get_rate(struct snd_oxfw *oxfw, unsigned int *rate)
 {
+	unsigned int tx_rate, rx_rate;
 	int err;
 
-	err = cmp_connection_init(&oxfw->in_conn, oxfw->unit,
-				  CMP_INPUT, 0);
+	err = snd_oxfw_command_get_rate(oxfw, AVC_GENERAL_PLUG_DIR_OUT,
+					&tx_rate);
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_init(&oxfw->rx_stream, oxfw->unit,
-				AMDTP_OUT_STREAM, CIP_NONBLOCKING);
+	err = snd_oxfw_command_get_rate(oxfw, AVC_GENERAL_PLUG_DIR_IN,
+					&rx_rate);
 	if (err < 0)
-		cmp_connection_destroy(&oxfw->in_conn);
+		goto end;
+
+	*rate = rx_rate;
+	if (rx_rate == tx_rate)
+		goto end;
+
+	/* synchronize receive stream rate to transmit stream rate */
+	err = snd_oxfw_command_set_rate(oxfw, AVC_GENERAL_PLUG_DIR_IN,
+					rx_rate);
+end:
+	return err;
+}
+
+int snd_oxfw_stream_set_rate(struct snd_oxfw *oxfw, unsigned int rate)
+{
+	int err;
+
+	err = snd_oxfw_command_set_rate(oxfw, AVC_GENERAL_PLUG_DIR_OUT, rate);
+	if (err < 0)
+		goto end;
+
+	err = snd_oxfw_command_set_rate(oxfw, AVC_GENERAL_PLUG_DIR_IN, rate);
 end:
 	return err;
 }
 
-static int start_stream(struct snd_oxfw *oxfw, unsigned int rate)
+static int stream_init(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
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
+	if (err < 0)
+		cmp_connection_destroy(conn);
+end:
+	return err;
+}
+
+static int start_stream(struct snd_oxfw *oxfw,
+			struct amdtp_stream *stream, unsigned int rate)
 {
 	unsigned int i, pcm_channels, midi_ports;
-	struct amdtp_stream *stream;
 	struct cmp_connection *conn;
 	int err;
 
@@ -71,11 +121,15 @@ static int start_stream(struct snd_oxfw *oxfw, unsigned int rate)
 		err = -EINVAL;
 		goto end;
 	}
-
-	pcm_channels = oxfw->rx_stream_formations[i].pcm;
-	midi_ports = oxfw->rx_stream_formations[i].midi;
-	conn = &oxfw->in_conn;
-	stream = &oxfw->rx_stream;
+	if (stream == &oxfw->tx_stream) {
+		pcm_channels = oxfw->tx_stream_formations[i].pcm;
+		midi_ports = oxfw->tx_stream_formations[i].midi;
+		conn = &oxfw->out_conn;
+	} else {
+		pcm_channels = oxfw->rx_stream_formations[i].pcm;
+		midi_ports = oxfw->rx_stream_formations[i].midi;
+		conn = &oxfw->in_conn;
+	}
 
 	/* The stream should have one pcm channels at least */
 	if (pcm_channels == 0) {
@@ -102,20 +156,22 @@ static int start_stream(struct snd_oxfw *oxfw, unsigned int rate)
 	/* Wait first callback */
 	err = amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT);
 	if (err < 0)
-		snd_oxfw_stream_stop(oxfw);
+		snd_oxfw_stream_stop(oxfw, stream);
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
@@ -129,10 +185,12 @@ static int check_connection_used_by_others(struct snd_oxfw *oxfw)
 	return err;
 }
 
-int snd_oxfw_stream_start(struct snd_oxfw *oxfw, unsigned int rate)
+int snd_oxfw_stream_start(struct snd_oxfw *oxfw,
+			  struct amdtp_stream *stream, unsigned int rate)
 {
 	unsigned int curr_rate;
-	int err = 0;
+	struct amdtp_stream *opposite;
+	int err;
 
 	mutex_lock(&oxfw->mutex);
 
@@ -140,72 +198,81 @@ int snd_oxfw_stream_start(struct snd_oxfw *oxfw, unsigned int rate)
 	 * Considering JACK/FFADO streaming:
 	 * TODO: This can be removed hwdep functionality becomes popular.
 	 */
-	err = check_connection_used_by_others(oxfw);
+	err = check_connection_used_by_others(oxfw, stream);
 	if (err < 0)
 		goto end;
 
 	/* packet queueing error */
-	if (amdtp_streaming_error(&oxfw->rx_stream))
-		snd_oxfw_stream_stop(oxfw);
+	if (amdtp_streaming_error(stream))
+		snd_oxfw_stream_stop(oxfw, stream);
 
-	/* arrange sampling rate */
-	err = avc_general_get_sig_fmt(oxfw->unit, &curr_rate,
-				      AVC_GENERAL_PLUG_DIR_IN, 0);
+	/* stop streams if rate is different */
+	err = snd_oxfw_stream_get_rate(oxfw, &curr_rate);
 	if (err < 0)
 		goto end;
-	if (err != 0x0c /* IMPLEMENTED/STABLE */) {
-		dev_err(&oxfw->unit->device,
-			"failed to get sample rate\n");
-		err = -EIO;
-		goto end;
-	}
 	if (curr_rate != rate) {
-		err = avc_general_set_sig_fmt(oxfw->unit, rate,
-					      AVC_GENERAL_PLUG_DIR_IN, 0);
+		/* get opposite stream */
+		if (stream == &oxfw->tx_stream)
+			opposite = &oxfw->rx_stream;
+		else
+			opposite = &oxfw->tx_stream;
+
+		err = check_connection_used_by_others(oxfw, opposite);
 		if (err < 0)
 			goto end;
-		if (err != 0x09 /* ACCEPTED */) {
-			dev_err(&oxfw->unit->device,
-				"failed to set sample rate\n");
-			err = -EIO;
+
+		err = snd_oxfw_stream_set_rate(oxfw, rate);
+		if (err < 0)
 			goto end;
-		}
 	}
 
-	if (!amdtp_stream_running(&oxfw->rx_stream))
-		err = start_stream(oxfw, rate);
+	if (!amdtp_stream_running(stream))
+		err = start_stream(oxfw, stream, rate);
 end:
 	mutex_unlock(&oxfw->mutex);
 	return err;
 }
 
-void snd_oxfw_stream_stop(struct snd_oxfw *oxfw)
+void snd_oxfw_stream_stop(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 {
-	if (amdtp_stream_running(&oxfw->rx_stream))
-		amdtp_stream_stop(&oxfw->rx_stream);
+	if (amdtp_stream_running(stream))
+		amdtp_stream_stop(stream);
 
-	cmp_connection_break(&oxfw->in_conn);
+	if (stream == &oxfw->tx_stream)
+		cmp_connection_break(&oxfw->out_conn);
+	else
+		cmp_connection_break(&oxfw->in_conn);
 }
 
-void snd_oxfw_stream_destroy(struct snd_oxfw *oxfw)
+void snd_oxfw_stream_destroy(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 {
-	amdtp_stream_pcm_abort(&oxfw->rx_stream);
+	amdtp_stream_pcm_abort(stream);
 
 	mutex_lock(&oxfw->mutex);
-	snd_oxfw_stream_stop(oxfw);
-	cmp_connection_destroy(&oxfw->in_conn);
+	snd_oxfw_stream_stop(oxfw, stream);
+	if (stream == &oxfw->tx_stream)
+		cmp_connection_destroy(&oxfw->out_conn);
+	else
+		cmp_connection_destroy(&oxfw->in_conn);
 	mutex_unlock(&oxfw->mutex);
 }
 
-void snd_oxfw_stream_update(struct snd_oxfw *oxfw)
+void snd_oxfw_stream_update(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 {
-	if (cmp_connection_update(&oxfw->in_conn) < 0) {
-		amdtp_stream_pcm_abort(&oxfw->rx_stream);
+	struct cmp_connection *conn;
+
+	if (stream == &oxfw->tx_stream)
+		conn = &oxfw->out_conn;
+	else
+		conn = &oxfw->in_conn;
+
+	if (cmp_connection_update(conn) < 0) {
+		amdtp_stream_pcm_abort(stream);
 		mutex_lock(&oxfw->mutex);
-		snd_oxfw_stream_stop(oxfw);
+		snd_oxfw_stream_stop(oxfw, stream);
 		mutex_unlock(&oxfw->mutex);
 	} else {
-		amdtp_stream_update(&oxfw->rx_stream);
+		amdtp_stream_update(stream);
 	}
 }
 
@@ -355,7 +422,10 @@ fill_stream_formations(struct snd_oxfw *oxfw, enum avc_general_plug_dir dir,
 	if (buf == NULL)
 		return -ENOMEM;
 
-	formations = oxfw->rx_stream_formations;
+	if (dir == AVC_GENERAL_PLUG_DIR_OUT)
+		formations = oxfw->tx_stream_formations;
+	else
+		formations = oxfw->rx_stream_formations;
 
 	/* initialize parameters here because of checking implementation */
 	eid = 0;
@@ -405,10 +475,28 @@ int snd_oxfw_stream_discover(struct snd_oxfw *oxfw)
 		goto end;
 	}
 
+	/* use oPCR[0] */
+	err = fill_stream_formations(oxfw, AVC_GENERAL_PLUG_DIR_OUT, 0);
+	if (err < 0)
+		goto end;
+
 	/* use iPCR[0] */
 	err = fill_stream_formations(oxfw, AVC_GENERAL_PLUG_DIR_IN, 0);
+end:
+	return err;
+}
+
+int snd_oxfw_streams_init(struct snd_oxfw *oxfw)
+{
+	int err;
+
+	err = stream_init(oxfw, &oxfw->rx_stream);
 	if (err < 0)
 		goto end;
+
+	/* 44.1kHz is the most popular */
+	if (oxfw->tx_stream_formations[1].pcm > 0)
+		err = stream_init(oxfw, &oxfw->tx_stream);
 end:
 	return err;
 }
-- 
1.8.3.2


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
