From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: constify regulator_desc structure" to the asoc tree
Date: Mon,  5 Nov 2018 11:58:24 +0000 (GMT)
Message-ID: <20181105115824.0D0071124D98@debutante.sirena.org.uk>
References: <1540706168-30601-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540706168-30601-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: constify regulator_desc structure

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

>From de3636488cff3678bafaf2d024e64c003ed2beae Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 28 Oct 2018 06:56:08 +0100
Subject: [PATCH] ASoC: AMD: constify regulator_desc structure

The regulator_desc structure can be const as it is only passed as the
second argument of devm_regulator_register and the corresponding
parameter is declared as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 3f813ea5210a..a5daad973ce5 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -403,7 +403,7 @@ static struct regulator_config acp_da7219_cfg = {
 static struct regulator_ops acp_da7219_ops = {
 };
 
-static struct regulator_desc acp_da7219_desc = {
+static const struct regulator_desc acp_da7219_desc = {
 	.name = "reg-fixed-1.8V",
 	.type = REGULATOR_VOLTAGE,
 	.owner = THIS_MODULE,
-- 
2.19.0.rc2
