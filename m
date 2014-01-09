From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: fix a bug where cinfo will be NULL before using it
Date: Thu, 9 Jan 2014 17:19:08 +0800
Message-ID: <1389259148-20798-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

If the dt is not used, the cinfo will be always NULL before using it.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index c67d2db..51a4784 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -225,8 +225,8 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 			}
 		}
 	} else {
-		cinfo->snd_card.dev = &pdev->dev;
 		cinfo = pdev->dev.platform_data;
+		cinfo->snd_card.dev = &pdev->dev;
 	}
 
 	if (!cinfo) {
-- 
1.8.4
