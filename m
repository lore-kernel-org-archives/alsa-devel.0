From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 20/23] aplay: add an implementation for
	volume unit meter
Date: Thu, 17 Aug 2017 21:00:01 +0900
Message-ID: <20170817120004.15326-21-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 05356266F15
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 14:00:16 +0200 (CEST)
In-Reply-To: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Current implementation of aplay has volume unit (vu) meter, by an option
'--vumeter' (-V). When 'm' or 's' is given for the option, used terminal
displays monaural or stereo meter via stderr.

This commit adds support for the similar function in different shape.
Unfortunately, current implementation just supports meters up to 2 channel,
as original implementation supports. If supporting more channels for
multi-channel devices, temrinal control code could be used.
---
 aplay/Makefile.am         |   7 +-
 aplay/options.c           |  40 ++++++-
 aplay/options.h           |   3 +
 aplay/vumeter.c           | 299 ++++++++++++++++++++++++++++++++++++++++++++++
 aplay/vumeter.h           |  50 ++++++++
 aplay/xfer-alsa-io-mmap.c |   3 +-
 aplay/xfer-alsa-io-rw.c   |   6 +-
 aplay/xfer-alsa.c         |   8 +-
 aplay/xfer-alsa.h         |   3 +-
 aplay/xfer.c              |  25 +++-
 aplay/xfer.h              |   5 +-
 11 files changed, 436 insertions(+), 13 deletions(-)
 create mode 100644 aplay/vumeter.c
 create mode 100644 aplay/vumeter.h

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index 5536c00..a0d498c 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -12,7 +12,8 @@ noinst_HEADERS = \
 	options.h \
 	xfer.h \
 	xfer-alsa.h \
-	main.h
+	main.h \
+	vumeter.h
 
 aplay_SOURCES = \
 	container.h \
@@ -41,7 +42,9 @@ aplay_SOURCES = \
 	main.h \
 	subcmd-list.c \
 	subcmd-transfer.c \
-	main.c
+	main.c \
+	vumeter.h \
+	vumeter.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/options.c b/aplay/options.c
index efe0ce0..c16269d 100644
--- a/aplay/options.c
+++ b/aplay/options.c
@@ -115,6 +115,30 @@ static int verify_cntr_format(struct context_options *opts, const char *literal)
 	return -EINVAL;
 }
 
+static int verify_vu_mode(struct context_options *opts, const char *literal)
+{
+	static const struct {
+		const char *const literal;
+		enum vumeter_mode mode;
+	} *entry, entries[] = {
+		{"m",	VUMETER_MODE_MONO},
+		{"s",	VUMETER_MODE_STEREO},
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
+		entry = &entries[i];
+		if (!strcmp(entry->literal, literal)) {
+			opts->vu_mode = entry->mode;
+			return 0;
+		}
+	}
+
+	printf("Invalid argument for vumeter mode: %s\n", literal);
+
+	return -EINVAL;
+}
+
 /* This should be called after 'verify_cntr_format()'. */
 static int verify_sample_format(struct context_options *opts,
 				const char *literal)
@@ -174,7 +198,8 @@ static int apply_policies(struct context_options *opts,
 			  snd_pcm_stream_t direction,
 			  const char *cntr_format_literal,
 			  const char *node_literal,
-			  const char *sample_format_literal)
+			  const char *sample_format_literal,
+			  const char *vu_mode_literal)
 {
 	int err;
 
@@ -256,6 +281,12 @@ static int apply_policies(struct context_options *opts,
 		}
 	}
 
