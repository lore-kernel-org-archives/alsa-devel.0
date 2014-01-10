From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/13] speakers: Add support AMDTP in-stream
	and PCM capture
Date: Sat, 11 Jan 2014 00:29:33 +0900
Message-ID: <1389367775-21360-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CF672654DB
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:30:03 +0100 (CET)
In-Reply-To: <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Previous commit adds support for some devices which can capture PCM samples.
They transmits AMDTP stream in non-blocking mode. This stream has a quirk for
'presentation timestamp'.

The sequence of 'presentation timestamp' is invalid even if header of packet
shows 'CIP header with SYT field'. So this driver can't reuse it for out
stream.

In this reason, this driver handles both streams separately.

For your information, I note the sequence of CIP headers in stream transmitted
by  Behringer F-Control Audio 202:

When this driver gives no out-stream:
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

When this driver gives out-stream:
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
 sound/firewire/speakers/speakers.c         |   9 +-
 sound/firewire/speakers/speakers.h         |  26 ++++-
 sound/firewire/speakers/speakers_command.c |  40 +++++++
 sound/firewire/speakers/speakers_pcm.c     | 179 +++++++++++++++++++++++++----
 sound/firewire/speakers/speakers_proc.c    |  14 ++-
 sound/firewire/speakers/speakers_stream.c  | 171 +++++++++++++++++++++------
 6 files changed, 365 insertions(+), 74 deletions(-)

diff --git a/sound/firewire/speakers/speakers.c b/sound/firewire/speakers/speakers.c
index e68046c..76afce9 100644
--- a/sound/firewire/speakers/speakers.c
+++ b/sound/firewire/speakers/speakers.c
@@ -90,7 +90,8 @@ static void fwspk_card_free(struct snd_card *card)
 	struct fwspk *fwspk = card->private_data;
 
 	mutex_lock(&fwspk->mutex);
-	snd_fwspk_stream_destroy(fwspk);
+	snd_fwspk_stream_destroy(fwspk, &fwspk->rx_stream);
+	snd_fwspk_stream_destroy(fwspk, &fwspk->tx_stream);
 	mutex_unlock(&fwspk->mutex);
 
 	fw_unit_put(fwspk->unit);	/* dec reference counter */
@@ -163,7 +164,8 @@ static void fwspk_bus_reset(struct fw_unit *unit)
 	mutex_lock(&fwspk->mutex);
 
 	fcp_bus_reset(fwspk->unit);
-	snd_fwspk_stream_update(fwspk);
+	snd_fwspk_stream_update(fwspk, &fwspk->rx_stream);
+	snd_fwspk_stream_update(fwspk, &fwspk->tx_stream);
 
 	mutex_unlock(&fwspk->mutex);
 }
@@ -172,7 +174,8 @@ static void fwspk_remove(struct fw_unit *unit)
 {
 	struct fwspk *fwspk = dev_get_drvdata(&unit->device);
 
-	snd_fwspk_stream_destroy(fwspk);
+	snd_fwspk_stream_destroy(fwspk, &fwspk->rx_stream);
+	snd_fwspk_stream_destroy(fwspk, &fwspk->tx_stream);
 	snd_card_disconnect(fwspk->card);
 	snd_card_free_when_closed(fwspk->card);
 }
