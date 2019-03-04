From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [RFC PATCH 1/4] alsa: make hw_params negotiation
	infrastructure 'bclk_ratio aware'
Date: Mon,  4 Mar 2019 11:59:52 -0500
Message-ID: <20190304165955.21696-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B49CF896F1
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2019 18:00:04 +0100 (CET)
Received: by mail-it1-x142.google.com with SMTP id z124so8573022itc.2
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2019 09:00:04 -0800 (PST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org

Negotiation seems to work ok, but bclk_ratio is exposed to
userspace via snd_pcm_hw_params, which is not acceptable.

Constrain bclk_ratio by:
- cpu   dai capabilities && rules
- codec dai capabilities && rules
- minimum bclk_ratio is sample_width * channels

In hw_params_choose(), pick the smallest supported bclk_ratio,
which should correspond to the most efficient solution.

If cpu and codec dais do not specify or constrain supported
bclk_ratios, alsa will pick sample_width * channels.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 include/sound/pcm.h         | 11 +++++++++++
 include/sound/soc.h         |  2 ++
 include/uapi/sound/asound.h |  5 +++--
 sound/core/pcm_native.c     | 34 +++++++++++++++++++++++++++++++++-
 sound/soc/soc-pcm.c         |  8 ++++++++
 5 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index d6bd3caf6878..71ac7e8de23d 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -56,6 +56,8 @@ struct snd_pcm_hardware {
 	unsigned int periods_min;	/* min # of periods */
 	unsigned int periods_max;	/* max # of periods */
 	size_t fifo_size;		/* fifo size in bytes */
+	unsigned int bclk_ratio_min;	/* min bclk ratio for wire format */
+	unsigned int bclk_ratio_max;	/* max bclk ratio for wire format */
 };
 
 struct snd_pcm_substream;
@@ -980,6 +982,15 @@ static inline unsigned int params_buffer_bytes(const struct snd_pcm_hw_params *p
 	return hw_param_interval_c(p, SNDRV_PCM_HW_PARAM_BUFFER_BYTES)->min;
 }
 
+/**
+ * params_bclk_ratio - Get the bclk_ratio from the hw params
+ * @p: hw params
+ */
+static inline unsigned int params_bclk_ratio(const struct snd_pcm_hw_params *p)
+{
+	return hw_param_interval_c(p, SNDRV_PCM_HW_PARAM_BCLK_RATIO)->min;
+}
+
 int snd_interval_refine(struct snd_interval *i, const struct snd_interval *v);
 int snd_interval_list(struct snd_interval *i, unsigned int count,
 		      const unsigned int *list, unsigned int mask);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index e665f111b0d2..96d669423688 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -732,6 +732,8 @@ struct snd_soc_pcm_stream {
 	unsigned int channels_min;	/* min channels */
 	unsigned int channels_max;	/* max channels */
 	unsigned int sig_bits;		/* number of bits of content */
+	unsigned int bclk_ratio_min;	/* min bclk ratio for wire format */
+	unsigned int bclk_ratio_max;	/* max bclk ratio for wire format */
 };
 
 /* SoC audio ops */
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 404d4b9ffe76..c3ea94eaaa77 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -371,8 +371,9 @@ typedef int snd_pcm_hw_param_t;
 #define	SNDRV_PCM_HW_PARAM_BUFFER_SIZE	17	/* Size of buffer in frames */
 #define	SNDRV_PCM_HW_PARAM_BUFFER_BYTES	18	/* Size of buffer in bytes */
 #define	SNDRV_PCM_HW_PARAM_TICK_TIME	19	/* Approx tick duration in us */
+#define SNDRV_PCM_HW_PARAM_BCLK_RATIO	20	/* bclk_ratio for wire format */
 #define	SNDRV_PCM_HW_PARAM_FIRST_INTERVAL	SNDRV_PCM_HW_PARAM_SAMPLE_BITS
-#define	SNDRV_PCM_HW_PARAM_LAST_INTERVAL	SNDRV_PCM_HW_PARAM_TICK_TIME
+#define	SNDRV_PCM_HW_PARAM_LAST_INTERVAL	SNDRV_PCM_HW_PARAM_BCLK_RATIO
 
 #define SNDRV_PCM_HW_PARAMS_NORESAMPLE	(1<<0)	/* avoid rate resampling */
 #define SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER	(1<<1)	/* export buffer */
@@ -399,7 +400,7 @@ struct snd_pcm_hw_params {
 	struct snd_mask mres[5];	/* reserved masks */
 	struct snd_interval intervals[SNDRV_PCM_HW_PARAM_LAST_INTERVAL -
 				        SNDRV_PCM_HW_PARAM_FIRST_INTERVAL + 1];
-	struct snd_interval ires[9];	/* reserved intervals */
+	struct snd_interval ires[8];	/* reserved intervals */
 	unsigned int rmask;		/* W: requested masks */
 	unsigned int cmask;		/* R: changed masks */
 	unsigned int info;		/* R: Info flags for returned setup */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 818dff1de545..23dbe43a6691 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -516,6 +516,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 		      struct snd_pcm_hw_params *params)
 {
 	int err;
+	struct snd_interval *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_BCLK_RATIO);
 
 	params->info = 0;
 	params->fifo_size = 0;
@@ -525,6 +526,12 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 		params->rate_num = 0;
 		params->rate_den = 0;
 	}
