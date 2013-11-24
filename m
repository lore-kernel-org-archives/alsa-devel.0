From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/6] ASoC: ep93xx: Use
	devm_snd_dmaengine_pcm_register()
Date: Sun, 24 Nov 2013 14:20:59 +0100
Message-ID: <1385299262-24304-3-git-send-email-lars@metafoo.de>
References: <1385299262-24304-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-164.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 293DA2616FB
 for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2013 14:20:39 +0100 (CET)
In-Reply-To: <1385299262-24304-1-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Lars-Peter Clausen <lars@metafoo.de>, Bo Shen <voice.shen@atmel.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Makes the code slightly shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/cirrus/ep93xx-pcm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
index cfe517e..fdb8b8f 100644
--- a/sound/soc/cirrus/ep93xx-pcm.c
+++ b/sound/soc/cirrus/ep93xx-pcm.c
@@ -78,19 +78,13 @@ static const struct snd_dmaengine_pcm_config ep93xx_dmaengine_pcm_config = {
 
 static int ep93xx_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_dmaengine_pcm_register(&pdev->dev,
+	return devm_snd_dmaengine_pcm_register(&pdev->dev,
 		&ep93xx_dmaengine_pcm_config,
 		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
 		SND_DMAENGINE_PCM_FLAG_NO_DT |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 
-static int ep93xx_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_dmaengine_pcm_unregister(&pdev->dev);
-	return 0;
-}
-
 static struct platform_driver ep93xx_pcm_driver = {
 	.driver = {
 			.name = "ep93xx-pcm-audio",
@@ -98,7 +92,6 @@ static struct platform_driver ep93xx_pcm_driver = {
 	},
 
 	.probe = ep93xx_soc_platform_probe,
-	.remove = ep93xx_soc_platform_remove,
 };
 
 module_platform_driver(ep93xx_pcm_driver);
-- 
1.8.0
