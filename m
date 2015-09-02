From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: intel: broadwell: Convert to
 devm_snd_soc_register_card
Date: Wed, 02 Sep 2015 12:01:27 +0800
Message-ID: <1441166487.9141.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 0597F2617AB
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2015 06:01:32 +0200 (CEST)
Received: by pacwi10 with SMTP id wi10so17759971pac.3
 for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2015 21:01:31 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/intel/boards/broadwell.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index 8bafaf6..3f8a1e1 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -266,18 +266,11 @@ static int broadwell_audio_probe(struct platform_device *pdev)
 {
 	broadwell_rt286.dev = &pdev->dev;
 
-	return snd_soc_register_card(&broadwell_rt286);
-}
-
-static int broadwell_audio_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_card(&broadwell_rt286);
-	return 0;
+	return devm_snd_soc_register_card(&pdev->dev, &broadwell_rt286);
 }
 
 static struct platform_driver broadwell_audio = {
 	.probe = broadwell_audio_probe,
-	.remove = broadwell_audio_remove,
 	.driver = {
 		.name = "broadwell-audio",
 	},
-- 
2.1.0
