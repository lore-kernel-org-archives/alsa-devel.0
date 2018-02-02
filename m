From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v2 3/3] cplay: support IEC61937 format
Date: Fri,  2 Feb 2018 13:32:46 +0900
Message-ID: <20180202043246.10481-3-suzuki.katsuhiro@socionext.com>
References: <20180202043246.10481-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CE01266F64
 for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2018 05:32:43 +0100 (CET)
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

This patch adds very simple supports for IEC61937 S/PDIF format.

The cplay just specifies the format ID and sends audio data to ALSA.
There is no check the audio data is valid or invalid as IEC61937
specifications.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 src/utils/cplay.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/utils/cplay.c b/src/utils/cplay.c
index beec45f..f15c728 100644
--- a/src/utils/cplay.c
+++ b/src/utils/cplay.c
@@ -304,6 +304,22 @@ void get_codec_mp3(FILE *file, struct compr_config *config,
 	codec->format = 0;
 }
 
+int get_codec_iec(FILE *file, struct compr_config *config,
+		struct snd_codec *codec)
+{
+	codec->id = SND_AUDIOCODEC_IEC61937;
+	/* FIXME: cannot get accurate ch_in, any channels may be accepted */
+	codec->ch_in = 2;
+	codec->ch_out = 2;
+	codec->sample_rate = 0;
+	codec->bit_rate = 0;
+	codec->rate_control = 0;
+	codec->profile = SND_AUDIOPROFILE_IEC61937_SPDIF;
+	codec->level = 0;
+	codec->ch_mode = 0;
+	codec->format = 0;
+}
+
 void play_samples(char *name, unsigned int card, unsigned int device,
 		unsigned long buffer_size, unsigned int frag,
 		unsigned long codec_id)
@@ -327,6 +343,9 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 	case SND_AUDIOCODEC_MP3:
 		get_codec_mp3(file, &config, &codec);
 		break;
+	case SND_AUDIOCODEC_IEC61937:
+		get_codec_iec(file, &config, &codec);
+		break;
 	default:
 		fprintf(stderr, "codec ID %d is not supported\n", codec_id);
 		exit(EXIT_FAILURE);
-- 
2.15.0
