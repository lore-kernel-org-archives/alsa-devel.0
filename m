From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/6] ASoC: wm5110: Fix up
	snd_soc_register_platform error path
Date: Thu, 21 Jan 2016 17:52:57 +0000
Message-ID: <1453398782-32198-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B05872604DF
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 18:53:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Whilst there is nothing wrong with the error path here it looks a little
bit odd, this patches makes the code a little more idiomatic.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 6088d30..83760b7 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2366,7 +2366,7 @@ static int wm5110_probe(struct platform_device *pdev)
 	ret = snd_soc_register_platform(&pdev->dev, &wm5110_compr_platform);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register platform: %d\n", ret);
-		goto error;
+		return ret;
 	}
 
 	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm5110,
@@ -2376,7 +2376,6 @@ static int wm5110_probe(struct platform_device *pdev)
 		snd_soc_unregister_platform(&pdev->dev);
 	}
 
-error:
 	return ret;
 }
 
-- 
2.1.4
