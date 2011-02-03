From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ASoC: fix build with PM_SLEEP unset
Date: Thu, 3 Feb 2011 09:32:29 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1102030928150.21719@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CA6F24621
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 09:32:33 +0100 (CET)
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

Fix a wrong preprocessor conditional, that leads to soc-core.c compilation 
failure with CONFIG_PM set and CONFIG_PM_SLEEP unset.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 205cbd7..10bc3c2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1801,7 +1801,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 	card->snd_card->dev = card->dev;
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	/* deferred resume work */
 	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
 #endif
