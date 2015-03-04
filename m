From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [ALSA-UTILS][PATCH] Add support for cplay and crecord
Date: Wed, 4 Mar 2015 15:36:00 +0000
Message-ID: <1425483360-1806-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 33ECD26508C
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 16:36:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Qais Yousef <qais.yousef@imgtec.com>
List-Id: alsa-devel@alsa-project.org

cplay and crecord use compress offload API to play and record compressed audio.

They're based on cplay and crec from tinycompress library using LGPL license.

For now cplay only supports playing mp3 files.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Mark Brown <broonie@kernel.org>
---
I renamed crec to crecord also to match aplay and arecord, hopefully
you don't mind Vinod.

This patch is dependent on my other patch that adds support for compress offload
to alsa-lib.

I needed to include <sound/compress_params.h> in cplay.c and crec.c
but I couldn't find an example of any C file which directly includes <sound/*.h>
The norm seems to be to just include <alsa/asoundlib.h>. Do I need to
redefine structs from <sound/compress_params.h> to newly added <alsa/compress.h>?
<alsa/pcm.h> seems to redefine structs from <sound/asound.h>.

I could only test cplay but have no means to test crecord at the moment.

 Makefile.am       |   3 +
 configure.ac      |   6 +-
 cplay/Makefile.am |  14 ++
 cplay/cplay.c     | 294 +++++++++++++++++++++++++++++++++++
 cplay/crec.c      | 449 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cplay/tinymp3.h   |  72 +++++++++
 6 files changed, 837 insertions(+), 1 deletion(-)
 create mode 100644 cplay/Makefile.am
 create mode 100644 cplay/cplay.c
 create mode 100644 cplay/crec.c
 create mode 100644 cplay/tinymp3.h

diff --git a/Makefile.am b/Makefile.am
index 5bbe588a8d84..0842657530fd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -19,6 +19,9 @@ if ALSALOOP
 SUBDIRS += alsaloop
 endif
 endif
+if HAVE_COMPRESS
+SUBDIRS += cplay
+endif
 if HAVE_SEQ
 SUBDIRS += seq
 endif
