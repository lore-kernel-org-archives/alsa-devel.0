From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH v2 08/10] ASoC: sun4i-codec: Remove unnecessary function call
Date: Wed, 23 Aug 2017 05:21:08 -0700
Message-ID: <644cc5dae3a807dcfa276d86006bf4348900c93c.1503484313.git.dolinux.peng@gmail.com>
References: <cover.1503484313.git.dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1503484313.git.dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wens@csie.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

The work of the function platform_set_drvdata is done by
devm_snd_soc_register_card.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 150069987c0c..82beeae8edc5 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1655,7 +1655,6 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		goto err_unregister_codec;
 	}
 
-	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, scodec);
 
 	ret = snd_soc_register_card(card);
-- 
2.14.1
