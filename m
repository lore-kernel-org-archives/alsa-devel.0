From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/13] speakers: Change the way to make PCM
	rules/constraints
Date: Sat, 11 Jan 2014 00:29:28 +0900
Message-ID: <1389367775-21360-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id A5758261A40
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:29:54 +0100 (CET)
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

For PCM rules/constrains, drivers need to know stream formation at each
supported sampling rates in advance. This commit adds
'struct fwspk_stream_formation' to save formation information.

According to datasheet of OXFW970/971, they support 32.0kHz to 196.0kHz.
So this commit adds 'rx_stream_formations' member to 'struct fwspk'. It's
an array with 7 elements. Each element corresponds to each sampling rate.

With these data structure, this commit changes the way to make PCM
rules/constraints.

I don't know whether Griffin/LaCie devices supports SINGLE/LIST subfunction of
'AV/C Stream Format Information' command. So this commit adds codes to
generate formations for them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/speakers/speakers.c        |  37 +++---
 sound/firewire/speakers/speakers.h        |  16 ++-
 sound/firewire/speakers/speakers_pcm.c    | 203 +++++++++++++++++++-----------
 sound/firewire/speakers/speakers_stream.c |  36 ++++++
 4 files changed, 198 insertions(+), 94 deletions(-)

diff --git a/sound/firewire/speakers/speakers.c b/sound/firewire/speakers/speakers.c
index 1b5556b..e07ed5f 100644
--- a/sound/firewire/speakers/speakers.c
+++ b/sound/firewire/speakers/speakers.c
@@ -24,6 +24,20 @@ MODULE_DESCRIPTION("FireWire speakers driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 
+static const struct device_info griffin_firewave = {
+	.driver_name = "FireWave",
+	.mixer_channels = 6,
+	.mute_fb_id   = 0x01,
+	.volume_fb_id = 0x02,
+};
+
+static const struct device_info lacie_speakers = {
+	.driver_name = "FWSpeakers",
+	.mixer_channels = 1,
+	.mute_fb_id   = 0x01,
+	.volume_fb_id = 0x01,
+};
+
 static int name_card(struct fwspk *fwspk)
 {
 	struct fw_device *fw_dev = fw_parent_device(fwspk->unit);
@@ -94,6 +108,13 @@ static int fwspk_probe(struct fw_unit *unit,
 	fwspk->device_info = (const struct device_info *)id->driver_data;
 	mutex_init(&fwspk->mutex);
 
+	if (fwspk->device_info == &griffin_firewave)
+		err = firewave_stream_discover(fwspk);
+	else
+		err = lacie_speakers_stream_discover(fwspk);
+	if (err < 0)
+		goto err_card;
+
 	err = name_card(fwspk);
 	if (err < 0)
 		goto err_card;
@@ -143,22 +164,6 @@ static void fwspk_remove(struct fw_unit *unit)
 	snd_card_free_when_closed(fwspk->card);
 }
 
-static const struct device_info griffin_firewave = {
-	.driver_name = "FireWave",
-	.pcm_constraints = firewave_constraints,
-	.mixer_channels = 6,
-	.mute_fb_id   = 0x01,
-	.volume_fb_id = 0x02,
-};
-
-static const struct device_info lacie_speakers = {
-	.driver_name = "FWSpeakers",
-	.pcm_constraints = lacie_speakers_constraints,
-	.mixer_channels = 1,
-	.mute_fb_id   = 0x01,
-	.volume_fb_id = 0x01,
-};
-
 static const struct ieee1394_device_id fwspk_id_table[] = {
 	{
 		.match_flags  = IEEE1394_MATCH_VENDOR_ID |
diff --git a/sound/firewire/speakers/speakers.h b/sound/firewire/speakers/speakers.h
index c921714..d3029f0 100644
--- a/sound/firewire/speakers/speakers.h
+++ b/sound/firewire/speakers/speakers.h
@@ -28,19 +28,28 @@ struct device_info {
 	const char *driver_name;
 	const char *short_name;
 	const char *long_name;
-	int (*pcm_constraints)(struct snd_pcm_runtime *runtime);
 	unsigned int mixer_channels;
 	u8 mute_fb_id;
 	u8 volume_fb_id;
 };
 
+#define	FWSPK_STREAM_TABLE_ENTRIES	7
+struct fwspk_stream_formation {
+	unsigned int pcm;
+	unsigned int midi;
+};
+extern const unsigned int fwspk_rate_table[FWSPK_STREAM_TABLE_ENTRIES];
 struct fwspk {
 	struct snd_card *card;
 	struct fw_unit *unit;
 	const struct device_info *device_info;
 	struct mutex mutex;
+
+	struct fwspk_stream_formation
+		rx_stream_formations[FWSPK_STREAM_TABLE_ENTRIES];
 	struct cmp_connection in_conn;
 	struct amdtp_stream rx_stream;
+
 	bool mute;
 	s16 volume[6];
 	s16 volume_min;
@@ -53,9 +62,10 @@ void snd_fwspk_stream_stop(struct fwspk *fwspk);
 void snd_fwspk_stream_destroy(struct fwspk *fwspk);
 void snd_fwspk_stream_update(struct fwspk *fwspk);
 
+int firewave_stream_discover(struct fwspk *fwspk);
+int lacie_speakers_stream_discover(struct fwspk *fwspk);
+
 int snd_fwspk_create_pcm(struct fwspk *fwspk);
 
 int snd_fwspk_create_mixer(struct fwspk *fwspk);
 
-int firewave_constraints(struct snd_pcm_runtime *runtime);
-int lacie_speakers_constraints(struct snd_pcm_runtime *runtime);
diff --git a/sound/firewire/speakers/speakers_pcm.c b/sound/firewire/speakers/speakers_pcm.c
index 8fa437f..cc4b610 100644
--- a/sound/firewire/speakers/speakers_pcm.c
+++ b/sound/firewire/speakers/speakers_pcm.c
@@ -7,92 +7,132 @@
 
 #include "speakers.h"
 
-static int firewave_rate_constraint(struct snd_pcm_hw_params *params,
-				    struct snd_pcm_hw_rule *rule)
+static int hw_rule_rate(struct snd_pcm_hw_params *params,
+			struct snd_pcm_hw_rule *rule,
+			struct fwspk *fwspk,
+			struct fwspk_stream_formation *formations)
 {
-	static unsigned int stereo_rates[] = { 48000, 96000 };
-	struct snd_interval *channels =
-			hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-	struct snd_interval *rate =
-			hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
-
-	/* two channels work only at 48/96 kHz */
-	if (snd_interval_max(channels) < 6)
-		return snd_interval_list(rate, 2, stereo_rates, 0);
-	return 0;
+	struct snd_interval *r =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	const struct snd_interval *c =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval t = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int i;
+
+	for (i = 0; i < FWSPK_STREAM_TABLE_ENTRIES; i++) {
+		/* entry is invalid */
+		if (formations[i].pcm == 0)
+			continue;
+
+		if (!snd_interval_test(c, formations[i].pcm))
+			continue;
+
+		t.min = min(t.min, fwspk_rate_table[i]);
+		t.max = max(t.max, fwspk_rate_table[i]);
+
+	}
+	return snd_interval_refine(r, &t);
 }
 
-static int firewave_channels_constraint(struct snd_pcm_hw_params *params,
+static int hw_rule_channels(struct snd_pcm_hw_params *params,
+			    struct snd_pcm_hw_rule *rule,
+			    struct fwspk *fwspk,
+			    struct fwspk_stream_formation *formations)
+{
+	struct snd_interval *c =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	const struct snd_interval *r =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval t = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+
+	unsigned int i;
+
+	for (i = 0; i < FWSPK_STREAM_TABLE_ENTRIES; i++) {
+		/* entry is invalid */
+		if (formations[i].pcm == 0)
+			continue;
+
+		if (!snd_interval_test(r, fwspk_rate_table[i]))
+			continue;
+
+		t.min = min(t.min, formations[i].pcm);
+		t.max = max(t.max, formations[i].pcm);
+	}
+
+	return snd_interval_refine(c, &t);
+}
+
+static inline int hw_rule_playback_rate(struct snd_pcm_hw_params *params,
 					struct snd_pcm_hw_rule *rule)
 {
-	static const struct snd_interval all_channels = { .min = 6, .max = 6 };
-	struct snd_interval *rate =
-			hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *channels =
-			hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-
-	/* 32/44.1 kHz work only with all six channels */
-	if (snd_interval_max(rate) < 48000)
-		return snd_interval_refine(channels, &all_channels);
-	return 0;
+	struct fwspk *fwspk = rule->private;
+	return hw_rule_rate(params, rule, fwspk,
+			    fwspk->rx_stream_formations);
 }
 
-int firewave_constraints(struct snd_pcm_runtime *runtime)
+static inline int hw_rule_playback_channels(struct snd_pcm_hw_params *params,
+					    struct snd_pcm_hw_rule *rule)
 {
-	static unsigned int channels_list[] = { 2, 6 };
-	static struct snd_pcm_hw_constraint_list channels_list_constraint = {
-		.count = 2,
-		.list = channels_list,
-	};
-	int err;
+	struct fwspk *fwspk = rule->private;
+	return hw_rule_channels(params, rule, fwspk,
+				fwspk->rx_stream_formations);
+}
 
-	runtime->hw.rates = SNDRV_PCM_RATE_32000 |
-			    SNDRV_PCM_RATE_44100 |
-			    SNDRV_PCM_RATE_48000 |
-			    SNDRV_PCM_RATE_96000;
-	runtime->hw.channels_max = 6;
+static void prepare_channels(struct snd_pcm_hardware *hw,
+			     struct fwspk_stream_formation *formations)
+{
+	unsigned int i;
 
-	err = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_CHANNELS,
-					 &channels_list_constraint);
-	if (err < 0)
-		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				  firewave_rate_constraint, NULL,
-				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
-	if (err < 0)
-		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-				  firewave_channels_constraint, NULL,
-				  SNDRV_PCM_HW_PARAM_RATE, -1);
-	if (err < 0)
-		return err;
+	for (i = 0; i < FWSPK_STREAM_TABLE_ENTRIES; i++) {
+		/* entry has no PCM channels */
+		if (formations[i].pcm == 0)
+			continue;
 
-	return 0;
+		hw->channels_min = min(hw->channels_min, formations[i].pcm);
+		hw->channels_max = max(hw->channels_max, formations[i].pcm);
+	}
+
+	return;
 }
 
-int lacie_speakers_constraints(struct snd_pcm_runtime *runtime)
+static void prepare_rates(struct snd_pcm_hardware *hw,
+			  struct fwspk_stream_formation *formations)
 {
-	runtime->hw.rates = SNDRV_PCM_RATE_32000 |
-			    SNDRV_PCM_RATE_44100 |
-			    SNDRV_PCM_RATE_48000 |
-			    SNDRV_PCM_RATE_88200 |
-			    SNDRV_PCM_RATE_96000;
+	unsigned int i;
 
-	return 0;
+	for (i = 0; i < FWSPK_STREAM_TABLE_ENTRIES; i++) {
+		/* entry has no PCM channels */
+		if (formations[i].pcm == 0)
+			continue;
+
+		hw->rate_min = min(hw->rate_min, fwspk_rate_table[i]);
+		hw->rate_max = max(hw->rate_max, fwspk_rate_table[i]);
+		hw->rates |= snd_pcm_rate_to_rate_bit(fwspk_rate_table[i]);
+	}
+
+	return;
 }
 
-static int fwspk_open(struct snd_pcm_substream *substream)
+int fwspk_open(struct snd_pcm_substream *substream)
 {
-	static const struct snd_pcm_hardware hardware = {
+	static const struct snd_pcm_hardware hw = {
 		.info = SNDRV_PCM_INFO_MMAP |
-			SNDRV_PCM_INFO_MMAP_VALID |
 			SNDRV_PCM_INFO_BATCH |
 			SNDRV_PCM_INFO_INTERLEAVED |
+			/* for Open Sound System compatibility */
+			SNDRV_PCM_INFO_MMAP_VALID |
 			SNDRV_PCM_INFO_BLOCK_TRANSFER,
-		.formats = AMDTP_OUT_PCM_FORMAT_BITS,
-		.channels_min = 2,
-		.channels_max = 2,
+		/* set up later */
+		.rates = 0,
+		.rate_min = UINT_MAX,
+		.rate_max = 0,
+		/* set up later */
+		.channels_min = UINT_MAX,
+		.channels_max = 0,
 		.buffer_bytes_max = 4 * 1024 * 1024,
 		.period_bytes_min = 1,
 		.period_bytes_max = UINT_MAX,
@@ -108,24 +148,37 @@ static int fwspk_open(struct snd_pcm_substream *substream)
 	if ((err < 0) || used)
 		goto end;
 
-	runtime->hw = hardware;
+	runtime->hw = hw;
 
-	err = fwspk->device_info->pcm_constraints(runtime);
-	if (err < 0)
-		goto end;
-	err = snd_pcm_limit_hw_rates(runtime);
-	if (err < 0)
-		goto end;
+	/* add rule between channels and sampling rate */
+	prepare_rates(&runtime->hw, fwspk->rx_stream_formations);
+	prepare_channels(&runtime->hw, fwspk->rx_stream_formations);
+	runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
+	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+			hw_rule_playback_channels, fwspk,
+			SNDRV_PCM_HW_PARAM_RATE, -1);
+	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+			hw_rule_playback_rate, fwspk,
+			SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 
-	err = snd_pcm_hw_constraint_minmax(runtime,
-					   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
-					   5000, UINT_MAX);
+	/* AM824 in IEC 61883-6 can deliver 24bit data */
+	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
 	if (err < 0)
 		goto end;
 
-	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	/*
+	 * AMDTP functionality in firewire-lib require periods to be aligned to
+	 * 16 bit, or 24bit inner 32bit.
+	 */
+	err = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
 	if (err < 0)
 		goto end;
+
+	/* time for period constraint */
+	err = snd_pcm_hw_constraint_minmax(runtime,
+					SNDRV_PCM_HW_PARAM_PERIOD_TIME,
+					5000, UINT_MAX);
 end:
 	return err;
 }
diff --git a/sound/firewire/speakers/speakers_stream.c b/sound/firewire/speakers/speakers_stream.c
index 9cc0ffb..17d83e4 100644
--- a/sound/firewire/speakers/speakers_stream.c
+++ b/sound/firewire/speakers/speakers_stream.c
@@ -7,6 +7,21 @@
 
 #include "speakers.h"
 
+/*
+ * According to their datasheet:
+ *  OXFW970: 32.0/44.1/48.0/96.0 Khz, 8 audio channels I/O
+ *  OXFW971: 32.0/44.1/48.0/88.2/96.0/192.0 kHz, 16 audio channels I/O, MIDI I/O
+ */
+const unsigned int fwspk_rate_table[FWSPK_STREAM_TABLE_ENTRIES] = {
+	[0] = 32000,
+	[1] = 44100,
+	[2] = 48000,
+	[3] = 88200,
+	[4] = 96000,
+	[5] = 176400,
+	[6] = 192000,
+};
+
 int snd_fwspk_stream_init(struct fwspk *fwspk)
 {
 	int err;
@@ -70,3 +85,24 @@ void snd_fwspk_stream_update(struct fwspk *fwspk)
 		amdtp_stream_update(&fwspk->rx_stream);
 	}
 }
+
+int firewave_stream_discover(struct fwspk *fwspk)
+{
+	fwspk->rx_stream_formations[2].pcm = 6;
+	fwspk->rx_stream_formations[3].pcm = 6;
+	fwspk->rx_stream_formations[4].pcm = 2;
+	fwspk->rx_stream_formations[6].pcm = 2;
+
+	return 0;
+}
+
+int lacie_speakers_stream_discover(struct fwspk *fwspk)
+{
+	fwspk->rx_stream_formations[2].pcm = 2;
+	fwspk->rx_stream_formations[3].pcm = 2;
+	fwspk->rx_stream_formations[4].pcm = 2;
+	fwspk->rx_stream_formations[5].pcm = 2;
+	fwspk->rx_stream_formations[6].pcm = 2;
+
+	return 0;
+}
-- 
1.8.3.2
