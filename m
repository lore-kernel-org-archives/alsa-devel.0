From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/15] oxfw: Change the way to make PCM rules/constraints
Date: Tue, 13 May 2014 23:27:44 +0900
Message-ID: <1399991272-5807-8-git-send-email-o-takashi@sakamocchi.jp>
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

For PCM rules/constrains, drivers need to know stream formation at each
supported sampling rates in advance. This commit adds
'struct snd_oxfw_stream_formation' to save formation information to create
PCM rules/constraints.

According to datasheet of OXFW970/971, they support 32.0kHz to 196.0kHz.
As long as developers investigate, some devices are confirmed to have several
entries for the same sampling rate.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c        |  41 ++++----
 sound/firewire/oxfw/oxfw.h        |  16 ++-
 sound/firewire/oxfw/oxfw_pcm.c    | 201 +++++++++++++++++++++++---------------
 sound/firewire/oxfw/oxfw_stream.c |  48 +++++++++
 4 files changed, 204 insertions(+), 102 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 28e38cf..cfdf420 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -25,6 +25,22 @@ MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("snd-firewire-speakers");
 
+static const struct device_info griffin_firewave = {
+	.vendor_name = "Griffin",
+	.driver_name = "FireWave",
+	.mixer_channels = 6,
+	.mute_fb_id   = 0x01,
+	.volume_fb_id = 0x02,
+};
+
+static const struct device_info lacie_speakers = {
+	.vendor_name = "LaCie",
+	.driver_name = "FWSpeakers",
+	.mixer_channels = 1,
+	.mute_fb_id   = 0x01,
+	.volume_fb_id = 0x01,
+};
+
 static int name_card(struct snd_oxfw *oxfw)
 {
 	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
@@ -81,6 +97,13 @@ static int oxfw_probe(struct fw_unit *unit,
 	oxfw->unit = unit;
 	oxfw->device_info = (const struct device_info *)id->driver_data;
 
+	if (oxfw->device_info == &griffin_firewave)
+		err = firewave_stream_discover(oxfw);
+	else
+		err = lacie_speakers_stream_discover(oxfw);
+	if (err < 0)
+		goto error;
+
 	err = name_card(oxfw);
 	if (err < 0)
 		goto error;
@@ -128,24 +151,6 @@ static void oxfw_remove(struct fw_unit *unit)
 	snd_card_free_when_closed(oxfw->card);
 }
 
-static const struct device_info griffin_firewave = {
-	.vendor_name = "Griffin",
-	.driver_name = "FireWave",
-	.pcm_constraints = firewave_constraints,
-	.mixer_channels = 6,
-	.mute_fb_id   = 0x01,
-	.volume_fb_id = 0x02,
-};
-
-static const struct device_info lacie_speakers = {
-	.vendor_name = "LaCie",
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
index b60e91d..000c2af 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -29,19 +29,29 @@
 struct device_info {
 	const char *vendor_name;
 	const char *driver_name;
-	int (*pcm_constraints)(struct snd_pcm_runtime *runtime);
 	unsigned int mixer_channels;
 	u8 mute_fb_id;
 	u8 volume_fb_id;
 };
 
+/* This is an arbitrary number for convinience. */
+#define	SND_OXFW_STREAM_FORMAT_ENTRIES	10
+struct snd_oxfw_stream_formation {
+	unsigned int rate;
+	unsigned int pcm;
+	unsigned int midi;
+};
 struct snd_oxfw {
 	struct snd_card *card;
 	struct fw_unit *unit;
 	const struct device_info *device_info;
 	struct mutex mutex;
+
+	struct snd_oxfw_stream_formation
+		rx_stream_formations[SND_OXFW_STREAM_FORMAT_ENTRIES];
 	struct cmp_connection in_conn;
 	struct amdtp_stream rx_stream;
+
 	bool mute;
 	s16 volume[6];
 	s16 volume_min;
@@ -54,8 +64,8 @@ void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw);
 
-int firewave_constraints(struct snd_pcm_runtime *runtime);
-int lacie_speakers_constraints(struct snd_pcm_runtime *runtime);
+int firewave_stream_discover(struct snd_oxfw *oxfw);
+int lacie_speakers_stream_discover(struct snd_oxfw *oxfw);
 int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_mixer(struct snd_oxfw *oxfw);
diff --git a/sound/firewire/oxfw/oxfw_pcm.c b/sound/firewire/oxfw/oxfw_pcm.c
index 1fd76ce..75c0520 100644
--- a/sound/firewire/oxfw/oxfw_pcm.c
+++ b/sound/firewire/oxfw/oxfw_pcm.c
@@ -7,117 +7,156 @@
 
 #include "oxfw.h"
 
-static int firewave_rate_constraint(struct snd_pcm_hw_params *params,
-				    struct snd_pcm_hw_rule *rule)
+static int hw_rule_rate(struct snd_pcm_hw_params *params,
+			struct snd_pcm_hw_rule *rule)
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
+	struct snd_oxfw_stream_formation *formations = rule->private;
+	struct snd_interval *r =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	const struct snd_interval *c =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval t = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int i;
+
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		if (formations[i].rate == 0)
+			continue;
+
+		if (!snd_interval_test(c, formations[i].pcm))
+			continue;
+
+		t.min = min(t.min, formations[i].rate);
+		t.max = max(t.max, formations[i].rate);
+
+	}
+	return snd_interval_refine(r, &t);
 }
 
