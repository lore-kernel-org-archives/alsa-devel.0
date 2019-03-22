From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH v3] ASoC: sirf-audio: Remove redundant of_match_node call
Date: Fri, 22 Mar 2019 17:00:29 -0500
Message-ID: <20190322220031.13773-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Barry Song <baohua@kernel.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Unlike other drivers probe method, of_match_node return value
is not used or checked. This patch removes the redundant code.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v2: Move the signed by above the version change log
v1: A check is unnecessary as match is never used.
---
 sound/soc/codecs/sirf-audio-codec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index e424499a8450..e0af21050078 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -461,9 +461,6 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
 	struct sirf_audio_codec *sirf_audio_codec;
 	void __iomem *base;
 	struct resource *mem_res;
-	const struct of_device_id *match;
-
-	match = of_match_node(sirf_audio_codec_of_match, pdev->dev.of_node);
 
 	sirf_audio_codec = devm_kzalloc(&pdev->dev,
 		sizeof(struct sirf_audio_codec), GFP_KERNEL);
-- 
2.17.1
