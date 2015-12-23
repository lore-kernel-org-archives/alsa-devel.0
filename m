From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5616: add an of_match table" to the
	asoc tree
Date: Wed, 23 Dec 2015 00:09:02 +0000
Message-ID: <E1aBWzG-0007Nn-WA@debutante>
References: <1450703894-32623-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C8F00265E24
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:09:07 +0100 (CET)
In-Reply-To: <1450703894-32623-1-git-send-email-wxt@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caesar Wang <wxt@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5616: add an of_match table

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

>From e17ff2de826f8c2153cf23c8bbd9097219a84fa9 Mon Sep 17 00:00:00 2001
From: Caesar Wang <wxt@rock-chips.com>
Date: Tue, 22 Dec 2015 13:45:02 +0800
Subject: [PATCH] ASoC: rt5616: add an of_match table

Add a device tree match table. This serves to make the driver's support
of device tree more explicit.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5616.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index 0e9414abab65..7bb56dddff8e 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -1287,6 +1287,14 @@ static const struct i2c_device_id rt5616_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5616_i2c_id);
 
+#if defined(CONFIG_OF)
+static const struct of_device_id rt5616_of_match[] = {
+	{ .compatible = "realtek,rt5616", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt5616_of_match);
+#endif
+
 static int rt5616_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -1359,6 +1367,7 @@ static void rt5616_i2c_shutdown(struct i2c_client *client)
 static struct i2c_driver rt5616_i2c_driver = {
 	.driver = {
 		.name = "rt5616",
+		.of_match_table = of_match_ptr(rt5616_of_match),
 	},
 	.probe = rt5616_i2c_probe,
 	.remove = rt5616_i2c_remove,
-- 
2.6.2