+	if (vu_mode_literal) {
+		err = verify_vu_mode(opts, vu_mode_literal);
+		if (err < 0)
+			return err;
+	}
+
 	if (opts->frames_per_second > 0) {
 		unsigned int orig = opts->frames_per_second;
 
@@ -285,7 +316,7 @@ static int apply_policies(struct context_options *opts,
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hqd:vt:D:c:f:r:MNF:A:R:T:B:I";
+	static const char *s_opts = "hqid:vt:D:c:f:r:MNF:A:R:T:B:IV:";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
@@ -321,11 +352,13 @@ int context_options_init(struct context_options *opts, int argc,
 		{"test-nowait",		0, 0, OPT_TEST_NOWAIT},
 		{"dump-hw-params",	0, 0, OPT_DUMP_HWPARAMS},
 		{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
+		{"vumeter",		1, 0, 'V'},
 		{NULL,			0, 0, 0},
 	};
 	const char *cntr_format_literal = NULL;
 	const char *node_literal = NULL;
 	const char *sample_format_literal = NULL;
+	const char *vu_mode_literal = NULL;
 	int c;
 	int err = 0;
 
@@ -407,7 +440,8 @@ int context_options_init(struct context_options *opts, int argc,
 		return err;
 
 	return apply_policies(opts, direction, cntr_format_literal,
-			      node_literal, sample_format_literal);
+			      node_literal, sample_format_literal,
+			      vu_mode_literal);
 }
 
 /*
diff --git a/aplay/options.h b/aplay/options.h
index dc474d5..2536275 100644
--- a/aplay/options.h
+++ b/aplay/options.h
@@ -10,6 +10,7 @@
 #define __ALSA_UTILS_APLAY_OPTIONS__H_
 
 #include "container.h"
+#include "vumeter.h"
 
 struct context_options {
 	bool help;
@@ -51,6 +52,8 @@ struct context_options {
 	bool dump_hw_params;
 	bool fatal_errors;
 
+	enum vumeter_mode vu_mode;
+
 	char **paths;
 	unsigned int path_count;
 };
diff --git a/aplay/vumeter.c b/aplay/vumeter.c
new file mode 100644
index 0000000..da39261
--- /dev/null
+++ b/aplay/vumeter.c
@@ -0,0 +1,299 @@
+/*
+ * vumeter.c - Volume Unit meter.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "vumeter.h"
+
+#include <stdio.h>
+#include <string.h>
+#include <endian.h>
+#include <gettext.h>
+
+static void print_vu_meter_mono(struct vumeter_context *vu, int *perc)
+{
+	const int *maxperc = vu->maxperc;
+	const int bar_length = 50;
+	char line[80];
+	int val;
+
+	for (val = 0; val <= *perc * bar_length / 100 && val < bar_length; val++)
+		line[val] = '#';
+	for (; val <= *maxperc * bar_length / 100 && val < bar_length; val++)
+		line[val] = ' ';
+	line[val] = '+';
+	for (++val; val <= bar_length; val++)
+		line[val] = ' ';
+	if (*maxperc > 99)
+		sprintf(line + val, "| MAX");
+	else
+		sprintf(line + val, "| %02i%%", *maxperc);
+	fputs(line, stderr);
+	if (*perc > 100)
+		fprintf(stderr, _(" !clip  "));
+}
+
+static void print_vu_meter_stereo(struct vumeter_context *vu, int *perc)
+{
+	const int bar_length = 35;
+	const int *maxperc = vu->maxperc;
+	char line[80];
+	int c;
+
+	memset(line, ' ', sizeof(line) - 1);
+	line[bar_length + 3] = '|';
+
+	for (c = 0; c < 2; c++) {
+		int p = perc[c] * bar_length / 100;
+		char tmp[4];
+		if (p > bar_length)
+			p = bar_length;
+		if (c)
+			memset(line + bar_length + 6 + 1, '#', p);
+		else
+			memset(line + bar_length - p - 1, '#', p);
+		p = maxperc[c] * bar_length / 100;
+		if (p > bar_length)
+			p = bar_length;
+		if (c)
+			line[bar_length + 6 + 1 + p] = '+';
+		else
+			line[bar_length - p - 1] = '+';
+		if (maxperc[c] > 99)
+			sprintf(tmp, "MAX");
+		else
+			sprintf(tmp, "%02d%%", maxperc[c]);
+		if (c)
+			memcpy(line + bar_length + 3 + 1, tmp, 3);
+		else
+			memcpy(line + bar_length, tmp, 3);
+	}
+	line[bar_length * 2 + 6 + 2] = 0;
+	fputs(line, stderr);
+}
+
+static void calculate_8bit_sample(struct vumeter_context *vu,
+				  void *frame_buffer,
+				  snd_pcm_uframes_t frame_count,
+				  int max_peak[2])
+{
+	enum vumeter_mode mode = vu->mode;
+	char *valp = frame_buffer;
+	char mask = vu->mask;
+	int val;
+	int c;
+
+	c = 0;
+	while (frame_count-- > 0) {
+		val = *valp++ ^ mask;
+		val = abs(val);
+		if (max_peak[c] < val)
+			max_peak[c] = val;
+		if (mode == VUMETER_MODE_STEREO)
+			c = !c;
+	}
+}
+
+static void calculate_16bit_sample(struct vumeter_context *vu,
+				   void *frame_buffer,
+				   snd_pcm_uframes_t frame_count,
+				   int max_peak[2])
+{
+	enum vumeter_mode mode = vu->mode;
+	signed short *valp = frame_buffer;
+	signed short mask = vu->mask;
+	signed short sval;
+	bool le = vu->le;
+	int c;
+
+	frame_count /= 2;
+	c = 0;
+	while (frame_count-- > 0) {
+		if (le)
+			sval = le16toh(*valp);
+		else
+			sval = be16toh(*valp);
+		sval = abs(sval) ^ mask;
+		if (max_peak[c] < sval)
+			max_peak[c] = sval;
+		valp++;
+		if (mode == VUMETER_MODE_STEREO)
+			c = !c;
+	}
+}
+
+static void calculate_24bit_sample(struct vumeter_context *vu,
+				   void *frame_buffer,
+				   snd_pcm_uframes_t frame_count,
+				   int max_peak[2])
+{
+	enum vumeter_mode mode = vu->mode;
+	char *valp = frame_buffer;
+	int mask = vu->mask;
+	bool le = vu->le;
+	int bits_per_sample = vu->bits_per_sample;
+	int val;
+	int c;
+
+	frame_count /= 3;
+	c = 0;
+	while (frame_count-- > 0) {
+		if (le) {
+			val = valp[0] |
+			      (valp[1] << 8) |
+			      (valp[2] << 16);
+		} else {
+			val = (valp[0] << 16) |
+			      (valp[1] << 8) |
+			      valp[2];
+		}
+		/* Correct signed bit in 32-bit value */
+		if (val & (1 << (bits_per_sample - 1))) {
+			/* Negate upper bits too */
+			val |= 0xff << 24;
+		}
+		val = abs(val) ^ mask;
+		if (max_peak[c] < val)
+			max_peak[c] = val;
+		valp += 3;
+		if (mode == VUMETER_MODE_STEREO)
+			c = !c;
+	}
+}
+
+static void calculate_32bit_sample(struct vumeter_context *vu,
+				   void *frame_buffer,
+				   snd_pcm_uframes_t frame_count,
+				   int max_peak[2])
+{
+	enum vumeter_mode mode = vu->mode;
+	signed int *valp = (signed int *)frame_buffer;
+	signed int mask = vu->mask;
+	bool le = vu->le;
+	int val;
+	int c;
+
+	frame_count /= 4;
+	c = 0;
+	while (frame_count-- > 0) {
+		if (le)
+			val = le32toh(*valp);
+		else
+			val = be32toh(*valp);
+		val = abs(val) ^ mask;
+		if (max_peak[c] < val)
+			max_peak[c] = val;
+		valp++;
+		if (mode == VUMETER_MODE_STEREO)
+			c = !c;
+	}
+}
+
+/* peak handler */
+void vumeter_context_print(struct vumeter_context *vu, void *frame_buffer,
+			   snd_pcm_uframes_t frame_count)
+{
+	signed int val, max, perc[2], max_peak[2];
+	int ichans, c;
+
+	memset(max_peak, 0, sizeof(max_peak));
+	vu->calculator(vu, frame_buffer, frame_count, max_peak);
+
+	if (vu->mode == VUMETER_MODE_STEREO)
+		ichans = 2;
+	else
+		ichans = 1;
+
+	max = 1 << (vu->significant_bits_per_sample - 1);
+	if (max <= 0)
+		max = 0x7fffffff;
+
+	for (c = 0; c < ichans; ++c) {
+		if (vu->bits_per_sample > 16)
+			perc[c] = max_peak[c] / (max / 100);
+		else
+			perc[c] = max_peak[c] * 100 / max;
+	}
+
+	if (vu->interleaved && vu->verbose <= 2) {
+		const time_t now = time(NULL);
+		if(now > vu->prev) {
+			vu->prev = now;
+			vu->maxperc[0] = 0;
+			vu->maxperc[1] = 0;
+		}
+		for (c = 0; c < ichans; c++)
+			if (perc[c] > vu->maxperc[c])
+				vu->maxperc[c] = perc[c];
+
+		putc('\r', stderr);
+
+		if (vu->mode == VUMETER_MODE_STEREO)
+			print_vu_meter_stereo(vu, perc);
+		else
+			print_vu_meter_mono(vu, perc);
+
+		fflush(stderr);
+	} else if (vu->verbose == 3) {
+		fprintf(stderr,
+			_("Max peak (%li samples): 0x%08x "),
+			frame_count, max_peak[0]);
+		for (val = 0; val < 20; val++)
+			if (val <= perc[0] / 5)
+				putc('#', stderr);
+			else
+				putc(' ', stderr);
+		fprintf(stderr, " %i%%\n", perc[0]);
+		fflush(stderr);
+	}
+}
+
+int vumeter_context_init(struct vumeter_context *vu, enum vumeter_mode mode,
+			 snd_pcm_access_t access, snd_pcm_format_t format,
+			 unsigned int samples_per_frame, unsigned int verbose)
+{
+	vu->verbose = verbose;
+
+	if ((access == SND_PCM_ACCESS_MMAP_INTERLEAVED) ||
+	    (access == SND_PCM_ACCESS_RW_INTERLEAVED))
+		vu->interleaved = true;
+	else if ((access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED) ||
+	         (access == SND_PCM_ACCESS_RW_NONINTERLEAVED))
+		vu->interleaved = false;
+	else
+		return -EINVAL;
+
+	vu->le = !!snd_pcm_format_little_endian(format);
+	vu->significant_bits_per_sample = snd_pcm_format_width(format);
+
+	vu->bits_per_sample = snd_pcm_format_physical_width(format);
+	if (vu->bits_per_sample == 8)
+		vu->calculator = calculate_8bit_sample;
+	else if (vu->bits_per_sample == 16)
+		vu->calculator = calculate_16bit_sample;
+	else if (vu->bits_per_sample == 24)
+		vu->calculator = calculate_24bit_sample;
+	else if (vu->bits_per_sample == 32)
+		vu->calculator = calculate_32bit_sample;
+	else
+		return -EINVAL;
+	vu->mask = snd_pcm_format_silence_64(format);
+
+	vu->samples_per_frame = samples_per_frame;
+
+	if (mode == VUMETER_MODE_MONO)
+		vu->printer = print_vu_meter_mono;
+	else
+		vu->printer = print_vu_meter_stereo;
+	vu->mode = mode;
+
+	return 0;
+}
+
+void vumeter_context_destroy(struct vumeter_context *vu)
+{
+	return;
+}
diff --git a/aplay/vumeter.h b/aplay/vumeter.h
new file mode 100644
index 0000000..d2fa8a4
--- /dev/null
+++ b/aplay/vumeter.h
@@ -0,0 +1,50 @@
+/*
+ * vumeter.h - Volume Unit meter.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef __ALSA_UTILS_APLAY_VUMETER__H_
+#define __ALSA_UTILS_APLAY_VUMETER__H_
+
+#include <stddef.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <time.h>
+#include <alsa/asoundlib.h>
+
+enum vumeter_mode {
+	VUMETER_MODE_NONE = 0,
+	VUMETER_MODE_MONO,
+	VUMETER_MODE_STEREO
+};
+
+struct vumeter_context {
+	enum vumeter_mode mode;
+	unsigned int verbose;
+
+	bool le;
+	bool interleaved;
+	int significant_bits_per_sample;
+	int bits_per_sample;
+	unsigned int samples_per_frame;
+
+	uint64_t mask;
+	int maxperc[2];
+	time_t prev;
+
+	void (*printer)(struct vumeter_context *vu, int *perc);
+	void (*calculator)(struct vumeter_context *vu, void *data,
+			   snd_pcm_uframes_t frame_count, int max_peaks[2]);
+};
+
+int vumeter_context_init(struct vumeter_context *vu, enum vumeter_mode mode,
+			 snd_pcm_access_t access, snd_pcm_format_t format,
+			 unsigned int samples_per_frame, unsigned int verbose);
+void vumeter_context_print(struct vumeter_context *vu, void *data,
+			   snd_pcm_uframes_t frame_count);
+void vumeter_context_destroy(struct vumeter_context *vu);
+
+#endif
diff --git a/aplay/xfer-alsa-io-mmap.c b/aplay/xfer-alsa-io-mmap.c
index 7ddb880..830d2f8 100644
--- a/aplay/xfer-alsa-io-mmap.c
+++ b/aplay/xfer-alsa-io-mmap.c
@@ -44,7 +44,8 @@ static int alsa_mmap_pre_process(struct alsa_state *state)
 static int alsa_mmap_process_frames(struct alsa_state *state,
 				    unsigned *frame_count,
 				    struct aligner_context *aligner,
-				    struct container_context *cntrs)
+				    struct container_context *cntrs,
+				    struct vumeter_context *vu)
 {
 	const snd_pcm_channel_area_t *areas;
 	snd_pcm_uframes_t frame_offset;
diff --git a/aplay/xfer-alsa-io-rw.c b/aplay/xfer-alsa-io-rw.c
index a69d7e0..513ff91 100644
--- a/aplay/xfer-alsa-io-rw.c
+++ b/aplay/xfer-alsa-io-rw.c
@@ -146,7 +146,8 @@ static int alsa_rw_pre_process(struct alsa_state *state)
 static int alsa_r_process_frames(struct alsa_state *state,
 				 unsigned int *frame_count,
 				 struct aligner_context *aligner,
-				 struct container_context *cntrs)
+				 struct container_context *cntrs,
+				 struct vumeter_context *vu)
 {
 	struct frame_cache *cache = state->io_private_data;
 	snd_pcm_sframes_t avail;
@@ -240,7 +241,8 @@ error:
 static int alsa_w_process_frames(struct alsa_state *state,
 				 unsigned *frame_count,
 				 struct aligner_context *aligner,
-				 struct container_context *cntrs)
+				 struct container_context *cntrs,
+				 struct vumeter_context *vu)
 {
 	struct frame_cache *cache = state->io_private_data;
 	snd_pcm_sframes_t avail;
diff --git a/aplay/xfer-alsa.c b/aplay/xfer-alsa.c
index 05e6e7e..2092f3e 100644
--- a/aplay/xfer-alsa.c
+++ b/aplay/xfer-alsa.c
@@ -443,11 +443,15 @@ static int xfer_alsa_pre_process(struct xfer_context *xfer,
 static int xfer_alsa_process_frames(struct xfer_context *xfer,
 				    unsigned int *frame_count,
 				    struct aligner_context *aligner,
-				    struct container_context *cntrs)
+				    struct container_context *cntrs,
+				    struct vumeter_context *vu)
 {
 	struct alsa_state *state = xfer->private_data;
 	int err;
-	err = state->io_ops->process_frames(state, frame_count, aligner, cntrs);
+
+	/* TODO: vumeter in each backend. */
+	err = state->io_ops->process_frames(state, frame_count, aligner, cntrs,
+					    vu);
 	if (err < 0) {
 		if (err == -EPIPE)
 			err = snd_pcm_prepare(state->handle);
diff --git a/aplay/xfer-alsa.h b/aplay/xfer-alsa.h
index 9cc079d..8702685 100644
--- a/aplay/xfer-alsa.h
+++ b/aplay/xfer-alsa.h
@@ -45,7 +45,8 @@ struct xfer_alsa_io_ops {
 	int (*process_frames)(struct alsa_state *state,
 			      unsigned int *frame_count,
 			      struct aligner_context *aligner,
-			      struct container_context *cntrs);
+			      struct container_context *cntrs,
+			      struct vumeter_context *vu);
 	void (*post_process)(struct alsa_state *state);
 	unsigned int private_size;
 };
