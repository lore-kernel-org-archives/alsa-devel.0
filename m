From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire: arrange common PCM
	info/constraints for AMDTP engine applications
Date: Thu,  8 Jun 2017 09:11:03 +0900
Message-ID: <20170608001103.28870-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 0D25E2671CA
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 02:11:08 +0200 (CEST)
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

In ALSA firewire stack, 8 drivers uses IEC 61883-1/6 engine for data
transmission. They have common PCM info/constraints and duplicated codes.

This commit unifies the codes into fireiwre-lib.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c            | 19 +++++++++++++++++
 sound/firewire/bebob/bebob_pcm.c         | 21 -------------------
 sound/firewire/dice/dice-pcm.c           | 20 ------------------
 sound/firewire/digi00x/digi00x-pcm.c     | 33 ++++++++++--------------------
 sound/firewire/fireface/ff-pcm.c         | 21 -------------------
 sound/firewire/fireworks/fireworks_pcm.c | 21 -------------------
 sound/firewire/motu/motu-pcm.c           | 20 ------------------
 sound/firewire/oxfw/oxfw-pcm.c           | 20 ------------------
 sound/firewire/tascam/tascam-pcm.c       | 35 ++++++--------------------------
 9 files changed, 36 insertions(+), 174 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 4316d9db404d..9678bc75dc5b 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -148,8 +148,27 @@ EXPORT_SYMBOL(amdtp_rate_table);
 int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
 					struct snd_pcm_runtime *runtime)
 {
+	struct snd_pcm_hardware *hw = &runtime->hw;
 	int err;
 
+	hw->info = SNDRV_PCM_INFO_BATCH |
+		   SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		   SNDRV_PCM_INFO_INTERLEAVED |
+		   SNDRV_PCM_INFO_JOINT_DUPLEX |
+		   SNDRV_PCM_INFO_MMAP |
+		   SNDRV_PCM_INFO_MMAP_VALID;
+
+	/* SNDRV_PCM_INFO_BATCH */
+	hw->periods_min = 2;
+	hw->periods_max = UINT_MAX;
+
+	/* bytes for a frame */
+	hw->period_bytes_min = 4 * hw->channels_max;
+
+	/* Just to prevent from allocating much pages. */
+	hw->period_bytes_max = hw->period_bytes_min * 2048;
+	hw->buffer_bytes_max = hw->period_bytes_max * hw->periods_min;
+
 	/*
 	 * Currently firewire-lib processes 16 packets in one software
 	 * interrupt callback. This equals to 2msec but actually the
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index 657e15a27e5c..e6adab3ef42e 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -92,19 +92,6 @@ limit_channels_and_rates(struct snd_pcm_hardware *hw,
 	}
 }
 
-static void
-limit_period_and_buffer(struct snd_pcm_hardware *hw)
-{
-	hw->periods_min = 2;		/* SNDRV_PCM_INFO_BATCH */
-	hw->periods_max = UINT_MAX;
-
-	hw->period_bytes_min = 4 * hw->channels_max;	/* bytes for a frame */
-
-	/* Just to prevent from allocating much pages. */
-	hw->period_bytes_max = hw->period_bytes_min * 2048;
-	hw->buffer_bytes_max = hw->period_bytes_max * hw->periods_min;
-}
-
 static int
 pcm_init_hw_params(struct snd_bebob *bebob,
 		   struct snd_pcm_substream *substream)