diff --git a/configure.ac b/configure.ac
index f09aa5484d1d..c08c24b90658 100644
--- a/configure.ac
+++ b/configure.ac
@@ -42,6 +42,8 @@ fi
 dnl Check components
 AC_CHECK_HEADERS([alsa/pcm.h], [have_pcm="yes"], [have_pcm="no"],
   [#include <alsa/asoundlib.h>])
+AC_CHECK_HEADERS([alsa/compress.h], [have_compress="yes"], [have_compress="no"],
+  [#include <alsa/asoundlib.h>])
 AC_CHECK_HEADERS([alsa/mixer.h], [have_mixer="yes"], [have_mixer="no"],
   [#include <alsa/asoundlib.h>])
 AC_CHECK_HEADERS([alsa/rawmidi.h], [have_rawmidi="yes"], [have_rawmidi="no"],
@@ -54,6 +56,7 @@ AC_CHECK_HEADERS([samplerate.h], [have_samplerate="yes"], [have_samplerate="no"]
   [#include <samplerate.h>])
 
 AM_CONDITIONAL(HAVE_PCM, test "$have_pcm" = "yes")
+AM_CONDITIONAL(HAVE_COMPRESS, test "$have_compress" = "yes")
 AM_CONDITIONAL(HAVE_MIXER, test "$have_mixer" = "yes")
 AM_CONDITIONAL(HAVE_RAWMIDI, test "$have_rawmidi" = "yes")
 AM_CONDITIONAL(HAVE_SEQ, test "$have_seq" = "yes")
@@ -359,7 +362,8 @@ AC_OUTPUT(Makefile alsactl/Makefile alsactl/init/Makefile \
 	  alsaconf/alsaconf alsaconf/Makefile \
 	  alsaconf/po/Makefile \
 	  alsaucm/Makefile \
-	  aplay/Makefile include/Makefile iecset/Makefile utils/Makefile \
+	  aplay/Makefile cplay/Makefile \
+	  include/Makefile iecset/Makefile utils/Makefile \
 	  utils/alsa-utils.spec seq/Makefile seq/aconnect/Makefile \
 	  seq/aplaymidi/Makefile seq/aseqdump/Makefile seq/aseqnet/Makefile \
 	  speaker-test/Makefile speaker-test/samples/Makefile \
diff --git a/cplay/Makefile.am b/cplay/Makefile.am
new file mode 100644
index 000000000000..bcb1bfce7a2d
--- /dev/null
+++ b/cplay/Makefile.am
@@ -0,0 +1,14 @@
+LIBRT = @LIBRT@
+
+AM_CPPFLAGS = -I$(top_srcdir)/include
+LDADD = $(LIBINTL) $(LIBRT)
+
+# debug flags
+#LDFLAGS = -static
+#LDADD += -ldl
+
+bin_PROGRAMS = cplay crecord
+noinst_HEADERS = tinymp3.h
+
+cplay_SOURCES = cplay.c
+crecord_SOURCES = crec.c
diff --git a/cplay/cplay.c b/cplay/cplay.c
new file mode 100644
index 000000000000..a017394e5b4f
--- /dev/null
+++ b/cplay/cplay.c
@@ -0,0 +1,294 @@
+/*
+ * tinyplay command line player for compress audio offload in alsa
+ * Copyright (c) 2011-2012, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU Lesser General Public License,
+ * version 2.1, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
+ * License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with this program; if not, write to
+ * the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <stdint.h>
+#include <linux/types.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <getopt.h>
+#include <sys/time.h>
+#include <alsa/asoundlib.h>
+#include <sound/compress_params.h>
+
+#include "tinymp3.h"
+
+static int verbose;
+
+static void usage(void)
+{
+	fprintf(stderr, "usage: cplay [OPTIONS] filename\n"
+		"-c\tcard number\n"
+		"-d\tdevice node\n"
+		"-b\tbuffer size\n"
+		"-f\tfragments\n\n"
+		"-v\tverbose mode\n"
+		"-h\tPrints this help list\n\n"
+		"Example:\n"
+		"\tcplay -c 1 -d 2 test.mp3\n"
+		"\tcplay -f 5 test.mp3\n");
+
+	exit(EXIT_FAILURE);
+}
+
+void play_samples(char *name, unsigned int card, unsigned int device,
+		unsigned long buffer_size, unsigned int frag);
+
+struct mp3_header {
+	uint16_t sync;
+	uint8_t format1;
+	uint8_t format2;
+};
+
+int parse_mp3_header(struct mp3_header *header, unsigned int *num_channels,
+		unsigned int *sample_rate, unsigned int *bit_rate)
+{
+	int ver_idx, mp3_version, layer, bit_rate_idx, sample_rate_idx, channel_idx;
+
+	/* check sync bits */
+	if ((header->sync & MP3_SYNC) != MP3_SYNC) {
+		fprintf(stderr, "Error: Can't find sync word\n");
+		return -1;
+	}
+	ver_idx = (header->sync >> 11) & 0x03;
+	mp3_version = ver_idx == 0 ? MPEG25 : ((ver_idx & 0x1) ? MPEG1 : MPEG2);
+	layer = 4 - ((header->sync >> 9) & 0x03);
+	bit_rate_idx = ((header->format1 >> 4) & 0x0f);
+	sample_rate_idx = ((header->format1 >> 2) & 0x03);
+	channel_idx = ((header->format2 >> 6) & 0x03);
+
+	if (sample_rate_idx == 3 || layer == 4 || bit_rate_idx == 15) {
+		fprintf(stderr, "Error: Can't find valid header\n");
+		return -1;
+	}
+	*num_channels = (channel_idx == MONO ? 1 : 2);
+	*sample_rate = mp3_sample_rates[mp3_version][sample_rate_idx];
+	*bit_rate = (mp3_bit_rates[mp3_version][layer - 1][bit_rate_idx]) * 1000;
+	if (verbose)
+		printf("%s: exit\n", __func__);
+	return 0;
+}
+
+int check_codec_format_supported(unsigned int card, unsigned int device, struct snd_codec *codec)
+{
+	if (snd_compr_is_codec_supported(card, device, COMPRESS_IN, codec) == false) {
+		fprintf(stderr, "Error: This codec or format is not supported by DSP\n");
+		return -1;
+	}
+	return 0;
+}
+
+static int print_time(struct snd_compr *compress)
+{
+	unsigned int avail;
+	struct timespec tstamp;
+
+	if (snd_compr_get_hpointer(compress, &avail, &tstamp) != 0) {
+		fprintf(stderr, "Error querying timestamp\n");
+		fprintf(stderr, "ERR: %s\n", snd_compr_get_error(compress));
+		return -1;
+	} else
+		fprintf(stderr, "DSP played %jd.%jd\n", (intmax_t)tstamp.tv_sec, (intmax_t)tstamp.tv_nsec*1000);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	char *file;
+	unsigned long buffer_size = 0;
+	int c;
+	unsigned int card = 0, device = 0, frag = 0;
+
+
+	if (argc < 2)
+		usage();
+
+	verbose = 0;
+	while ((c = getopt(argc, argv, "hvb:f:c:d:")) != -1) {
+		switch (c) {
+		case 'h':
+			usage();
+			break;
+		case 'b':
+			buffer_size = strtol(optarg, NULL, 0);
+			break;
+		case 'f':
+			frag = strtol(optarg, NULL, 10);
+			break;
+		case 'c':
+			card = strtol(optarg, NULL, 10);
+			break;
+		case 'd':
+			device = strtol(optarg, NULL, 10);
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+		default:
+			exit(EXIT_FAILURE);
+		}
+	}
+	if (optind >= argc)
+		usage();
+
+	file = argv[optind];
+
+	play_samples(file, card, device, buffer_size, frag);
+
+	fprintf(stderr, "Finish Playing.... Close Normally\n");
+	exit(EXIT_SUCCESS);
+}
+
+void play_samples(char *name, unsigned int card, unsigned int device,
+		unsigned long buffer_size, unsigned int frag)
+{
+	struct snd_compr_config config;
+	struct snd_codec codec;
+	struct snd_compr *compress;
+	struct mp3_header header;
+	FILE *file;
+	char *buffer;
+	int size, num_read, wrote;
+	unsigned int channels, rate, bits;
+
+	if (verbose)
+		printf("%s: entry\n", __func__);
+	file = fopen(name, "rb");
+	if (!file) {
+		fprintf(stderr, "Unable to open file '%s'\n", name);
+		exit(EXIT_FAILURE);
+	}
+
+	fread(&header, sizeof(header), 1, file);
+
+	if (parse_mp3_header(&header, &channels, &rate, &bits) == -1) {
+		fclose(file);
+		exit(EXIT_FAILURE);
+	}
+
+	codec.id = SND_AUDIOCODEC_MP3;
+	codec.ch_in = channels;
+	codec.ch_out = channels;
+	codec.sample_rate = rate;
+	if (!codec.sample_rate) {
+		fprintf(stderr, "invalid sample rate %d\n", rate);
+		fclose(file);
+		exit(EXIT_FAILURE);
+	}
+	codec.bit_rate = bits;
+	codec.rate_control = 0;
+	codec.profile = 0;
+	codec.level = 0;
+	codec.ch_mode = 0;
+	codec.format = 0;
+	if ((buffer_size != 0) && (frag != 0)) {
+		config.fragment_size = buffer_size/frag;
+		config.fragments = frag;
+	} else {
+		/* use driver defaults */
+		config.fragment_size = 0;
+		config.fragments = 0;
+	}
+	config.codec = &codec;
+
+	compress = snd_compr_open(card, device, COMPRESS_IN, &config);
+	if (!compress || !snd_compr_is_ready(compress)) {
+		fprintf(stderr, "Unable to open Compress device %d:%d\n",
+				card, device);
+		fprintf(stderr, "ERR: %s\n", snd_compr_get_error(compress));
+		goto FILE_EXIT;
+	};
+	if (verbose)
+		printf("%s: Opened compress device\n", __func__);
+	size = config.fragment_size;
+	buffer = malloc(size * config.fragments);
+	if (!buffer) {
+		fprintf(stderr, "Unable to allocate %d bytes\n", size);
+		goto COMP_EXIT;
+	}
+
+	/* we will write frag fragment_size and then start */
+	num_read = fread(buffer, 1, size * config.fragments, file);
+	if (num_read > 0) {
+		if (verbose)
+			printf("%s: Doing first buffer write of %d\n", __func__, num_read);
+		wrote = snd_compr_write(compress, buffer, num_read);
+		if (wrote < 0) {
+			fprintf(stderr, "Error %d playing sample\n", wrote);
+			fprintf(stderr, "ERR: %s\n", snd_compr_get_error(compress));
+			goto BUF_EXIT;
+		}
+		if (wrote != num_read) {
+			/* TODO: Buufer pointer needs to be set here */
+			fprintf(stderr, "We wrote %d, DSP accepted %d\n", num_read, wrote);
+		}
+	}
+	printf("Playing file %s On Card %u device %u, with buffer of %lu bytes\n",
+			name, card, device, buffer_size);
+	printf("Format %u Channels %u, %u Hz, Bit Rate %d\n",
+			SND_AUDIOCODEC_MP3, channels, rate, bits);
+
+	snd_compr_start(compress);
+	if (verbose)
+		printf("%s: You should hear audio NOW!!!\n", __func__);
+
+	do {
+		num_read = fread(buffer, 1, size, file);
+		if (num_read > 0) {
+			wrote = snd_compr_write(compress, buffer, num_read);
+			if (wrote < 0) {
+				fprintf(stderr, "Error playing sample\n");
+				fprintf(stderr, "ERR: %s\n", snd_compr_get_error(compress));
+				goto BUF_EXIT;
+			}
+			if (wrote != num_read) {
+				/* TODO: Buffer pointer needs to be set here */
+				fprintf(stderr, "We wrote %d, DSP accepted %d\n", num_read, wrote);
+			}
+			if (verbose) {
+				print_time(compress);
+				printf("%s: wrote %d\n", __func__, wrote);
+			}
+		}
+	} while (num_read > 0);
+
+	if (verbose)
+		printf("%s: exit success\n", __func__);
+	/* issue drain if it supports */
+	snd_compr_drain(compress);
+	free(buffer);
+	fclose(file);
+	snd_compr_close(compress);
+	return;
+BUF_EXIT:
+	free(buffer);
+COMP_EXIT:
+	snd_compr_close(compress);
+FILE_EXIT:
+	fclose(file);
+	if (verbose)
+		printf("%s: exit failure\n", __func__);
+	exit(EXIT_FAILURE);
+}
+
diff --git a/cplay/crec.c b/cplay/crec.c
new file mode 100644
index 000000000000..6a3b4a260ceb
--- /dev/null
+++ b/cplay/crec.c
@@ -0,0 +1,449 @@
+/*
+ * crec command line recorder for compress audio record in alsa
+ * Copyright (c) 2011-2012, Intel Corporation
+ * Copyright (c) 2013-2014, Wolfson Microelectronic Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU Lesser General Public License,
+ * version 2.1, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
+ * License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with this program; if not, write to
+ * the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <stdint.h>
+#include <linux/types.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <getopt.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <alsa/asoundlib.h>
+#include <sound/compress_params.h>
+
+static int verbose;
+static int file;
+static FILE *finfo;
+static bool streamed;
+
+static const unsigned int DEFAULT_CHANNELS = 1;
+static const unsigned int DEFAULT_RATE = 44100;
+static const unsigned int DEFAULT_FORMAT = SND_PCM_FORMAT_S16_LE;
+
+struct riff_chunk {
+	char desc[4];
+	uint32_t size;
+} __attribute__((__packed__));
+
+struct wave_header {
+	struct {
+		struct riff_chunk chunk;
+		char format[4];
+	} __attribute__((__packed__)) riff;
+
+	struct {
+		struct riff_chunk chunk;
+		uint16_t type;
+		uint16_t channels;
+		uint32_t rate;
+		uint32_t byterate;
+		uint16_t blockalign;
+		uint16_t samplebits;
+	} __attribute__((__packed__)) fmt;
+
+	struct {
+		struct riff_chunk chunk;
+	} __attribute__((__packed__)) data;
+} __attribute__((__packed__));
+
+const struct wave_header blank_wave_header = {
+	.riff = {
+		.chunk = {
+			.desc = "RIFF",
+		},
+		.format = "WAVE",
+	},
+	.fmt = {
+		.chunk = {
+			.desc = "fmt ", /* Note the space is important here */
+			.size = sizeof(blank_wave_header.fmt) -
+				sizeof(blank_wave_header.fmt.chunk),
+		},
+		.type = 0x01,   /* PCM */
+	},
+	.data = {
+		.chunk = {
+			.desc = "data",
+		},
+	},
+};
+
+static void init_wave_header(struct wave_header *header, uint16_t channels,
+			     uint32_t rate, uint16_t samplebits)
+{
+	memcpy(header, &blank_wave_header, sizeof(blank_wave_header));
+
+	header->fmt.channels = channels;
+	header->fmt.rate = rate;
+	header->fmt.byterate = channels * rate * (samplebits / 8);
+	header->fmt.blockalign = channels * (samplebits / 8);
+	header->fmt.samplebits = samplebits;
+}
+
+static void size_wave_header(struct wave_header *header, uint32_t size)
+{
+	header->riff.chunk.size = sizeof(*header) -
+				  sizeof(header->riff.chunk) + size;
+	header->data.chunk.size = size;
+}
+
+static void usage(void)
+{
+	fprintf(stderr, "usage: crecord [OPTIONS] [filename]\n"
+		"-c\tcard number\n"
+		"-d\tdevice node\n"
+		"-b\tbuffer size\n"
+		"-f\tfragments\n"
+		"-v\tverbose mode\n"
+		"-l\tlength of record in seconds\n"
+		"-h\tPrints this help list\n\n"
+		"-C\tSpecify the number of channels (default %u)\n"
+		"-R\tSpecify the sample rate (default %u)\n"
+		"-F\tSpecify the format: S16_LE, S32_LE (default S16_LE)\n\n"
+		"If filename is not given the output is\n"
+		"written to stdout\n\n"
+		"Example:\n"
+		"\tcrec -c 1 -d 2 test.wav\n"
+		"\tcrec -f 5 test.wav\n",
+		DEFAULT_CHANNELS, DEFAULT_RATE);
+
+	exit(EXIT_FAILURE);
+}
+
+static int print_time(struct snd_compr *compress)
+{
+	unsigned int avail;
+	struct timespec tstamp;
+
+	if (snd_compr_get_hpointer(compress, &avail, &tstamp) != 0) {
+		fprintf(stderr, "Error querying timestamp\n");
+		fprintf(stderr, "ERR: %s\n", snd_compr_get_error(compress));
+		return -1;
+	} else {
+		fprintf(finfo, "DSP recorded %jd.%jd\n",
+		       (intmax_t)tstamp.tv_sec, (intmax_t)tstamp.tv_nsec*1000);
+	}
+	return 0;
+}
+
+static int finish_record()
+{
+	struct wave_header header;
+	int ret;
+	size_t nread, written;
+
+	if (!file)
+		return -ENOENT;
+
+	/* can't rewind if streaming to stdout */
+	if (streamed)
+		return 0;
+
+	/* Get amount of data written to file */
+	ret = lseek(file, 0, SEEK_END);
+	if (ret < 0)
+		return -errno;
+
+	written = ret;
+	if (written < sizeof(header))
+		return -ENOENT;
+	written -= sizeof(header);
+
+	/* Sync file header from file */
+	ret = lseek(file, 0, SEEK_SET);
+	if (ret < 0)
+		return -errno;
+
+	nread = read(file, &header, sizeof(header));
+	if (nread != sizeof(header))
+		return -errno;
+
+	/* Update file header */
+	ret = lseek(file, 0, SEEK_SET);
+	if (ret < 0)
+		return -errno;
+
+	size_wave_header(&header, written);
+
+	written = write(file, &header, sizeof(header));
+	if (written != sizeof(header))
+		return -errno;
+
+	return 0;
+}
+
+void capture_samples(char *name, unsigned int card, unsigned int device,
+		     unsigned long buffer_size, unsigned int frag,
+		     unsigned int length, unsigned int rate,
+		     unsigned int channels, unsigned int format)
+{
+	struct snd_compr_config config;
+	struct snd_codec codec;
+	struct snd_compr *compress;
+	struct wave_header header;
+	char *buffer;
+	size_t written;
+	int read, ret;
+	unsigned int size, total_read = 0;
+	unsigned int samplebits;
+
+	switch (format) {
+	case SND_PCM_FORMAT_S32_LE:
+		samplebits = 32;
+		break;
+	default:
+		samplebits = 16;
+		break;
+	}
+
+	/* Convert length from seconds to bytes */
+	length = length * rate * (samplebits / 8) * channels;
+
+	if (verbose)
+		fprintf(finfo, "%s: entry, reading %u bytes\n", __func__, length);
+        if (!name) {
+                file = STDOUT_FILENO;
+        } else {
+	        file = open(name, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
+	        if (file == -1) {
+		       fprintf(stderr, "Unable to open file '%s'\n", name);
+		       exit(EXIT_FAILURE);
+	        }
+        }
+
+	/* Write a header, will update with size once record is complete */
+        if (!streamed) {
+	    init_wave_header(&header, channels, rate, samplebits);
+	    written = write(file, &header, sizeof(header));
+	    if (written != sizeof(header)) {
+		fprintf(stderr, "Error writing output file header: %s\n",
+			strerror(errno));
+		goto file_exit;
+	    }
+        }
+
+	memset(&codec, 0, sizeof(codec));
+	memset(&config, 0, sizeof(config));
+	codec.id = SND_AUDIOCODEC_PCM;
+	codec.ch_in = channels;
+	codec.ch_out = channels;
+	codec.sample_rate = rate;
+	if (!codec.sample_rate) {
+		fprintf(stderr, "invalid sample rate %d\n", rate);
+		goto file_exit;
+	}
+	codec.format = format;
+	if ((buffer_size != 0) && (frag != 0)) {
+		config.fragment_size = buffer_size/frag;
+		config.fragments = frag;
+	}
+	config.codec = &codec;
+
+	compress = snd_compr_open(card, device, COMPRESS_OUT, &config);
+	if (!compress || !snd_compr_is_ready(compress)) {
+		fprintf(stderr, "Unable to open Compress device %d:%d\n",
+			card, device);
+		fprintf(stderr, "ERR: %s\n", snd_compr_get_error(compress));
+		goto file_exit;
+	};
+
+	if (verbose)
+		fprintf(finfo, "%s: Opened compress device\n", __func__);
+
+	size = config.fragment_size;
+	buffer = malloc(size * config.fragments);
+	if (!buffer) {
+		fprintf(stderr, "Unable to allocate %d bytes\n", size);
+		goto comp_exit;
+	}
+
+	fprintf(finfo, "Recording file %s On Card %u device %u, with buffer of %lu bytes\n",
+	       name, card, device, buffer_size);
+	fprintf(finfo, "Codec %u Format %u Channels %u, %u Hz\n",
+	       codec.id, codec.format, codec.ch_out, rate);
+
+	snd_compr_start(compress);
+
+	if (verbose)
+		fprintf(finfo, "%s: Capturing audio NOW!!!\n", __func__);
+
+	do {
+		if (length && size > length - total_read)
+			size = length - total_read;
+
+		read = snd_compr_read(compress, buffer, size);
+		if (read < 0) {
+			fprintf(stderr, "Error reading sample\n");
+			fprintf(stderr, "ERR: %s\n", snd_compr_get_error(compress));
+			goto buf_exit;
+		}
+		if ((unsigned int)read != size) {
+			fprintf(stderr, "We read %d, DSP sent %d\n",
+				size, read);
+		}
+
+		if (read > 0) {
+			total_read += read;
+
+			written = write(file, buffer, read);
+			if (written != (size_t)read) {
+				fprintf(stderr, "Error writing output file: %s\n",
+					strerror(errno));
+				goto buf_exit;
+			}
+			if (verbose) {
+				print_time(compress);
+				fprintf(finfo, "%s: read %d\n", __func__, read);
+			}
+		}
+	} while (!length || total_read < length);
+
+	ret = snd_compr_stop(compress);
+	if (ret < 0) {
+		fprintf(stderr, "Error closing stream\n");
+		fprintf(stderr, "ERR: %s\n", snd_compr_get_error(compress));
+	}
+
+	ret = finish_record();
+	if (ret < 0) {
+		fprintf(stderr, "Failed to finish header: %s\n", strerror(ret));
+		goto buf_exit;
+	}
+
+	if (verbose)
+		fprintf(finfo, "%s: exit success\n", __func__);
+
+	free(buffer);
+	close(file);
+	file = 0;
+
+	snd_compr_close(compress);
+
+	return;
+buf_exit:
+	free(buffer);
+comp_exit:
+	snd_compr_close(compress);
+file_exit:
+	close(file);
+
+	if (verbose)
+		fprintf(finfo, "%s: exit failure\n", __func__);
+
+	exit(EXIT_FAILURE);
+}
+
+static void sig_handler(int signum __attribute__ ((unused)))
+{
+	finish_record();
+
+	if (file)
+		close(file);
+
+	_exit(EXIT_FAILURE);
+}
+
+int main(int argc, char **argv)
+{
+	char *file;
+	unsigned long buffer_size = 0;
+	int c;
+	unsigned int card = 0, device = 0, frag = 0, length = 0;
+	unsigned int rate = DEFAULT_RATE, channels = DEFAULT_CHANNELS;
+	unsigned int format = DEFAULT_FORMAT;
+
+	if (signal(SIGINT, sig_handler) == SIG_ERR) {
+		fprintf(stderr, "Error registering signal handler\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (argc < 1)
+		usage();
+
+	verbose = 0;
+	while ((c = getopt(argc, argv, "hvl:R:C:F:b:f:c:d:")) != -1) {
+		switch (c) {
+		case 'h':
+			usage();
+			break;
+		case 'b':
+			buffer_size = strtol(optarg, NULL, 0);
+			break;
+		case 'f':
+			frag = strtol(optarg, NULL, 10);
+			break;
+		case 'c':
+			card = strtol(optarg, NULL, 10);
+			break;
+		case 'd':
+			device = strtol(optarg, NULL, 10);
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+		case 'l':
+			length = strtol(optarg, NULL, 10);
+			break;
+		case 'R':
+			rate = strtol(optarg, NULL, 10);
+			break;
+		case 'C':
+			channels = strtol(optarg, NULL, 10);
+			break;
+		case 'F':
+			if (strcmp(optarg, "S16_LE") == 0) {
+				format = SND_PCM_FORMAT_S16_LE;
+			} else if (strcmp(optarg, "S32_LE") == 0) {
+				format = SND_PCM_FORMAT_S32_LE;
+			} else {
+				fprintf(stderr, "Unrecognised format: %s\n",
+					optarg);
+				usage();
+			}
+			break;
+		default:
+			exit(EXIT_FAILURE);
+		}
+	}
+	if (optind >= argc) {
+		file = NULL;
+		finfo = fopen("/dev/null", "w");
+		streamed = true;
+	} else {
+		file = argv[optind];
+		finfo = stdout;
+		streamed = false;
+	}
+
+	capture_samples(file, card, device, buffer_size, frag, length,
+			rate, channels, format);
+
+	fprintf(finfo, "Finish capturing... Close Normally\n");
+
+	exit(EXIT_SUCCESS);
+}
+
diff --git a/cplay/tinymp3.h b/cplay/tinymp3.h
new file mode 100644
index 000000000000..13afaec2757d
--- /dev/null
+++ b/cplay/tinymp3.h
@@ -0,0 +1,72 @@
+/*
+ * mp3 header and parsing
+ * Copyright (c) 2011-2012, Intel Corporation.
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU Lesser General Public License,
+ * version 2.1, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
+ * License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with this program; if not, write to
+ * the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+
+#ifndef __TINYMP3_H
+#define __TINYMP3_H
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+
+#define MP3_SYNC 0xe0ff
+
+const int mp3_sample_rates[3][3] = {
+	{44100, 48000, 32000},        /* MPEG-1 */
+	{22050, 24000, 16000},        /* MPEG-2 */
+	{11025, 12000,  8000},        /* MPEG-2.5 */
+};
+
+const int mp3_bit_rates[3][3][15] = {
+	{
+		/* MPEG-1 */
+		{  0, 32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448}, /* Layer 1 */
+		{  0, 32, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320, 384}, /* Layer 2 */
+		{  0, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320}, /* Layer 3 */
+	},
+	{
+		/* MPEG-2 */
+		{  0, 32, 48, 56, 64, 80, 96, 112, 128, 144, 160, 176, 192, 224, 256}, /* Layer 1 */
+		{  0,  8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160}, /* Layer 2 */
+		{  0,  8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160}, /* Layer 3 */
+	},
+	{
+		/* MPEG-2.5 */
+		{  0, 32, 48, 56, 64, 80, 96, 112, 128, 144, 160, 176, 192, 224, 256}, /* Layer 1 */
+		{  0,  8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160}, /* Layer 2 */
+		{  0,  8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160}, /* Layer 3 */
+	},
+};
+
+enum mpeg_version {
+	MPEG1  = 0,
+	MPEG2  = 1,
+	MPEG25 = 2
+};
+
+enum mp3_stereo_mode {
+	STEREO = 0x00,
+	JOINT = 0x01,
+	DUAL = 0x02,
+	MONO = 0x03
+};
+
+#endif
-- 
2.1.0