+	/*
+	 * if left zero (not empty), assume userspace is oblivious, and
+	 * completely flexible
+	 */
+	if (snd_interval_single(r) && snd_interval_min(r) == 0)
+		snd_interval_any(r);
 
 	err = constrain_mask_params(substream, params);
 	if (err < 0)
@@ -610,7 +617,8 @@ static inline void snd_pcm_timer_notify(struct snd_pcm_substream *substream,
  * Choose one configuration from configuration space defined by @params.
  * The configuration chosen is that obtained fixing in this order:
  * first access, first format, first subformat, min channels,
- * min rate, min period time, max buffer size, min tick time
+ * min rate, min period time, max buffer size, min tick time,
+ * min bclk_ratio
  *
  * Return: Zero if successful, or a negative error code on failure.
  */
@@ -626,6 +634,7 @@ static int snd_pcm_hw_params_choose(struct snd_pcm_substream *pcm,
 		SNDRV_PCM_HW_PARAM_PERIOD_TIME,
 		SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
 		SNDRV_PCM_HW_PARAM_TICK_TIME,
+		SNDRV_PCM_HW_PARAM_BCLK_RATIO,
 		-1
 	};
 	const int *v;
@@ -2100,6 +2109,18 @@ static int snd_pcm_hw_rule_format(struct snd_pcm_hw_params *params,
 	return snd_mask_refine(mask, &m);
 }
 
+static int snd_pcm_hw_rule_bclk_ratio(struct snd_pcm_hw_params *params,
+				  struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval i;
+	struct snd_interval *ratios = hw_param_interval(params, SNDRV_PCM_HW_PARAM_BCLK_RATIO);
+	snd_interval_any(&i);
+	i.openmax = 1;
+	i.min = params_channels(params) * params_width(params);
+	i.integer = 1;
+	return snd_interval_refine(ratios, &i);
+}
+
 static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
 				       struct snd_pcm_hw_rule *rule)
 {
@@ -2180,12 +2201,18 @@ int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 	snd_interval_setinteger(constrs_interval(constrs, SNDRV_PCM_HW_PARAM_BUFFER_BYTES));
 	snd_interval_setinteger(constrs_interval(constrs, SNDRV_PCM_HW_PARAM_SAMPLE_BITS));
 	snd_interval_setinteger(constrs_interval(constrs, SNDRV_PCM_HW_PARAM_FRAME_BITS));
+	snd_interval_setinteger(constrs_interval(constrs, SNDRV_PCM_HW_PARAM_BCLK_RATIO));
 
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FORMAT,
 				   snd_pcm_hw_rule_format, NULL,
 				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
 	if (err < 0)
 		return err;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BCLK_RATIO,
+				   snd_pcm_hw_rule_bclk_ratio, NULL,
+				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS, SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (err < 0)
+		return err;
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS, 
 				  snd_pcm_hw_rule_sample_bits, NULL,
 				  SNDRV_PCM_HW_PARAM_FORMAT, 
@@ -2341,6 +2368,11 @@ int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 	if (err < 0)
 		return err;
 
+	err = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BCLK_RATIO,
+					   hw->bclk_ratio_min, hw->bclk_ratio_max);
+	if (err < 0)
+		return err;
+
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 
 				  snd_pcm_hw_rule_buffer_bytes_max, substream,
 				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES, -1);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 03f36e534050..747026595634 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -381,6 +381,7 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_stream *cpu_stream;
 	unsigned int chan_min = 0, chan_max = UINT_MAX;
 	unsigned int rate_min = 0, rate_max = UINT_MAX;
+	unsigned int bclk_ratio_min = 0, bclk_ratio_max = UINT_MAX;
 	unsigned int rates = UINT_MAX;
 	u64 formats = ULLONG_MAX;
 	int i;
@@ -413,6 +414,8 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 			codec_stream = &codec_dai_drv->capture;
 		chan_min = max(chan_min, codec_stream->channels_min);
 		chan_max = min(chan_max, codec_stream->channels_max);
+		bclk_ratio_min = max(bclk_ratio_min, codec_stream->bclk_ratio_min);
+		bclk_ratio_max = min_not_zero(bclk_ratio_max, codec_stream->bclk_ratio_max);
 		rate_min = max(rate_min, codec_stream->rate_min);
 		rate_max = min_not_zero(rate_max, codec_stream->rate_max);
 		formats &= codec_stream->formats;
@@ -443,6 +446,11 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 	hw->rate_min = max(hw->rate_min, rate_min);
 	hw->rate_max = min_not_zero(hw->rate_max, cpu_stream->rate_max);
 	hw->rate_max = min_not_zero(hw->rate_max, rate_max);
+
+	hw->bclk_ratio_min = max(hw->bclk_ratio_min, cpu_stream->bclk_ratio_min);
+	hw->bclk_ratio_min = max(hw->bclk_ratio_min, bclk_ratio_min);
+	hw->bclk_ratio_max = min_not_zero(hw->bclk_ratio_max, cpu_stream->bclk_ratio_max);
+	hw->bclk_ratio_max = min_not_zero(hw->bclk_ratio_max, bclk_ratio_max);
 }
 
 static int soc_pcm_components_close(struct snd_pcm_substream *substream,
-- 
2.17.1
