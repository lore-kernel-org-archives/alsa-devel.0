From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: using macro for default
	register map" to the asoc tree
Date: Wed, 28 Oct 2015 10:09:02 +0900
Message-ID: <E1ZrFEc-0000tj-QY@finisterre>
References: <1445843945-13319-4-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CB732656F5
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 02:09:16 +0100 (CET)
In-Reply-To: <1445843945-13319-4-git-send-email-zidan.wang@freescale.com>
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

   ASoC: fsl_ssi: using macro for default register map

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

>From 43f20d51f4d5070f5e254119419ce2c98ab0c2bd Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Mon, 26 Oct 2015 15:19:05 +0800
Subject: [PATCH] ASoC: fsl_ssi: using macro for default register map

using macro for default register map

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 7c495d3..5908ec9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -113,17 +113,17 @@ struct fsl_ssi_rxtx_reg_val {
 };
 
 static const struct reg_default fsl_ssi_reg_defaults[] = {
-	{0x10, 0x00000000},
-	{0x18, 0x00003003},
-	{0x1c, 0x00000200},
-	{0x20, 0x00000200},
-	{0x24, 0x00040000},
-	{0x28, 0x00040000},
-	{0x38, 0x00000000},
-	{0x48, 0x00000000},
-	{0x4c, 0x00000000},
-	{0x54, 0x00000000},
-	{0x58, 0x00000000},
+	{CCSR_SSI_SCR,     0x00000000},
+	{CCSR_SSI_SIER,    0x00003003},
+	{CCSR_SSI_STCR,    0x00000200},
+	{CCSR_SSI_SRCR,    0x00000200},
+	{CCSR_SSI_STCCR,   0x00040000},
+	{CCSR_SSI_SRCCR,   0x00040000},
+	{CCSR_SSI_SACNT,   0x00000000},
+	{CCSR_SSI_STMSK,   0x00000000},
+	{CCSR_SSI_SRMSK,   0x00000000},
+	{CCSR_SSI_SACCEN,  0x00000000},
+	{CCSR_SSI_SACCDIS, 0x00000000},
 };
 
 static bool fsl_ssi_readable_reg(struct device *dev, unsigned int reg)
-- 
2.6.1
