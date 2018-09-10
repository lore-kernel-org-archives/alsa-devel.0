From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tscs454: use
	devm_snd_soc_register_component()" to the asoc tree
Date: Mon, 10 Sep 2018 15:21:51 +0100 (BST)
Message-ID: <20180910142151.87F7B1122D51@debutante.sirena.org.uk>
References: <87in3irusn.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 14B8E267803
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 16:21:51 +0200 (CEST)
In-Reply-To: <87in3irusn.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tscs454: use devm_snd_soc_register_component()

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

>From 007ac42db9ff4c36e91d192353421c6209058e06 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 7 Sep 2018 01:01:50 +0000
Subject: [PATCH] ASoC: tscs454: use devm_snd_soc_register_component()

Now we have devm_snd_soc_register_component().
Let's use it instead of snd_soc_register_component().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs454.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
index ff85a0bf6170..93d84e5ae2d5 100644
--- a/sound/soc/codecs/tscs454.c
+++ b/sound/soc/codecs/tscs454.c
@@ -3459,7 +3459,7 @@ static int tscs454_i2c_probe(struct i2c_client *i2c,
 	/* Sync pg sel reg with cache */
 	regmap_write(tscs454->regmap, R_PAGESEL, 0x00);
 
-	ret = snd_soc_register_component(&i2c->dev, &soc_component_dev_tscs454,
+	ret = devm_snd_soc_register_component(&i2c->dev, &soc_component_dev_tscs454,
 			tscs454_dais, ARRAY_SIZE(tscs454_dais));
 	if (ret) {
 		dev_err(&i2c->dev, "Failed to register component (%d)\n", ret);
-- 
2.19.0.rc1
