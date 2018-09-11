From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5668: remove empty
	rt5668_i2c_remove()" to the asoc tree
Date: Tue, 11 Sep 2018 19:22:24 +0100 (BST)
Message-ID: <20180911182224.6BDB51121B1F@debutante.sirena.org.uk>
References: <87tvmw4j7i.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 15D8926784A
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 20:22:24 +0200 (CEST)
In-Reply-To: <87tvmw4j7i.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: rt5668: remove empty rt5668_i2c_remove()

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

>From a6ebf4c9770e918e601aa9bf4bc3cf4001dd3d4d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 11 Sep 2018 07:02:04 +0000
Subject: [PATCH] ASoC: rt5668: remove empty rt5668_i2c_remove()

rt5668_i2c_remove() is empty, and no longer needed.
Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5668.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 4412cd2910cd..85ba04d6e7ae 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -2591,11 +2591,6 @@ static int rt5668_i2c_probe(struct i2c_client *i2c,
 			rt5668_dai, ARRAY_SIZE(rt5668_dai));
 }
 
-static int rt5668_i2c_remove(struct i2c_client *i2c)
-{
-	return 0;
-}
-
 static void rt5668_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5668_priv *rt5668 = i2c_get_clientdata(client);
@@ -2626,7 +2621,6 @@ static struct i2c_driver rt5668_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(rt5668_acpi_match),
 	},
 	.probe = rt5668_i2c_probe,
-	.remove = rt5668_i2c_remove,
 	.shutdown = rt5668_i2c_shutdown,
 	.id_table = rt5668_i2c_id,
 };
-- 
2.19.0.rc2
