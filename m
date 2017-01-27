From: Shailendra Verma <shailendra.v@samsung.com>
Subject: [PATCH] sound: soc: davinci - Fix possible NULL derefrence.
Date: Fri, 27 Jan 2017 16:40:57 +0530
Message-ID: <1485515457-3055-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170127111104epcas1p2810feef80b04b21983efd16c00b1b651@epcas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.v@samsung.com>, Shailendra Verma <shailendra.capricorn@gmail.com>
List-Id: alsa-devel@alsa-project.org

of_match_device could return NULL, and so can cause a NULL
pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 sound/soc/davinci/davinci-evm.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 731fb0d..7a369e0 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -358,13 +358,20 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 static int davinci_evm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match =
-		of_match_device(of_match_ptr(davinci_evm_dt_ids), &pdev->dev);
-	struct snd_soc_dai_link *dai = (struct snd_soc_dai_link *) match->data;
+	const struct of_device_id *match;
+	struct snd_soc_dai_link *dai;
 	struct snd_soc_card_drvdata_davinci *drvdata = NULL;
 	struct clk *mclk;
 	int ret = 0;
 
+	match = of_match_device(of_match_ptr(davinci_evm_dt_ids), &pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "Error: No device match found\n");
+		return -ENODEV;
+	}
+
+	dai = (struct snd_soc_dai_link *) match->data;
+
 	evm_soc_card.dai_link = dai;
 
 	dai->codec_of_node = of_parse_phandle(np, "ti,audio-codec", 0);
-- 
1.7.9.5
