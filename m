From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rename functions that pollute the
	simple_xxx namespace" to the asoc tree
Date: Tue, 21 May 2019 21:32:43 +0100 (BST)
Message-ID: <20190521203243.280541126D21@debutante.sirena.org.uk>
References: <20190516102641.6574-2-amir73il@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 187AFF8972A
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 22:32:55 +0200 (CEST)
In-Reply-To: <20190516102641.6574-2-amir73il@gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: alsa-devel@alsa-project.org, Jan Kara <jack@suse.cz>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Matthew Bobrowski <mbobrowski@mbobrowski.org>, linux-fsdevel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rename functions that pollute the simple_xxx namespace

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From b0a821daf0d04e5a8ae99829e24f2fe538f25763 Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 16 May 2019 13:26:28 +0300
Subject: [PATCH] ASoC: rename functions that pollute the simple_xxx namespace

include/linux/fs.h defines a bunch of simple fs helpers, (e.g.
simple_rename) and we intend to add an fs helper named simple_remove.

Rename the ASoC driver static functions, so they will not collide with
the upcoming fs helper function name.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 9b568f578bcd..d16e894fce2b 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -607,7 +607,7 @@ static int simple_soc_probe(struct snd_soc_card *card)
 	return 0;
 }
 
-static int simple_probe(struct platform_device *pdev)
+static int asoc_simple_probe(struct platform_device *pdev)
 {
 	struct asoc_simple_priv *priv;
 	struct device *dev = &pdev->dev;
@@ -705,7 +705,7 @@ static int simple_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int simple_remove(struct platform_device *pdev)
+static int asoc_simple_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -726,8 +726,8 @@ static struct platform_driver asoc_simple_card = {
 		.pm = &snd_soc_pm_ops,
 		.of_match_table = simple_of_match,
 	},
-	.probe = simple_probe,
-	.remove = simple_remove,
+	.probe = asoc_simple_probe,
+	.remove = asoc_simple_remove,
 };
 
 module_platform_driver(asoc_simple_card);
-- 
2.20.1
