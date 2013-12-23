From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: Cleanup __asoc_simple_card_dai_init() ret check
Date: Mon, 23 Dec 2013 13:24:59 +0800
Message-ID: <1387776299-25418-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: rob@landley.net, kuninori.morimoto.gx@renesas.com, fabio.estevam@freescale.com, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The ret parameter is always equal to zero till here.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 643c9ed..6ce9745 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -25,7 +25,7 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 
 	daifmt |= set->fmt;
 
-	if (!ret && daifmt)
+	if (daifmt)
 		ret = snd_soc_dai_set_fmt(dai, daifmt);
 
 	if (ret == -ENOTSUPP) {
-- 
1.8.4