diff --git a/sound/firewire/speakers/speakers.h b/sound/firewire/speakers/speakers.h
index 017d972..5d6c8e8 100644
--- a/sound/firewire/speakers/speakers.h
+++ b/sound/firewire/speakers/speakers.h
@@ -47,8 +47,12 @@ struct fwspk {
 	struct mutex mutex;
 
 	struct fwspk_stream_formation
+		tx_stream_formations[FWSPK_STREAM_TABLE_ENTRIES];
+	struct fwspk_stream_formation
 		rx_stream_formations[FWSPK_STREAM_TABLE_ENTRIES];
+	struct cmp_connection out_conn;
 	struct cmp_connection in_conn;
+	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
 
 	bool mute;
@@ -87,11 +91,23 @@ int avc_general_inquiry_sig_fmt(struct fw_unit *unit, unsigned int rate,
 				enum avc_general_plug_dir dir,
 				unsigned short pid);
 
-int snd_fwspk_stream_init(struct fwspk *fwspk);
-int snd_fwspk_stream_start(struct fwspk *fwspk, unsigned int rate);
-void snd_fwspk_stream_stop(struct fwspk *fwspk);
-void snd_fwspk_stream_destroy(struct fwspk *fwspk);
-void snd_fwspk_stream_update(struct fwspk *fwspk);
+int snd_fwspk_command_set_rate(struct fwspk *fwspk,
+			       enum avc_general_plug_dir dir,
+			       unsigned int rate);
+int snd_fwspk_command_get_rate(struct fwspk *fwspk,
+			       enum avc_general_plug_dir dir,
+			       unsigned int *rate);
+
+int snd_fwspk_stream_get_rate(struct fwspk *fwspk, unsigned int *rate);
+int snd_fwspk_stream_set_rate(struct fwspk *fwspk, unsigned int rate);
+
+int snd_fwspk_stream_start(struct fwspk *fwspk,
+			   struct amdtp_stream *stream, unsigned int rate);
+void snd_fwspk_stream_stop(struct fwspk *fwspk, struct amdtp_stream *stream);
+void snd_fwspk_stream_destroy(struct fwspk *fwspk, struct amdtp_stream *stream);
+void snd_fwspk_stream_update(struct fwspk *fwspk, struct amdtp_stream *stream);
+
+int snd_fwspk_streams_init(struct fwspk *fwspk);
 
 int firewave_stream_discover(struct fwspk *fwspk);
 int lacie_speakers_stream_discover(struct fwspk *fwspk);
diff --git a/sound/firewire/speakers/speakers_command.c b/sound/firewire/speakers/speakers_command.c
index a13bc9e..274683e 100644
--- a/sound/firewire/speakers/speakers_command.c
+++ b/sound/firewire/speakers/speakers_command.c
@@ -120,3 +120,43 @@ end:
 	kfree(buf);
 	return err;
 }
+
+int snd_fwspk_command_set_rate(struct fwspk *fwspk,
+			       enum avc_general_plug_dir dir,
+			       unsigned int rate)
+{
+	int err;
+
+	err = avc_general_set_sig_fmt(fwspk->unit, rate, dir, 0);
+	if (err < 0)
+		goto end;
+
+	/* ACCEPTED or INTERIM is OK */
+	if ((err != 0x0f) && (err != 0x09)) {
+		dev_err(&fwspk->unit->device,
+			"failed to set sampling rate\n");
+		err = -EIO;
+	}
+end:
+	return err;
+}
+
+int snd_fwspk_command_get_rate(struct fwspk *fwspk,
+			       enum avc_general_plug_dir dir,
+			       unsigned int *rate)
+{
+	int err;
+
+	err = avc_general_get_sig_fmt(fwspk->unit, rate, dir, 0);
+	if (err < 0)
+		goto end;
+
+	/* IMPLEMENTED/STABLE is OK */
+	if (err != 0x0c) {
+		dev_err(&fwspk->unit->device,
+			"failed to get sampling rate\n");
+		err = -EIO;
+	}
+end:
+	return err;
+}
diff --git a/sound/firewire/speakers/speakers_pcm.c b/sound/firewire/speakers/speakers_pcm.c
index 2258ddf..da777d2 100644
--- a/sound/firewire/speakers/speakers_pcm.c
+++ b/sound/firewire/speakers/speakers_pcm.c
@@ -66,6 +66,13 @@ static int hw_rule_channels(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(c, &t);
 }
 
+static inline int hw_rule_capture_rate(struct snd_pcm_hw_params *params,
+				       struct snd_pcm_hw_rule *rule)
+{
+	struct fwspk *fwspk = rule->private;
+	return hw_rule_rate(params, rule, fwspk,
+			    fwspk->tx_stream_formations);
+}
 static inline int hw_rule_playback_rate(struct snd_pcm_hw_params *params,
 					struct snd_pcm_hw_rule *rule)
 {
@@ -74,6 +81,14 @@ static inline int hw_rule_playback_rate(struct snd_pcm_hw_params *params,
 			    fwspk->rx_stream_formations);
 }
 
