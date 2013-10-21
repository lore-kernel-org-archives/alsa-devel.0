From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [23/29] ALSA: dice: dynamic sample rate selection
Date: Mon, 21 Oct 2013 21:34:00 +0200
Message-ID: <526581A8.7090708@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Instead of relying of some control panel application to configure some
fixed sample rate, allow applications to set it automatically.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |  137 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 102 insertions(+), 35 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index e6bba6d..61dd00c 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -70,6 +70,17 @@ static const unsigned int dice_rates[] = {
 	[6] = 192000,
 };

+static unsigned int rate_to_index(unsigned int rate)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(dice_rates); ++i)
+		if (dice_rates[i] == rate)
+			return i;
+
+	return 0;
+}
+
 static unsigned int rate_index_to_mode(unsigned int rate_index)
 {
 	return ((int)rate_index - 1) / 2;
@@ -302,6 +313,59 @@ static void dice_notification(struct fw_card *card, struct fw_request *request,
 	wake_up(&dice->hwdep_wait);
 }

+static int dice_rate_constraint(struct snd_pcm_hw_params *params,
+				struct snd_pcm_hw_rule *rule)
+{
+	struct dice *dice = rule->private;
+	const struct snd_interval *channels =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval *rate =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval allowed_rates = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int i, mode;
+
+	for (i = 0; i < ARRAY_SIZE(dice_rates); ++i) {
+		mode = rate_index_to_mode(i);
+		if ((dice->clock_caps & (1 << i)) &&
+		    snd_interval_test(channels, dice->rx_channels[mode])) {
+			allowed_rates.min = min(allowed_rates.min,
+						dice_rates[i]);
+			allowed_rates.max = max(allowed_rates.max,
+						dice_rates[i]);
+		}
+	}
+
+	return snd_interval_refine(rate, &allowed_rates);
+}
+
+static int dice_channels_constraint(struct snd_pcm_hw_params *params,
+				    struct snd_pcm_hw_rule *rule)
+{
+	struct dice *dice = rule->private;
+	const struct snd_interval *rate =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval allowed_channels = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int i, mode;
+
+	for (i = 0; i < ARRAY_SIZE(dice_rates); ++i)
+		if ((dice->clock_caps & (1 << i)) &&
+		    snd_interval_test(rate, dice_rates[i])) {
+			mode = rate_index_to_mode(i);
+			allowed_channels.min = min(allowed_channels.min,
+						   dice->rx_channels[mode]);
+			allowed_channels.max = max(allowed_channels.max,
+						   dice->rx_channels[mode]);
+		}
+
+	return snd_interval_refine(channels, &allowed_channels);
+}
+
 static int dice_open(struct snd_pcm_substream *substream)
 {
 	static const struct snd_pcm_hardware hardware = {
@@ -311,6 +375,8 @@ static int dice_open(struct snd_pcm_substream *substream)
 			SNDRV_PCM_INFO_INTERLEAVED |
 			SNDRV_PCM_INFO_BLOCK_TRANSFER,
 		.formats = AMDTP_OUT_PCM_FORMAT_BITS,
+		.channels_min = UINT_MAX,
+		.channels_max = 0,
 		.buffer_bytes_max = 16 * 1024 * 1024,
 		.period_bytes_min = 1,
 		.period_bytes_max = UINT_MAX,
@@ -319,53 +385,46 @@ static int dice_open(struct snd_pcm_substream *substream)
 	};
 	struct dice *dice = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	__be32 clock_sel, data[2];
-	unsigned int rate_index, number_audio, number_midi;
+	unsigned int i;
 	int err;

 	err = dice_try_lock(dice);
 	if (err < 0)
 		goto error;

-	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
-				 global_address(dice, GLOBAL_CLOCK_SELECT),
-				 &clock_sel, 4, 0);
-	if (err < 0)
-		goto err_lock;
-	rate_index = (be32_to_cpu(clock_sel) & CLOCK_RATE_MASK)
-							>> CLOCK_RATE_SHIFT;
-	if (rate_index >= ARRAY_SIZE(dice_rates)) {
-		err = -ENXIO;
-		goto err_lock;
-	}
-
-	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
-				 rx_address(dice, RX_NUMBER_AUDIO),
-				 data, 2 * 4, 0);
-	if (err < 0)
-		goto err_lock;
-	number_audio = be32_to_cpu(data[0]);
-	number_midi = be32_to_cpu(data[1]);
-
 	runtime->hw = hardware;

-	runtime->hw.rates = snd_pcm_rate_to_rate_bit(dice_rates[rate_index]);
+	for (i = 0; i < ARRAY_SIZE(dice_rates); ++i)
+		if (dice->clock_caps & (1 << i))
+			runtime->hw.rates |=
+				snd_pcm_rate_to_rate_bit(dice_rates[i]);
 	snd_pcm_limit_hw_rates(runtime);

-	runtime->hw.channels_min = number_audio;
-	runtime->hw.channels_max = number_audio;
+	for (i = 0; i < 3; ++i)
+		if (dice->rx_channels[i]) {
+			runtime->hw.channels_min = min(runtime->hw.channels_min,
+						       dice->rx_channels[i]);
+			runtime->hw.channels_max = max(runtime->hw.channels_max,
+						       dice->rx_channels[i]);
+		}

-	amdtp_out_stream_set_parameters(&dice->stream, dice_rates[rate_index],
-					number_audio, number_midi);
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  dice_rate_constraint, dice,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (err < 0)
+		goto err_lock;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  dice_channels_constraint, dice,
+				  SNDRV_PCM_HW_PARAM_RATE, -1);
+	if (err < 0)
+		goto err_lock;

 	err = snd_pcm_hw_constraint_step(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-					 amdtp_syt_intervals[rate_index]);
+					 SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 32);
 	if (err < 0)
 		goto err_lock;
 	err = snd_pcm_hw_constraint_step(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
-					 amdtp_syt_intervals[rate_index]);
+					 SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 32);
 	if (err < 0)
 		goto err_lock;

@@ -502,6 +561,7 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *hw_params)
 {
 	struct dice *dice = substream->private_data;
+	unsigned int rate_index, mode;
 	int err;

 	mutex_lock(&dice->mutex);
@@ -511,15 +571,22 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
 					       params_buffer_bytes(hw_params));
 	if (err < 0)
-		goto error;
+		return err;

+	rate_index = rate_to_index(params_rate(hw_params));
+	err = dice_change_rate(dice, rate_index << CLOCK_RATE_SHIFT);
+	if (err < 0)
+		return err;
+
+	mode = rate_index_to_mode(rate_index);
+	amdtp_out_stream_set_parameters(&dice->stream,
+					params_rate(hw_params),
+					params_channels(hw_params),
+					dice->rx_midi_ports[mode]);
 	amdtp_out_stream_set_pcm_format(&dice->stream,
 					params_format(hw_params));

 	return 0;
-
-error:
-	return err;
 }

 static int dice_hw_free(struct snd_pcm_substream *substream)

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
