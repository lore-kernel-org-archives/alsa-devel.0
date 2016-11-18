From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: Use devm_gpio_request_one()" to
	the asoc tree
Date: Fri, 18 Nov 2016 12:01:27 +0000
Message-ID: <E1c7hrD-0005Bj-5H@debutante>
References: <20161116130842.28182-2-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 912A0266DC0
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2016 13:01:37 +0100 (CET)
In-Reply-To: <20161116130842.28182-2-axel.lin@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <julia.lawall@lip6.fr>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: Use devm_gpio_request_one()

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

>From f2826c1fe5d071fa437d337c41df979b60f0fc32 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 16 Nov 2016 21:08:42 +0800
Subject: [PATCH] ASoC: rt5665: Use devm_gpio_request_one()

Simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 7dfaaf1c2d14..324461e985b3 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4677,11 +4677,9 @@ static int rt5665_i2c_probe(struct i2c_client *i2c,
 	}
 
 	if (gpio_is_valid(rt5665->pdata.ldo1_en)) {
-		if (devm_gpio_request(&i2c->dev, rt5665->pdata.ldo1_en,
-			"rt5665"))
+		if (devm_gpio_request_one(&i2c->dev, rt5665->pdata.ldo1_en,
+					  GPIOF_OUT_INIT_HIGH, "rt5665"))
 			dev_err(&i2c->dev, "Fail gpio_request gpio_ldo\n");
-		else if (gpio_direction_output(rt5665->pdata.ldo1_en, 1))
-			dev_err(&i2c->dev, "Fail gpio_direction gpio_ldo\n");
 	}
 
 	/* Sleep for 300 ms miniumum */
-- 
2.10.2
