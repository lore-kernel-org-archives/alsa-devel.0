From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] crecord: Add option to specify codec ID
Date: Wed, 18 Jan 2017 16:29:54 +0000
Message-ID: <1484756994-19679-2-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1484756994-19679-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C9F92667E7
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2017 17:30:00 +0100 (CET)
In-Reply-To: <1484756994-19679-1-git-send-email-rf@opensource.wolfsonmicro.com>
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

This patch adds a -I command line option to set the codec ID,
either from a defined set of string values or as a number.

After discussion with Vinod it was agreed that we should only
allow writing to a file if we support creating the correct container
file format for that data. As we currently only have support for
creating WAV files only PCM data can be written to a file. Other
formats can be sent raw to stdout.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 src/utils/crecord.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 87 insertions(+), 12 deletions(-)

diff --git a/src/utils/crecord.c b/src/utils/crecord.c
index 390fe45..1fd3698 100644
--- a/src/utils/crecord.c
+++ b/src/utils/crecord.c
@@ -83,6 +83,31 @@ static bool streamed;
 static const unsigned int DEFAULT_CHANNELS = 1;
 static const unsigned int DEFAULT_RATE = 44100;
 static const unsigned int DEFAULT_FORMAT = SNDRV_PCM_FORMAT_S16_LE;
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
+#define CREC_NUM_CODEC_IDS (sizeof(codec_ids) / sizeof(codec_ids[0]))
 
 struct riff_chunk {
 	char desc[4];
@@ -151,9 +176,25 @@ static void size_wave_header(struct wave_header *header, uint32_t size)
 	header->data.chunk.size = size;
 }
 
+static const char *codec_name_from_id(unsigned int id)
+{
+	static char hexname[12];
+	int i;
+
+	for (i = 0; i < CREC_NUM_CODEC_IDS; ++i) {
+		if (codec_ids[i].id == id)
+			return codec_ids[i].name;
+	}
+
+	snprintf(hexname, sizeof(hexname), "0x%x", id);
+	return hexname; /* a static is safe because we're single-threaded */
+}
+
 static void usage(void)
 {
-	fprintf(stderr, "usage: crecord [OPTIONS] [filename]\n"
+	int i;
+
+	fprintf(stderr, "usage: crecord [OPTIONS] [filename.wav]\n"
 		"-c\tcard number\n"
 		"-d\tdevice node\n"
 		"-b\tbuffer size\n"
@@ -163,13 +204,23 @@ static void usage(void)
 		"-h\tPrints this help list\n\n"
 		"-C\tSpecify the number of channels (default %u)\n"
 		"-R\tSpecify the sample rate (default %u)\n"
-		"-F\tSpecify the format: S16_LE, S32_LE (default S16_LE)\n\n"
-		"If filename is not given the output is\n"
-		"written to stdout\n\n"
+		"-F\tSpecify the format: S16_LE, S32_LE (default S16_LE)\n"
+		"-I\tSpecify codec ID (default %s)\n\n"
+		"If filename.wav is not given the output is written to stdout\n"
+		"Only PCM data can be written to a WAV file.\n\n"
 		"Example:\n"
 		"\tcrecord -c 1 -d 2 test.wav\n"
-		"\tcrecord -f 5 test.wav\n",
-		DEFAULT_CHANNELS, DEFAULT_RATE);
+		"\tcrecord -f 5 test.wav\n"
+		"\tcrecord -I BESPOKE >raw.bin\n\n"
+		"Valid codec IDs:\n",
+		DEFAULT_CHANNELS, DEFAULT_RATE,
+		codec_name_from_id(DEFAULT_CODEC_ID));
+
+	for (i = 0; i < CREC_NUM_CODEC_IDS; ++i)
+		fprintf(stderr, "%s%c", codec_ids[i].name,
+		((i + 1) % 8) ? ' ' : '\n');
+
+	fprintf(stderr, "\nor the value in decimal or hex\n");
 
 	exit(EXIT_FAILURE);
 }
@@ -239,7 +290,8 @@ static int finish_record(void)
 static void capture_samples(char *name, unsigned int card, unsigned int device,
 			    unsigned long buffer_size, unsigned int frag,
 			    unsigned int length, unsigned int rate,
-			    unsigned int channels, unsigned int format)
+			    unsigned int channels, unsigned int format,
+			    unsigned int codec_id)
 {
 	struct compr_config config;
 	struct snd_codec codec;
@@ -289,7 +341,7 @@ static void capture_samples(char *name, unsigned int card, unsigned int device,
 
 	memset(&codec, 0, sizeof(codec));
 	memset(&config, 0, sizeof(config));
-	codec.id = SND_AUDIOCODEC_PCM;
+	codec.id = codec_id;
 	codec.ch_in = channels;
 	codec.ch_out = channels;
 	codec.sample_rate = rate;
@@ -409,10 +461,11 @@ int main(int argc, char **argv)
 {
 	char *file;
 	unsigned long buffer_size = 0;
-	int c;
+	int c, i;
 	unsigned int card = 0, device = 0, frag = 0, length = 0;
 	unsigned int rate = DEFAULT_RATE, channels = DEFAULT_CHANNELS;
 	unsigned int format = DEFAULT_FORMAT;
+	unsigned int codec_id = DEFAULT_CODEC_ID;
 
 	if (signal(SIGINT, sig_handler) == SIG_ERR) {
 		fprintf(stderr, "Error registering signal handler\n");
@@ -423,7 +476,7 @@ int main(int argc, char **argv)
 		usage();
 
 	verbose = 0;
-	while ((c = getopt(argc, argv, "hvl:R:C:F:b:f:c:d:")) != -1) {
+	while ((c = getopt(argc, argv, "hvl:R:C:F:I:b:f:c:d:")) != -1) {
 		switch (c) {
 		case 'h':
 			usage();
@@ -463,6 +516,25 @@ int main(int argc, char **argv)
 				usage();
 			}
 			break;
+		case 'I':
+			if (optarg[0] == '0') {
+				codec_id = strtol(optarg, NULL, 0);
+			} else {
+				for (i = 0; i < CREC_NUM_CODEC_IDS; ++i) {
+					if (strcmp(optarg,
+						   codec_ids[i].name) == 0) {
+						codec_id = codec_ids[i].id;
+						break;
+					}
+				}
+
+				if (i == CREC_NUM_CODEC_IDS) {
+					fprintf(stderr, "Unrecognised ID: %s\n",
+						optarg);
+					usage();
+				}
+			}
+			break;
 		default:
 			exit(EXIT_FAILURE);
 		}
@@ -472,14 +544,17 @@ int main(int argc, char **argv)
 		file = NULL;
 		finfo = fopen("/dev/null", "w");
 		streamed = true;
-	} else {
+	} else if (codec_id == SND_AUDIOCODEC_PCM) {
 		file = argv[optind];
 		finfo = stdout;
 		streamed = false;
+	} else {
+		fprintf(stderr, "ERROR: Only PCM can be written to a WAV file\n");
+		exit(EXIT_FAILURE);
 	}
 
 	capture_samples(file, card, device, buffer_size, frag, length,
-			rate, channels, format);
+			rate, channels, format, codec_id);
 
 	fprintf(finfo, "Finish capturing... Close Normally\n");
 
-- 
1.9.1
