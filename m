From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: enable speaker protection
	features" to the asoc tree
Date: Wed, 28 Jun 2017 20:23:23 +0100
Message-ID: <E1dQIYd-0004Fv-Bp@finisterre>
References: <1498529129-30647-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B1B68266D55
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 21:23:50 +0200 (CEST)
In-Reply-To: <1498529129-30647-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, alexlee@realtek.com, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: enable speaker protection features

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

>From 105e56f1ec335ab62b920882e755da49e81e5b60 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 27 Jun 2017 10:05:29 +0800
Subject: [PATCH] ASoC: rt5645: enable speaker protection features

This patch is uploaded for enabling the speaker protection features
of the audio codec.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 308c22f5909a..630374ee692a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -59,7 +59,7 @@ static const struct regmap_range_cfg rt5645_ranges[] = {
 
 static const struct reg_sequence init_list[] = {
 	{RT5645_PR_BASE + 0x3d,	0x3600},
-	{RT5645_PR_BASE + 0x1c,	0xfd20},
+	{RT5645_PR_BASE + 0x1c,	0xfd70},
 	{RT5645_PR_BASE + 0x20,	0x611f},
 	{RT5645_PR_BASE + 0x21,	0x4040},
 	{RT5645_PR_BASE + 0x23,	0x0004},
@@ -3759,6 +3759,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 					   ret);
 	}
 
+	regmap_update_bits(rt5645->regmap, RT5645_CLSD_OUT_CTRL, 0xc0, 0xc0);
+
 	if (rt5645->pdata.in2_diff)
 		regmap_update_bits(rt5645->regmap, RT5645_IN2_CTRL,
 					RT5645_IN_DF2, RT5645_IN_DF2);
-- 
2.13.2
