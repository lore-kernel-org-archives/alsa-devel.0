From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v4 2/2] ASoC: sti: bind pcm controls to pcm
	device.
Date: Wed, 30 Nov 2016 11:24:10 +0100
Message-ID: <1480501450-10780-3-git-send-email-arnaud.pouliquen@st.com>
References: <1480501450-10780-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 4AF7426720E
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 11:24:18 +0100 (CET)
In-Reply-To: <1480501450-10780-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Move PCM control list in DAI driver struct, to
bind PCM control to PCM device created during DAI linking.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/sti_uniperif.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 98eb205..cf42982 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -248,34 +248,6 @@ int sti_uniperiph_get_tdm_word_pos(struct uniperif *uni,
 }
 
 /*
- * sti_uniperiph_dai_create_ctrl
- * This function is used to create Ctrl associated to DAI but also pcm device.
- * Request is done by front end to associate ctrl with pcm device id
- */
-static int sti_uniperiph_dai_create_ctrl(struct snd_soc_dai *dai)
-{
-	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
-	struct uniperif *uni = priv->dai_data.uni;
-	struct snd_kcontrol_new *ctrl;
-	int i;
-
-	if (!uni->num_ctrls)
-		return 0;
-
-	for (i = 0; i < uni->num_ctrls; i++) {
-		/*
-		 * Several Control can have same name. Controls are indexed on
-		 * Uniperipheral instance ID
-		 */
-		ctrl = &uni->snd_ctrls[i];
-		ctrl->index = uni->id;
-		ctrl->device = uni->id;
-	}
-
-	return snd_soc_add_dai_controls(dai, uni->snd_ctrls, uni->num_ctrls);
-}
-
-/*
  * DAI
  */
 int sti_uniperiph_dai_hw_params(struct snd_pcm_substream *substream,
@@ -365,7 +337,7 @@ static int sti_uniperiph_dai_probe(struct snd_soc_dai *dai)
 	dai_data->dma_data.addr = dai_data->uni->fifo_phys_address;
 	dai_data->dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-	return sti_uniperiph_dai_create_ctrl(dai);
+	return 0;
 }
 
 static const struct snd_soc_dai_driver sti_uniperiph_dai_template = {
@@ -487,6 +459,9 @@ static int sti_uniperiph_probe(struct platform_device *pdev)
 
 	ret = sti_uniperiph_cpu_dai_of(node, priv);
 
+	priv->dai->pcm_controls = priv->dai_data.uni->snd_ctrls;
+	priv->dai->num_pcm_controls = priv->dai_data.uni->num_ctrls;
+
 	dev_set_drvdata(&pdev->dev, priv);
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
-- 
1.9.1
