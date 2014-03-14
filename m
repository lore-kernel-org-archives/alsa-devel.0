From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: sirf-audio-codec: Remove
	snd_soc_codec_set_cache_io() call
Date: Fri, 14 Mar 2014 09:26:11 +0100
Message-ID: <1394785572-28315-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-088.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 6771A264FF9
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 09:25:33 +0100 (CET)
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
Cc: Rongjun Ying <rongjun.ying@csr.com>, Barry Song <baohua@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There was a overlap between the snd_soc_codec_set_cache_io() cleanup and the
addition of the sirf-audio-codec resulting in the sirf-audio-codec driver still
using the old signature of snd_soc_codec_set_cache_io(), which will cause a
compile error. Since the core is able to automatically setup IO for this driver
we can just remove both the snd_soc_set_cache_io() call and the control_data
assignment.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sirf-audio-codec.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index 90e3a22..58e7c1f 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -337,18 +337,9 @@ struct snd_soc_dai_driver sirf_audio_codec_dai = {
 
 static int sirf_audio_codec_probe(struct snd_soc_codec *codec)
 {
-	int ret;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	struct sirf_audio_codec *sirf_audio_codec = snd_soc_codec_get_drvdata(codec);
 
 	pm_runtime_enable(codec->dev);
-	codec->control_data = sirf_audio_codec->regmap;
-
-	ret = snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		return ret;
-	}
 
 	if (of_device_is_compatible(codec->dev->of_node, "sirf,prima2-audio-codec")) {
 		snd_soc_dapm_new_controls(dapm,
-- 
1.8.0
