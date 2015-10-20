From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: Intel: Skylake: Convert to
	devm_snd_soc_register_card
Date: Tue, 20 Oct 2015 16:58:49 +0800
Message-ID: <1445331529.25880.4.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C7C3266485
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 11:04:43 +0200 (CEST)
Received: by pacfv9 with SMTP id fv9so16229218pac.3
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 02:04:42 -0700 (PDT)
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
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/intel/boards/skl_rt286.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 488c98e..3b6f48c 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -240,18 +240,11 @@ static int skylake_audio_probe(struct platform_device *pdev)
 {
 	skylake_rt286.dev = &pdev->dev;
 
-	return snd_soc_register_card(&skylake_rt286);
-}
-
-static int skylake_audio_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_card(&skylake_rt286);
-	return 0;
+	return devm_snd_soc_register_card(&skylake_rt286);
 }
 
 static struct platform_driver skylake_audio = {
 	.probe = skylake_audio_probe,
-	.remove = skylake_audio_remove,
 	.driver = {
 		.name = "skl_alc286s_i2s",
 	},
-- 
2.1.4
