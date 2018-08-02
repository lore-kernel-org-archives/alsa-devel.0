From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: smd845: remove auto rebinding" to the
	asoc tree
Date: Thu,  2 Aug 2018 17:20:57 +0100 (BST)
Message-ID: <20180802162057.3C32E1121BE5@debutante.sirena.org.uk>
References: <20180802150338.24538-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BF9102677E3
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 18:20:58 +0200 (CEST)
In-Reply-To: <20180802150338.24538-3-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: stefan.wahren@i2se.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, guillaume.tucker@collabora.com, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, rohitkr@codeaurora.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: smd845: remove auto rebinding

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

>From 62121debfb31a8700e387bd2987779b3a98bc520 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 2 Aug 2018 16:03:37 +0100
Subject: [PATCH] ASoC: smd845: remove auto rebinding

Remove auto rebinding support, as component framework can deadlock
in few usecases if we are trying to add new/remove component within
a bind/unbind callbacks.

Card rebinding is ASoC core feature so all the previous component
framework stuff in q6dsp remains removed.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index bf4ec4646906..be0cb1122036 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -226,7 +226,6 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	card->dev = dev;
-	card->auto_bind = true;
 	dev_set_drvdata(dev, card);
 	ret = qcom_snd_parse_of(card);
 	if (ret) {
@@ -258,7 +257,6 @@ static int sdm845_snd_platform_remove(struct platform_device *pdev)
 	struct snd_soc_card *card = dev_get_drvdata(&pdev->dev);
 	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
 
-	card->auto_bind = false;
 	snd_soc_unregister_card(card);
 	kfree(card->dai_link);
 	kfree(data);
-- 
2.18.0
