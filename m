From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: increase LDO level" to the asoc
	tree
Date: Wed, 08 Mar 2017 14:23:17 +0100
Message-ID: <E1clbYj-0000Ln-81@finisterre>
References: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 248B62671B2
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 14:23:31 +0100 (CET)
In-Reply-To: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: increase LDO level

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

>From 593dd5d9fb66c0345cef5fc8caf4199bb6d4e093 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 8 Mar 2017 19:05:29 +0800
Subject: [PATCH] ASoC: rt5665: increase LDO level

Too low LDO level will cause a few functions unstable.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index fe2cf1ed8237..a4c07c2ee414 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4798,7 +4798,7 @@ static int rt5665_i2c_probe(struct i2c_client *i2c,
 	/* Enhance performance*/
 	regmap_update_bits(rt5665->regmap, RT5665_PWR_ANLG_1,
 		RT5665_HP_DRIVER_MASK | RT5665_LDO1_DVO_MASK,
-		RT5665_HP_DRIVER_5X | RT5665_LDO1_DVO_09);
+		RT5665_HP_DRIVER_5X | RT5665_LDO1_DVO_12);
 
 	INIT_DELAYED_WORK(&rt5665->jack_detect_work,
 				rt5665_jack_detect_handler);
-- 
2.11.0
