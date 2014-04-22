From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Export devm_snd_soc_register_platform()
Date: Tue, 22 Apr 2014 22:58:41 +0200
Message-ID: <1398200321-4299-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-072.synserver.de (smtp-out-122.synserver.de
 [212.40.185.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 47041261663
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 22:58:44 +0200 (CEST)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

devm_snd_soc_register_platform() is used in drivers which can be build as
modules, so it needs to be exported to avoid linkers errors like:

	ERROR: "devm_snd_soc_register_platform" [sound/soc/omap/snd-soc-omap.ko] undefined!
	ERROR: "devm_snd_soc_register_platform" [sound/soc/davinci/snd-soc-davinci.ko] undefined!

Fixes: 8931bf620 ("ASoC: Add resource managed snd_soc_register_platform()")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-devres.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-devres.c b/sound/soc/soc-devres.c
index e94aa02..057e5ef 100644
--- a/sound/soc/soc-devres.c
+++ b/sound/soc/soc-devres.c
@@ -85,6 +85,7 @@ int devm_snd_soc_register_platform(struct device *dev,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(devm_snd_soc_register_platform);
 
 static void devm_card_release(struct device *dev, void *res)
 {
-- 
1.8.0