@@ -114,13 +101,6 @@ pcm_init_hw_params(struct snd_bebob *bebob,
 	struct snd_bebob_stream_formation *formations;
 	int err;
 
-	runtime->hw.info = SNDRV_PCM_INFO_BATCH |
-			   SNDRV_PCM_INFO_BLOCK_TRANSFER |
-			   SNDRV_PCM_INFO_INTERLEAVED |
-			   SNDRV_PCM_INFO_JOINT_DUPLEX |
-			   SNDRV_PCM_INFO_MMAP |
-			   SNDRV_PCM_INFO_MMAP_VALID;
-
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		runtime->hw.formats = AM824_IN_PCM_FORMAT_BITS;
 		s = &bebob->tx_stream;
@@ -132,7 +112,6 @@ pcm_init_hw_params(struct snd_bebob *bebob,
 	}
 
 	limit_channels_and_rates(&runtime->hw, formations);
-	limit_period_and_buffer(&runtime->hw);
 
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				  hw_rule_channels, formations,
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 2dda74695069..7cb9e9713ac3 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -51,18 +51,6 @@ static int limit_channels_and_rates(struct snd_dice *dice,
 	return 0;
 }
 
-static void limit_period_and_buffer(struct snd_pcm_hardware *hw)
-{
-	hw->periods_min = 2;			/* SNDRV_PCM_INFO_BATCH */
-	hw->periods_max = UINT_MAX;
-
-	hw->period_bytes_min = 4 * hw->channels_max;    /* byte for a frame */
-
-	/* Just to prevent from allocating much pages. */
-	hw->period_bytes_max = hw->period_bytes_min * 2048;
-	hw->buffer_bytes_max = hw->period_bytes_max * hw->periods_min;
-}
-
 static int init_hw_info(struct snd_dice *dice,
 			struct snd_pcm_substream *substream)
 {
@@ -74,13 +62,6 @@ static int init_hw_info(struct snd_dice *dice,
 	unsigned int count, size;
 	int err;
 
-	hw->info = SNDRV_PCM_INFO_MMAP |
-		   SNDRV_PCM_INFO_MMAP_VALID |
-		   SNDRV_PCM_INFO_BATCH |
-		   SNDRV_PCM_INFO_INTERLEAVED |
-		   SNDRV_PCM_INFO_JOINT_DUPLEX |
-		   SNDRV_PCM_INFO_BLOCK_TRANSFER;
-
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		hw->formats = AM824_IN_PCM_FORMAT_BITS;
 		dir = AMDTP_IN_STREAM;
@@ -107,7 +88,6 @@ static int init_hw_info(struct snd_dice *dice,
 				       substream->pcm->device, size);
 	if (err < 0)
 		return err;
-	limit_period_and_buffer(hw);
 
 	return amdtp_am824_add_pcm_hw_constraints(stream, runtime);
 }
diff --git a/sound/firewire/digi00x/digi00x-pcm.c b/sound/firewire/digi00x/digi00x-pcm.c
index f76cf5e383db..796f4b4645f5 100644
--- a/sound/firewire/digi00x/digi00x-pcm.c
+++ b/sound/firewire/digi00x/digi00x-pcm.c
@@ -58,31 +58,11 @@ static int hw_rule_channels(struct snd_pcm_hw_params *params,
 static int pcm_init_hw_params(struct snd_dg00x *dg00x,
 			      struct snd_pcm_substream *substream)
 {
-	static const struct snd_pcm_hardware hardware = {
-		.info = SNDRV_PCM_INFO_BATCH |
-			SNDRV_PCM_INFO_BLOCK_TRANSFER |
-			SNDRV_PCM_INFO_INTERLEAVED |
-			SNDRV_PCM_INFO_JOINT_DUPLEX |
-			SNDRV_PCM_INFO_MMAP |
-			SNDRV_PCM_INFO_MMAP_VALID,
-		.rates = SNDRV_PCM_RATE_44100 |
-			 SNDRV_PCM_RATE_48000 |
-			 SNDRV_PCM_RATE_88200 |
-			 SNDRV_PCM_RATE_96000,
-		.rate_min = 44100,
-		.rate_max = 96000,
-		.channels_min = 10,
-		.channels_max = 18,
-		.period_bytes_min = 4 * 18,
-		.period_bytes_max = 4 * 18 * 2048,
-		.buffer_bytes_max = 4 * 18 * 2048 * 2,
-		.periods_min = 2,
-		.periods_max = UINT_MAX,
-	};
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_pcm_hardware *hw = &runtime->hw;
 	struct amdtp_stream *s;
 	int err;
 
-	substream->runtime->hw = hardware;
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S32;
@@ -92,6 +72,15 @@ static int pcm_init_hw_params(struct snd_dg00x *dg00x,
 		s = &dg00x->rx_stream;
 	}
 
+	hw->channels_min = 10;
+	hw->channels_max = 18;
+
+	hw->rates = SNDRV_PCM_RATE_44100 |
+		    SNDRV_PCM_RATE_48000 |
+		    SNDRV_PCM_RATE_88200 |
+		    SNDRV_PCM_RATE_96000;
+	snd_pcm_limit_hw_rates(runtime);
+
 	err = snd_pcm_hw_rule_add(substream->runtime, 0,
 				  SNDRV_PCM_HW_PARAM_CHANNELS,
 				  hw_rule_channels, NULL,
diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
index ad974b5a2561..d12a0e3a4219 100644
--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -91,18 +91,6 @@ static void limit_channels_and_rates(struct snd_pcm_hardware *hw,
 	}
 }
 
-static void limit_period_and_buffer(struct snd_pcm_hardware *hw)
-{
-	hw->periods_min = 2;		/* SNDRV_PCM_INFO_BATCH */
-	hw->periods_max = UINT_MAX;
-
-	hw->period_bytes_min = 4 * hw->channels_max;	/* bytes for a frame */
-
-	/* Just to prevent from allocating much pages. */
-	hw->period_bytes_max = hw->period_bytes_min * 2048;
-	hw->buffer_bytes_max = hw->period_bytes_max * hw->periods_min;
-}
-
 static int pcm_init_hw_params(struct snd_ff *ff,
 			      struct snd_pcm_substream *substream)
 {
@@ -111,13 +99,6 @@ static int pcm_init_hw_params(struct snd_ff *ff,
 	const unsigned int *pcm_channels;
 	int err;
 
-	runtime->hw.info = SNDRV_PCM_INFO_BATCH |
-			   SNDRV_PCM_INFO_BLOCK_TRANSFER |
-			   SNDRV_PCM_INFO_INTERLEAVED |
-			   SNDRV_PCM_INFO_JOINT_DUPLEX |
-			   SNDRV_PCM_INFO_MMAP |
-			   SNDRV_PCM_INFO_MMAP_VALID;
-
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		runtime->hw.formats = SNDRV_PCM_FMTBIT_S32;
 		s = &ff->tx_stream;
@@ -128,9 +109,7 @@ static int pcm_init_hw_params(struct snd_ff *ff,
 		pcm_channels = ff->spec->pcm_playback_channels;
 	}
 
-	/* limit rates */
 	limit_channels_and_rates(&runtime->hw, pcm_channels);
-	limit_period_and_buffer(&runtime->hw);
 
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				  hw_rule_channels, (void *)pcm_channels,
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index 346e2647ed1f..40faed5e6968 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -129,19 +129,6 @@ limit_channels(struct snd_pcm_hardware *hw, unsigned int *pcm_channels)
 	}
 }
 
-static void
-limit_period_and_buffer(struct snd_pcm_hardware *hw)
-{
-	hw->periods_min = 2;		/* SNDRV_PCM_INFO_BATCH */
-	hw->periods_max = UINT_MAX;
-
-	hw->period_bytes_min = 4 * hw->channels_max;	/* bytes for a frame */
-
-	/* Just to prevent from allocating much pages. */
-	hw->period_bytes_max = hw->period_bytes_min * 2048;
-	hw->buffer_bytes_max = hw->period_bytes_max * hw->periods_min;
-}
-
 static int
 pcm_init_hw_params(struct snd_efw *efw,
 		   struct snd_pcm_substream *substream)
@@ -151,13 +138,6 @@ pcm_init_hw_params(struct snd_efw *efw,
 	unsigned int *pcm_channels;
 	int err;
 
-	runtime->hw.info = SNDRV_PCM_INFO_BATCH |
-			   SNDRV_PCM_INFO_BLOCK_TRANSFER |
-			   SNDRV_PCM_INFO_INTERLEAVED |
-			   SNDRV_PCM_INFO_JOINT_DUPLEX |
-			   SNDRV_PCM_INFO_MMAP |
-			   SNDRV_PCM_INFO_MMAP_VALID;
-
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		runtime->hw.formats = AM824_IN_PCM_FORMAT_BITS;
 		s = &efw->tx_stream;
@@ -173,7 +153,6 @@ pcm_init_hw_params(struct snd_efw *efw,
 	snd_pcm_limit_hw_rates(runtime);
 
 	limit_channels(&runtime->hw, pcm_channels);
-	limit_period_and_buffer(&runtime->hw);
 
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				  hw_rule_channels, pcm_channels,
diff --git a/sound/firewire/motu/motu-pcm.c b/sound/firewire/motu/motu-pcm.c
index e3ef89cee565..a2b50df70874 100644
--- a/sound/firewire/motu/motu-pcm.c
+++ b/sound/firewire/motu/motu-pcm.c
@@ -96,18 +96,6 @@ static void limit_channels_and_rates(struct snd_motu *motu,
 	snd_pcm_limit_hw_rates(runtime);
 }
 
-static void limit_period_and_buffer(struct snd_pcm_hardware *hw)
-{
-	hw->periods_min = 2;			/* SNDRV_PCM_INFO_BATCH */
-	hw->periods_max = UINT_MAX;
-
-	hw->period_bytes_min = 4 * hw->channels_max;    /* byte for a frame */
-
-	/* Just to prevent from allocating much pages. */
-	hw->period_bytes_max = hw->period_bytes_min * 2048;
-	hw->buffer_bytes_max = hw->period_bytes_max * hw->periods_min;
-}
-
 static int init_hw_info(struct snd_motu *motu,
 			struct snd_pcm_substream *substream)
 {
@@ -117,13 +105,6 @@ static int init_hw_info(struct snd_motu *motu,
 	struct snd_motu_packet_format *formats;
 	int err;
 
-	hw->info = SNDRV_PCM_INFO_MMAP |
-		   SNDRV_PCM_INFO_MMAP_VALID |
-		   SNDRV_PCM_INFO_BATCH |
-		   SNDRV_PCM_INFO_INTERLEAVED |
-		   SNDRV_PCM_INFO_JOINT_DUPLEX |
-		   SNDRV_PCM_INFO_BLOCK_TRANSFER;
-
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		hw->formats = SNDRV_PCM_FMTBIT_S32;
 		stream = &motu->tx_stream;
@@ -135,7 +116,6 @@ static int init_hw_info(struct snd_motu *motu,
 	}
 
 	limit_channels_and_rates(motu, runtime, formats);
-	limit_period_and_buffer(hw);
 
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				  motu_rate_constraint, formats,
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index bc1a3a36ab06..3dd46285c0e2 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -106,18 +106,6 @@ static void limit_channels_and_rates(struct snd_pcm_hardware *hw, u8 **formats)
 	}
 }
 
-static void limit_period_and_buffer(struct snd_pcm_hardware *hw)
-{
-	hw->periods_min = 2;		/* SNDRV_PCM_INFO_BATCH */
-	hw->periods_max = UINT_MAX;
-
-	hw->period_bytes_min = 4 * hw->channels_max;	/* bytes for a frame */
-
-	/* Just to prevent from allocating much pages. */
-	hw->period_bytes_max = hw->period_bytes_min * 2048;
-	hw->buffer_bytes_max = hw->period_bytes_max * hw->periods_min;
-}
-
 static int init_hw_params(struct snd_oxfw *oxfw,
 			  struct snd_pcm_substream *substream)
 {
@@ -126,13 +114,6 @@ static int init_hw_params(struct snd_oxfw *oxfw,
 	struct amdtp_stream *stream;
 	int err;
 
-	runtime->hw.info = SNDRV_PCM_INFO_BATCH |
-			   SNDRV_PCM_INFO_BLOCK_TRANSFER |
-			   SNDRV_PCM_INFO_INTERLEAVED |
-			   SNDRV_PCM_INFO_JOINT_DUPLEX |
-			   SNDRV_PCM_INFO_MMAP |
-			   SNDRV_PCM_INFO_MMAP_VALID;
-
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		runtime->hw.formats = AM824_IN_PCM_FORMAT_BITS;
 		stream = &oxfw->tx_stream;
@@ -144,7 +125,6 @@ static int init_hw_params(struct snd_oxfw *oxfw,
 	}
 
 	limit_channels_and_rates(&runtime->hw, formats);
-	limit_period_and_buffer(&runtime->hw);
 
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				  hw_rule_channels, formats,
diff --git a/sound/firewire/tascam/tascam-pcm.c b/sound/firewire/tascam/tascam-pcm.c
index 3c4482aa7231..6ec8ec634d4d 100644
--- a/sound/firewire/tascam/tascam-pcm.c
+++ b/sound/firewire/tascam/tascam-pcm.c
@@ -8,41 +8,14 @@
 
 #include "tascam.h"
 
-static void set_buffer_params(struct snd_pcm_hardware *hw)
-{
-	hw->period_bytes_min = 4 * hw->channels_min;
-	hw->period_bytes_max = hw->period_bytes_min * 2048;
-	hw->buffer_bytes_max = hw->period_bytes_max * 2;
-
-	hw->periods_min = 2;
-	hw->periods_max = UINT_MAX;
-}
-
 static int pcm_init_hw_params(struct snd_tscm *tscm,
 			      struct snd_pcm_substream *substream)
 {
-	static const struct snd_pcm_hardware hardware = {
-		.info = SNDRV_PCM_INFO_BATCH |
-			SNDRV_PCM_INFO_BLOCK_TRANSFER |
-			SNDRV_PCM_INFO_INTERLEAVED |
-			SNDRV_PCM_INFO_JOINT_DUPLEX |
-			SNDRV_PCM_INFO_MMAP |
-			SNDRV_PCM_INFO_MMAP_VALID,
-		.rates = SNDRV_PCM_RATE_44100 |
-			 SNDRV_PCM_RATE_48000 |
-			 SNDRV_PCM_RATE_88200 |
-			 SNDRV_PCM_RATE_96000,
-		.rate_min = 44100,
-		.rate_max = 96000,
-		.channels_min = 10,
-		.channels_max = 18,
-	};
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_pcm_hardware *hw = &runtime->hw;
 	struct amdtp_stream *stream;
 	unsigned int pcm_channels;
 
-	runtime->hw = hardware;
-
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		runtime->hw.formats = SNDRV_PCM_FMTBIT_S32;
 		stream = &tscm->tx_stream;
@@ -59,7 +32,11 @@ static int pcm_init_hw_params(struct snd_tscm *tscm,
 		pcm_channels += 2;
 	runtime->hw.channels_min = runtime->hw.channels_max = pcm_channels;
 
-	set_buffer_params(&runtime->hw);
+	hw->rates = SNDRV_PCM_RATE_44100 |
+		    SNDRV_PCM_RATE_48000 |
+		    SNDRV_PCM_RATE_88200 |
+		    SNDRV_PCM_RATE_96000;
+	snd_pcm_limit_hw_rates(runtime);
 
 	return amdtp_tscm_add_pcm_hw_constraints(stream, runtime);
 }
-- 
2.11.0
