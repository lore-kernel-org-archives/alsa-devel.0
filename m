From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH 08/12] ASoC: qcom: Remove useless function call
Date: Sun, 20 Aug 2017 13:43:57 +0800
Message-ID: <1503207837-16310-1-git-send-email-dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F367266BCF
 for <alsa-devel@alsa-project.org>; Sun, 20 Aug 2017 07:44:02 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id w127so34844pfd.1
 for <alsa-devel@alsa-project.org>; Sat, 19 Aug 2017 22:44:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, plai@codeaurora.org, bgoswami@codeaurora.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

The function platform_set_drvdata(pdev, data) copies the value of
the variable data to pdev->dev.driver_data,but when calling
snd_soc_register_card,the function dev_set_drvdata(card->dev, card)
will override it, so i think that the former copy operation is
useless and can be removed.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/qcom/apq8016_sbc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index d084d74..5292591 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -191,7 +191,6 @@ static int apq8016_sbc_platform_probe(struct platform_device *pdev)
 	if (IS_ERR(data->spkr_iomux))
 		return PTR_ERR(data->spkr_iomux);
 
-	platform_set_drvdata(pdev, data);
 	snd_soc_card_set_drvdata(card, data);
 
 	return devm_snd_soc_register_card(&pdev->dev, card);
-- 
1.9.1
