From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [TINYCOMPRESS][PATCH] crec: support streaming output
	to stdout
Date: Thu, 19 Feb 2015 14:55:40 +0000
Message-ID: <1424357740-6561-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3AF8260594
 for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2015 15:56:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Ammar Zahid Ali Syed <aali@opensource.wolfsonmicro.com>

It's useful for testing to be able to stream the captured
audio to stdout instead of having to go via a file.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Ammar Ali <aali@opensource.wolfsonmicro.com>
---
 crec.c |   73 ++++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/crec.c b/crec.c
index e3f189f..258fade 100644
--- a/crec.c
+++ b/crec.c
@@ -77,6 +77,8 @@
 
 static int verbose;
 static int file;
+static FILE *finfo;
+static bool streamed;
 
 static const unsigned int DEFAULT_CHANNELS = 1;
 static const unsigned int DEFAULT_RATE = 44100;
@@ -151,7 +153,7 @@ static void size_wave_header(struct wave_header *header, uint32_t size)
 
 static void usage(void)
 {
-	fprintf(stderr, "usage: crec [OPTIONS] filename\n"
+	fprintf(stderr, "usage: crec [OPTIONS] [filename]\n"
 		"-c\tcard number\n"
 		"-d\tdevice node\n"
 		"-b\tbuffer size\n"
@@ -162,6 +164,8 @@ static void usage(void)
 		"-C\tSpecify the number of channels (default %u)\n"
 		"-R\tSpecify the sample rate (default %u)\n"
 		"-F\tSpecify the format: S16_LE, S32_LE (default S16_LE)\n\n"
+		"If filename is not given the output is\n"
+		"written to stdout\n\n"
 		"Example:\n"
 		"\tcrec -c 1 -d 2 test.wav\n"
 		"\tcrec -f 5 test.wav\n",
@@ -180,7 +184,7 @@ static int print_time(struct compress *compress)
 		fprintf(stderr, "ERR: %s\n", compress_get_error(compress));
 		return -1;
 	} else {
-		printf("DSP recorded %jd.%jd\n",
+		fprintf(finfo, "DSP recorded %jd.%jd\n",
 		       (intmax_t)tstamp.tv_sec, (intmax_t)tstamp.tv_nsec*1000);
 	}
 	return 0;
@@ -195,6 +199,10 @@ static int finish_record()
 	if (!file)
 		return -ENOENT;
 
+	/* can't rewind if streaming to stdout */
+	if (streamed)
+		return 0;
+
 	/* Get amount of data written to file */
 	ret = lseek(file, 0, SEEK_END);
 	if (ret < 0)
@@ -256,22 +264,27 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 	length = length * rate * (samplebits / 8) * channels;
 
 	if (verbose)
-		printf("%s: entry, reading %u bytes\n", __func__, length);
-
-	file = open(name, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
-	if (file == -1) {
-		fprintf(stderr, "Unable to open file '%s'\n", name);
-		exit(EXIT_FAILURE);
-	}
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
 
 	/* Write a header, will update with size once record is complete */
-	init_wave_header(&header, channels, rate, samplebits);
-	written = write(file, &header, sizeof(header));
-	if (written != sizeof(header)) {
+        if (!streamed) {
+	    init_wave_header(&header, channels, rate, samplebits);
+	    written = write(file, &header, sizeof(header));
+	    if (written != sizeof(header)) {
 		fprintf(stderr, "Error writing output file header: %s\n",
 			strerror(errno));
 		goto file_exit;
-	}
+	    }
+        }
 
 	memset(&codec, 0, sizeof(codec));
 	memset(&config, 0, sizeof(config));
@@ -299,7 +312,7 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 	};
 
 	if (verbose)
-		printf("%s: Opened compress device\n", __func__);
+		fprintf(finfo, "%s: Opened compress device\n", __func__);
 
 	size = config.fragment_size;
 	buffer = malloc(size * config.fragments);
@@ -308,15 +321,15 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 		goto comp_exit;
 	}
 
-	printf("Recording file %s On Card %u device %u, with buffer of %lu bytes\n",
+	fprintf(finfo, "Recording file %s On Card %u device %u, with buffer of %lu bytes\n",
 	       name, card, device, buffer_size);
-	printf("Format %u Channels %u, %u Hz\n",
-	       codec.id, codec.ch_out, rate);
+	fprintf(finfo, "Codec %u Format %u Channels %u, %u Hz\n",
+	       codec.id, codec.format, codec.ch_out, rate);
 
 	compress_start(compress);
 
 	if (verbose)
-		printf("%s: Capturing audio NOW!!!\n", __func__);
+		fprintf(finfo, "%s: Capturing audio NOW!!!\n", __func__);
 
 	do {
 		if (length && size > length - total_read)
@@ -344,7 +357,7 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 			}
 			if (verbose) {
 				print_time(compress);
-				printf("%s: read %d\n", __func__, read);
+				fprintf(finfo, "%s: read %d\n", __func__, read);
 			}
 		}
 	} while (!length || total_read < length);
@@ -362,7 +375,7 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 	}
 
 	if (verbose)
-		printf("%s: exit success\n", __func__);
+		fprintf(finfo, "%s: exit success\n", __func__);
 
 	free(buffer);
 	close(file);
@@ -379,7 +392,7 @@ file_exit:
 	close(file);
 
 	if (verbose)
-		printf("%s: exit failure\n", __func__);
+		fprintf(finfo, "%s: exit failure\n", __func__);
 
 	exit(EXIT_FAILURE);
 }
@@ -408,7 +421,7 @@ int main(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	if (argc < 2)
+	if (argc < 1)
 		usage();
 
 	verbose = 0;
@@ -456,15 +469,21 @@ int main(int argc, char **argv)
 			exit(EXIT_FAILURE);
 		}
 	}
-	if (optind >= argc)
-		usage();
-
-	file = argv[optind];
+	if (optind >= argc) {
+		file = NULL;
+		finfo = fopen("/dev/null", "w");
+		streamed = true;
+	} else {
+		file = argv[optind];
+		finfo = stdout;
+		streamed = false;
+	}
 
 	capture_samples(file, card, device, buffer_size, frag, length,
 			rate, channels, format);
 
-	printf("Finish capturing... Close Normally\n");
+	fprintf(finfo, "Finish capturing... Close Normally\n");
+
 	exit(EXIT_SUCCESS);
 }
 
-- 
1.7.2.5
