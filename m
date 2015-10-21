From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt298: fix wrong setting of gpio2_en"
	to the asoc tree
Date: Wed, 21 Oct 2015 13:34:20 +0100
Message-ID: <E1Zosay-0003zj-Au@finisterre>
References: <1445415499-29200-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 48B582606B7
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 14:34:32 +0200 (CEST)
In-Reply-To: <1445415499-29200-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt298: fix wrong setting of gpio2_en

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

>From f8f2dc4a7127725383c93b501fcc4e47871b0a9d Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 21 Oct 2015 16:18:18 +0800
Subject: [PATCH] ASoC: rt298: fix wrong setting of gpio2_en

The register value to enable gpio2 was incorrect. So fix it.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index d3e30a6..f823eb5 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1214,7 +1214,7 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 	mdelay(10);
 
 	if (!rt298->pdata.gpio2_en)
-		regmap_write(rt298->regmap, RT298_SET_DMIC2_DEFAULT, 0x4000);
+		regmap_write(rt298->regmap, RT298_SET_DMIC2_DEFAULT, 0x40);
 	else
 		regmap_write(rt298->regmap, RT298_SET_DMIC2_DEFAULT, 0);
 
-- 
2.6.1
