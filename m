From: Pavel Machek <pavel@ucw.cz>
Subject: multi-card support for davinci-evm
Date: Mon, 30 Nov 2015 12:33:56 +0100
Message-ID: <20151130113356.GA32172@amd>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
 <20151012090045.GA7448@amd>
 <20151012113702.GC8805@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151012113702.GC8805@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

If I undestand things correctly... when there's more than one wm5102,
we need to dynamically allocate struct snd_soc_card. So something like this?

(Patch from v4.2)

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 731fb0d..718631a 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -364,8 +516,11 @@ static int davinci_evm_probe(struct platform_device *pdev)
 	struct snd_soc_card_drvdata_davinci *drvdata = NULL;
 	struct clk *mclk;
 	int ret = 0;
+	struct snd_soc_card *card = devm_kzalloc(&pdev->dev, sizeof(struct snd_soc_card), GFP_KERNEL);
+
+	*card = evm_soc_card;
 
-	evm_soc_card.dai_link = dai;
+	card->dai_link = dai;
 
 	dai->codec_of_node = of_parse_phandle(np, "ti,audio-codec", 0);
 	if (!dai->codec_of_node)
@@ -377,8 +533,8 @@ static int davinci_evm_probe(struct platform_device *pdev)
 
 	dai->platform_of_node = dai->cpu_of_node;
 
-	evm_soc_card.dev = &pdev->dev;
-	ret = snd_soc_of_parse_card_name(&evm_soc_card, "ti,model");
+	card->dev = &pdev->dev;
+	ret = snd_soc_of_parse_card_name(card, "ti,model");
 	if (ret)
 		return ret;
 
@@ -415,8 +588,8 @@ static int davinci_evm_probe(struct platform_device *pdev)
 				 requestd_rate, drvdata->sysclk);
 	}
 
-	snd_soc_card_set_drvdata(&evm_soc_card, drvdata);
-	ret = devm_snd_soc_register_card(&pdev->dev, &evm_soc_card);
+	snd_soc_card_set_drvdata(card, drvdata);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
