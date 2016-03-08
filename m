From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v4 2/6] ASoC: sti: use
	snd_soc_add_dai_pcm_controls helper
Date: Tue, 8 Mar 2016 13:53:57 +0100
Message-ID: <1457441641-7501-3-git-send-email-arnaud.pouliquen@st.com>
References: <1457441641-7501-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 87E02261561
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 13:54:28 +0100 (CET)
In-Reply-To: <1457441641-7501-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, arnaud.pouliquen@st.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/sti_uniperif.c | 37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 39bcefe..0c87380 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -11,34 +11,6 @@
 #include "uniperif.h"
 
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
-		ctrl->index = uni->info->id;
-		ctrl->device = uni->info->id;
-	}
-
-	return snd_soc_add_dai_controls(dai, uni->snd_ctrls, uni->num_ctrls);
-}
-
-/*
  * DAI
  */
 int sti_uniperiph_dai_hw_params(struct snd_pcm_substream *substream,
@@ -112,6 +84,7 @@ static int sti_uniperiph_dai_probe(struct snd_soc_dai *dai)
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct sti_uniperiph_dai *dai_data = &priv->dai_data;
+	struct uniperif *uni = priv->dai_data.uni;
 
 	/* DMA settings*/
 	if (of_device_is_compatible(dai->dev->of_node, "st,sti-uni-player"))
@@ -119,10 +92,14 @@ static int sti_uniperiph_dai_probe(struct snd_soc_dai *dai)
 	else
 		snd_soc_dai_init_dma_data(dai, NULL, &dai_data->dma_data);
 
-	dai_data->dma_data.addr = dai_data->uni->fifo_phys_address;
+	dai_data->dma_data.addr = uni->fifo_phys_address;
 	dai_data->dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-	return sti_uniperiph_dai_create_ctrl(dai);
+	if (uni->num_ctrls)
+		return snd_soc_add_dai_pcm_controls(dai, uni->snd_ctrls,
+						    uni->num_ctrls);
+
+	return 0;
 }
 
 static const struct snd_soc_dai_driver sti_uniperiph_dai_template = {
-- 
1.9.1
