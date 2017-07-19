From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt274: correct comment style" to the
	asoc tree
Date: Wed, 19 Jul 2017 12:27:23 +0100
Message-ID: <E1dXn8V-0002eu-2g@debutante>
References: <1500429132-28583-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D7BBA267348
 for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2017 13:27:37 +0200 (CEST)
In-Reply-To: <1500429132-28583-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, guneshwor.o.singh@intel.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt274: correct comment style

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

>From 49a69163ddbe47063be960ad5c2fcfe94c8b473b Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 19 Jul 2017 09:52:12 +0800
Subject: [PATCH] ASoC: rt274: correct comment style

There was a comment style issue in the driver.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt274.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 81e29ba2f50c..fb683ffc4e03 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1159,7 +1159,7 @@ static int rt274_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt274->regmap, 0x6f, 0x3000, 0x2000);
 	/* HP DC Calibration */
 	regmap_update_bits(rt274->regmap, 0x6f, 0xf, 0x0);
-	//Set NID=58h.Index 00h [15]= 1b;
+	/* Set NID=58h.Index 00h [15]= 1b; */
 	regmap_write(rt274->regmap, RT274_COEF58_INDEX, 0x00);
 	regmap_write(rt274->regmap, RT274_COEF58_COEF, 0xb888);
 	msleep(500);
-- 
2.13.2
