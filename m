From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH v2 06/10] ASoC: mxs-sgtl5000: Remove unnecessary function call
Date: Wed, 23 Aug 2017 05:20:30 -0700
Message-ID: <f672a072d422e23df2c1e56f643874caf613c360.1503484313.git.dolinux.peng@gmail.com>
References: <cover.1503484313.git.dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1503484313.git.dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

The work of the function platform_set_drvdata is done by
devm_snd_soc_register_card.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/mxs/mxs-sgtl5000.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index a96276e77332..90ca6f9131a1 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -140,16 +140,13 @@ static int mxs_sgtl5000_probe(struct platform_device *pdev)
 	}
 
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
 			ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int mxs_sgtl5000_remove(struct platform_device *pdev)
-- 
2.14.1
