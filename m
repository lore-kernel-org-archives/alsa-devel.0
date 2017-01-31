From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci - Fix possible NULL
	derefrence." to the asoc tree
Date: Tue, 31 Jan 2017 20:02:35 +0000
Message-ID: <E1cYedP-0005ci-KU@debutante>
References: <1485515457-3055-1-git-send-email-shailendra.v@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A6482673B0
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 21:02:54 +0100 (CET)
In-Reply-To: <1485515457-3055-1-git-send-email-shailendra.v@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shailendra Verma <shailendra.v@samsung.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, ashish.kalra@samsung.com, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, p.shailesh@samsung.com, Mark Brown <broonie@kernel.org>, Shailendra Verma <shailendra.capricorn@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci - Fix possible NULL derefrence.

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3f81d9aa80ae4b513416440e416a6486ef2ad817 Mon Sep 17 00:00:00 2001
From: Shailendra Verma <shailendra.v@samsung.com>
Date: Fri, 27 Jan 2017 16:40:57 +0530
Subject: [PATCH] ASoC: davinci - Fix possible NULL derefrence.

of_match_device could return NULL, and so can cause a NULL
pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-evm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 731fb0d86c6a..7a369e0f2093 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -358,13 +358,20 @@ static struct snd_soc_card evm_soc_card = {
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
2.11.0
