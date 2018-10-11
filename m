From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98373: Sort max98373_bde_gain_tlv in
	reverse order" to the asoc tree
Date: Thu, 11 Oct 2018 15:46:04 +0100 (BST)
Message-ID: <20181011144604.39AC111223ED@debutante.sirena.org.uk>
References: <20181010232222.52340-3-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A4FCD2677F0
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2018 16:46:04 +0200 (CEST)
In-Reply-To: <20181010232222.52340-3-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc: alsa-devel@alsa-project.org, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>, Ryan Lee <ryans.lee@maximintegrated.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98373: Sort max98373_bde_gain_tlv in reverse order

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

>From d34c8f37c75b739efc26383145a43497143ada88 Mon Sep 17 00:00:00 2001
From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Date: Wed, 10 Oct 2018 23:26:13 +0000
Subject: [PATCH] ASoC: max98373: Sort max98373_bde_gain_tlv in reverse order

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 38871677cbae..37f8bcdd8e35 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -483,7 +483,7 @@ static const DECLARE_TLV_DB_RANGE(max98373_limiter_thresh_tlv,
 );
 
 static const DECLARE_TLV_DB_RANGE(max98373_bde_gain_tlv,
-	0, 60, TLV_DB_SCALE_ITEM(0, -25, 0),
+	0, 60, TLV_DB_SCALE_ITEM(-1500, 25, 0),
 );
 
 static bool max98373_readable_register(struct device *dev, unsigned int reg)
@@ -654,21 +654,21 @@ SOC_SINGLE("BDE Hold Time", MAX98373_R2090_BDE_LVL_HOLD, 0, 0xFF, 0),
 SOC_SINGLE("BDE Attack Rate", MAX98373_R2091_BDE_GAIN_ATK_REL_RATE, 4, 0xF, 0),
 SOC_SINGLE("BDE Release Rate", MAX98373_R2091_BDE_GAIN_ATK_REL_RATE, 0, 0xF, 0),
 SOC_SINGLE_TLV("BDE LVL1 Clip Thresh Volume", MAX98373_R20A9_BDE_L1_CFG_2,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL2 Clip Thresh Volume", MAX98373_R20AC_BDE_L2_CFG_2,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL3 Clip Thresh Volume", MAX98373_R20AF_BDE_L3_CFG_2,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL4 Clip Thresh Volume", MAX98373_R20B2_BDE_L4_CFG_2,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL1 Clip Reduction Volume", MAX98373_R20AA_BDE_L1_CFG_3,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL2 Clip Reduction Volume", MAX98373_R20AD_BDE_L2_CFG_3,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL3 Clip Reduction Volume", MAX98373_R20B0_BDE_L3_CFG_3,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL4 Clip Reduction Volume", MAX98373_R20B3_BDE_L4_CFG_3,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL1 Limiter Thresh Volume", MAX98373_R20A8_BDE_L1_CFG_1,
 	0, 0xF, 1, max98373_limiter_thresh_tlv),
 SOC_SINGLE_TLV("BDE LVL2 Limiter Thresh Volume", MAX98373_R20AB_BDE_L2_CFG_1,
-- 
2.19.0.rc2
