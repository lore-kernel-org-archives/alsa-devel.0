From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Variable "ret" in function
	rt5651_i2c_probe() could be uninitialized" to the asoc tree
Date: Mon, 28 Jan 2019 12:35:16 +0000 (GMT)
Message-ID: <20190128123516.2E34D1127D29@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D9ED7267477
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 13:35:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yizhuo <yzhai003@ucr.edu>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Variable "ret" in function rt5651_i2c_probe() could be uninitialized

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

>From e20bfeb0b7d808bc05e7c4cb1f492cd31d837da0 Mon Sep 17 00:00:00 2001
From: Yizhuo <yzhai003@ucr.edu>
Date: Fri, 25 Jan 2019 10:45:37 -0800
Subject: [PATCH] ASoC: rt5651: Variable "ret" in function rt5651_i2c_probe()
 could be uninitialized

In function rt5651_i2c_probe(), local variable "ret" could
be uninitialized if function regmap_read() returns -EINVAL.
However, this value is used in if statement. This is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 75994297c896..29b2d60076b0 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -2181,6 +2181,7 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 {
 	struct rt5651_priv *rt5651;
 	int ret;
+	int err;
 
 	rt5651 = devm_kzalloc(&i2c->dev, sizeof(*rt5651),
 				GFP_KERNEL);
@@ -2197,7 +2198,10 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	regmap_read(rt5651->regmap, RT5651_DEVICE_ID, &ret);
+	err = regmap_read(rt5651->regmap, RT5651_DEVICE_ID, &ret);
+	if (err)
+		return err;
+
 	if (ret != RT5651_DEVICE_ID_VALUE) {
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt5651\n", ret);
-- 
2.20.1
