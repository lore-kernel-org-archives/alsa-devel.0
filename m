From: Kulikov Vasiliy <segooon@gmail.com>
Subject: [PATCH 13/15] sound/soc: davinci: check kzalloc() result (typo)
Date: Fri, 16 Jul 2010 20:16:17 +0400
Message-ID: <1279296977-25267-1-git-send-email-segooon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Miguel Aguilar <miguel.aguilar@ridgerun.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The code checks 'davinci_vc' after kzalloc() and do not checks
'davinci_vcif_dev' that kzalloc() result is assigned to. It seems that
it is a typo (autocompletion?).

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 sound/soc/davinci/davinci-vcif.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index 9aa980d..4867853 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -203,7 +203,7 @@ static int davinci_vcif_probe(struct platform_device *pdev)
 	int ret;
 
 	davinci_vcif_dev = kzalloc(sizeof(struct davinci_vcif_dev), GFP_KERNEL);
-	if (!davinci_vc) {
+	if (!davinci_vcif_dev) {
 		dev_dbg(&pdev->dev,
 			"could not allocate memory for private data\n");
 		return -ENOMEM;
-- 
1.7.0.4
