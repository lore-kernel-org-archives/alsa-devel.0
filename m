From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt286: Fix run time error while
	modifying const data" to the asoc tree
Date: Wed, 07 Oct 2015 10:48:32 +0100
Message-ID: <E1ZjlKq-0002iU-2a@finisterre>
References: <1444051360.13473.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94F42265AE8
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 11:48:54 +0200 (CEST)
In-Reply-To: <1444051360.13473.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt286: Fix run time error while modifying const data

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

>From dc6d84c69cf8296b1e8e2fd0b1e115b7787ef4e9 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 5 Oct 2015 21:22:40 +0800
Subject: [PATCH] ASoC: rt286: Fix run time error while modifying const data

Make a copy of memory for index_cache rather than directly use the
rt286_index_def to avoid run time error.

Fixes: c418a84a8c8f ("ASoC: Constify reg_default tables")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt286.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index bd93658..2088dfa 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -38,7 +38,7 @@
 #define RT288_VENDOR_ID 0x10ec0288
 
 struct rt286_priv {
-	const struct reg_default *index_cache;
+	struct reg_default *index_cache;
 	int index_cache_size;
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
@@ -1161,7 +1161,11 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 		return -ENODEV;
 	}
 
-	rt286->index_cache = rt286_index_def;
+	rt286->index_cache = devm_kmemdup(&i2c->dev, rt286_index_def,
+					  sizeof(rt286_index_def), GFP_KERNEL);
+	if (!rt286->index_cache)
+		return -ENOMEM;
+
 	rt286->index_cache_size = INDEX_CACHE_SIZE;
 	rt286->i2c = i2c;
 	i2c_set_clientdata(i2c, rt286);
-- 
2.5.0
