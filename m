From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2 1/7] ASoC: simple-card: fix __asoc_simple_card_dai_init
Date: Fri, 24 Jan 2014 15:43:00 +0800
Message-ID: <1390549386-4702-2-git-send-email-Li.Xiubo@freescale.com>
References: <1390549386-4702-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390549386-4702-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
Cc: rob@landley.net, perex@perex.cz, moinejf@free.fr, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

If the CPU/CODEC DAI set_sysclk() is not support, the -ENOTSUPP will returnd.
Here do the check like set_fmt().

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 6443c87..6366f3f 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -27,21 +27,29 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
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
+			goto err;
+		}
 	}
 
-	if (!ret && set->sysclk)
+	if (set->sysclk) {
 		ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk, 0);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dai->dev, "simple-card: set_sysclk error\n");
+			goto err;
+		}
+	}
+
+	ret = 0;
 
+err:
 	return ret;
 }
 
-- 
1.8.4
