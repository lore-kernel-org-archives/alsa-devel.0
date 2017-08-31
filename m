From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: ac97c: Fix an error handling path in 'atmel_ac97c_probe()'" to the asoc tree
Date: Thu, 31 Aug 2017 12:55:00 +0100
Message-ID: <E1dnO3o-0000oV-Qv@debutante>
References: <20170831044042.23306-1-christophe.jaillet@wanadoo.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170831044042.23306-1-christophe.jaillet@wanadoo.fr>
Sender: kernel-janitors-owner@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, arvind.yadav.cs@gmail.com, nicolas.ferre@microchip.combroonie@kernel.org, garsilva@embeddedor.com, andriy.shevchenko@linux.intel.com, bhumirks@gmail.comChristophe JAILLET <christophe.jaillet@wanadoo.fr>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: ac97c: Fix an error handling path in 'atmel_ac97c_probe()'

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

>From 0515760fa1159ffa863c7b2b73466aaff7d11a80 Mon Sep 17 00:00:00 2001
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Date: Thu, 31 Aug 2017 06:40:42 +0200
Subject: [PATCH] ALSA: ac97c: Fix an error handling path in
 'atmel_ac97c_probe()'

If 'clk_prepare_enable()' fails, we must release some resources before
returning. Add a new label in the existing error handling path and 'goto'
there.

Fixes: 260ea95cc027 ("ASoC: atmel: ac97c: Handle return value of clk_prepare_enable.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/atmel/ac97c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 52b0522fda20..d78405329ceb 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -785,7 +785,7 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 	}
 	retval = clk_prepare_enable(pclk);
 	if (retval)
-		return retval;
+		goto err_prepare_enable;
 
 	retval = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
 			      SNDRV_DEFAULT_STR1, THIS_MODULE,
@@ -881,6 +881,7 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 	snd_card_free(card);
 err_snd_card_new:
 	clk_disable_unprepare(pclk);
+err_prepare_enable:
 	clk_put(pclk);
 	return retval;
 }
-- 
2.14.1

