From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: improve PLL function's
	stability" to the asoc tree
Date: Thu, 17 May 2018 18:12:51 +0100 (BST)
Message-ID: <20180517171251.C40DA44007C@finisterre.ee.mobilebroadband>
References: <1526536448-1603-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DAC62675CD
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 19:12:55 +0200 (CEST)
In-Reply-To: <1526536448-1603-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5670: improve PLL function's stability

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

>From 81dd1c5dcf510a2104b3468e9c4884f85ef1f644 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 17 May 2018 13:54:08 +0800
Subject: [PATCH] ASoC: rt5670: improve PLL function's stability

Set PR-38 register to 0x1fe1 will make PLL function more stable.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index dc7df337d5f8..732ef928b25d 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -71,7 +71,7 @@ static const struct regmap_range_cfg rt5670_ranges[] = {
 
 static const struct reg_sequence init_list[] = {
 	{ RT5670_PR_BASE + 0x14, 0x9a8a },
-	{ RT5670_PR_BASE + 0x38, 0x3ba1 },
+	{ RT5670_PR_BASE + 0x38, 0x1fe1 },
 	{ RT5670_PR_BASE + 0x3d, 0x3640 },
 	{ 0x8a, 0x0123 },
 };
-- 
2.17.0
