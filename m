From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: fix __asoc_simple_card_dai_init
Date: Thu, 16 Jan 2014 10:31:10 +0800
Message-ID: <1389839470-31199-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: kuninori.morimoto.gx@renesas.com, moinejf@free.fr, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

If the CPU/CODEC DAI set_sysclk() is not support, the -ENOTSUPP will returnd.
Here do the check like set_fmt().

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 2a1b1b5..b6014fe 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -19,22 +19,27 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 				       struct asoc_simple_dai *set,
 				       unsigned int daifmt)
 {
-	int ret = 0;
+	int ret;
 
 	daifmt |= set->fmt;
 
-	if (daifmt)
+	if (daifmt) {
 		ret = snd_soc_dai_set_fmt(dai, daifmt);
-
-	if (ret == -ENOTSUPP) {
-		dev_dbg(dai->dev, "ASoC: set_fmt is not supported\n");
-		ret = 0;
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dai->dev, "simple-card: set_fmt error\n");
+			return ret;
+		}
 	}
 
-	if (!ret && set->sysclk)
+	if (set->sysclk) {
 		ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk, 0);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dai->dev, "simple-card: set_sysclk error\n");
+			return ret;
+		}
+	}
 
-	return ret;
+	return 0;
 }
 
 static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
-- 
1.8.4
