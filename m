From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] ASoC: sst-haswell-pcm: Alloc state struct
	in driver probe()
Date: Wed, 20 Aug 2014 13:08:47 +0200
Message-ID: <1408532929-26978-3-git-send-email-lars@metafoo.de>
References: <1408532929-26978-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-032.synserver.de (smtp-out-036.synserver.de
 [212.40.185.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E3E32656E2
 for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2014 13:08:56 +0200 (CEST)
In-Reply-To: <1408532929-26978-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Resource allocations should happen in driver probe callback rather than in
snd_soc_platform probe functions. Especially if the resource is device
managed. The snd_soc_* probe/remove functions are mainly intended to be used
for things that require the component to be already bound to a card.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/intel/sst-haswell-pcm.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 61bf6da..1de0958 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -778,20 +778,11 @@ static const struct snd_soc_dapm_route graph[] = {
 
 static int hsw_pcm_probe(struct snd_soc_platform *platform)
 {
+	struct hsw_priv_data *priv_data = snd_soc_platform_get_drvdata(platform);
 	struct sst_pdata *pdata = dev_get_platdata(platform->dev);
-	struct hsw_priv_data *priv_data;
-	struct device *dma_dev;
+	struct device *dma_dev = pdata->dma_dev;
 	int i, ret = 0;
 
-	if (!pdata)
-		return -ENODEV;
-
-	dma_dev = pdata->dma_dev;
-
-	priv_data = devm_kzalloc(platform->dev, sizeof(*priv_data), GFP_KERNEL);
-	priv_data->hsw = pdata->dsp;
-	snd_soc_platform_set_drvdata(platform, priv_data);
-
 	/* allocate DSP buffer page tables */
 	for (i = 0; i < ARRAY_SIZE(hsw_dais); i++) {
 
@@ -863,12 +854,23 @@ static const struct snd_soc_component_driver hsw_dai_component = {
 static int hsw_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct sst_pdata *sst_pdata = dev_get_platdata(&pdev->dev);
+	struct hsw_priv_data *priv_data;
 	int ret;
 
+	if (!sst_pdata)
+		return -EINVAL;
+
+	priv_data = devm_kzalloc(&pdev->dev, sizeof(*priv_data), GFP_KERNEL);
+	if (!priv_data)
+		return -ENOMEM;
+
 	ret = sst_hsw_dsp_init(&pdev->dev, sst_pdata);
 	if (ret < 0)
 		return -ENODEV;
 
+	priv_data->hsw = sst_pdata->dsp;
+	platform_set_drvdata(pdev, priv_data);
+
 	ret = snd_soc_register_platform(&pdev->dev, &hsw_soc_platform);
 	if (ret < 0)
 		goto err_plat;
-- 
1.8.0