-static int firewave_channels_constraint(struct snd_pcm_hw_params *params,
-					struct snd_pcm_hw_rule *rule)
+static int hw_rule_channels(struct snd_pcm_hw_params *params,
+			    struct snd_pcm_hw_rule *rule)
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
+	struct snd_oxfw_stream_formation *formations = rule->private;
+	struct snd_interval *c =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	const struct snd_interval *r =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
+	unsigned int i, j, count, list[SND_OXFW_STREAM_FORMAT_ENTRIES] = {0};
+
+	count = 0;
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		if (formations[i].rate == 0)
+			continue;
+
+		if (!snd_interval_test(r, formations[i].rate))
+			continue;
+		if (list[count] == formations[i].pcm)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(list); j++) {
+			if (list[j] == formations[i].pcm)
+				break;
+		}
+		if (j == ARRAY_SIZE(list)) {
+			list[count] = formations[i].pcm;
+			if (++count == ARRAY_SIZE(list))
+				break;
+		}
+	}
+
+	return snd_interval_list(c, count, list, 0);
 }
 
-int firewave_constraints(struct snd_pcm_runtime *runtime)
+static void limit_channels_and_rates(struct snd_pcm_hardware *hw,
+				struct snd_oxfw_stream_formation *formations)
 {
-	static unsigned int channels_list[] = { 2, 6 };
-	static struct snd_pcm_hw_constraint_list channels_list_constraint = {
-		.count = 2,
-		.list = channels_list,
-	};
-	int err;
+	unsigned int i;
 
-	runtime->hw.rates = SNDRV_PCM_RATE_32000 |
-			    SNDRV_PCM_RATE_44100 |
-			    SNDRV_PCM_RATE_48000 |
-			    SNDRV_PCM_RATE_96000;
-	runtime->hw.channels_max = 6;
+	hw->channels_min = UINT_MAX;
+	hw->channels_max = 0;
 
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
+	hw->rate_min = UINT_MAX;
+	hw->rate_max = 0;
+	hw->rates = 0;
 
-	return 0;
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		if (formations[i].rate == 0)
+			continue;
+
+		hw->channels_min = min(hw->channels_min, formations[i].pcm);
+		hw->channels_max = max(hw->channels_max, formations[i].pcm);
+
+		hw->rate_min = min(hw->rate_min, formations[i].rate);
+		hw->rate_max = max(hw->rate_max, formations[i].rate);
+		hw->rates |= snd_pcm_rate_to_rate_bit(formations[i].rate);
+	}
 }
 
