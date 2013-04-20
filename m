From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/8] ASoC: mxs: Setup dma data in DAI probe
Date: Sat, 20 Apr 2013 19:29:02 +0200
Message-ID: <1366478947-9377-3-git-send-email-lars@metafoo.de>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-081.synserver.de (smtp-out-086.synserver.de
 [212.40.185.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 493CD26517F
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 19:29:59 +0200 (CEST)
In-Reply-To: <1366478947-9377-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

This allows us to access the DAI DMA data when we create the PCM. We'll use
this when converting mxs to generic DMA engine PCM driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/mxs/mxs-saif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index f13bd87..d796a39 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -369,7 +369,6 @@ static int mxs_saif_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *cpu_dai)
 {
 	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
-	snd_soc_dai_set_dma_data(cpu_dai, substream, &saif->dma_param);
 
 	/* clear error status to 0 for each re-open */
 	saif->fifo_underrun = 0;
@@ -605,6 +604,8 @@ static int mxs_saif_dai_probe(struct snd_soc_dai *dai)
 	struct mxs_saif *saif = dev_get_drvdata(dai->dev);
 
 	snd_soc_dai_set_drvdata(dai, saif);
+	dai->playback_dma_data = &saif->dma_param;
+	dai->capture_dma_data = &saif->dma_param;
 
 	return 0;
 }
-- 
1.8.0