diff --git a/aplay/xfer.c b/aplay/xfer.c
index 977f00a..02ed0a6 100644
--- a/aplay/xfer.c
+++ b/aplay/xfer.c
@@ -41,6 +41,14 @@ int xfer_context_init(struct xfer_context *xfer, enum xfer_type type,
 		return -ENOMEM;
 	memset(xfer->private_data, 0, entries[i].data->private_size);
 
+	if (opts->vu_mode != VUMETER_MODE_NONE) {
+		xfer->vu = malloc(sizeof(*xfer->vu));
+		if (xfer->vu == NULL)
+			return -ENOMEM;
+		memset(xfer->vu, 0, sizeof(*xfer->vu));
+		xfer->vu->mode = opts->vu_mode;
+	}
+
 	return xfer->ops->init(xfer, direction, opts);
 }
 
@@ -67,6 +75,14 @@ int xfer_context_pre_process(struct xfer_context *xfer,
 	if (err < 0)
 		return err;
 
+	if (xfer->vu) {
+		err = vumeter_context_init(xfer->vu, xfer->vu->mode, *access,
+					   *format, *samples_per_frame,
+					   xfer->verbose);
+		if (err < 0)
+			return err;
+	}
+
 	if (xfer->verbose > 0) {
 		printf("Transfer: %s\n", xfer_type_labels[xfer->type]);
 		printf("  access: %s\n", snd_pcm_access_name(*access));
@@ -87,7 +103,8 @@ int xfer_context_process_frames(struct xfer_context *xfer,
 				struct container_context *cntrs,
 				unsigned int *frame_count)
 {
-	return xfer->ops->process_frames(xfer, frame_count, aligner, cntrs);
+	return xfer->ops->process_frames(xfer, frame_count, aligner, cntrs,
+					 xfer->vu);
 }
 
 void xfer_context_pause(struct xfer_context *xfer, bool enable)
@@ -98,4 +115,10 @@ void xfer_context_pause(struct xfer_context *xfer, bool enable)
 void xfer_context_post_process(struct xfer_context *xfer)
 {
 	xfer->ops->post_process(xfer);
+
+	if (xfer->vu) {
+		vumeter_context_destroy(xfer->vu);
+		free(xfer->vu);
+		xfer->vu = NULL;
+	}
 }
diff --git a/aplay/xfer.h b/aplay/xfer.h
index 749fa6c..8a18712 100644
--- a/aplay/xfer.h
+++ b/aplay/xfer.h
@@ -23,6 +23,8 @@ struct xfer_context  {
 	const struct xfer_ops *ops;
 	void *private_data;
 
+	struct vumeter_context *vu;
+
 	unsigned int verbose;
 };
 
@@ -55,7 +57,8 @@ struct xfer_ops {
 	int (*process_frames)(struct xfer_context *xfer,
 			      unsigned int *frame_count,
 			      struct aligner_context *aligner,
-			      struct container_context *cntrs);
+			      struct container_context *cntrs,
+			      struct vumeter_context *vu);
 	void (*post_process)(struct xfer_context *xfer);
 	void (*destroy)(struct xfer_context *xfer);
 	void (*pause)(struct xfer_context *xfer, bool enable);
-- 
2.11.0