-int lacie_speakers_constraints(struct snd_pcm_runtime *runtime)
+static void limit_period_and_buffer(struct snd_pcm_hardware *hw)
 {
-	runtime->hw.rates = SNDRV_PCM_RATE_32000 |
-			    SNDRV_PCM_RATE_44100 |
-			    SNDRV_PCM_RATE_48000 |
-			    SNDRV_PCM_RATE_88200 |
-			    SNDRV_PCM_RATE_96000;
+	hw->periods_min = 2;		/* SNDRV_PCM_INFO_BATCH */
+	hw->periods_max = UINT_MAX;
 
-	return 0;
+	hw->period_bytes_min = 4 * hw->channels_max;	/* bytes for a frame */
+
+	/* Just to prevent from allocating much pages. */
+	hw->period_bytes_max = hw->period_bytes_min * 2048;
+	hw->buffer_bytes_max = hw->period_bytes_max * hw->periods_min;
 }
 
 static int pcm_open(struct snd_pcm_substream *substream)
 {
-	static const struct snd_pcm_hardware hardware = {
-		.info = SNDRV_PCM_INFO_MMAP |
-			SNDRV_PCM_INFO_MMAP_VALID |
-			SNDRV_PCM_INFO_BATCH |
-			SNDRV_PCM_INFO_INTERLEAVED |
-			SNDRV_PCM_INFO_BLOCK_TRANSFER,
-		.formats = AMDTP_OUT_PCM_FORMAT_BITS,
-		.channels_min = 2,
-		.channels_max = 2,
-		.buffer_bytes_max = 4 * 1024 * 1024,
-		.period_bytes_min = 1,
-		.period_bytes_max = UINT_MAX,
-		.periods_min = 1,
-		.periods_max = UINT_MAX,
-	};
 	struct snd_oxfw *oxfw = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	bool used;
+	struct snd_oxfw_stream_formation *formations;
+	unsigned int rate;
 	int err;
 
-	err = cmp_connection_check_used(&oxfw->in_conn, &used);
-	if ((err < 0) || used)
-		goto end;
+	formations = oxfw->rx_stream_formations;
+
+	runtime->hw.info = SNDRV_PCM_INFO_BATCH |
+			   SNDRV_PCM_INFO_BLOCK_TRANSFER |
+			   SNDRV_PCM_INFO_INTERLEAVED |
+			   SNDRV_PCM_INFO_MMAP |
+			   SNDRV_PCM_INFO_MMAP_VALID;
 
-	runtime->hw = hardware;
+	limit_channels_and_rates(&runtime->hw, formations);
+	limit_period_and_buffer(&runtime->hw);
 
-	err = oxfw->device_info->pcm_constraints(runtime);
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  hw_rule_channels, formations,
+				  SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		goto end;
-	err = snd_pcm_limit_hw_rates(runtime);
+
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  hw_rule_rate, formations,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	if (err < 0)
 		goto end;
 
 	err = amdtp_stream_add_pcm_hw_constraints(&oxfw->rx_stream, runtime);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * When any PCM streams are already running, the available sampling
+	 * rate is limited at current value.
+	 */
+	if (amdtp_stream_pcm_running(&oxfw->rx_stream)) {
+		err = avc_general_get_sig_fmt(oxfw->unit, &rate,
+					      AVC_GENERAL_PLUG_DIR_IN, 0);
+		if (err < 0) {
+			dev_err(&oxfw->unit->device,
+				"fail to get sampling rate: %d\n", err);
+			goto end;
+		}
+		runtime->hw.rate_min = rate;
+		runtime->hw.rate_max = rate;
+	}
+
+	snd_pcm_set_sync(substream);
 end:
 	return err;
 }
diff --git a/sound/firewire/oxfw/oxfw_stream.c b/sound/firewire/oxfw/oxfw_stream.c
index 59861b2..954584e 100644
--- a/sound/firewire/oxfw/oxfw_stream.c
+++ b/sound/firewire/oxfw/oxfw_stream.c
@@ -8,6 +8,20 @@
 
 #include "oxfw.h"
 
+/*
+ * According to their datasheet:
+ *  OXFW970: 32.0/44.1/48.0/96.0 Khz, 8 audio channels I/O
+ *  OXFW971: 32.0/44.1/48.0/88.2/96.0/192.0 kHz, 16 audio channels I/O, MIDI I/O
+ */
+static const unsigned int oxfw_rate_table[] = {
+	[0] = 32000,
+	[1] = 44100,
+	[2] = 48000,
+	[3] = 88200,
+	[4] = 96000,
+	[5] = 192000,
+};
+
 int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw)
 {
 	int err;
@@ -90,3 +104,37 @@ void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw)
 		amdtp_stream_update(&oxfw->rx_stream);
 	}
 }
+
+int firewave_stream_discover(struct snd_oxfw *oxfw)
+{
+	/* 6 channels for PCM at 32.0/44.1/48.0/96.0kHz */
+	oxfw->rx_stream_formations[0].rate = oxfw_rate_table[0];
+	oxfw->rx_stream_formations[1].rate = oxfw_rate_table[1];
+	oxfw->rx_stream_formations[2].rate = oxfw_rate_table[2];
+	oxfw->rx_stream_formations[3].rate = oxfw_rate_table[4];
+	oxfw->rx_stream_formations[0].pcm = 6;
+	oxfw->rx_stream_formations[1].pcm = 6;
+	oxfw->rx_stream_formations[2].pcm = 6;
+	oxfw->rx_stream_formations[3].pcm = 6;
+
+	/* 2 channels for PCM at 48.0/96.0kHz */
+	oxfw->rx_stream_formations[4].rate = oxfw_rate_table[2];
+	oxfw->rx_stream_formations[5].rate = oxfw_rate_table[4];
+	oxfw->rx_stream_formations[4].pcm = 2;
+	oxfw->rx_stream_formations[5].pcm = 2;
+
+	return 0;
+}
+
+int lacie_speakers_stream_discover(struct snd_oxfw *oxfw)
+{
+	unsigned int i;
+
+	/* 2 channels for MBLA at 32.0/44.1/48.0/88.2/96.0kHz */
+	for (i = 0; i < 5; i++) {
+		oxfw->rx_stream_formations[i].rate = oxfw_rate_table[i];
+		oxfw->rx_stream_formations[i].pcm = 2;
+	}
+
+	return 0;
+}
-- 
1.8.3.2


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
