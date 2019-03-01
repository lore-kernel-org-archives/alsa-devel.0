From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH V2] ASoC: fsl_asrc: add constraint for the asrc
 of older version
Date: Fri, 1 Mar 2019 08:37:08 +0000
Message-ID: <24ebf5b610cc69f18c05e4aefa1874ae23861943.1551429264.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150082.outbound.protection.outlook.com [40.107.15.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78E96F8073C
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 09:37:11 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

There is constraint for the channel number setting on the
asrc of older version (e.g. imx35), the channel number should
be even, odd number isn't valid.

So add this constraint when the asrc of older version is used.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2
- switch to add constraint in startup function

 sound/soc/fsl/fsl_asrc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 528e8b108422..31494f225037 100644
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
+	/* channel_bits = 3 means older version on imx35*/
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
1.9.1
