From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] ASoC: ti: edma-pcm: Fix for legacy
	dma_slave_map based channel lookup
Date: Fri, 30 Aug 2019 13:38:40 +0300
Message-ID: <20190830103841.25128-4-peter.ujfalusi@ti.com>
References: <20190830103841.25128-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19251F80369
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 12:38:26 +0200 (CEST)
In-Reply-To: <20190830103841.25128-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Most of the daVinci devices does not boot with DT. In this case the DMA
channel is looked up with dma_slave_map and for that the chan_names[]
must be configured.

Both McASP and ASP/McBSP uses "tx" and "rx" as channel names, so we can
just do this when the dev->of_node is not valid.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/edma-pcm.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/ti/edma-pcm.c b/sound/soc/ti/edma-pcm.c
index 3ebea1bd15cb..634b040b65f0 100644
--- a/sound/soc/ti/edma-pcm.c
+++ b/sound/soc/ti/edma-pcm.c
@@ -39,7 +39,22 @@ static const struct snd_dmaengine_pcm_config edma_dmaengine_pcm_config = {
 
 int edma_pcm_platform_register(struct device *dev)
 {
-	return devm_snd_dmaengine_pcm_register(dev, &edma_dmaengine_pcm_config, 0);
+	struct snd_dmaengine_pcm_config *config;
+
+	if (dev->of_node)
+		return devm_snd_dmaengine_pcm_register(dev,
+						&edma_dmaengine_pcm_config, 0);
+
+	config = devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	*config = edma_dmaengine_pcm_config;
+
+	config->chan_names[0] = "tx";
+	config->chan_names[1] = "rx";
+
+	return devm_snd_dmaengine_pcm_register(dev, config, 0);
 }
 EXPORT_SYMBOL_GPL(edma_pcm_platform_register);
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
