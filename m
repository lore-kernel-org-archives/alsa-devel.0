From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: mediatek: mt8183: move card registration
	to the end of probe
Date: Wed, 22 May 2019 22:54:02 +0800
Message-ID: <20190522145402.256102-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1F68F80C20
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 16:54:42 +0200 (CEST)
Received: by mail-qt1-x84a.google.com with SMTP id 28so2257510qtw.5
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 07:54:42 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com, jiaxin.yu@mediatek.com
List-Id: alsa-devel@alsa-project.org

mt8183_mt6358_ts3a227_max98357_dev_probe() does not return immediately
if devm_snd_soc_register_card() returns fail.  As a result, the rest of
code still get executed.

Two options to fix:
1. add an extra return statement if devm_snd_soc_register_card()
   returns fail
2. move devm_snd_soc_register_card() to the end of probe

Adopt option 2 which is more clear and common.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 4e44e5689d6f..1efc7f5d04e4 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -345,7 +345,7 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 	struct device_node *platform_node;
 	struct snd_soc_dai_link *dai_link;
 	struct pinctrl *default_pins;
-	int ret, i;
+	int i;
 
 	card->dev = &pdev->dev;
 
@@ -380,11 +380,6 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret)
-		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
-			__func__, ret);
-
 	default_pins =
 		devm_pinctrl_get_select(&pdev->dev, PINCTRL_STATE_DEFAULT);
 	if (IS_ERR(default_pins)) {
@@ -393,7 +388,7 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 		return PTR_ERR(default_pins);
 	}
 
-	return ret;
+	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
 #ifdef CONFIG_OF
-- 
2.21.0.1020.gf2820cf01a-goog
