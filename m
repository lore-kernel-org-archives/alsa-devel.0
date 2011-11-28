From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: Convert smdk_wm8994pcm to use
 module_platform_driver()
Date: Mon, 28 Nov 2011 18:53:57 +0800
Message-ID: <1322477637.1939.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 26237245AC
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 11:54:05 +0100 (CET)
Received: by yws1 with SMTP id 1so2379378yws.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 02:54:04 -0800 (PST)
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use the module_platform_driver() macro which makes
the code smaller and a bit simpler.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/samsung/smdk_wm8994pcm.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8994pcm.c b/sound/soc/samsung/smdk_wm8994pcm.c
index da9c2a2..23c7fb7 100644
--- a/sound/soc/samsung/smdk_wm8994pcm.c
+++ b/sound/soc/samsung/smdk_wm8994pcm.c
@@ -158,19 +158,7 @@ static struct platform_driver snd_smdk_driver = {
 	.remove = __devexit_p(snd_smdk_remove),
 };
 
-static int __init smdk_audio_init(void)
-{
-	return platform_driver_register(&snd_smdk_driver);
-}
-
-module_init(smdk_audio_init);
-
-static void __exit smdk_audio_exit(void)
-{
-	platform_driver_unregister(&snd_smdk_driver);
-}
-
-module_exit(smdk_audio_exit);
+module_platform_driver(snd_smdk_driver);
 
 MODULE_AUTHOR("Sangbeom Kim, <sbkim73@samsung.com>");
 MODULE_DESCRIPTION("ALSA SoC SMDK WM8994 for PCM");
-- 
1.7.5.4
