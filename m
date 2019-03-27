From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_audmix: Fix kbuild failure" to the asoc tree
Date: Wed, 27 Mar 2019 12:52:34 +0000 (GMT)
Message-ID: <20190327125234.3357411288FA@debutante.sirena.org.uk>
References: <1553678953-31228-1-git-send-email-viorel.suman@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553678953-31228-1-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Viorel Suman <viorel.suman@gmail.com>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_audmix: Fix kbuild failure

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

>From 5fb94d46c3179cb7afd805a5a9252111316a926f Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Wed, 27 Mar 2019 09:29:38 +0000
Subject: [PATCH] ASoC: fsl_audmix: Fix kbuild failure

The format in dev_dbg function must be a constant.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_audmix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 3356cb617713..dabde0342c95 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -90,7 +90,7 @@ static int fsl_audmix_state_trans(struct snd_soc_component *comp,
 	struct fsl_audmix *priv = snd_soc_component_get_drvdata(comp);
 	/* Enforce all required TDMs are started */
 	if ((priv->tdms & prm.tdms) != prm.tdms) {
-		dev_dbg(comp->dev, prm.msg);
+		dev_dbg(comp->dev, "%s", prm.msg);
 		return -EINVAL;
 	}
 
-- 
2.20.1
