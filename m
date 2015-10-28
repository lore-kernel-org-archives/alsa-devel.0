From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_spdif: STL and STR registers are
	non volatile" to the asoc tree
Date: Wed, 28 Oct 2015 10:09:04 +0900
Message-ID: <E1ZrFEe-0000uE-7T@finisterre>
References: <1445843945-13319-3-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66507265838
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 02:09:16 +0100 (CET)
In-Reply-To: <1445843945-13319-3-git-send-email-zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_spdif: STL and STR registers are non volatile

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

>From 2a0035113a0f16305476083fc6bacdd0e29b1e5f Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Mon, 26 Oct 2015 15:19:04 +0800
Subject: [PATCH] ASoC: fsl_spdif: STL and STR registers are non volatile

STL and STR registers are writable and not readable. So they are non volatile.
Remove them from volatile list, and add default register value for them.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_spdif.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 3d59bb6..28a8823 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1006,12 +1006,14 @@ static const struct snd_soc_component_driver fsl_spdif_component = {
 
 /* FSL SPDIF REGMAP */
 static const struct reg_default fsl_spdif_reg_defaults[] = {
-	{0x0,  0x00000400},
-	{0x4,  0x00000000},
-	{0xc,  0x00000000},
-	{0x34, 0x00000000},
-	{0x38, 0x00000000},
-	{0x50, 0x00020f00},
+	{REG_SPDIF_SCR,    0x00000400},
+	{REG_SPDIF_SRCD,   0x00000000},
+	{REG_SPDIF_SIE,	   0x00000000},
+	{REG_SPDIF_STL,	   0x00000000},
+	{REG_SPDIF_STR,	   0x00000000},
+	{REG_SPDIF_STCSCH, 0x00000000},
+	{REG_SPDIF_STCSCL, 0x00000000},
+	{REG_SPDIF_STC,	   0x00020f00},
 };
 
 static bool fsl_spdif_readable_reg(struct device *dev, unsigned int reg)
@@ -1049,8 +1051,6 @@ static bool fsl_spdif_volatile_reg(struct device *dev, unsigned int reg)
 	case REG_SPDIF_SRCSL:
 	case REG_SPDIF_SRU:
 	case REG_SPDIF_SRQ:
-	case REG_SPDIF_STL:
-	case REG_SPDIF_STR:
 	case REG_SPDIF_SRFM:
 		return true;
 	default:
-- 
2.6.1
