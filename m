From: Jerry Snitselaar <dev@snitselaar.org>
Subject: [PATCH] ASoC: core: remove unused variable in soc_probe() in linux-next
Date: Thu,  9 Aug 2012 23:16:26 -0700
Message-ID: <1344579386-27193-1-git-send-email-dev@snitselaar.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

With commit 28d528c8 "ASoC: core: Remove pointless error on card
registration failure", the variable ret is no longer used in
soc_probe() and generates an unused variable warning during a build.

Signed-off-by: Jerry Snitselaar <dev@snitselaar.org>
---
 sound/soc/soc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2d98ffc..7adf115 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1816,7 +1816,6 @@ base_error:
 static int soc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	int ret = 0;
 
 	/*
 	 * no card, so machine driver should be registering card
-- 
1.7.12.rc1.17.g9a7365c
