From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH 4/4] ASoC: mediatek: mt8183: fix space issues
Date: Fri, 30 Aug 2019 15:42:40 +0800
Message-ID: <20190830074240.195166-5-tzungbi@google.com>
References: <20190830074240.195166-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com
 [IPv6:2607:f8b0:4864:20::94a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2A33BF805FC
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 09:43:07 +0200 (CEST)
Received: by mail-ua1-x94a.google.com with SMTP id g25so824999uan.5
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 00:43:07 -0700 (PDT)
In-Reply-To: <20190830074240.195166-1-tzungbi@google.com>
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
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

Fix space issues:
- No space before ';'.
- No trailing blank line.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 30a7735c4af3..bb9cdc0d6552 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -471,7 +471,7 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->pinctrl);
 	}
 
-	for (i = 0 ; i < PIN_STATE_MAX ; i++) {
+	for (i = 0; i < PIN_STATE_MAX; i++) {
 		priv->pin_states[i] = pinctrl_lookup_state(priv->pinctrl,
 							   mt8183_pin_str[i]);
 		if (IS_ERR(priv->pin_states[i])) {
@@ -526,4 +526,3 @@ MODULE_DESCRIPTION("MT8183-MT6358-TS3A227-MAX98357 ALSA SoC machine driver");
 MODULE_AUTHOR("Shunli Wang <shunli.wang@mediatek.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("mt8183_mt6358_ts3a227_max98357 soc card");
-
-- 
2.23.0.187.g17f5b7556c-goog