+static inline int hw_rule_capture_channels(struct snd_pcm_hw_params *params,
+					   struct snd_pcm_hw_rule *rule)
+{
+	struct fwspk *fwspk = rule->private;
+	return hw_rule_channels(params, rule, fwspk,
+				fwspk->tx_stream_formations);
+}
+
 static inline int hw_rule_playback_channels(struct snd_pcm_hw_params *params,
 					    struct snd_pcm_hw_rule *rule)
 {
@@ -117,12 +132,14 @@ static void prepare_rates(struct snd_pcm_hardware *hw,
 	return;
 }
 
-int fwspk_open(struct snd_pcm_substream *substream)
+static int init_hw_params(struct fwspk *fwspk,
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
@@ -139,22 +156,33 @@ int fwspk_open(struct snd_pcm_substream *substream)
 		.periods_min = 1,
 		.periods_max = UINT_MAX,
 	};
-	struct fwspk *fwspk = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
 	runtime->hw = hw;
 
 	/* add rule between channels and sampling rate */
-	prepare_rates(&runtime->hw, fwspk->rx_stream_formations);
-	prepare_channels(&runtime->hw, fwspk->rx_stream_formations);
-	runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
-	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-			hw_rule_playback_channels, fwspk,
-			SNDRV_PCM_HW_PARAM_RATE, -1);
-	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-			hw_rule_playback_rate, fwspk,
-			SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		prepare_rates(&runtime->hw, fwspk->tx_stream_formations);
+		prepare_channels(&runtime->hw, fwspk->tx_stream_formations);
+		runtime->hw.formats = SNDRV_PCM_FMTBIT_S32_LE;
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				    hw_rule_capture_channels, fwspk,
+				    SNDRV_PCM_HW_PARAM_RATE, -1);
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				    hw_rule_capture_rate, fwspk,
+				    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	} else {
+		prepare_rates(&runtime->hw, fwspk->rx_stream_formations);
+		prepare_channels(&runtime->hw, fwspk->rx_stream_formations);
+		runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				    hw_rule_playback_channels, fwspk,
+				    SNDRV_PCM_HW_PARAM_RATE, -1);
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				    hw_rule_playback_rate, fwspk,
+				    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	}
 
 	/* AM824 in IEC 61883-6 can deliver 24bit data */
 	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
@@ -178,6 +206,34 @@ end:
 	return err;
 }
 
+static int fwspk_open(struct snd_pcm_substream *substream)
+{
+	struct fwspk *fwspk = substream->private_data;
+	unsigned int rate;
+	int err;
+
+	err = init_hw_params(fwspk, substream);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * When any PCM stream are already running, the available sampling rate
+	 *  is limited at current value.
+	 */
+	if (amdtp_stream_pcm_running(&fwspk->tx_stream) ||
+	    amdtp_stream_pcm_running(&fwspk->rx_stream)) {
+		err = snd_fwspk_stream_get_rate(fwspk, &rate);
+		if (err < 0)
+			goto end;
+		substream->runtime->hw.rate_min = rate;
+		substream->runtime->hw.rate_max = rate;
+	}
+
+	snd_pcm_set_sync(substream);
+end:
+	return err;
+}
+
 static int fwspk_close(struct snd_pcm_substream *substream)
 {
 	return 0;
@@ -190,18 +246,46 @@ static int fwspk_hw_params(struct snd_pcm_substream *substream,
 						params_buffer_bytes(hw_params));
 }
 
