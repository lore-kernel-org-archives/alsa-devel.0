From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: fix the cinfo error check
Date: Thu, 9 Jan 2014 17:49:40 +0800
Message-ID: <1389260980-25579-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

If the dt is used and the cinfo is NULL, the -ENOMEM should be return.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 51a4784..406e4ea 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -223,15 +223,17 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 					dev_err(dev, "parse error %d\n", ret);
 				return ret;
 			}
+		} else {
+			return -ENOMEM;
 		}
 	} else {
 		cinfo = pdev->dev.platform_data;
-		cinfo->snd_card.dev = &pdev->dev;
-	}
+		if (!cinfo) {
+			dev_err(dev, "no info for asoc-simple-card\n");
+			return -EINVAL;
+		}
 
-	if (!cinfo) {
-		dev_err(dev, "no info for asoc-simple-card\n");
-		return -EINVAL;
+		cinfo->snd_card.dev = &pdev->dev;
 	}
 
 	if (!cinfo->name	||
-- 
1.8.4
