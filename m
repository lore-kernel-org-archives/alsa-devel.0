From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] mioa701 convert to snd_soc_register_card API
Date: Sat, 30 Jun 2012 19:25:08 +0200
Message-ID: <1341077108-18455-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D357243E5
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2012 19:25:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

The mioa701 board code is converted to the snd_soc_register_card()
and snd_soc_unregister_card() APIs.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/pxa/mioa701_wm9713.c |   33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 9c585af..8687c1c 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -186,36 +186,27 @@ static struct snd_soc_card mioa701 = {
 	.num_links = ARRAY_SIZE(mioa701_dai),
 };
 
-static struct platform_device *mioa701_snd_device;
-
-static int mioa701_wm9713_probe(struct platform_device *pdev)
+static int __devinit mioa701_wm9713_probe(struct platform_device *pdev)
 {
-	int ret;
+	int rc;
 
 	if (!machine_is_mioa701())
 		return -ENODEV;
 
-	dev_warn(&pdev->dev, "Be warned that incorrect mixers/muxes setup will"
-		 "lead to overheating and possible destruction of your device."
-		 "Do not use without a good knowledge of mio's board design!\n");
-
-	mioa701_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!mioa701_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(mioa701_snd_device, &mioa701);
-
-	ret = platform_device_add(mioa701_snd_device);
-	if (!ret)
-		return 0;
-
-	platform_device_put(mioa701_snd_device);
-	return ret;
+	mioa701.dev = &pdev->dev;
+	rc =  snd_soc_register_card(&mioa701);
+	if (!rc)
+		dev_warn(&pdev->dev, "Be warned that incorrect mixers/muxes setup will"
+			 "lead to overheating and possible destruction of your device."
+			 " Do not use without a good knowledge of mio's board design!\n");
+	return rc;
 }
 
 static int __devexit mioa701_wm9713_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(mioa701_snd_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
 	return 0;
 }
 
-- 
1.7.10
