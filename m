From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: qi_lb60: Pass flags to gpiod_get()
Date: Tue, 25 Nov 2014 20:29:40 +0100
Message-ID: <1416943780-1016-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-208.synserver.de (smtp-out-210.synserver.de
 [212.40.185.210])
 by alsa0.perex.cz (Postfix) with ESMTP id C94B5260600
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 20:28:52 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Pass flags to gpiod_get() to automatically configure the GPIOs. This is shorter
and not passing any flags to gpiod_get() will eventually no longer be supported.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/qi_lb60.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index 5cb91f9..0fb7d2a 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -77,25 +77,18 @@ static int qi_lb60_probe(struct platform_device *pdev)
 {
 	struct qi_lb60 *qi_lb60;
 	struct snd_soc_card *card = &qi_lb60_card;
-	int ret;
 
 	qi_lb60 = devm_kzalloc(&pdev->dev, sizeof(*qi_lb60), GFP_KERNEL);
 	if (!qi_lb60)
 		return -ENOMEM;
 
-	qi_lb60->snd_gpio = devm_gpiod_get(&pdev->dev, "snd");
+	qi_lb60->snd_gpio = devm_gpiod_get(&pdev->dev, "snd", GPIOD_OUT_LOW);
 	if (IS_ERR(qi_lb60->snd_gpio))
 		return PTR_ERR(qi_lb60->snd_gpio);
-	ret = gpiod_direction_output(qi_lb60->snd_gpio, 0);
-	if (ret)
-		return ret;
 
-	qi_lb60->amp_gpio = devm_gpiod_get(&pdev->dev, "amp");
+	qi_lb60->amp_gpio = devm_gpiod_get(&pdev->dev, "amp", GPIOD_OUT_LOW);
 	if (IS_ERR(qi_lb60->amp_gpio))
 		return PTR_ERR(qi_lb60->amp_gpio);
-	ret = gpiod_direction_output(qi_lb60->amp_gpio, 0);
-	if (ret)
-		return ret;
 
 	card->dev = &pdev->dev;
 
-- 
1.7.10.4
