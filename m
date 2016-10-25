From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l73: Remove cache bypass for read
	of ID registers" to the asoc tree
Date: Tue, 25 Oct 2016 20:23:30 +0100
Message-ID: <E1bz7Jq-0004k6-5V@debutante>
References: <1477410151-17515-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 51E1A2606F8
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 21:23:38 +0200 (CEST)
In-Reply-To: <1477410151-17515-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: brian.austin@cirrus.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l73: Remove cache bypass for read of ID registers

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

>From ca493dabbc77a20c1df9a386f192126b863a2437 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 25 Oct 2016 16:42:31 +0100
Subject: [PATCH] ASoC: cs42l73: Remove cache bypass for read of ID registers

Don't manually enable cache_bypass for reading the ID registers they
don't have a default anyway so the first read will always hit the
hardware. The old code worked this is simply the more standard way
to implement this.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l73.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 71ba5605495f..3df2c473ab88 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1337,8 +1337,6 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 		gpio_set_value_cansleep(cs42l73->pdata.reset_gpio, 1);
 	}
 
-	regcache_cache_bypass(cs42l73->regmap, true);
-
 	/* initialize codec */
 	ret = regmap_read(cs42l73->regmap, CS42L73_DEVID_AB, &reg);
 	devid = (reg & 0xFF) << 12;
@@ -1366,8 +1364,6 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	dev_info(&i2c_client->dev,
 		 "Cirrus Logic CS42L73, Revision: %02X\n", reg & 0xFF);
 
-	regcache_cache_bypass(cs42l73->regmap, false);
-
 	ret =  snd_soc_register_codec(&i2c_client->dev,
 			&soc_codec_dev_cs42l73, cs42l73_dai,
 			ARRAY_SIZE(cs42l73_dai));
-- 
2.8.1
