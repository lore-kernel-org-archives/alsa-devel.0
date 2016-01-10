From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: remove register defaults" to
	the asoc tree
Date: Sun, 10 Jan 2016 12:22:25 +0000
Message-ID: <E1aIF0r-0008O2-AV@debutante>
References: <5677107C.60904@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AAD626061E
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:22:37 +0100 (CET)
In-Reply-To: <5677107C.60904@maciej.szmigiero.name>
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

   ASoC: fsl_ssi: remove register defaults

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

>From 9f2d0be4c64f96ac575d164ede47becec1eececf Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Sun, 20 Dec 2015 21:33:00 +0100
Subject: [PATCH] ASoC: fsl_ssi: remove register defaults

There is no guarantee that on fsl_ssi module load
SSI registers will have their power-on-reset values.

In fact, if the driver is reloaded the values in
registers will be whatever they were set to previously.

This fixes hard lockup on fsl_ssi module reload,
at least in AC'97 mode.

Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 40dfd8a36484..f6ef7d64acb3 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -112,20 +112,6 @@ struct fsl_ssi_rxtx_reg_val {
 	struct fsl_ssi_reg_val tx;
 };
 
-static const struct reg_default fsl_ssi_reg_defaults[] = {
-	{CCSR_SSI_SCR,     0x00000000},
-	{CCSR_SSI_SIER,    0x00003003},
-	{CCSR_SSI_STCR,    0x00000200},
-	{CCSR_SSI_SRCR,    0x00000200},
-	{CCSR_SSI_STCCR,   0x00040000},
-	{CCSR_SSI_SRCCR,   0x00040000},
-	{CCSR_SSI_SACNT,   0x00000000},
-	{CCSR_SSI_STMSK,   0x00000000},
-	{CCSR_SSI_SRMSK,   0x00000000},
-	{CCSR_SSI_SACCEN,  0x00000000},
-	{CCSR_SSI_SACCDIS, 0x00000000},
-};
-
 static bool fsl_ssi_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -190,8 +176,6 @@ static const struct regmap_config fsl_ssi_regconfig = {
 	.val_bits = 32,
 	.reg_stride = 4,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.reg_defaults = fsl_ssi_reg_defaults,
-	.num_reg_defaults = ARRAY_SIZE(fsl_ssi_reg_defaults),
 	.readable_reg = fsl_ssi_readable_reg,
 	.volatile_reg = fsl_ssi_volatile_reg,
 	.precious_reg = fsl_ssi_precious_reg,
-- 
2.7.0.rc3
