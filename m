From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 44/52] oxfw: Change the way to make PCM rules/constraints
Date: Wed, 29 Jan 2014 22:44:51 +0900
Message-ID: <1391003099-7109-45-git-send-email-o-takashi@sakamocchi.jp>
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

For PCM rules/constrains, drivers need to know stream formation at each
supported sampling rates in advance. This commit adds
'struct snd_oxfw_stream_formation' to save formation information.

According to datasheet of OXFW970/971, they support 32.0kHz to 196.0kHz.
So this commit adds 'rx_stream_formations' member to 'struct snd_oxfw'. It's
an array with 7 elements. Each element corresponds to each sampling rate.

With these data structure, this commit changes the way to make PCM
rules/constraints.

I don't know whether Griffin/LaCie devices supports SINGLE/LIST subfunction
'AV/C Stream Format Information' command. So this commit adds codes to
generate formations for them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c        |  37 ++++---
 sound/firewire/oxfw/oxfw.h        |  17 ++-
 sound/firewire/oxfw/oxfw_pcm.c    | 214 +++++++++++++++++++++++++-------------
 sound/firewire/oxfw/oxfw_stream.c |  36 +++++++
 4 files changed, 209 insertions(+), 95 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 6d64364..fda1ada 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -25,6 +25,20 @@ MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("snd-firewire-speakers");
 
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
 static int name_card(struct snd_oxfw *oxfw)
 {
 	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
@@ -90,6 +104,13 @@ static int oxfw_probe(struct fw_unit *unit,
 	oxfw->device_info = (const struct device_info *)id->driver_data;
 	mutex_init(&oxfw->mutex);
 
+	if (oxfw->device_info == &griffin_firewave)
+		err = firewave_stream_discover(oxfw);
+	else
+		err = lacie_speakers_stream_discover(oxfw);
+	if (err < 0)
+		goto err_card;
+
 	err = name_card(oxfw);
 	if (err < 0)
 		goto err_card;
@@ -138,22 +159,6 @@ static void oxfw_remove(struct fw_unit *unit)
 	snd_card_free_when_closed(oxfw->card);
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
 static const struct ieee1394_device_id oxfw_id_table[] = {
 	{
 		.match_flags  = IEEE1394_MATCH_VENDOR_ID |
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 0a97592..c3a7e22 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -28,19 +28,28 @@
 
 struct device_info {
 	const char *driver_name;
-	int (*pcm_constraints)(struct snd_pcm_runtime *runtime);
 	unsigned int mixer_channels;
 	u8 mute_fb_id;
 	u8 volume_fb_id;
 };
 
+#define	SND_OXFW_STREAM_TABLE_ENTRIES	7
+struct snd_oxfw_stream_formation {
+	unsigned int pcm;
+	unsigned int midi;
+};
+extern const unsigned int snd_oxfw_rate_table[SND_OXFW_STREAM_TABLE_ENTRIES];
 struct snd_oxfw {
 	struct snd_card *card;
 	struct fw_unit *unit;
 	const struct device_info *device_info;
 	struct mutex mutex;
+
+	struct snd_oxfw_stream_formation
+		rx_stream_formations[SND_OXFW_STREAM_TABLE_ENTRIES];
 	struct cmp_connection in_conn;
 	struct amdtp_stream rx_stream;
+
 	bool mute;
 	s16 volume[6];
 	s16 volume_min;
@@ -53,9 +62,9 @@ void snd_oxfw_stream_stop(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_destroy(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_update(struct snd_oxfw *oxfw);
 
-int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
+int firewave_stream_discover(struct snd_oxfw *oxfw);
+int lacie_speakers_stream_discover(struct snd_oxfw *oxfw);
 
-int firewave_constraints(struct snd_pcm_runtime *runtime);
-int lacie_speakers_constraints(struct snd_pcm_runtime *runtime);
+int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_mixer(struct snd_oxfw *oxfw);
diff --git a/sound/firewire/oxfw/oxfw_pcm.c b/sound/firewire/oxfw/oxfw_pcm.c
index c742ce0..d217a9d 100644
--- a/sound/firewire/oxfw/oxfw_pcm.c
+++ b/sound/firewire/oxfw/oxfw_pcm.c
@@ -7,92 +7,132 @@
 
 #include "oxfw.h"
 
-static int firewave_rate_constraint(struct snd_pcm_hw_params *params,
-				    struct snd_pcm_hw_rule *rule)
+static int hw_rule_rate(struct snd_pcm_hw_params *params,
+			struct snd_pcm_hw_rule *rule,
+			struct snd_oxfw *oxfw,
+			struct snd_oxfw_stream_formation *formations)
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
+	for (i = 0; i < SND_OXFW_STREAM_TABLE_ENTRIES; i++) {
+		/* entry is invalid */
+		if (formations[i].pcm == 0)
+			continue;
+
+		if (!snd_interval_test(c, formations[i].pcm))
+			continue;
+
+		t.min = min(t.min, snd_oxfw_rate_table[i]);
+		t.max = max(t.max, snd_oxfw_rate_table[i]);
+
+	}
+	return snd_interval_refine(r, &t);
+}
+
+static int hw_rule_channels(struct snd_pcm_hw_params *params,
+			    struct snd_pcm_hw_rule *rule,
+			    struct snd_oxfw *oxfw,
+			    struct snd_oxfw_stream_formation *formations)
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
+	for (i = 0; i < SND_OXFW_STREAM_TABLE_ENTRIES; i++) {
+		/* entry is invalid */
+		if (formations[i].pcm == 0)
+			continue;
+
+		if (!snd_interval_test(r, snd_oxfw_rate_table[i]))
+			continue;
+
+		t.min = min(t.min, formations[i].pcm);
+		t.max = max(t.max, formations[i].pcm);
+	}
+
+	return snd_interval_refine(c, &t);
 }
 
-static int firewave_channels_constraint(struct snd_pcm_hw_params *params,
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
+	struct snd_oxfw *oxfw = rule->private;
+	return hw_rule_rate(params, rule, oxfw,
+			    oxfw->rx_stream_formations);
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
+	struct snd_oxfw *oxfw = rule->private;
+	return hw_rule_channels(params, rule, oxfw,
+				oxfw->rx_stream_formations);
+}
 
-	runtime->hw.rates = SNDRV_PCM_RATE_32000 |
-			    SNDRV_PCM_RATE_44100 |
-			    SNDRV_PCM_RATE_48000 |
-			    SNDRV_PCM_RATE_96000;
-	runtime->hw.channels_max = 6;
+static void prepare_channels(struct snd_pcm_hardware *hw,
+			     struct snd_oxfw_stream_formation *formations)
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
+	for (i = 0; i < SND_OXFW_STREAM_TABLE_ENTRIES; i++) {
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
+			  struct snd_oxfw_stream_formation *formations)
 {
-	runtime->hw.rates = SNDRV_PCM_RATE_32000 |
-			    SNDRV_PCM_RATE_44100 |
-			    SNDRV_PCM_RATE_48000 |
-			    SNDRV_PCM_RATE_88200 |
-			    SNDRV_PCM_RATE_96000;
+	unsigned int i;
 
-	return 0;
+	for (i = 0; i < SND_OXFW_STREAM_TABLE_ENTRIES; i++) {
+		/* entry has no PCM channels */
+		if (formations[i].pcm == 0)
+			continue;
+
+		hw->rate_min = min(hw->rate_min, snd_oxfw_rate_table[i]);
+		hw->rate_max = max(hw->rate_max, snd_oxfw_rate_table[i]);
+		hw->rates |= snd_pcm_rate_to_rate_bit(snd_oxfw_rate_table[i]);
+	}
+
+	return;
 }
 
 static int oxfw_open(struct snd_pcm_substream *substream)
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
@@ -101,31 +141,55 @@ static int oxfw_open(struct snd_pcm_substream *substream)
 	};
 	struct snd_oxfw *oxfw = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	bool used;
+	unsigned int rate;
 	int err;
 
-	err = cmp_connection_check_used(&oxfw->in_conn, &used);
-	if ((err < 0) || used)
-		goto end;
+	runtime->hw = hw;
 
-	runtime->hw = hardware;
+	/* add rule between channels and sampling rate */
+	prepare_rates(&runtime->hw, oxfw->rx_stream_formations);
+	prepare_channels(&runtime->hw, oxfw->rx_stream_formations);
+	runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
+	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+			    hw_rule_playback_channels, oxfw,
+			    SNDRV_PCM_HW_PARAM_RATE, -1);
+	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+			    hw_rule_playback_rate, oxfw,
+			    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 
-	err = oxfw->device_info->pcm_constraints(runtime);
+	/* AM824 in IEC 61883-6 can deliver 24bit data */
+	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
 	if (err < 0)
 		goto end;
-	err = snd_pcm_limit_hw_rates(runtime);
+
+	/*
+	 * AMDTP functionality in firewire-lib require periods to be aligned to
+	 * 16 bit, or 24bit inner 32bit.
+	 */
+	err = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
 	if (err < 0)
 		goto end;
 
+	/* time for period constraint */
 	err = snd_pcm_hw_constraint_minmax(runtime,
 					   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
 					   5000, UINT_MAX);
-	if (err < 0)
-		goto end;
 
-	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
-	if (err < 0)
-		goto end;
+	/*
+	 * When any PCM streams are already running, the available sampling
+	 * rate is limited at current value.
+	 */
+	if (amdtp_stream_pcm_running(&oxfw->rx_stream)) {
+		err = avc_general_get_sig_fmt(oxfw->unit, &rate,
+					      AVC_GENERAL_PLUG_DIR_IN, 0);
+		if (err < 0)
+			goto end;
+		substream->runtime->hw.rate_min = rate;
+		substream->runtime->hw.rate_max = rate;
+	}
+
+	snd_pcm_set_sync(substream);
 end:
 	return err;
 }
diff --git a/sound/firewire/oxfw/oxfw_stream.c b/sound/firewire/oxfw/oxfw_stream.c
index 199a0ef..f1d6ce5 100644
--- a/sound/firewire/oxfw/oxfw_stream.c
+++ b/sound/firewire/oxfw/oxfw_stream.c
@@ -7,6 +7,21 @@
 
 #include "oxfw.h"
 
+/*
+ * According to their datasheet:
+ *  OXFW970: 32.0/44.1/48.0/96.0 Khz, 8 audio channels I/O
+ *  OXFW971: 32.0/44.1/48.0/88.2/96.0/192.0 kHz, 16 audio channels I/O, MIDI I/O
+ */
+const unsigned int snd_oxfw_rate_table[SND_OXFW_STREAM_TABLE_ENTRIES] = {
+	[0] = 32000,
+	[1] = 44100,
+	[2] = 48000,
+	[3] = 88200,
+	[4] = 96000,
+	[5] = 176400,
+	[6] = 192000,
+};
+
 int snd_oxfw_stream_init(struct snd_oxfw *oxfw)
 {
 	int err;
@@ -72,3 +87,24 @@ void snd_oxfw_stream_update(struct snd_oxfw *oxfw)
 		amdtp_stream_update(&oxfw->rx_stream);
 	}
 }
+
+int firewave_stream_discover(struct snd_oxfw *oxfw)
+{
+	oxfw->rx_stream_formations[0].pcm = 6;
+	oxfw->rx_stream_formations[1].pcm = 6;
+	oxfw->rx_stream_formations[2].pcm = 2;
+	oxfw->rx_stream_formations[4].pcm = 2;
+
+	return 0;
+}
+
+int lacie_speakers_stream_discover(struct snd_oxfw *oxfw)
+{
+	oxfw->rx_stream_formations[0].pcm = 2;
+	oxfw->rx_stream_formations[1].pcm = 2;
+	oxfw->rx_stream_formations[2].pcm = 2;
+	oxfw->rx_stream_formations[3].pcm = 2;
+	oxfw->rx_stream_formations[4].pcm = 2;
+
+	return 0;
+}
-- 
1.8.3.2


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
