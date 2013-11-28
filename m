From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/6] ASoC: bcm2835-i2s: Use
	devm_snd_dmaengine_pcm_register()
Date: Thu, 28 Nov 2013 08:50:33 +0100
Message-ID: <1385625037-24973-2-git-send-email-lars@metafoo.de>
References: <1385625037-24973-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-014.synserver.de
 [212.40.185.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FE0C2651DB
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 08:50:14 +0100 (CET)
In-Reply-To: <1385625037-24973-1-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Timur Tabi <timur@tabi.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Lars-Peter Clausen <lars@metafoo.de>, Florian Meier <florian.meier@koalo.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Makes the code slightly shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
New in v2
---
 sound/soc/bcm/bcm2835-i2s.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index f49b007..2685fe4 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -848,7 +848,7 @@ static int bcm2835_i2s_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM: %d\n", ret);
 		return ret;
@@ -862,15 +862,8 @@ static const struct of_device_id bcm2835_i2s_of_match[] = {
 	{},
 };
 
-static int bcm2835_i2s_remove(struct platform_device *pdev)
-{
-	snd_dmaengine_pcm_unregister(&pdev->dev);
-	return 0;
-}
-
 static struct platform_driver bcm2835_i2s_driver = {
 	.probe		= bcm2835_i2s_probe,
-	.remove		= bcm2835_i2s_remove,
 	.driver		= {
 		.name	= "bcm2835-i2s",
 		.owner	= THIS_MODULE,
-- 
1.8.0
