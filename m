From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas571x: Kill BUG_ON() usage" to the
	asoc tree
Date: Wed, 20 Sep 2017 04:47:54 -0700 (PDT)
Message-ID: <20170920114754.E69A24400D3@finisterre.ee.mobilebroadband>
References: <20170907085918.4496-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7381426752C
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 13:47:55 +0200 (CEST)
In-Reply-To: <20170907085918.4496-2-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas571x: Kill BUG_ON() usage

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

>From a029ef45179d72945c7ae0a11f97e8012a5574ac Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 7 Sep 2017 10:59:16 +0200
Subject: [PATCH] ASoC: tas571x: Kill BUG_ON() usage

Don't use BUG_ON() for a non-critical sanity check on production
systems.  This patch replaces with a softer WARN_ON() and an error
path.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas571x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 810369f687d7..a09499977be4 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -697,7 +697,8 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 		return PTR_ERR(priv->mclk);
 	}
 
-	BUG_ON(priv->chip->num_supply_names > TAS571X_MAX_SUPPLIES);
+	if (WARN_ON(priv->chip->num_supply_names > TAS571X_MAX_SUPPLIES))
+		return -EINVAL;
 	for (i = 0; i < priv->chip->num_supply_names; i++)
 		priv->supplies[i].supply = priv->chip->supply_names[i];
 
-- 
2.13.2
