From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_asrc: add constraint for the asrc of older
 version" to the asoc tree
Date: Thu, 21 Mar 2019 15:07:13 +0000 (GMT)
Message-ID: <20190321150713.E4B1411288EC@debutante.sirena.org.uk>
References: <3fc3a2cbe15b67537be9e97beff0d97f619a063f.1551505839.git.shengjiu.wang@nxp.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <3fc3a2cbe15b67537be9e97beff0d97f619a063f.1551505839.git.shengjiu.wang@nxp.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Cc: alsa-devel@alsa-project.org, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_asrc: add constraint for the asrc of older version

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

>From 53f67a78663811968f426d480bc55887d787bd94 Mon Sep 17 00:00:00 2001
From: "S.j. Wang" <shengjiu.wang@nxp.com>
Date: Sat, 2 Mar 2019 05:52:19 +0000
Subject: [PATCH] ASoC: fsl_asrc: add constraint for the asrc of older version

There is a constraint for the channel number setting on the
asrc of older version (e.g. imx35), the channel number should
be even, odd number isn't valid.

So add this constraint when the asrc of older version is used.

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 528e8b108422..0b937924d2e4 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -445,6 +445,19 @@ struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair, bool dir)
 }
 EXPORT_SYMBOL_GPL(fsl_asrc_get_dma_channel);
 
+static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct fsl_asrc *asrc_priv = snd_soc_dai_get_drvdata(dai);
+
+	/* Odd channel number is not valid for older ASRC (channel_bits==3) */
+	if (asrc_priv->channel_bits == 3)
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_CHANNELS, 2);
+
+	return 0;
+}
+
 static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
@@ -539,6 +552,7 @@ static int fsl_asrc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 }
 
 static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
+	.startup      = fsl_asrc_dai_startup,
 	.hw_params    = fsl_asrc_dai_hw_params,
 	.hw_free      = fsl_asrc_dai_hw_free,
 	.trigger      = fsl_asrc_dai_trigger,
-- 
2.20.1
