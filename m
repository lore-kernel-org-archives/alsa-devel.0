From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4118: use
	devm_snd_soc_register_component()" to the asoc tree
Date: Tue,  2 Jul 2019 14:04:40 +0100 (BST)
Message-ID: <20190702130440.3E08444004A@finisterre.sirena.org.uk>
References: <87tvcas68e.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCF0CF800C7
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 15:04:41 +0200 (CEST)
In-Reply-To: <87tvcas68e.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4118: use devm_snd_soc_register_component()

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

>From 35407f9ffd84560501f72ee3954344f8e5b49264 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Jun 2019 13:09:40 +0900
Subject: [PATCH] ASoC: ak4118: use devm_snd_soc_register_component()

We have devm_xxx version of snd_soc_register_component,
let's use it.

This patch also removes related empty functions

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4118.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/ak4118.c b/sound/soc/codecs/ak4118.c
index ce419e8cf890..f44d9a4a8507 100644
--- a/sound/soc/codecs/ak4118.c
+++ b/sound/soc/codecs/ak4118.c
@@ -400,14 +400,8 @@ static int ak4118_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	return snd_soc_register_component(&i2c->dev, &soc_component_drv_ak4118,
-					  &ak4118_dai, 1);
-}
-
-static int ak4118_i2c_remove(struct i2c_client *i2c)
-{
-	snd_soc_unregister_component(&i2c->dev);
-	return 0;
+	return devm_snd_soc_register_component(&i2c->dev,
+				&soc_component_drv_ak4118, &ak4118_dai, 1);
 }
 
 static const struct of_device_id ak4118_of_match[] = {
@@ -429,7 +423,6 @@ static struct i2c_driver ak4118_i2c_driver = {
 	},
 	.id_table = ak4118_id_table,
 	.probe  = ak4118_i2c_probe,
-	.remove = ak4118_i2c_remove,
 };
 
 module_i2c_driver(ak4118_i2c_driver);
-- 
2.20.1
