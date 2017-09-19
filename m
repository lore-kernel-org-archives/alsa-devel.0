From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv2][PATCH 30/38] axfer: add an option to support
	volume unit meter
Date: Tue, 19 Sep 2017 09:44:10 +0900
Message-ID: <20170919004418.24668-31-o-takashi@sakamocchi.jp>
References: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 22214267054
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 02:44:31 +0200 (CEST)
In-Reply-To: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In aplay, volume unit (vu) meter is implemented, by an option '--vumeter'
(-V). When 'm' or 's' is given for the option, terminal displays monaural
or stereo meter via stderr.

This commit adds support for this feature. Original implementation just
supports meters up to 2 channel and this commit follows it. However,
actual calculation is done all of channels with a consideration about
future extension to display all of channels.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am               |   7 +-
 axfer/options.c                 |  43 ++-
 axfer/options.h                 |   4 +
 axfer/subcmd-transfer.c         |   1 -
 axfer/vumeter.c                 | 565 ++++++++++++++++++++++++++++++++++++++++
 axfer/vumeter.h                 |  56 ++++
 axfer/xfer-libasound-irq-mmap.c |  16 +-
 axfer/xfer-libasound-irq-rw.c   |  40 ++-
 axfer/xfer-libasound.c          |   5 +-
 axfer/xfer-libasound.h          |   3 +-
 axfer/xfer.c                    |  39 ++-
 axfer/xfer.h                    |   5 +-
 12 files changed, 755 insertions(+), 29 deletions(-)
 create mode 100644 axfer/vumeter.c
 create mode 100644 axfer/vumeter.h

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index 79592bc8..8c22bb18 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -22,7 +22,8 @@ noinst_HEADERS = \
 	options.h \
 	xfer.h \
 	xfer-alsa.h \
-	waiter.h
+	waiter.h \
+	vumeter.h
 
 axfer_SOURCES = \
 	misc.h \
@@ -50,4 +51,6 @@ axfer_SOURCES = \
 	waiter.h \
 	waiter.c \
 	waiter-poll.c \
-	xfer-libasound-irq-mmap.c
+	xfer-libasound-irq-mmap.c \
+	vumeter.h \
+	vumeter.c
diff --git a/axfer/options.c b/axfer/options.c
index 2770b719..34e8ae77 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -113,6 +113,30 @@ static int verify_cntr_format(struct context_options *opts, const char *literal)
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
+	fprintf(stderr, "Invalid argument for vumeter mode: %s\n", literal);
+
+	return -EINVAL;
+}
+
 /* This should be called after 'verify_cntr_format()'. */
 static int verify_sample_format(struct context_options *opts,
 				const char *literal)
