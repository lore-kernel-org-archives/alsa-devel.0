From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v2 2/3] cplay: move around MP3 header parsing
	method
Date: Fri,  2 Feb 2018 13:32:45 +0900
Message-ID: <20180202043246.10481-2-suzuki.katsuhiro@socionext.com>
References: <20180202043246.10481-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 781AF266FD8
 for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2018 05:32:40 +0100 (CET)
In-Reply-To: <20180202043246.10481-1-suzuki.katsuhiro@socionext.com>
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

This patch moves MP3 parsing method for -I option, this is for
adding other codec ID in the future.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 src/utils/cplay.c | 69 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/src/utils/cplay.c b/src/utils/cplay.c
index 1eb21ce..beec45f 100644
--- a/src/utils/cplay.c
+++ b/src/utils/cplay.c
@@ -268,6 +268,42 @@ int main(int argc, char **argv)
 	exit(EXIT_SUCCESS);
 }
 
+void get_codec_mp3(FILE *file, struct compr_config *config,
+		struct snd_codec *codec)
+{
+	size_t read;
+	struct mp3_header header;
+	unsigned int channels, rate, bits;
+
+	read = fread(&header, 1, sizeof(header), file);
+	if (read != sizeof(header)) {
+		fprintf(stderr, "Unable to read header \n");
+		fclose(file);
+		exit(EXIT_FAILURE);
+	}
+
+	if (parse_mp3_header(&header, &channels, &rate, &bits) == -1) {
+		fclose(file);
+		exit(EXIT_FAILURE);
+	}
+
+	codec->id = SND_AUDIOCODEC_MP3;
+	codec->ch_in = channels;
+	codec->ch_out = channels;
+	codec->sample_rate = rate;
+	if (!codec->sample_rate) {
+		fprintf(stderr, "invalid sample rate %d\n", rate);
+		fclose(file);
+		exit(EXIT_FAILURE);
+	}
+	codec->bit_rate = bits;
+	codec->rate_control = 0;
+	codec->profile = 0;
+	codec->level = 0;
+	codec->ch_mode = 0;
+	codec->format = 0;
+}
+
 void play_samples(char *name, unsigned int card, unsigned int device,
 		unsigned long buffer_size, unsigned int frag,
 		unsigned long codec_id)
@@ -275,12 +311,9 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 	struct compr_config config;
 	struct snd_codec codec;
 	struct compress *compress;
-	struct mp3_header header;
 	FILE *file;
 	char *buffer;
 	int size, num_read, wrote;
-	unsigned int channels, rate, bits;
-	size_t read;
 
 	if (verbose)
 		printf("%s: entry\n", __func__);
@@ -290,33 +323,15 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 		exit(EXIT_FAILURE);
 	}
 
-	read = fread(&header, 1, sizeof(header), file);
-	if (read != sizeof(header)) {
-		fprintf(stderr, "Unable to read header \n");
-		fclose(file);
+	switch (codec_id) {
+	case SND_AUDIOCODEC_MP3:
+		get_codec_mp3(file, &config, &codec);
+		break;
+	default:
+		fprintf(stderr, "codec ID %d is not supported\n", codec_id);
 		exit(EXIT_FAILURE);
 	}
 
-	if (parse_mp3_header(&header, &channels, &rate, &bits) == -1) {
-		fclose(file);
-		exit(EXIT_FAILURE);
-	}
-
-	codec.id = SND_AUDIOCODEC_MP3;
-	codec.ch_in = channels;
-	codec.ch_out = channels;
-	codec.sample_rate = rate;
-	if (!codec.sample_rate) {
-		fprintf(stderr, "invalid sample rate %d\n", rate);
-		fclose(file);
-		exit(EXIT_FAILURE);
-	}
-	codec.bit_rate = bits;
-	codec.rate_control = 0;
-	codec.profile = 0;
-	codec.level = 0;
-	codec.ch_mode = 0;
-	codec.format = 0;
 	if ((buffer_size != 0) && (frag != 0)) {
 		config.fragment_size = buffer_size/frag;
 		config.fragments = frag;
-- 
2.15.0
