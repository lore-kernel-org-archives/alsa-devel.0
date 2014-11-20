From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: sirf-audio-codec: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Thu, 20 Nov 2014 21:28:15 +0100
Message-ID: <1416515295-30851-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-076.synserver.de (smtp-out-076.synserver.de
 [212.40.185.76])
 by alsa0.perex.cz (Postfix) with ESMTP id 67C242605FF
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 21:28:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

While we are at it also replace dev_get_drvdata() with snd_soc_codec_get_drvdata().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sirf-audio-codec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index 06ba492..07eea20 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -120,7 +120,8 @@ static int atlas6_codec_enable_and_reset_event(struct snd_soc_dapm_widget *w,
 {
 #define ATLAS6_CODEC_ENABLE_BITS (1 << 29)
 #define ATLAS6_CODEC_RESET_BITS (1 << 28)
-	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(w->codec->dev);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct sirf_audio_codec *sirf_audio_codec = snd_soc_codec_get_drvdata(codec);
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		enable_and_reset_codec(sirf_audio_codec->regmap,
@@ -142,7 +143,8 @@ static int prima2_codec_enable_and_reset_event(struct snd_soc_dapm_widget *w,
 {
 #define PRIMA2_CODEC_ENABLE_BITS (1 << 27)
 #define PRIMA2_CODEC_RESET_BITS (1 << 26)
-	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(w->codec->dev);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct sirf_audio_codec *sirf_audio_codec = snd_soc_codec_get_drvdata(codec);
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		enable_and_reset_codec(sirf_audio_codec->regmap,
-- 
1.8.0
