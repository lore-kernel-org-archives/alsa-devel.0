From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: remove duplicated flag setting
	in fsl_ssi_setup_reg_vals()" to the asoc tree
Date: Mon, 27 Nov 2017 18:52:27 +0000
Message-ID: <E1eJOW3-0006yi-7A@debutante>
References: <9c78bea8-c264-0094-c2e9-950a9f7797e6@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B05A2675CA
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:52:36 +0100 (CET)
In-Reply-To: <9c78bea8-c264-0094-c2e9-950a9f7797e6@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: remove duplicated flag setting in fsl_ssi_setup_reg_vals()

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

>From 74231295c67ada29a4566272d8ac4886d09f3e83 Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Mon, 20 Nov 2017 23:12:01 +0100
Subject: [PATCH] ASoC: fsl_ssi: remove duplicated flag setting in
 fsl_ssi_setup_reg_vals()

We don't need to set CCSR_SSI_SIER_RFF0_EN / CCSR_SSI_SIER_TFE0_EN bits
in reg->rx.sier / reg->tx.sier variables in a non-AC'97 mode considering we
had just initialized these variables to these very values unconditionally a
few lines earlier.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 424bafaf51ef..9e97a0529f37 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -600,9 +600,7 @@ static void fsl_ssi_setup_reg_vals(struct fsl_ssi_private *ssi_private)
 
 	if (!fsl_ssi_is_ac97(ssi_private)) {
 		reg->rx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE;
-		reg->rx.sier |= CCSR_SSI_SIER_RFF0_EN;
 		reg->tx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE;
-		reg->tx.sier |= CCSR_SSI_SIER_TFE0_EN;
 	}
 
 	if (ssi_private->use_dma) {
-- 
2.15.0
