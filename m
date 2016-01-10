From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: mark some registers precious"
	to the asoc tree
Date: Sun, 10 Jan 2016 12:22:26 +0000
Message-ID: <E1aIF0s-0008OV-7L@debutante>
References: <56771034.5080702@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E1F9260614
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:22:36 +0100 (CET)
In-Reply-To: <56771034.5080702@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: mark some registers precious

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

>From f51e3d5372b4bf80006cdc1694a7656aba7c9b58 Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Sun, 20 Dec 2015 21:31:48 +0100
Subject: [PATCH] ASoC: fsl_ssi: mark some registers precious

Mark some registers precious since their
reads have side effects (like clearing flags).

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index cc22354d7758..40dfd8a36484 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -157,6 +157,21 @@ static bool fsl_ssi_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool fsl_ssi_precious_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CCSR_SSI_SRX0:
+	case CCSR_SSI_SRX1:
+	case CCSR_SSI_SISR:
+	case CCSR_SSI_SACADD:
+	case CCSR_SSI_SACDAT:
+	case CCSR_SSI_SATAG:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool fsl_ssi_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -179,6 +194,7 @@ static const struct regmap_config fsl_ssi_regconfig = {
 	.num_reg_defaults = ARRAY_SIZE(fsl_ssi_reg_defaults),
 	.readable_reg = fsl_ssi_readable_reg,
 	.volatile_reg = fsl_ssi_volatile_reg,
+	.precious_reg = fsl_ssi_precious_reg,
 	.writeable_reg = fsl_ssi_writeable_reg,
 	.cache_type = REGCACHE_RBTREE,
 };
-- 
2.7.0.rc3
