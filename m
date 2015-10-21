From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt298: Make rt298_index_def const" to
	the asoc tree
Date: Wed, 21 Oct 2015 13:34:24 +0100
Message-ID: <E1Zosb2-00040E-3K@finisterre>
References: <1444051428.13473.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71EE52666C1
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 14:34:38 +0200 (CEST)
In-Reply-To: <1444051428.13473.2.camel@ingics.com>
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

   ASoC: rt298: Make rt298_index_def const

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

>From 9eee0988f01758515ff54a5cba76c1ff24ad3d92 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 5 Oct 2015 21:23:48 +0800
Subject: [PATCH] ASoC: rt298: Make rt298_index_def const

The index_cache is per instance run time state but rt298_index_def is not.
Make rt298_index_def const and make a copy of memory for index_cache rather
than directly use the rt298_index_def.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt298.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 3c2f0f8..ef8e23a 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -49,7 +49,7 @@ struct rt298_priv {
 	int is_hp_in;
 };
 
-static struct reg_default rt298_index_def[] = {
+static const struct reg_default rt298_index_def[] = {
 	{ 0x01, 0xaaaa },
 	{ 0x02, 0x8aaa },
 	{ 0x03, 0x0002 },
@@ -1165,7 +1165,11 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 		return -ENODEV;
 	}
 
-	rt298->index_cache = rt298_index_def;
+	rt298->index_cache = devm_kmemdup(&i2c->dev, rt298_index_def,
+					  sizeof(rt298_index_def), GFP_KERNEL);
+	if (!rt298->index_cache)
+		return -ENOMEM;
+
 	rt298->index_cache_size = INDEX_CACHE_SIZE;
 	rt298->i2c = i2c;
 	i2c_set_clientdata(i2c, rt298);
-- 
2.6.1