@@ -176,7 +200,8 @@ static int apply_policies(struct context_options *opts,
 			  snd_pcm_stream_t direction,
 			  const char *cntr_format_literal,
 			  const char *node_literal,
-			  const char *sample_format_literal)
+			  const char *sample_format_literal,
+			  const char *vu_mode_literal)
 {
 	int err;
 
@@ -252,6 +277,12 @@ static int apply_policies(struct context_options *opts,
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
 
@@ -326,7 +357,7 @@ void context_options_calculate_duration(struct context_options *opts,
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NMF:B:A:R:T:";
+	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NMF:B:A:R:T:V:";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
@@ -361,6 +392,8 @@ int context_options_init(struct context_options *opts, int argc,
 		{"dump-hw-params",	0, 0, OPT_DUMP_HW_PARAMS},
 		{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
 		{"test-nowait",		0, 0, OPT_TEST_NOWAIT},
+		/* Misc features. */
+		{"vumeter",		1, 0, 'V'},
 		/* Obsoleted. */
 		{"max-file-time",       1, 0, OPT_MAX_FILE_TIME},
 		{NULL,			0, 0, 0},
@@ -368,6 +401,7 @@ int context_options_init(struct context_options *opts, int argc,
 	const char *cntr_format_literal = NULL;
 	const char *node_literal = NULL;
 	const char *sample_format_literal = NULL;
+	const char *vu_mode_literal = NULL;
 	int l_index = 0;
 	int c;
 	int err = 0;
@@ -432,6 +466,8 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->finish_at_xrun = true;
 		else if (c == OPT_TEST_NOWAIT)
 			opts->test_nowait = true;
+		else if (c == 'V')
+			vu_mode_literal = optarg;
 		else if (c == OPT_MAX_FILE_TIME) {
 			fprintf(stderr,
 				"An option '--%s' is obsoleted and has no "
@@ -450,7 +486,8 @@ int context_options_init(struct context_options *opts, int argc,
 		return err;
 
 	return apply_policies(opts, direction, cntr_format_literal,
-			      node_literal, sample_format_literal);
+			      node_literal, sample_format_literal,
+			      vu_mode_literal);
 }
 
 static int generate_path_with_suffix(struct context_options *opts,
diff --git a/axfer/options.h b/axfer/options.h
index 95012ad3..57dfc31f 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -10,6 +10,7 @@
 #define __ALSA_UTILS_AXFER_OPTIONS__H_
 
 #include "container.h"
+#include "vumeter.h"
 
 struct context_options {
 	bool help;
@@ -55,6 +56,9 @@ struct context_options {
 	bool dump_hw_params;
 	bool finish_at_xrun;
 	bool test_nowait;
+
+	/* Misc features. */
+	enum vumeter_mode vu_mode;
 };
 
 int context_options_init(struct context_options *opts, int argc,
diff --git a/axfer/subcmd-transfer.c b/axfer/subcmd-transfer.c
index df477f61..1527fae8 100644
--- a/axfer/subcmd-transfer.c
+++ b/axfer/subcmd-transfer.c
@@ -128,7 +128,6 @@ static int prepare_signal_handler(struct context *ctx)
 
 static int context_init(struct context *ctx, snd_pcm_stream_t direction)
 {
-	/* Initialize transfer. */
 	return xfer_context_init(&ctx->xfer, XFER_TYPE_LIBASOUND, direction,
 				 &ctx->opts);
 }
diff --git a/axfer/vumeter.c b/axfer/vumeter.c
new file mode 100644
index 00000000..010afc28
--- /dev/null
+++ b/axfer/vumeter.c
@@ -0,0 +1,565 @@
+/*
+ * vumeter.c - Volume Unit meter.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "vumeter.h"
+#include "misc.h"
+
+#include <endian.h>
+
+/*
+ * MEMO: Casting to 'intXX_t' is important to calculate absolute value from
+ * 'uintXX_t' representation of PCM frame.
+ */
+
+static void calculate_8bit_sample_buf(struct vumeter_context *vu,
+				      void *frame_buffer,
+				      unsigned int frame_count)
+{
+	int8_t *buf = frame_buffer;
+	unsigned int samples_per_frame = vu->samples_per_frame;
+	bool interleaved = vu->interleaved;
+	int8_t zero_point = (int8_t)vu->zero_point;
+	int c, i;
+
+	for (c = 0; c < samples_per_frame; ++c) {
+		int8_t peak = 0;
+
+		for (i = 0; i < frame_count; ++i) {
+			int8_t val;
+			unsigned int offset;
+
+			if (interleaved)
+				offset = i * samples_per_frame + c;
+			else
+				offset = c * frame_count + i;
+
+			val = abs(buf[offset] ^ zero_point);
+			if (val > peak)
+				peak = val;
+		}
+
+		vu->peaks[c] = (uint32_t)peak;
+	}
+}
+
+static void calculate_8bit_sample_vector(struct vumeter_context *vu,
+					 void *frame_buffer,
+					 unsigned int frame_count)
+{
+	int8_t **bufs = frame_buffer;
+	unsigned int samples_per_frame = vu->samples_per_frame;
+	int8_t zero_point = (int8_t)vu->zero_point;
+	int c, i;
+
+	for (c = 0; c < samples_per_frame; ++c) {
+		int8_t *buf = bufs[c];
+		int8_t peak = 0;
+
+		for (i = 0; i < frame_count; ++i) {
+			int8_t val;
+
+			val = abs(buf[i] ^ zero_point);
+			if (val > peak)
+				peak = val;
+		}
+
+		vu->peaks[c] = (uint32_t)peak;
+	}
+}
+
+static void calculate_16bit_sample_buf(struct vumeter_context *vu,
+				       void *frame_buffer,
+				       unsigned int frame_count)
+{
+	int16_t *buf = frame_buffer;
+	unsigned int samples_per_frame = vu->samples_per_frame;
+	bool le = vu->le;
+	bool interleaved = vu->interleaved;
+	int16_t zero_point = (int16_t)vu->zero_point;
+	int c, i;
+
+	for (c = 0; c < samples_per_frame; ++c) {
+		int16_t peak = 0;
+
+		for (i = 0; i < frame_count; ++i) {
+			int16_t val;
+			unsigned int offset;
+
+			if (interleaved)
+				offset = i * samples_per_frame + c;
+			else
+				offset = c * frame_count + i;
+
+			if (le)
+				val = (int32_t)le16toh(buf[offset]);
+			else
+				val = (int32_t)be16toh(buf[offset]);
+
+			val = abs(val ^ zero_point);
+			if (val > peak)
+				peak = val;
+		}
+
+		vu->peaks[c] = (uint32_t)peak;
+	}
+}
+
+static void calculate_16bit_sample_vector(struct vumeter_context *vu,
+					  void *frame_buffer,
+					  unsigned int frame_count)
+{
+	int16_t **bufs = frame_buffer;
+	unsigned int samples_per_frame = vu->samples_per_frame;
+	bool le = vu->le;
+	int16_t zero_point = vu->zero_point;
+	int c, i;
+
+	for (c = 0; c < samples_per_frame; ++c) {
+		int16_t *buf = bufs[c];
+		int16_t peak = 0;
+
+		for (i = 0; i < frame_count; ++i) {
+			int16_t val;
+
+			if (le)
+				val = (int16_t)le16toh(buf[i]);
+			else
+				val = (int16_t)be16toh(buf[i]);
+
+			val = abs(val ^ zero_point);
+			if (val > peak)
+				peak = val;
+		}
+
+		vu->peaks[c] = peak;
+	}
+}
+
+static void calculate_24bit_sample_buf(struct vumeter_context *vu,
+				       void *frame_buffer,
+				       unsigned int frame_count)
+{
+	int8_t *buf = frame_buffer;
+	unsigned int samples_per_frame = vu->samples_per_frame;
+	unsigned int bytes_per_sample = vu->bytes_per_sample;
+	bool le = vu->le;
+	bool interleaved = vu->interleaved;
+	int32_t zero_point = vu->zero_point;
+	int c, i;
+
+	for (c = 0; c < samples_per_frame; ++c) {
+		int32_t peak = 0;
+
+		for (i = 0; i < frame_count; ++i) {
+			int32_t val;
+			unsigned int offset;
+
+			if (interleaved)
+				offset = i * bytes_per_sample * samples_per_frame + c;
+			else
+				offset = i + c * bytes_per_sample * frame_count;
+
+			if (le) {
+				val = (int32_t)(((buf[offset] << 8) |
+				      (buf[offset + 1] << 16) |
+				      (buf[offset + 2] << 24)));
+			} else {
+				val = (int32_t)(((buf[offset] << 24) |
+				      (buf[offset + 1] << 16) |
+				      (buf[offset + 2] << 8)));
+			}
+
+			val = abs(val ^ zero_point);
+			if (vu->significant_bits_per_sample == 18)
+				val >>= 14;
+			else if (vu->significant_bits_per_sample == 20)
+				val >>= 12;
+			else
+				val >>= 8;
+			if (val > peak)
+				peak = val;
+		}
+
+		vu->peaks[c] = peak;
+	}
+}
+
+static void calculate_24bit_sample_vector(struct vumeter_context *vu,
+					  void *frame_buffer,
+					  unsigned int frame_count)
+{
+	int8_t **bufs = frame_buffer;
+	unsigned int samples_per_frame = vu->samples_per_frame;
+	unsigned int bytes_per_sample = vu->bytes_per_sample;
+	bool le = vu->le;
+	int32_t zero_point = vu->zero_point;
+	int c, i;
+
+	for (c = 0; c < samples_per_frame; ++c) {
+		int8_t *buf = bufs[c];
+		int32_t peak = 0;
+
+		for (i = 0; i < frame_count; ++i) {
+			int32_t val;
+			unsigned int offset;
+
+			offset = bytes_per_sample * i;
+
+			if (le) {
+				val = (int32_t)((buf[offset] << 8) |
+				      (buf[offset + 1] << 16) |
+				      (buf[offset + 2] << 24));
+			} else {
+				val = (int32_t)((buf[offset] << 24) |
+				      (buf[offset + 1] << 16) |
+				      (buf[offset + 2] << 8));
+			}
+
+			val = abs(val ^ zero_point);
+			if (vu->significant_bits_per_sample == 18)
+				val >>= 14;
+			else if (vu->significant_bits_per_sample == 20)
+				val >>= 12;
+			else
+				val >>= 8;
+			if (val > peak)
+				peak = val;
+		}
+
+		vu->peaks[c] = peak;
+	}
+}
+
+static void calculate_32bit_sample_buf(struct vumeter_context *vu,
+				       void *frame_buffer,
+				       unsigned int frame_count)
+{
+	int32_t *buf = frame_buffer;
+	unsigned int samples_per_frame = vu->samples_per_frame;
+	bool le = vu->le;
+	bool interleaved = vu->interleaved;
+	int32_t zero_point = vu->zero_point;
+	int c, i;
+
+	for (c = 0; c < samples_per_frame; ++c) {
+		int32_t peak = 0;
+
+		for (i = 0; i < frame_count; ++i) {
+			int32_t val;
+			unsigned int offset;
+
+			if (interleaved)
+				offset = i * samples_per_frame + c;
+			else
+				offset = c * frame_count + i;
+
+			if (le)
+				val = (int32_t)le32toh(buf[offset]);
+			else
+				val = (int32_t)be32toh(buf[offset]);
+
+			val = abs(val ^ zero_point);
+			/* For [S/U]24_[B|L]E. */
+			if (vu->significant_bits_per_sample == 24)
+				val >>= 8;
+			if (val > peak)
+				peak = val;
+		}
+
+		vu->peaks[c] = peak;
+	}
+}
+
+static void calculate_32bit_sample_vector(struct vumeter_context *vu,
+					  void *frame_buffer,
+					  unsigned int frame_count)
+{
+	int32_t **bufs = frame_buffer;
+	unsigned int samples_per_frame = vu->samples_per_frame;
+	bool le = vu->le;
+	int32_t zero_point = vu->zero_point;
+	int c, i;
+
+	for (c = 0; c < samples_per_frame; ++c) {
+		int32_t *buf = bufs[c];
+		int32_t peak = 0;
+
+		for (i = 0; i < frame_count; ++i) {
+			int32_t val;
+
+			if (le)
+				val = (int32_t)le32toh(buf[i]);
+			else
+				val = (int32_t)be32toh(buf[i]);
+
+			val = abs(val ^ zero_point);
+			/* For [S/U]24_[B|L]E. */
+			if (vu->significant_bits_per_sample == 24)
+				val >>= 8;
+			if (val > peak)
+				peak = val;
+		}
+
+		vu->peaks[c] = peak;
+	}
+}
+
+static void print_monaural(struct vumeter_context *vu, char line[80])
+{
+	const int bar_len = 50;
+	unsigned int pos;
+
+	/* NOTE: 74 + '| 00%' + '\0' = 80 characters. */
+
+	/* Print peaks on current buffer. */
+	pos = vu->ratios[0] * bar_len / 100;
+	memset(line, '#', pos);
+
+	/* Print maximum peaks within a second. */
+	pos = vu->max_ratios_in_second[0] * bar_len / 100;
+	line[pos] = '+';
+
+	if (vu->max_ratios_in_second[0] > 99) {
+		snprintf(line + bar_len + 1, 80 - bar_len,
+			 "| MAX");
+	} else {
+		snprintf(line + bar_len + 1, 80 - bar_len,
+			 "| %02u%%", vu->max_ratios_in_second[0]);
+	}
+}
+
+static void print_stereo(struct vumeter_context *vu, char line[80])
+{
+	const int bar_length = 35;
+	bool even;
+	int width;
+	char *substr;
+	int c;
+
+	/* NOTE: 35 + ' 00%|00% ' + 35 + '\0' = 80 characters. */
+
+	for (c = 0; c < 2; c++) {
+		even = (c % 2 > 0);
+
+		/* Print peaks on current buffer. */
+		width = vu->ratios[c] * bar_length / 100;
+		if (width > bar_length)
+			width = bar_length;
+		if (even)
+			memset(line + bar_length + 9, '#', width);
+		else
+			memset(line + bar_length - width, '#', width);
+
+		/* Print maximum peaks within a second. */
+		width = vu->max_ratios_in_second[c] * bar_length / 100;
+		if (width > bar_length)
+			width = bar_length;
+		if (even)
+			line[bar_length + 8 + width] = '+';
+		else
+			line[bar_length - width] = '+';
+
+		/* Print numerical value of maximum peaks within a second. */
+		if (even)
+			substr = line + bar_length + 5;
+		else
+			substr = line + bar_length + 1;
+		if (vu->max_ratios_in_second[c] > 99) {
+			snprintf(substr, 4, "MAX");
+		} else {
+			snprintf(substr, 4,
+				 "%02u%%", vu->max_ratios_in_second[c]);
+		}
+		substr[3] = ' ';
+	}
+
+	line[bar_length + 4] = '|';
+}
+
+int vumeter_context_init(struct vumeter_context *vu, enum vumeter_mode mode,
+			 snd_pcm_access_t access, snd_pcm_format_t format,
+			 unsigned int samples_per_frame,
+			 unsigned int frames_per_second)
+{
+	int bits_per_sample;
+
+	/* Just for sample formats of PCM. */
+	if (format != SND_PCM_FORMAT_S8 &&
+	    format != SND_PCM_FORMAT_U8 &&
+	    format != SND_PCM_FORMAT_S16_LE &&
+	    format != SND_PCM_FORMAT_S16_BE &&
+	    format != SND_PCM_FORMAT_U16_LE &&
+	    format != SND_PCM_FORMAT_U16_BE &&
+	    format != SND_PCM_FORMAT_S24_LE &&
+	    format != SND_PCM_FORMAT_S24_BE &&
+	    format != SND_PCM_FORMAT_U24_LE &&
+	    format != SND_PCM_FORMAT_U24_BE &&
+	    format != SND_PCM_FORMAT_S32_LE &&
+	    format != SND_PCM_FORMAT_S32_BE &&
+	    format != SND_PCM_FORMAT_U32_LE &&
+	    format != SND_PCM_FORMAT_U32_BE &&
+	    format != SND_PCM_FORMAT_S24_3LE &&
+	    format != SND_PCM_FORMAT_S24_3BE &&
+	    format != SND_PCM_FORMAT_U24_3LE &&
+	    format != SND_PCM_FORMAT_U24_3BE &&
+	    format != SND_PCM_FORMAT_S24_3LE &&
+	    format != SND_PCM_FORMAT_S24_3BE &&
+	    format != SND_PCM_FORMAT_U24_3LE &&
+	    format != SND_PCM_FORMAT_U24_3BE &&
+	    format != SND_PCM_FORMAT_S20_3LE &&
+	    format != SND_PCM_FORMAT_S20_3BE &&
+	    format != SND_PCM_FORMAT_U20_3LE &&
+	    format != SND_PCM_FORMAT_U20_3BE &&
+	    format != SND_PCM_FORMAT_S18_3LE &&
+	    format != SND_PCM_FORMAT_S18_3BE &&
+	    format != SND_PCM_FORMAT_U18_3LE &&
+	    format != SND_PCM_FORMAT_U18_3BE)
+		return -EINVAL;
+
+	bits_per_sample = snd_pcm_format_physical_width(format);
+	if (access == SND_PCM_ACCESS_RW_NONINTERLEAVED) {
+		if (bits_per_sample == 8)
+			vu->calculator = calculate_8bit_sample_vector;
+		else if (bits_per_sample == 16)
+			vu->calculator = calculate_16bit_sample_vector;
+		else if (bits_per_sample == 24)
+			vu->calculator = calculate_24bit_sample_vector;
+		else if (bits_per_sample == 32)
+			vu->calculator = calculate_32bit_sample_vector;
+		else
+			return -EINVAL;
+		vu->interleaved = false;
+	} else {
+		if (bits_per_sample == 8)
+			vu->calculator = calculate_8bit_sample_buf;
+		else if (bits_per_sample == 16)
+			vu->calculator = calculate_16bit_sample_buf;
+		else if (bits_per_sample == 24)
+			vu->calculator = calculate_24bit_sample_buf;
+		else if (bits_per_sample == 32)
+			vu->calculator = calculate_32bit_sample_buf;
+		else
+			return -EINVAL;
+
+		if (access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED)
+			vu->interleaved = false;
+		else
+			vu->interleaved = true;
+	}
+	vu->bytes_per_sample = bits_per_sample / 8;
+
+	vu->peaks = calloc(samples_per_frame, sizeof(*vu->peaks));
+	if (vu->peaks == NULL)
+		return -ENOMEM;
+	vu->samples_per_frame = samples_per_frame;
+	vu->frames_per_second = frames_per_second;
+
+	if (mode == VUMETER_MODE_MONO || samples_per_frame == 1)
+		vu->printer = print_monaural;
+	else if (mode == VUMETER_MODE_STEREO)
+		vu->printer = print_stereo;
+	else
+		return -EINVAL;
+	vu->mode = mode;
+
+	vu->ratios = calloc(samples_per_frame, sizeof(*vu->ratios));
+	if (vu->ratios == NULL)
+		return -ENOMEM;
+	vu->max_ratios_in_second = calloc(samples_per_frame,
+					  sizeof(*vu->max_ratios_in_second));
+	if (vu->max_ratios_in_second == NULL)
+		return -ENOMEM;
+
+	vu->significant_bits_per_sample = snd_pcm_format_width(format);
+	vu->max = (1 << (vu->significant_bits_per_sample - 1)) - 1;
+
+	vu->le = !!snd_pcm_format_little_endian(format);
+	vu->zero_point = snd_pcm_format_silence_64(format);
+	/* For these sample formats, use 32bit width storage temporarily. */
+	if (vu->significant_bits_per_sample == 18)
+		vu->zero_point <<= 14;
+	if (vu->significant_bits_per_sample == 20)
+		vu->zero_point <<= 12;
+	if (vu->significant_bits_per_sample == 24)
+		vu->zero_point <<= 8;
+
+	return 0;
+}
+
+void vumeter_context_prepare(struct vumeter_context *vu)
+{
+	int c;
+
+	for (c = 0; c < vu->samples_per_frame; ++c) {
+		vu->ratios[c] = 0;
+		vu->max_ratios_in_second[c] = 0;
+	}
+	vu->total_frame_count = 0;
+}
+
+void vumeter_context_calculate(struct vumeter_context *vu, void *frame_buffer,
+			       unsigned int frame_count)
+{
+	int64_t val;
+	unsigned int ratio;
+	int c;
+
+	vu->calculator(vu, frame_buffer, frame_count);
+
+	vu->total_frame_count += frame_count;
+
+	for (c = 0; c < vu->samples_per_frame; ++c) {
+		val = (int64_t)vu->peaks[c];
+	        ratio = val * 100 / vu->max;
+
+		/* Reset ratios every second. */
+		if (vu->total_frame_count >= vu->frames_per_second)
+			vu->max_ratios_in_second[c] = 0;
+		if (ratio > vu->max_ratios_in_second[c])
+			vu->max_ratios_in_second[c] = ratio;
+
+		vu->ratios[c] = ratio;
+	}
+
+	vu->total_frame_count %= vu->frames_per_second;
+}
+
+void vumeter_context_print(struct vumeter_context *vu)
+{
+	char line[80];
+
+	memset(line, ' ', 79);
+
+	putc('\r', stderr);
+
+	vu->printer(vu, line);
+
+	line[79] = '\0';
+	fputs(line, stderr);
+	fflush(stderr);
+}
+
+void vumeter_context_break(struct vumeter_context *vu)
+{
+	fprintf(stderr, "\r");
+}
+
+void vumeter_context_destroy(struct vumeter_context *vu)
+{
+	if (vu->ratios)
+		free(vu->ratios);
+	vu->ratios = NULL;
+
+	if (vu->max_ratios_in_second)
+		free(vu->max_ratios_in_second);
+	vu->max_ratios_in_second = NULL;
+
+	if (vu->peaks)
+		free(vu->peaks);
+	vu->peaks = NULL;
+}
diff --git a/axfer/vumeter.h b/axfer/vumeter.h
new file mode 100644
index 00000000..ae6d45bd
--- /dev/null
+++ b/axfer/vumeter.h
@@ -0,0 +1,56 @@
+/*
+ * vumeter.h - Volume Unit meter.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef __ALSA_UTILS_AXFER_VUMETER__H_
+#define __ALSA_UTILS_AXFER_VUMETER__H_
+
+#include <stdbool.h>
+#include <stdint.h>
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
+
+	bool le;
+	bool interleaved;
+	unsigned int significant_bits_per_sample;
+	unsigned int bytes_per_sample;
+	unsigned int samples_per_frame;
+	unsigned int frames_per_second;
+
+	int64_t zero_point;
+	uint32_t max;
+	int32_t *peaks;
+
+	unsigned int *ratios;
+	unsigned int *max_ratios_in_second;
+	uint64_t total_frame_count;
+
+	void (*printer)(struct vumeter_context *vu, char line[80]);
+	void (*calculator)(struct vumeter_context *vu, void *frame_buffer,
+			   unsigned int frame_count);
+};
+
+int vumeter_context_init(struct vumeter_context *vu, enum vumeter_mode mode,
+			 snd_pcm_access_t access, snd_pcm_format_t format,
+			 unsigned int samples_per_frame,
+			 unsigned int frames_per_second);
+void vumeter_context_prepare(struct vumeter_context *vu);
+void vumeter_context_calculate(struct vumeter_context *vu, void *frame_buffer,
+			       unsigned int frame_count);
+void vumeter_context_print(struct vumeter_context *vu);
+void vumeter_context_break(struct vumeter_context *vu);
+void vumeter_context_destroy(struct vumeter_context *vu);
+
+#endif
diff --git a/axfer/xfer-libasound-irq-mmap.c b/axfer/xfer-libasound-irq-mmap.c
index a892642f..6074c4a3 100644
--- a/axfer/xfer-libasound-irq-mmap.c
+++ b/axfer/xfer-libasound-irq-mmap.c
@@ -64,7 +64,8 @@ static int irq_mmap_pre_process(struct libasound_state *state)
 static int irq_mmap_process_frames(struct libasound_state *state,
 				   unsigned int *frame_count,
 				   struct mapper_context *mapper,
-				   struct container_context *cntrs)
+				   struct container_context *cntrs,
+				   struct vumeter_context *vu)
 {
 	struct map_layout *layout = state->private_data;
 	const snd_pcm_channel_area_t *areas;
@@ -126,6 +127,9 @@ static int irq_mmap_process_frames(struct libasound_state *state,
 	if (consumed_count != avail_count)
 		logging(state, "A bug of access plugin for this PCM node.\n");
 
+	if (vu)
+		vumeter_context_calculate(vu, frame_buf, consumed_count);
+
 	*frame_count = consumed_count;
 
 	return 0;
@@ -137,7 +141,8 @@ error:
 static int irq_mmap_r_process_frames(struct libasound_state *state,
 				     unsigned *frame_count,
 				     struct mapper_context *mapper,
-				     struct container_context *cntrs)
+				     struct container_context *cntrs,
+				     struct vumeter_context *vu)
 {
 	int err;
 
@@ -154,7 +159,7 @@ static int irq_mmap_r_process_frames(struct libasound_state *state,
 			goto error;
 	}
 
-	err = irq_mmap_process_frames(state, frame_count, mapper, cntrs);
+	err = irq_mmap_process_frames(state, frame_count, mapper, cntrs, vu);
 	if (err < 0)
 		goto error;
 
@@ -167,11 +172,12 @@ error:
 static int irq_mmap_w_process_frames(struct libasound_state *state,
 				     unsigned *frame_count,
 				     struct mapper_context *mapper,
-				     struct container_context *cntrs)
+				     struct container_context *cntrs,
+				     struct vumeter_context *vu)
 {
 	int err;
 
-	err = irq_mmap_process_frames(state, frame_count, mapper, cntrs);
+	err = irq_mmap_process_frames(state, frame_count, mapper, cntrs, vu);
 	if (err < 0)
 		goto error;
 
diff --git a/axfer/xfer-libasound-irq-rw.c b/axfer/xfer-libasound-irq-rw.c
index 26db75d6..89cacbc3 100644
--- a/axfer/xfer-libasound-irq-rw.c
+++ b/axfer/xfer-libasound-irq-rw.c
@@ -20,7 +20,8 @@ struct frame_cache {
 
 	int (*handle)(struct libasound_state *state, snd_pcm_state_t status,
 		      unsigned int *frame_count, struct mapper_context *mapper,
-		      struct container_context *cntrs);
+		      struct container_context *cntrs,
+		      struct vumeter_context *vu);
 	void (*align_frames)(struct frame_cache *cache,
 			     unsigned int consumed_count,
 			     unsigned int bytes_per_sample,
@@ -73,7 +74,8 @@ static void align_frames_in_n(struct frame_cache *cache,
 
 static int read_frames(struct libasound_state *state, unsigned int *frame_count,
 		       unsigned int avail_count, struct mapper_context *mapper,
-		       struct container_context *cntrs)
+		       struct container_context *cntrs,
+		       struct vumeter_context *vu)
 {
 	struct frame_cache *cache = state->private_data;
 	unsigned int consumed_count;
@@ -111,6 +113,9 @@ static int read_frames(struct libasound_state *state, unsigned int *frame_count,
 	if (err < 0)
 		return err;
 
+	if (vu)
+		vumeter_context_calculate(vu, cache->buf, consumed_count);
+
 	cache->align_frames(cache, consumed_count, cache->bytes_per_sample,
 			    cache->samples_per_frame);
 
@@ -123,7 +128,8 @@ static int r_process_frames_blocking(struct libasound_state *state,
 				     snd_pcm_state_t status,
 				     unsigned int *frame_count,
 				     struct mapper_context *mapper,
-				     struct container_context *cntrs)
+				     struct container_context *cntrs,
+				     struct vumeter_context *vu)
 {
 	snd_pcm_sframes_t avail;
 	snd_pcm_uframes_t avail_count;
@@ -159,7 +165,7 @@ static int r_process_frames_blocking(struct libasound_state *state,
 		avail_count = (unsigned int)frame_count;
 	}
 
-	err = read_frames(state, frame_count, avail_count, mapper, cntrs);
+	err = read_frames(state, frame_count, avail_count, mapper, cntrs, vu);
 	if (err < 0)
 		goto error;
 
@@ -173,7 +179,8 @@ static int r_process_frames_nonblocking(struct libasound_state *state,
 					snd_pcm_state_t status,
 					unsigned int *frame_count,
 					struct mapper_context *mapper,
-					struct container_context *cntrs)
+					struct container_context *cntrs,
+					struct vumeter_context *vu)
 {
 	snd_pcm_sframes_t avail;
 	snd_pcm_uframes_t avail_count;
@@ -205,7 +212,7 @@ static int r_process_frames_nonblocking(struct libasound_state *state,
 		goto error;
 	}
 
-	err = read_frames(state, frame_count, avail_count, mapper, cntrs);
+	err = read_frames(state, frame_count, avail_count, mapper, cntrs, vu);
 	if (err < 0)
 		goto error;
 
@@ -218,7 +225,8 @@ error:
 static int write_frames(struct libasound_state *state,
 			unsigned int *frame_count, unsigned int avail_count,
 			struct mapper_context *mapper,
-			struct container_context *cntrs)
+			struct container_context *cntrs,
+			struct vumeter_context *vu)
 {
 	struct frame_cache *cache = state->private_data;
 	snd_pcm_uframes_t consumed_count;
@@ -253,6 +261,9 @@ static int write_frames(struct libasound_state *state,
 	if (err < 0)
 		return err;
 
+	if (vu)
+		vumeter_context_calculate(vu, cache->buf, consumed_count);
+
 	consumed_count = (unsigned int)err;
 	cache->align_frames(cache, consumed_count, cache->bytes_per_sample,
 			    cache->samples_per_frame);
@@ -266,7 +277,8 @@ static int w_process_frames_blocking(struct libasound_state *state,
 				     snd_pcm_state_t status,
 				     unsigned int *frame_count,
 				     struct mapper_context *mapper,
-				     struct container_context *cntrs)
+				     struct container_context *cntrs,
+				     struct vumeter_context *vu)
 {
 	snd_pcm_sframes_t avail;
 	unsigned int avail_count;
@@ -322,7 +334,7 @@ static int w_process_frames_blocking(struct libasound_state *state,
 			avail_count = (unsigned int)frames_per_period;
 	}
 
-	err = write_frames(state, frame_count, avail_count, mapper, cntrs);
+	err = write_frames(state, frame_count, avail_count, mapper, cntrs, vu);
 	if (err < 0)
 		goto error;
 
@@ -336,7 +348,8 @@ static int w_process_frames_nonblocking(struct libasound_state *state,
 					snd_pcm_state_t status,
 					unsigned int *frame_count,
 					struct mapper_context *mapper,
-					struct container_context *cntrs)
+					struct container_context *cntrs,
+					struct vumeter_context *vu)
 {
 	snd_pcm_sframes_t avail;
 	unsigned int avail_count;
@@ -362,7 +375,7 @@ static int w_process_frames_nonblocking(struct libasound_state *state,
 		goto error;
 	}
 
-	err = write_frames(state, frame_count, avail_count, mapper, cntrs);
+	err = write_frames(state, frame_count, avail_count, mapper, cntrs, vu);
 	if (err < 0)
 		goto error;
 
@@ -459,7 +472,8 @@ static int irq_rw_pre_process(struct libasound_state *state)
 static int irq_rw_process_frames(struct libasound_state *state,
 				unsigned int *frame_count,
 				struct mapper_context *mapper,
-				struct container_context *cntrs)
+				struct container_context *cntrs,
+				struct vumeter_context *vu)
 {
 	struct frame_cache *cache = state->private_data;
 	snd_pcm_state_t status;
@@ -470,7 +484,7 @@ static int irq_rw_process_frames(struct libasound_state *state,
 		return -EPIPE;
 
 	/* NOTE: Actually, status can be shift always. */
-	return cache->handle(state, status, frame_count, mapper, cntrs);
+	return cache->handle(state, status, frame_count, mapper, cntrs, vu);
 }
 
 static void irq_rw_post_process(struct libasound_state *state)
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 488d5a60..77131a7e 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -508,7 +508,8 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 static int xfer_libasound_process_frames(struct xfer_context *xfer,
 					 unsigned int *frame_count,
 					 struct mapper_context *mapper,
-					 struct container_context *cntrs)
+					 struct container_context *cntrs,
+					 struct vumeter_context *vu)
 {
 	struct libasound_state *state = xfer->private_data;
 	int err;
@@ -516,7 +517,7 @@ static int xfer_libasound_process_frames(struct xfer_context *xfer,
 	if (state->handle == NULL)
 		return -ENXIO;
 
-	err = state->ops->process_frames(state, frame_count, mapper, cntrs);
+	err = state->ops->process_frames(state, frame_count, mapper, cntrs, vu);
 	if (err < 0) {
 		if (err == -EPIPE && !state->finish_at_xrun) {
 			/*
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index db85e604..7214ebbf 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -41,7 +41,8 @@ struct xfer_libasound_ops {
 	int (*process_frames)(struct libasound_state *state,
 			      unsigned int *frame_count,
 			      struct mapper_context *mapper,
-			      struct container_context *cntrs);
+			      struct container_context *cntrs,
+			      struct vumeter_context *vu);
 	void (*post_process)(struct libasound_state *state);
 	unsigned int private_size;
 };
diff --git a/axfer/xfer.c b/axfer/xfer.c
index d004abf9..bdb9517c 100644
--- a/axfer/xfer.c
+++ b/axfer/xfer.c
@@ -47,6 +47,14 @@ int xfer_context_init(struct xfer_context *xfer, enum xfer_type type,
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
 
@@ -61,6 +69,10 @@ void xfer_context_destroy(struct xfer_context *xfer)
 		xfer->ops->destroy(xfer);
 	if (xfer->private_data)
 		free(xfer->private_data);
+
+	if (xfer->vu)
+		free(xfer->vu);
+	xfer->vu = NULL;
 }
 
 int xfer_context_pre_process(struct xfer_context *xfer,
@@ -97,6 +109,16 @@ int xfer_context_pre_process(struct xfer_context *xfer,
 	assert(*access <= SND_PCM_ACCESS_LAST);
 	assert(*frames_per_buffer > 0);
 
+	if (xfer->vu) {
+		err = vumeter_context_init(xfer->vu, xfer->vu->mode, *access,
+					   *format, *samples_per_frame,
+					   *frames_per_second);
+		if (err < 0)
+			return err;
+
+		vumeter_context_prepare(xfer->vu);
+	}
+
 	if (xfer->verbose > 0) {
 		fprintf(stderr, "Transfer: %s\n",
 			xfer_type_labels[xfer->type]);
@@ -122,6 +144,8 @@ int xfer_context_process_frames(struct xfer_context *xfer,
 				struct container_context *cntrs,
 				unsigned int *frame_count)
 {
+	int err;
+
 	assert(xfer);
 	assert(mapper);
 	assert(cntrs);
@@ -130,7 +154,15 @@ int xfer_context_process_frames(struct xfer_context *xfer,
 	if (!xfer->ops)
 		return -ENXIO;
 
-	return xfer->ops->process_frames(xfer, frame_count, mapper, cntrs);
+	err = xfer->ops->process_frames(xfer, frame_count, mapper, cntrs,
+					xfer->vu);
+	if (err < 0)
+		return err;
+
+	if (xfer->vu)
+		vumeter_context_print(xfer->vu);
+
+	return 0;
 }
 
 void xfer_context_pause(struct xfer_context *xfer, bool enable)
@@ -151,4 +183,9 @@ void xfer_context_post_process(struct xfer_context *xfer)
 		return;
 
 	xfer->ops->post_process(xfer);
+
+	if (xfer->vu) {
+		vumeter_context_break(xfer->vu);
+		vumeter_context_destroy(xfer->vu);
+	}
 }
diff --git a/axfer/xfer.h b/axfer/xfer.h
index 167c9903..eccf042c 100644
--- a/axfer/xfer.h
+++ b/axfer/xfer.h
@@ -23,6 +23,8 @@ struct xfer_context  {
 	const struct xfer_ops *ops;
 	void *private_data;
 
+	struct vumeter_context *vu;
+
 	unsigned int verbose;
 };
 
@@ -57,7 +59,8 @@ struct xfer_ops {
 	int (*process_frames)(struct xfer_context *xfer,
 			      unsigned int *frame_count,
 			      struct mapper_context *mapper,
-			      struct container_context *cntrs);
+			      struct container_context *cntrs,
+			      struct vumeter_context *vu);
 	void (*post_process)(struct xfer_context *xfer);
 	void (*destroy)(struct xfer_context *xfer);
 	void (*pause)(struct xfer_context *xfer, bool enable);
-- 
2.11.0
