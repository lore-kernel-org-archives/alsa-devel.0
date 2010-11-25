From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: davinci-vcif - fix a memory leak
Date: Thu, 25 Nov 2010 11:33:14 +0800
Message-ID: <1290655994.30158.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jhnikula@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/davinci/davinci-vcif.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index fb4cc1e..9d2afcc 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -247,7 +247,10 @@ fail:
 
 static int davinci_vcif_remove(struct platform_device *pdev)
 {
+	struct davinci_vcif_dev *davinci_vcif_dev = dev_get_drvdata(&pdev->dev);
+
 	snd_soc_unregister_dai(&pdev->dev);
+	kfree(davinci_vcif_dev);
 
 	return 0;
 }
-- 
1.7.2
