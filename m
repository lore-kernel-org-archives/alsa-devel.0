From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs47l35: Use define for DSPCLK enable
	bit" to the asoc tree
Date: Mon, 22 Jul 2019 13:22:05 +0100 (BST)
Message-ID: <20190722122205.DB4322742C08@ypsilon.sirena.org.uk>
References: <20190722093516.12906-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98677F800E8
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 14:22:08 +0200 (CEST)
In-Reply-To: <20190722093516.12906-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs47l35: Use define for DSPCLK enable bit

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From fc3136e7e11f8e9a3cb8d6c880a5732013935661 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 22 Jul 2019 10:35:16 +0100
Subject: [PATCH] ASoC: cs47l35: Use define for DSPCLK enable bit

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20190722093516.12906-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs47l35.c b/sound/soc/codecs/cs47l35.c
index e3585c1dab3d..d396a8545d51 100644
--- a/sound/soc/codecs/cs47l35.c
+++ b/sound/soc/codecs/cs47l35.c
@@ -524,7 +524,7 @@ SND_SOC_DAPM_SUPPLY("SYSCLK", MADERA_SYSTEM_CLOCK_1, MADERA_SYSCLK_ENA_SHIFT,
 		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 SND_SOC_DAPM_SUPPLY("OPCLK", MADERA_OUTPUT_SYSTEM_CLOCK,
 		    MADERA_OPCLK_ENA_SHIFT, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("DSPCLK", MADERA_DSP_CLOCK_1, 6,
+SND_SOC_DAPM_SUPPLY("DSPCLK", MADERA_DSP_CLOCK_1, MADERA_DSP_CLK_ENA_SHIFT,
 		    0, NULL, 0),
 
 SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD2", 0, 0),
-- 
2.20.1
