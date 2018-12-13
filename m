From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ASoC: simple-card: Dereference pointer for memcpy sizeof in asoc_simple_card_probe
Date: Wed, 12 Dec 2018 21:35:48 -0700
Message-ID: <20181213043548.29747-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>
List-Id: alsa-devel@alsa-project.org

Clang warns:

sound/soc/generic/simple-card.c:462:6: warning: argument to 'sizeof' in
'memcpy' call is the same pointer type 'struct asoc_simple_dai *' as the
source; expected 'struct asoc_simple_dai' or an explicit length
[-Wsizeof-pointer-memaccess]
                                        sizeof(priv->dai_props->cpu_dai));
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/generic/simple-card.c:464:6: warning: argument to 'sizeof' in
'memcpy' call is the same pointer type 'struct asoc_simple_dai *' as the
source; expected 'struct asoc_simple_dai' or an explicit length
[-Wsizeof-pointer-memaccess]
                                        sizeof(priv->dai_props->codec_dai));
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 warnings generated.

Commit 4fb7f4df49d3 ("ASoC: simple-card: use cpu/codec pointer on
simple_dai_props") updated {cpu,codec}_dai to be pointers in struct
simple_dai_props but didn't update these locations to dereference the
pointers to get the proper size of their contents.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/soc/generic/simple-card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 766123485d7c..d4738d3eb2f1 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -459,9 +459,9 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		dai_link->dai_fmt	= cinfo->daifmt;
 		dai_link->init		= asoc_simple_card_dai_init;
 		memcpy(&priv->dai_props->cpu_dai, &cinfo->cpu_dai,
-					sizeof(priv->dai_props->cpu_dai));
+					sizeof(*priv->dai_props->cpu_dai));
 		memcpy(&priv->dai_props->codec_dai, &cinfo->codec_dai,
-					sizeof(priv->dai_props->codec_dai));
+					sizeof(*priv->dai_props->codec_dai));
 	}
 
 	snd_soc_card_set_drvdata(card, priv);
-- 
2.20.0
