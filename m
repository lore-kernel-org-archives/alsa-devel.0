From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/6] ASoC: spear: Use
	devm_snd_dmaengine_pcm_register
Date: Sun, 24 Nov 2013 14:21:01 +0100
Message-ID: <1385299262-24304-5-git-send-email-lars@metafoo.de>
References: <1385299262-24304-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-164.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id DE0AD261701
 for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2013 14:20:41 +0100 (CET)
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
 sound/soc/spear/spear_pcm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index 4707f2b..9a02141 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -49,18 +49,12 @@ static const struct snd_dmaengine_pcm_config spear_dmaengine_pcm_config = {
 
 static int spear_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_dmaengine_pcm_register(&pdev->dev,
+	return devm_snd_dmaengine_pcm_register(&pdev->dev,
 		&spear_dmaengine_pcm_config,
 		SND_DMAENGINE_PCM_FLAG_NO_DT |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 
-static int spear_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_dmaengine_pcm_unregister(&pdev->dev);
-	return 0;
-}
-
 static struct platform_driver spear_pcm_driver = {
 	.driver = {
 		.name = "spear-pcm-audio",
@@ -68,7 +62,6 @@ static struct platform_driver spear_pcm_driver = {
 	},
 
 	.probe = spear_soc_platform_probe,
-	.remove = spear_soc_platform_remove,
 };
 
 module_platform_driver(spear_pcm_driver);
-- 
1.8.0
