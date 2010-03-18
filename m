From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2] ASoC: remove a card from the list,
	if instantiation failed
Date: Thu, 18 Mar 2010 08:23:33 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1003180818250.4485@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 5B5CD2453E
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 08:23:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

If instantiation of a card failed, we still have to remove it from the 
card list on unregistration. This fixes an Oops on Migo-R, triggering, 
when after a failed firmware load attempt the driver modules are removed 
and re-inserted again.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Mark, is this more like what you mean?

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c8b0556..f63b59a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1232,26 +1232,25 @@ static int soc_remove(struct platform_device *pdev)
 	struct snd_soc_platform *platform = card->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 
-	if (!card->instantiated)
-		return 0;
+	if (card->instantiated) {
+		run_delayed_work(&card->delayed_work);
 
-	run_delayed_work(&card->delayed_work);
+		if (platform->remove)
+			platform->remove(pdev);
 
-	if (platform->remove)
-		platform->remove(pdev);
+		if (codec_dev->remove)
+			codec_dev->remove(pdev);
 
-	if (codec_dev->remove)
-		codec_dev->remove(pdev);
+		for (i = 0; i < card->num_links; i++) {
+			struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
+			if (cpu_dai->remove)
+				cpu_dai->remove(pdev, cpu_dai);
+		}
 
-	for (i = 0; i < card->num_links; i++) {
-		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
-		if (cpu_dai->remove)
-			cpu_dai->remove(pdev, cpu_dai);
+		if (card->remove)
+			card->remove(pdev);
 	}
 
-	if (card->remove)
-		card->remove(pdev);
-
 	snd_soc_unregister_card(card);
 
 	return 0;
