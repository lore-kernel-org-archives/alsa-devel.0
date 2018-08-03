From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: smd845: fix memory leak" to the asoc
	tree
Date: Fri,  3 Aug 2018 18:01:53 +0100 (BST)
Message-ID: <20180803170153.2FC2C1123AA1@debutante.sirena.org.uk>
References: <20180803134211.GA24593@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B17632677E7
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 19:01:53 +0200 (CEST)
In-Reply-To: <20180803134211.GA24593@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: smd845: fix memory leak

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 8530ebf1079ccc84ffa32d970cdcae168b2f3684 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Fri, 3 Aug 2018 08:42:11 -0500
Subject: [PATCH] ASoC: smd845: fix memory leak

In case memory resources for *card* were allocated, release them before
return.

Addresses-Coverity-ID: 1472244 ("Resource leak")
Fixes: 6b1687bf76ef ("ASoC: qcom: add sdm845 sound card support")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index be0cb1122036..c1adb77230eb 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -222,8 +222,10 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 
 	/* Allocate the private data */
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
+	if (!data) {
+		ret = -ENOMEM;
+		goto data_alloc_fail;
+	}
 
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
@@ -248,6 +250,7 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 	kfree(card->dai_link);
 parse_dt_fail:
 	kfree(data);
+data_alloc_fail:
 	kfree(card);
 	return ret;
 }
-- 
2.18.0
