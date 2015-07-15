From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: sirf-audio-codec: Staticise local symbols
Date: Wed, 15 Jul 2015 13:50:49 +0800
Message-ID: <1436939449.24267.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id ED3BB2657D2
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 07:50:58 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so18003177pac.3
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 22:50:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: RongJun Ying <Rongjun.Ying@csr.com>, Barry Song <baohua@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Also make sirf_audio_codec_dai_ops const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/sirf-audio-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index 29cb442..6bfd25c 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -370,11 +370,11 @@ static int sirf_audio_codec_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-struct snd_soc_dai_ops sirf_audio_codec_dai_ops = {
+static const struct snd_soc_dai_ops sirf_audio_codec_dai_ops = {
 	.trigger = sirf_audio_codec_trigger,
 };
 
-struct snd_soc_dai_driver sirf_audio_codec_dai = {
+static struct snd_soc_dai_driver sirf_audio_codec_dai = {
 	.name = "sirf-audio-codec",
 	.playback = {
 		.stream_name = "Playback",
-- 
2.1.0
