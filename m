From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v2 1/3] cplay: add option to specify codec ID
Date: Fri,  2 Feb 2018 13:32:44 +0900
Message-ID: <20180202043246.10481-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 757F3266F64
 for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2018 05:32:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Takashi Iwai <tiwai@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds a -I command line option to set the codec ID,
same as crecord.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 src/utils/cplay.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/src/utils/cplay.c b/src/utils/cplay.c
index bc95f0d..1eb21ce 100644
--- a/src/utils/cplay.c
+++ b/src/utils/cplay.c
@@ -74,25 +74,75 @@
 #include "tinycompress/tinymp3.h"
 
 static int verbose;
+static const unsigned int DEFAULT_CODEC_ID = SND_AUDIOCODEC_PCM;
+
+static const struct {
+	const char *name;
+	unsigned int id;
+} codec_ids[] = {
+	{ "PCM", SND_AUDIOCODEC_PCM },
+	{ "MP3", SND_AUDIOCODEC_MP3 },
+	{ "AMR", SND_AUDIOCODEC_AMR },
+	{ "AMRWB", SND_AUDIOCODEC_AMRWB },
+	{ "AMRWBPLUS", SND_AUDIOCODEC_AMRWBPLUS },
+	{ "AAC", SND_AUDIOCODEC_AAC },
+	{ "WMA", SND_AUDIOCODEC_WMA },
+	{ "REAL", SND_AUDIOCODEC_REAL },
+	{ "VORBIS", SND_AUDIOCODEC_VORBIS },
+	{ "FLAC", SND_AUDIOCODEC_FLAC },
+	{ "IEC61937", SND_AUDIOCODEC_IEC61937 },
+	{ "G723_1", SND_AUDIOCODEC_G723_1 },
+	{ "G729", SND_AUDIOCODEC_G729 },
+/* BESPOKE isn't defined on older kernels */
+#ifdef SND_AUDIOCODEC_BESPOKE
+	{ "BESPOKE", SND_AUDIOCODEC_BESPOKE },
+#endif
+};
+#define CPLAY_NUM_CODEC_IDS (sizeof(codec_ids) / sizeof(codec_ids[0]))
+
+static const char *codec_name_from_id(unsigned int id)
+{
+	static char hexname[12];
+	int i;
+
+	for (i = 0; i < CPLAY_NUM_CODEC_IDS; ++i) {
+		if (codec_ids[i].id == id)
+			return codec_ids[i].name;
+	}
+
+	snprintf(hexname, sizeof(hexname), "0x%x", id);
+	return hexname; /* a static is safe because we're single-threaded */
+}
 
 static void usage(void)
 {
+	int i;
+
 	fprintf(stderr, "usage: cplay [OPTIONS] filename\n"
 		"-c\tcard number\n"
 		"-d\tdevice node\n"
+		"-I\tspecify codec ID (default is mp3)\n"
 		"-b\tbuffer size\n"
 		"-f\tfragments\n\n"
 		"-v\tverbose mode\n"
 		"-h\tPrints this help list\n\n"
 		"Example:\n"
 		"\tcplay -c 1 -d 2 test.mp3\n"
-		"\tcplay -f 5 test.mp3\n");
+		"\tcplay -f 5 test.mp3\n\n"
+		"Valid codec IDs:\n");
+
+	for (i = 0; i < CPLAY_NUM_CODEC_IDS; ++i)
+		fprintf(stderr, "%s%c", codec_ids[i].name,
+			((i + 1) % 8) ? ' ' : '\n');
+
+	fprintf(stderr, "\nor the value in decimal or hex\n");
 
 	exit(EXIT_FAILURE);
 }
 
 void play_samples(char *name, unsigned int card, unsigned int device,
-		unsigned long buffer_size, unsigned int frag);
+		unsigned long buffer_size, unsigned int frag,
+		unsigned long codec_id);
 
 struct mp3_header {
 	uint16_t sync;
@@ -156,15 +206,15 @@ int main(int argc, char **argv)
 {
 	char *file;
 	unsigned long buffer_size = 0;
-	int c;
+	int c, i;
 	unsigned int card = 0, device = 0, frag = 0;
-
+	unsigned int codec_id = SND_AUDIOCODEC_MP3;
 
 	if (argc < 2)
 		usage();
 
 	verbose = 0;
-	while ((c = getopt(argc, argv, "hvb:f:c:d:")) != -1) {
+	while ((c = getopt(argc, argv, "hvb:f:c:d:I:")) != -1) {
 		switch (c) {
 		case 'h':
 			usage();
@@ -181,6 +231,25 @@ int main(int argc, char **argv)
 		case 'd':
 			device = strtol(optarg, NULL, 10);
 			break;
+		case 'I':
+			if (optarg[0] == '0') {
+				codec_id = strtol(optarg, NULL, 0);
+			} else {
+				for (i = 0; i < CPLAY_NUM_CODEC_IDS; ++i) {
+					if (strcmp(optarg,
+						   codec_ids[i].name) == 0) {
+						codec_id = codec_ids[i].id;
+						break;
+					}
+				}
+
+				if (i == CPLAY_NUM_CODEC_IDS) {
+					fprintf(stderr, "Unrecognised ID: %s\n",
+						optarg);
+					usage();
+				}
+			}
+			break;
 		case 'v':
 			verbose = 1;
 			break;
@@ -193,14 +262,15 @@ int main(int argc, char **argv)
 
 	file = argv[optind];
 
-	play_samples(file, card, device, buffer_size, frag);
+	play_samples(file, card, device, buffer_size, frag, codec_id);
 
 	fprintf(stderr, "Finish Playing.... Close Normally\n");
 	exit(EXIT_SUCCESS);
 }
 
 void play_samples(char *name, unsigned int card, unsigned int device,
-		unsigned long buffer_size, unsigned int frag)
+		unsigned long buffer_size, unsigned int frag,
+		unsigned long codec_id)
 {
 	struct compr_config config;
 	struct snd_codec codec;
@@ -292,7 +362,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 	printf("Playing file %s On Card %u device %u, with buffer of %lu bytes\n",
 			name, card, device, buffer_size);
 	printf("Format %u Channels %u, %u Hz, Bit Rate %d\n",
-			SND_AUDIOCODEC_MP3, channels, rate, bits);
+			codec.id, codec.ch_in, codec.sample_rate, codec.bit_rate);
 
 	compress_start(compress);
 	if (verbose)
-- 
2.15.0