-static int fwspk_hw_free(struct snd_pcm_substream *substream)
+static int fwspk_hw_free_capture(struct snd_pcm_substream *substream)
 {
 	struct fwspk *fwspk = substream->private_data;
 
 	mutex_lock(&fwspk->mutex);
-	snd_fwspk_stream_stop(fwspk);
+	snd_fwspk_stream_stop(fwspk, &fwspk->tx_stream);
 	mutex_unlock(&fwspk->mutex);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
+static int fwspk_hw_free_playback(struct snd_pcm_substream *substream)
+{
+	struct fwspk *fwspk = substream->private_data;
+
+	mutex_lock(&fwspk->mutex);
+	snd_fwspk_stream_stop(fwspk, &fwspk->rx_stream);
+	mutex_unlock(&fwspk->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int fwspk_prepare_capture(struct snd_pcm_substream *substream)
+{
+	struct fwspk *fwspk = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
 
-static int fwspk_prepare(struct snd_pcm_substream *substream)
+	mutex_lock(&fwspk->mutex);
+
+	err = snd_fwspk_stream_start(fwspk, &fwspk->tx_stream, runtime->rate);
+	if (err < 0)
+		goto end;
+
+	amdtp_stream_set_pcm_format(&fwspk->tx_stream, runtime->format);
+	amdtp_stream_pcm_prepare(&fwspk->tx_stream);
+end:
+	mutex_unlock(&fwspk->mutex);
+	return err;
+}
+static int fwspk_prepare_playback(struct snd_pcm_substream *substream)
 {
 	struct fwspk *fwspk = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -209,7 +293,7 @@ static int fwspk_prepare(struct snd_pcm_substream *substream)
 
 	mutex_lock(&fwspk->mutex);
 
-	err = snd_fwspk_stream_start(fwspk, runtime->rate);
+	err = snd_fwspk_stream_start(fwspk, &fwspk->rx_stream, runtime->rate);
 	if (err < 0)
 		goto end;
 
@@ -220,7 +304,25 @@ end:
 	return err;
 }
 
-static int fwspk_trigger(struct snd_pcm_substream *substream, int cmd)
+static int fwspk_trigger_capture(struct snd_pcm_substream *substream, int cmd)
+{
+	struct fwspk *fwspk = substream->private_data;
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
+	amdtp_stream_pcm_trigger(&fwspk->tx_stream, pcm);
+	return 0;
+}
+static int fwspk_trigger_playback(struct snd_pcm_substream *substream, int cmd)
 {
 	struct fwspk *fwspk = substream->private_data;
 	struct snd_pcm_substream *pcm;
@@ -239,35 +341,62 @@ static int fwspk_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
-static snd_pcm_uframes_t fwspk_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t fwspk_pointer_capture(struct snd_pcm_substream *sbstm)
 {
-	struct fwspk *fwspk = substream->private_data;
+	struct fwspk *fwspk = sbstm->private_data;
+
+	return amdtp_stream_pcm_pointer(&fwspk->tx_stream);
+}
+static snd_pcm_uframes_t fwspk_pointer_playback(struct snd_pcm_substream *sbstm)
+{
+	struct fwspk *fwspk = sbstm->private_data;
 
 	return amdtp_stream_pcm_pointer(&fwspk->rx_stream);
 }
 
 int snd_fwspk_create_pcm(struct fwspk *fwspk)
 {
-	static struct snd_pcm_ops ops = {
+	static struct snd_pcm_ops capture_ops = {
 		.open      = fwspk_open,
 		.close     = fwspk_close,
 		.ioctl     = snd_pcm_lib_ioctl,
 		.hw_params = fwspk_hw_params,
-		.hw_free   = fwspk_hw_free,
-		.prepare   = fwspk_prepare,
-		.trigger   = fwspk_trigger,
-		.pointer   = fwspk_pointer,
+		.hw_free   = fwspk_hw_free_capture,
+		.prepare   = fwspk_prepare_capture,
+		.trigger   = fwspk_trigger_capture,
+		.pointer   = fwspk_pointer_capture,
+		.page      = snd_pcm_lib_get_vmalloc_page,
+		.mmap      = snd_pcm_lib_mmap_vmalloc,
+	};
+	static struct snd_pcm_ops playback_ops = {
+		.open      = fwspk_open,
+		.close     = fwspk_close,
+		.ioctl     = snd_pcm_lib_ioctl,
+		.hw_params = fwspk_hw_params,
+		.hw_free   = fwspk_hw_free_playback,
+		.prepare   = fwspk_prepare_playback,
+		.trigger   = fwspk_trigger_playback,
+		.pointer   = fwspk_pointer_playback,
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
+	unsigned int cap = 0;
 	int err;
 
-	err = snd_pcm_new(fwspk->card, fwspk->card->driver, 0, 1, 0, &pcm);
+	/* 44.1kHz is the most popular */
+	if (fwspk->tx_stream_formations[1].pcm > 0)
+		cap = 1;
+
+	err = snd_pcm_new(fwspk->card, fwspk->card->driver, 0, 1, cap, &pcm);
 	if (err < 0)
 		return err;
+
 	pcm->private_data = fwspk;
 	strcpy(pcm->name, fwspk->card->shortname);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &playback_ops);
+	if (cap > 0)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &capture_ops);
+
 	return 0;
 }
diff --git a/sound/firewire/speakers/speakers_proc.c b/sound/firewire/speakers/speakers_proc.c
index 9721e52..2865ce2 100644
--- a/sound/firewire/speakers/speakers_proc.c
+++ b/sound/firewire/speakers/speakers_proc.c
@@ -16,6 +16,15 @@ proc_read_formation(struct snd_info_entry *entry,
 	struct fwspk_stream_formation *formation;
 	unsigned int i;
 
+	snd_iprintf(buffer, "Output Stream from device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	formation = fwspk->tx_stream_formations;
+	for (i = 0; i < FWSPK_STREAM_TABLE_ENTRIES; i++) {
+		snd_iprintf(buffer,
+			"\t%d\t%d\t%d\n", fwspk_rate_table[i],
+			formation[i].pcm, formation[i].midi);
+	}
+
 	snd_iprintf(buffer, "Input Stream to device:\n");
 	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
 	formation = fwspk->rx_stream_formations;
@@ -32,11 +41,8 @@ proc_read_clock(struct snd_info_entry *entry,
 {
 	struct fwspk *fwspk = entry->private_data;
 	unsigned int rate;
-	int err;
 
-	err = avc_general_get_sig_fmt(fwspk->unit, &rate,
-				      AVC_GENERAL_PLUG_DIR_IN, 0);
-	if ((err < 0) && (err == 0x09))
+	if (snd_fwspk_stream_get_rate(fwspk, &rate) >= 0)
 		snd_iprintf(buffer, "Sampling rate: %d\n", rate);
 }
 
diff --git a/sound/firewire/speakers/speakers_stream.c b/sound/firewire/speakers/speakers_stream.c
index 591e6bf..b02b03c 100644
--- a/sound/firewire/speakers/speakers_stream.c
+++ b/sound/firewire/speakers/speakers_stream.c
@@ -36,39 +36,101 @@ static const unsigned int avc_stream_rate_table[] = {
 	[6] = 0x07,
 };
 
-int snd_fwspk_stream_init(struct fwspk *fwspk)
+int snd_fwspk_stream_get_rate(struct fwspk *fwspk, unsigned int *rate)
 {
+	unsigned int tx_rate, rx_rate;
 	int err;
 
-	err = cmp_connection_init(&fwspk->in_conn, fwspk->unit,
-				  CMP_INPUT, 0);
+	err = snd_fwspk_command_get_rate(fwspk,
+					 AVC_GENERAL_PLUG_DIR_OUT, &tx_rate);
+	if (err < 0)
+		goto end;
+
+	err = snd_fwspk_command_get_rate(fwspk,
+				 AVC_GENERAL_PLUG_DIR_IN, &rx_rate);
+	if (err < 0)
+		goto end;
+
+	*rate = rx_rate;
+	if (rx_rate == tx_rate)
+		goto end;
+
+	/* synchronize receive stream rate to transmit stream rate */
+	err = snd_fwspk_command_set_rate(fwspk,
+					 AVC_GENERAL_PLUG_DIR_IN, rx_rate);
+end:
+	return err;
+}
+
+int snd_fwspk_stream_set_rate(struct fwspk *fwspk, unsigned int rate)
+{
+	int err;
+
+	err = snd_fwspk_command_set_rate(fwspk, AVC_GENERAL_PLUG_DIR_OUT, rate);
+	if (err < 0)
+		goto end;
+
+	err = snd_fwspk_command_set_rate(fwspk, AVC_GENERAL_PLUG_DIR_IN, rate);
+end:
+	return err;
+}
+
+static int stream_init(struct fwspk *fwspk, struct amdtp_stream *stream)
+{
+	struct cmp_connection *conn;
+	enum cmp_direction c_dir;
+	enum amdtp_stream_direction s_dir;
+	int err;
+
+	if (stream == &fwspk->tx_stream) {
+		conn = &fwspk->out_conn;
+		c_dir = CMP_OUTPUT;
+		s_dir = AMDTP_IN_STREAM;
+	} else {
+		conn = &fwspk->in_conn;
+		c_dir = CMP_INPUT;
+		s_dir = AMDTP_OUT_STREAM;
+	}
+
+	err = cmp_connection_init(conn, fwspk->unit, c_dir, 0);
 	if (err < 0) {
 		fw_unit_put(fwspk->unit);
 		goto end;
 	}
 
-	err = amdtp_stream_init(&fwspk->rx_stream, fwspk->unit,
-				AMDTP_OUT_STREAM, CIP_NONBLOCKING);
+	err = amdtp_stream_init(stream, fwspk->unit, s_dir, CIP_NONBLOCKING);
 	if (err < 0)
-		cmp_connection_destroy(&fwspk->in_conn);
+		cmp_connection_destroy(conn);
 end:
 	return err;
 }
 
-int snd_fwspk_stream_start(struct fwspk *fwspk, unsigned int rate)
+int snd_fwspk_stream_start(struct fwspk *fwspk,
+			   struct amdtp_stream *stream,
+			   unsigned int rate)
 {
 	unsigned int i, curr_rate, pcm_channels, midi_ports;
+	struct cmp_connection *conn;
+	enum avc_general_plug_dir dir;
 	bool used;
 	int err;
 
 	/* already start or not */
-	if (amdtp_stream_running(&fwspk->rx_stream)) {
+	if (amdtp_stream_running(stream)) {
 		err = 0;
 		goto end;
 	}
 
+	if (stream == &fwspk->tx_stream) {
+		conn = &fwspk->out_conn;
+		dir = AVC_GENERAL_PLUG_DIR_OUT;
+	} else {
+		conn = &fwspk->in_conn;
+		dir = AVC_GENERAL_PLUG_DIR_IN;
+	}
+
 	/* check other's connection */
-	err = cmp_connection_check_used(&fwspk->in_conn, &used);
+	err = cmp_connection_check_used(conn, &used);
 	if (err < 0)
 		goto end;
 	else if (used) {
@@ -77,8 +139,7 @@ int snd_fwspk_stream_start(struct fwspk *fwspk, unsigned int rate)
 	};
 
 	/* arrange sampling rate */
-	err = avc_general_get_sig_fmt(fwspk->unit, &curr_rate,
-				      AVC_GENERAL_PLUG_DIR_IN, 0);
+	err = avc_general_get_sig_fmt(fwspk->unit, &curr_rate, dir, 0);
 	if (err < 0)
 		goto end;
 	if (err != 0x0c /* IMPLEMENTED/STABLE */) {
@@ -88,8 +149,7 @@ int snd_fwspk_stream_start(struct fwspk *fwspk, unsigned int rate)
 		goto end;
 	}
 	if (curr_rate != rate) {
-		err = avc_general_set_sig_fmt(fwspk->unit, rate,
-					      AVC_GENERAL_PLUG_DIR_IN, 0);
+		err = avc_general_set_sig_fmt(fwspk->unit, rate, dir, 0);
 		if (err < 0)
 			goto end;
 		if (err != 0x09 /* ACCEPTED */) {
@@ -109,52 +169,66 @@ int snd_fwspk_stream_start(struct fwspk *fwspk, unsigned int rate)
 		err = -EINVAL;
 		goto end;
 	}
-	pcm_channels = fwspk->rx_stream_formations[i].pcm;
-	midi_ports = fwspk->rx_stream_formations[i].midi;
-	if ((pcm_channels == 0) && (midi_ports == 0)) {
+	if (stream == &fwspk->tx_stream) {
+		pcm_channels = fwspk->tx_stream_formations[i].pcm;
+		midi_ports = fwspk->tx_stream_formations[i].midi;
+	} else {
+		pcm_channels = fwspk->rx_stream_formations[i].pcm;
+		midi_ports = fwspk->rx_stream_formations[i].midi;
+	}
+	if (pcm_channels == 0) {
 		err = -EINVAL;
 		goto end;
 	}
-	amdtp_stream_set_parameters(&fwspk->rx_stream, rate,
-				    pcm_channels, midi_ports);
+	amdtp_stream_set_parameters(stream, rate, pcm_channels, midi_ports);
 
 	/* establish connection */
-	err = cmp_connection_establish(&fwspk->in_conn,
-			amdtp_stream_get_max_payload(&fwspk->rx_stream));
+	err = cmp_connection_establish(conn,
+			amdtp_stream_get_max_payload(stream));
 	if (err < 0)
 		goto end;
 
 	/* start stream */
-	err = amdtp_stream_start(&fwspk->rx_stream,
-				 fwspk->in_conn.resources.channel,
-				 fwspk->in_conn.speed);
+	err = amdtp_stream_start(stream,
+				 conn->resources.channel,
+				 conn->speed);
 	if (err < 0)
-		cmp_connection_break(&fwspk->in_conn);
+		cmp_connection_break(conn);
 end:
 	return err;
 }
 
-void snd_fwspk_stream_stop(struct fwspk *fwspk)
+void snd_fwspk_stream_stop(struct fwspk *fwspk, struct amdtp_stream *stream)
 {
-	if (amdtp_stream_running(&fwspk->rx_stream))
-		amdtp_stream_stop(&fwspk->rx_stream);
+	if (amdtp_stream_running(stream))
+		amdtp_stream_stop(stream);
 
-	cmp_connection_break(&fwspk->in_conn);
+	if (stream == &fwspk->tx_stream)
+		cmp_connection_break(&fwspk->out_conn);
+	else
+		cmp_connection_break(&fwspk->in_conn);
 }
 
-void snd_fwspk_stream_destroy(struct fwspk *fwspk)
+void snd_fwspk_stream_destroy(struct fwspk *fwspk, struct amdtp_stream *stream)
 {
-	amdtp_stream_pcm_abort(&fwspk->rx_stream);
-	snd_fwspk_stream_stop(fwspk);
+	amdtp_stream_pcm_abort(stream);
+	snd_fwspk_stream_stop(fwspk, stream);
 }
 
-void snd_fwspk_stream_update(struct fwspk *fwspk)
+void snd_fwspk_stream_update(struct fwspk *fwspk, struct amdtp_stream *stream)
 {
-	if (cmp_connection_update(&fwspk->in_conn) < 0) {
-		amdtp_stream_pcm_abort(&fwspk->rx_stream);
-		snd_fwspk_stream_stop(fwspk);
+	struct cmp_connection *conn;
+
+	if (stream == &fwspk->tx_stream)
+		conn = &fwspk->out_conn;
+	else
+		conn = &fwspk->in_conn;
+
+	if (cmp_connection_update(conn) < 0) {
+		amdtp_stream_pcm_abort(stream);
+		snd_fwspk_stream_stop(fwspk, stream);
 	} else {
-		amdtp_stream_update(&fwspk->rx_stream);
+		amdtp_stream_update(stream);
 	}
 }
 
@@ -304,7 +378,10 @@ fill_stream_formations(struct fwspk *fwspk, enum avc_general_plug_dir dir,
 	if (buf == NULL)
 		return -ENOMEM;
 
-	formations = fwspk->rx_stream_formations;
+	if (dir == AVC_GENERAL_PLUG_DIR_OUT)
+		formations = fwspk->tx_stream_formations;
+	else
+		formations = fwspk->rx_stream_formations;
 
 	/* initialize parameters here because of checking implementation */
 	eid = 0;
@@ -354,6 +431,11 @@ int snd_fwspk_stream_discover(struct fwspk *fwspk)
 		goto end;
 	}
 
+	/* use oPCR[0] */
+	err = fill_stream_formations(fwspk, AVC_GENERAL_PLUG_DIR_OUT, 0);
+	if (err < 0)
+		goto end;
+
 	/* use iPCR[0] */
 	err = fill_stream_formations(fwspk, AVC_GENERAL_PLUG_DIR_IN, 0);
 	if (err < 0)
@@ -361,3 +443,18 @@ int snd_fwspk_stream_discover(struct fwspk *fwspk)
 end:
 	return err;
 }
+
+int snd_fwspk_streams_init(struct fwspk *fwspk)
+{
+	int err;
+
+	err = stream_init(fwspk, &fwspk->rx_stream);
+	if (err < 0)
+		goto end;
+
+	/* 44.1kHz is the most popular */
+	if (fwspk->tx_stream_formations[1].pcm > 0)
+		err = stream_init(fwspk, &fwspk->tx_stream);
+end:
+	return err;
+}
-- 
1.8.3.2
