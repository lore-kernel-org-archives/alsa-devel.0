From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Call snd_soc_unregister_dais instead of
	snd_soc_unregister_dai in sh4_soc_dai_remove
Date: Thu, 25 Nov 2010 17:23:55 +0800
Message-ID: <1290677035.1928.3.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We call snd_soc_register_dais() in sh4_soc_dai_probe(),
thus we should call snd_soc_unregister_dais() in sh4_soc_dai_remove().

Otherwise, we got "too many arguments to function 'snd_soc_unregister_dai'"
error message.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/sh/ssi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index 40bbdf1..05192d9 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -387,7 +387,7 @@ static int __devinit sh4_soc_dai_probe(struct platform_device *pdev)
 
 static int __devexit sh4_soc_dai_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_dai(&pdev->dev, ARRAY_SIZE(sh4_ssi_dai));
+	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(sh4_ssi_dai));
 	return 0;
 }
 
-- 
1.7.2
