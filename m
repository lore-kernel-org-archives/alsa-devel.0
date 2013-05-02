From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [TINYCOMPRESS][PATCH 1/1] crec: Initial version of a
	compressed	capture utility
Date: Thu, 2 May 2013 09:51:28 +0100
Message-ID: <20130502085128.GA9718@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E21DC26519F
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2013 10:58:56 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@linux.intel.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 Android.mk     |   10 ++
 crec.c         |  339 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makefile.linux |   20 ++-
 3 files changed, 362 insertions(+), 7 deletions(-)
 create mode 100644 crec.c

diff --git a/Android.mk b/Android.mk
index b9c52e2..5baccaf 100644
--- a/Android.mk
+++ b/Android.mk
@@ -20,3 +20,13 @@ LOCAL_MODULE_TAGS := optional
 
 include $(BUILD_EXECUTABLE)
 
+include $(CLEAR_VARS)
+
+LOCAL_C_INCLUDES:= $(LOCAL_PATH)/include
+LOCAL_SRC_FILES:= crec.c
+LOCAL_MODULE := crec
+LOCAL_SHARED_LIBRARIES:= libcutils libutils libtinycompress
+LOCAL_MODULE_TAGS := optional
+
+include $(BUILD_EXECUTABLE)
+
diff --git a/crec.c b/crec.c
new file mode 100644
index 0000000..4f13878
--- /dev/null
+++ b/crec.c
@@ -0,0 +1,339 @@
+/*
+ * BSD LICENSE
+ *
+ * tinyplay command line player for compress audio offload in alsa
+ * Copyright (c) 2011-2012, Intel Corporation
+ * All rights reserved.
+ *
+ * Author: Vinod Koul <vinod.koul@linux.intel.com>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * Redistributions of source code must retain the above copyright notice,
+ * this list of conditions and the following disclaimer.
+ * Redistributions in binary form must reproduce the above copyright notice,
+ * this list of conditions and the following disclaimer in the documentation
+ * and/or other materials provided with the distribution.
+ * Neither the name of Intel Corporation nor the names of its contributors
+ * may be used to endorse or promote products derived from this software
+ * without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * LGPL LICENSE
+ *
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
+#define __force
+#define __bitwise
+#define __user
+#include "sound/compress_params.h"
+#include "tinycompress/tinycompress.h"
+
+static int verbose;
+
+static void usage(void)
+{
+	fprintf(stderr, "usage: crec [OPTIONS] filename\n"
+		"-c\tcard number\n"
+		"-d\tdevice node\n"
+		"-b\tbuffer size\n"
+		"-f\tfragments\n\n"
+		"-v\tverbose mode\n"
+		"-h\tPrints this help list\n\n"
+		"Example:\n"
+		"\tcrec -c 1 -d 2 test.raw\n"
+		"\tcrec -f 5 test.raw\n");
+
+	exit(EXIT_FAILURE);
+}
+
+static int sample_rate_to_alsa(unsigned int *alsa_rate, int rate)
+{
+	switch (rate) {
+	case 5512:
+		*alsa_rate = SNDRV_PCM_RATE_5512;
+		return 0;
+	case 8000:
+		*alsa_rate = SNDRV_PCM_RATE_8000;
+		return 0;
+	case 11025:
+		*alsa_rate = SNDRV_PCM_RATE_11025;
+		return 0;
+	case 16000:
+		*alsa_rate = SNDRV_PCM_RATE_16000;
+		return 0;
+	case 220500:
+		*alsa_rate = SNDRV_PCM_RATE_22050;
+		return 0;
+	case 32000:
+		*alsa_rate = SNDRV_PCM_RATE_32000;
+		return 0;
+	case 44100:
+		*alsa_rate = SNDRV_PCM_RATE_44100;
+		return 0;
+	case 48000:
+		*alsa_rate = SNDRV_PCM_RATE_48000;
+		return 0;
+	case 64000:
+		*alsa_rate = SNDRV_PCM_RATE_64000;
+		return 0;
+	case 88200:
+		*alsa_rate = SNDRV_PCM_RATE_88200;
+		return 0;
+	case 96000:
+		*alsa_rate = SNDRV_PCM_RATE_96000;
+		return 0;
+	case 176400:
+		*alsa_rate = SNDRV_PCM_RATE_176400;
+		return 0;
+	case 192000:
+		*alsa_rate = SNDRV_PCM_RATE_192000;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int alsa_to_sample_rate(unsigned int alsa_rate)
+{
+	switch (alsa_rate) {
+	case SNDRV_PCM_RATE_5512:
+		return 5512;
+	case SNDRV_PCM_RATE_8000:
+		return 8000;
+	case SNDRV_PCM_RATE_11025:
+		return 11025;
+	case SNDRV_PCM_RATE_16000:
+		return 16000;
+	case SNDRV_PCM_RATE_22050:
+		return 22050;
+	case SNDRV_PCM_RATE_32000:
+		return 32000;
+	case SNDRV_PCM_RATE_44100:
+		return 44100;
+	case SNDRV_PCM_RATE_48000:
+		return 48000;
+	case SNDRV_PCM_RATE_64000:
+		return 64000;
+	case SNDRV_PCM_RATE_88200:
+		return 88200;
+	case SNDRV_PCM_RATE_96000:
+		return 96000;
+	case SNDRV_PCM_RATE_176400:
+		return 176400;
+	case SNDRV_PCM_RATE_192000:
+		return 192000;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int print_time(struct compress *compress)
+{
+	unsigned int avail;
+	struct timespec tstamp;
+
+	if (compress_get_hpointer(compress, &avail, &tstamp) != 0) {
+		fprintf(stderr, "Error querying timestamp\n");
+		fprintf(stderr, "ERR: %s\n", compress_get_error(compress));
+		return -1;
+	} else
+		fprintf(stderr, "DSP played %jd.%jd\n", (intmax_t)tstamp.tv_sec, 
(intmax_t)tstamp.tv_nsec*1000);
+	return 0;
+}
+
+void capture_samples(char *name, unsigned int card, unsigned int device,
+		unsigned long buffer_size, unsigned int frag, unsigned int rate)
+{
+	struct compr_config config;
+	struct snd_codec codec;
+	struct compress *compress;
+	FILE *file;
+	char *buffer;
+	int size, num_read, wrote;
+
+	if (verbose)
+		printf("%s: entry\n", __func__);
+	file = fopen(name, "wb");
+	if (!file) {
+		fprintf(stderr, "Unable to open file '%s'\n", name);
+		exit(EXIT_FAILURE);
+	}
+
+	codec.id = SND_AUDIOCODEC_PCM;
+	codec.ch_in = 1;
+	codec.ch_out = 1;
+	if (sample_rate_to_alsa(&codec.sample_rate, rate) != 0) {
+		fprintf(stderr, "unknown sample rate %d\n", rate);
+		goto FILE_EXIT;
+	}
+
+	codec.bit_rate = 0;
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
+	compress = compress_open(card, device, COMPRESS_OUT, &config);
+	if (!compress || !is_compress_ready(compress)) {
+		fprintf(stderr, "Unable to open Compress device %d:%d\n",
+				card, device);
+		fprintf(stderr, "ERR: %s\n", compress_get_error(compress));
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
+	printf("Recording file %s On Card %u device %u, with buffer of %lu bytes\n",
+			name, card, device, buffer_size);
+	printf("Format %u Channels %u, %u Hz\n",
+			codec.id, codec.ch_out,
+			alsa_to_sample_rate(codec.sample_rate));
+
+	compress_start(compress);
+	if (verbose)
+		printf("%s: Capturing audio NOW!!!\n", __func__);
+
+	do {
+		num_read = compress_read(compress, buffer, size);
+		if (num_read > 0) {
+		wrote = fwrite(buffer, 1, num_read, file);
+			if (wrote < 0) {
+				fprintf(stderr, "Error writing output file\n");
+				fprintf(stderr, "ERR: %s\n", compress_get_error(compress));
+				goto BUF_EXIT;
+			}
+			if (wrote != num_read) {
+				/* TODO: Buffer pointer needs to be set here */
+				fprintf(stderr, "DSP supplied %d, we wrote %d\n", num_read, wrote);
+			}
+			if (verbose) {
+				print_time(compress);
+				printf("%s: read %d\n", __func__, num_read);
+			}
+		}
+	} while (num_read > 0);
+
+	if (verbose)
+		printf("%s: exit success\n", __func__);
+	free(buffer);
+	fclose(file);
+	compress_close(compress);
+	return;
+BUF_EXIT:
+	free(buffer);
+COMP_EXIT:
+	compress_close(compress);
+FILE_EXIT:
+	fclose(file);
+	if (verbose)
+		printf("%s: exit failure\n", __func__);
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, char **argv)
+{
+	char *file;
+	unsigned long buffer_size = 0;
+	int c;
+	unsigned int card = 0, device = 0, frag = 0, rate = 16000;
+
+
+	if (argc < 2)
+		usage();
+
+	verbose = 0;
+	while ((c = getopt(argc, argv, "rhvb:f:c:d:")) != -1) {
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
+		case 'r':
+			rate = strtol(optarg, NULL, 10);
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
+	capture_samples(file, card, device, buffer_size, frag, rate);
+
+	fprintf(stderr, "Finish capturing... Close Normally\n");
+	exit(EXIT_SUCCESS);
+}
+
diff --git a/makefile.linux b/makefile.linux
index 60d6c04..9404fd8 100644
--- a/makefile.linux
+++ b/makefile.linux
@@ -1,10 +1,13 @@
 LIB = libtinycompress
-BIN = cplay
 VER = 0.1
 LIBSRC = compress.c
-SRC = cplay.c
+PLAYBIN = cplay
+RECBIN = crec
+PLAYSRC = cplay.c
+RECSRC = crec.c
 LIBOBJ = ${LIBSRC:.c=.o}
-OBJ = ${SRC:.c=.o}
+PLAYOBJ = ${PLAYSRC:.c=.o}
+RECOBJ = ${RECSRC:.c=.o}
 
 CC = gcc
 CROSS_COMPILE =
@@ -13,23 +16,26 @@ CFLAGS += -std=c99 -Wall -Wextra -Wunused -DVERSION=\"${VER}\" -I./include
 LDFLAGS += -L. -ltinycompress
 LIBLDFLAGS = -lasound
 
-all: libtinycompress cplay
+all: libtinycompress cplay crec
 
 $(LIB): ${LIBOBJ}
 	@echo "  LD	"$@
 	@${CROSS_COMPILE}${CC} ${CFLAGS} -shared -Wl,-soname,$@.so -o $@.so ${LIBOBJ} ${LIBLDFLAGS}
 
-$(BIN): ${OBJ} ${LIB}
+$(PLAYBIN): ${PLAYOBJ} ${LIB}
 	@echo "  LD	"$@
-	@${CROSS_COMPILE}${CC} ${CFLAGS} -o $@ ${OBJ} ${LDFLAGS}
+	@${CROSS_COMPILE}${CC} ${CFLAGS} -o $@ ${PLAYOBJ} ${LDFLAGS}
 
+$(RECBIN): ${RECOBJ} ${LIB}
+	@echo "  LD	"$@
+	@${CROSS_COMPILE}${CC} ${CFLAGS} -o $@ ${RECOBJ} ${LDFLAGS}
 
 %.o: %.c
 	@echo "  CC	"$<
 	@${CROSS_COMPILE}${CC} ${CFLAGS} -c -fPIC -o $@ $<
 
 clean:
-	@rm -rf ${BIN} ${OBJ} ${LIB}.so ${LIBOBJ}
+	@rm -rf ${BIN} ${PLAYOBJ} ${RECOBJ} ${LIB}.so ${LIBOBJ}
 
 
 .PHONY: all clean
-- 
1.7.2.5
