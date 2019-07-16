From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: odroid: fix an use-after-free issue for codec" to the asoc tree
Date: Tue, 16 Jul 2019 19:18:08 +0100 (BST)
Message-ID: <20190716181808.6D85F2742BE5@ypsilon.sirena.org.uk>
References: <1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, cheng.shengyu@zte.com.cn, Jaroslav Kysela <perex@perex.cz>, krzk@kernel.orgKrzysztof Kozlowski <krzk@kernel.org>, lgirdwood@gmail.comLiam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>perex@perex.cz, Sangbeom Kim <sbkim73@samsung.com>sbkim73@samsung.com, s.nawrocki@samsung.comSylwester Nawrocki <s.nawrocki@samsung.com>, Takashi Iwai <tiwai@suse.com>tiwai@suse.com, wang.yi59@zte.com.cn, xue.zhihong@zte.com.cn
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: odroid: fix an use-after-free issue for codec

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9b6d104a6b150bd4d3e5b039340e1f6b20c2e3c1 Mon Sep 17 00:00:00 2001
From: Wen Yang <wen.yang99@zte.com.cn>
Date: Sat, 13 Jul 2019 11:46:14 +0800
Subject: [PATCH] ASoC: samsung: odroid: fix an use-after-free issue for codec

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
Link: https://lore.kernel.org/r/1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/odroid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index dfb6e460e7eb..64ebe895cdd7 100644
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
2.20.1
