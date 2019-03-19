From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] ASoC: codecs: Fix to avoid potential NULL pointer dereferences
Date: Mon, 18 Mar 2019 19:58:01 -0500
Message-ID: <20190319005805.13823-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Barry Song <baohua@kernel.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In sirf_audio_codec_driver_probe, of_match_node may fail and return a
NULL pointer. The patch avoids a potential NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 sound/soc/codecs/sirf-audio-codec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index e424499a8450..fd2bbd6a3c58 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -464,6 +464,8 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	match = of_match_node(sirf_audio_codec_of_match, pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
 
 	sirf_audio_codec = devm_kzalloc(&pdev->dev,
 		sizeof(struct sirf_audio_codec), GFP_KERNEL);
-- 
2.17.1
