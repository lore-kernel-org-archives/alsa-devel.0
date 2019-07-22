From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt1308: add silence detection and
	manual PDB control" to the asoc tree
Date: Mon, 22 Jul 2019 13:22:06 +0100 (BST)
Message-ID: <20190722122206.488132740463@ypsilon.sirena.org.uk>
References: <20190719063249.18806-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0CA7F8045F
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 14:22:08 +0200 (CEST)
In-Reply-To: <20190719063249.18806-1-shumingf@realtek.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Shuming Fan <shumingf@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, derek.fang@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt1308: add silence detection and manual PDB control

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

>From 607b9c8a850e505b02659f1552da123965e00270 Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Fri, 19 Jul 2019 14:32:49 +0800
Subject: [PATCH] ASoC: rt1308: add silence detection and manual PDB control

We enable the silence detection function in initial settings.
PDB control changes to manual mode, hence the driver could
fully control the AMP output on/off.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Link: https://lore.kernel.org/r/20190719063249.18806-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1308.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
index 19d255e01827..cf3d72f99705 100755
--- a/sound/soc/codecs/rt1308.c
+++ b/sound/soc/codecs/rt1308.c
@@ -40,10 +40,10 @@ static const struct reg_sequence init_list[] = {
 	{ RT1308_VREF,			0x18100000 },
 	{ RT1308_IV_SENSE,		0x87010000 },
 	{ RT1308_DUMMY_REG,		0x00000200 },
-	{ RT1308_SIL_DET,		0x61c30000 },
+	{ RT1308_SIL_DET,		0xe1c30000 },
 	{ RT1308_DC_CAL_2,		0x00ffff00 },
 	{ RT1308_CLK_DET,		0x01000000 },
-	{ RT1308_POWER_STATUS,		0x00800000 },
+	{ RT1308_POWER_STATUS,		0x08800000 },
 	{ RT1308_DAC_SET,		0xafaf0700 },
 
 };
@@ -308,12 +308,13 @@ static int rt1308_classd_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 		msleep(30);
 		snd_soc_component_update_bits(component, RT1308_POWER_STATUS,
-			RT1308_POW_PDB_REG_BIT, RT1308_POW_PDB_REG_BIT);
+			RT1308_POW_PDB_REG_BIT | RT1308_POW_PDB_MN_BIT,
+			RT1308_POW_PDB_REG_BIT | RT1308_POW_PDB_MN_BIT);
 		msleep(40);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		snd_soc_component_update_bits(component, RT1308_POWER_STATUS,
-			RT1308_POW_PDB_REG_BIT, 0);
+			RT1308_POW_PDB_REG_BIT | RT1308_POW_PDB_MN_BIT, 0);
 		usleep_range(150000, 200000);
 		break;
 
-- 
2.20.1
