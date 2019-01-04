From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Variable "val" in function
	rt274_i2c_probe() could be uninitialized" to the asoc tree
Date: Fri,  4 Jan 2019 14:01:00 +0000 (GMT)
Message-ID: <20190104140100.790D911270A3@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B0F9267B42
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 15:01:04 +0100 (CET)
In-Reply-To: 
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

   ASoC: Variable "val" in function rt274_i2c_probe() could be uninitialized

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

>From 8c3590de0a378c2449fc1aec127cc693632458e4 Mon Sep 17 00:00:00 2001
From: Yizhuo <yzhai003@ucr.edu>
Date: Thu, 3 Jan 2019 13:59:12 -0800
Subject: [PATCH] ASoC: Variable "val" in function rt274_i2c_probe() could be
 uninitialized

Inside function rt274_i2c_probe(), if regmap_read() function
returns -EINVAL, then local variable "val" leaves uninitialized
but used in if statement. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt274.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 0ef966d56bac..e2855ab9a2c6 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1128,8 +1128,11 @@ static int rt274_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	regmap_read(rt274->regmap,
+	ret = regmap_read(rt274->regmap,
 		RT274_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &val);
+	if (ret)
+		return ret;
+
 	if (val != RT274_VENDOR_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt274\n", val);
-- 
2.20.1
