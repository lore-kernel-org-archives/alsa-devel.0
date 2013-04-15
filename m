From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/17] ASoC: mxs: Setup dma data in DAI probe
Date: Mon, 15 Apr 2013 19:19:56 +0200
Message-ID: <1366046404-8759-10-git-send-email-lars@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 53C3F265230
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:21 +0200 (CEST)
In-Reply-To: <1366046404-8759-1-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

This allows us to access the DAI DMA data when we create the PCM. We'll use
this when converting mxs to generic DMA engine PCM driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/mxs/mxs-saif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index abf4ddf..b563141 100644
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
