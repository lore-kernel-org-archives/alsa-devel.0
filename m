From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 1/2] ASoC: samsung: odroid: fix an use-after-free issue for codec
Date: Sat, 13 Jul 2019 11:46:14 +0800
Message-ID: <1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn>
References: <1562989575-33785-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562989575-33785-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: krzk@kernel.org
Cc: sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
List-Id: alsa-devel@alsa-project.org

The codec variable is still being used after the of_node_put() call,
which may result in use-after-free.

Fixes: bc3cf17b575a ("ASoC: samsung: odroid: Add support for secondary CPU DAI")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/samsung/odroid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index dfb6e46..64ebe89 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -284,9 +284,8 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	}
 
 	of_node_put(cpu);
-	of_node_put(codec);
 	if (ret < 0)
-		return ret;
+		goto err_put_node;
 
 	ret = snd_soc_of_get_dai_link_codecs(dev, codec, codec_link);
 	if (ret < 0)
@@ -317,6 +316,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 		goto err_put_clk_i2s;
 	}
 
+	of_node_put(codec);
 	return 0;
 
 err_put_clk_i2s:
@@ -326,6 +326,8 @@ static int odroid_audio_probe(struct platform_device *pdev)
 err_put_cpu_dai:
 	of_node_put(cpu_dai);
 	snd_soc_of_put_dai_link_codecs(codec_link);
+err_put_node:
+	of_node_put(codec);
 	return ret;
 }
 
-- 
2.9.5
