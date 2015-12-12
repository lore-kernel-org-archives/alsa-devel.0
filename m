From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Atmel: ClassD: unregister codec when
	error occurs" to the asoc tree
Date: Sat, 12 Dec 2015 23:07:23 +0000
Message-ID: <E1a7tG7-0002cN-MB@finisterre>
References: <1449803257-27255-1-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 222EB26085B
 for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2015 00:07:32 +0100 (CET)
In-Reply-To: <1449803257-27255-1-git-send-email-songjun.wu@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Songjun Wu <songjun.wu@atmel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Atmel: ClassD: unregister codec when error occurs

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

>From 32e69bad8ed9ed4e1bf1fd8217b61d5f87996253 Mon Sep 17 00:00:00 2001
From: Songjun Wu <songjun.wu@atmel.com>
Date: Fri, 11 Dec 2015 11:07:37 +0800
Subject: [PATCH] ASoC: Atmel: ClassD: unregister codec when error occurs

Add code to unregister codec in probe function,
when the error occurs after the codec is registered.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel-classd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 8276675..f3ffb39 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -636,8 +636,10 @@ static int atmel_classd_probe(struct platform_device *pdev)
 
 	/* register sound card */
 	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
-	if (!card)
-		return -ENOMEM;
+	if (!card) {
+		ret = -ENOMEM;
+		goto unregister_codec;
+	}
 
 	snd_soc_card_set_drvdata(card, dd);
 	platform_set_drvdata(pdev, card);
@@ -645,16 +647,20 @@ static int atmel_classd_probe(struct platform_device *pdev)
 	ret = atmel_classd_asoc_card_init(dev, card);
 	if (ret) {
 		dev_err(dev, "failed to init sound card\n");
-		return ret;
+		goto unregister_codec;
 	}
 
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret) {
 		dev_err(dev, "failed to register sound card: %d\n", ret);
-		return ret;
+		goto unregister_codec;
 	}
 
 	return 0;
+
+unregister_codec:
+	snd_soc_unregister_codec(dev);
+	return ret;
 }
 
 static int atmel_classd_remove(struct platform_device *pdev)
-- 
2.6.4
