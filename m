From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Add the missing register in the
	readable table" to the asoc tree
Date: Mon, 16 Apr 2018 18:15:21 +0100
Message-ID: <E1f87ir-0002vM-4o@debutante>
References: <1522395715-14870-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 63D142673D2
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 19:15:24 +0200 (CEST)
In-Reply-To: <1522395715-14870-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Add the missing register in the readable table

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

>From 5ef5ac8de125fe6b4b23293bee026ca7ea1529b9 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Fri, 30 Mar 2018 15:41:55 +0800
Subject: [PATCH] ASoC: rt5514: Add the missing register in the readable table

The patch adds the missing register in the readable table.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index e8a66b03faab..1570b91bf018 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -89,6 +89,7 @@ static const struct reg_default rt5514_reg[] = {
 	{RT5514_PLL3_CALIB_CTRL5,	0x40220012},
 	{RT5514_DELAY_BUF_CTRL1,	0x7fff006a},
 	{RT5514_DELAY_BUF_CTRL3,	0x00000000},
+	{RT5514_ASRC_IN_CTRL1,		0x00000003},
 	{RT5514_DOWNFILTER0_CTRL1,	0x00020c2f},
 	{RT5514_DOWNFILTER0_CTRL2,	0x00020c2f},
 	{RT5514_DOWNFILTER0_CTRL3,	0x10000362},
@@ -181,6 +182,7 @@ static bool rt5514_readable_register(struct device *dev, unsigned int reg)
 	case RT5514_PLL3_CALIB_CTRL5:
 	case RT5514_DELAY_BUF_CTRL1:
 	case RT5514_DELAY_BUF_CTRL3:
+	case RT5514_ASRC_IN_CTRL1:
 	case RT5514_DOWNFILTER0_CTRL1:
 	case RT5514_DOWNFILTER0_CTRL2:
 	case RT5514_DOWNFILTER0_CTRL3:
@@ -238,6 +240,7 @@ static bool rt5514_i2c_readable_register(struct device *dev,
 	case RT5514_DSP_MAPPING | RT5514_PLL3_CALIB_CTRL5:
 	case RT5514_DSP_MAPPING | RT5514_DELAY_BUF_CTRL1:
 	case RT5514_DSP_MAPPING | RT5514_DELAY_BUF_CTRL3:
+	case RT5514_DSP_MAPPING | RT5514_ASRC_IN_CTRL1:
 	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER0_CTRL1:
 	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER0_CTRL2:
 	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER0_CTRL3:
-- 
2.17.0
