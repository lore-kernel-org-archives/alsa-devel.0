From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 01/14] ASoC: wm8350: Use devm_regulator_bulk_get
Date: Mon, 26 Nov 2012 17:19:34 +0530
Message-ID: <1353930587-12907-2-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A47E265089
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:17 +0100 (CET)
Received: by mail-da0-f51.google.com with SMTP id i30so2953117dad.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:17 -0800 (PST)
In-Reply-To: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

devm_regulator_bulk_get() is device managed and makes error
handling and code cleanup simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/wm8350.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index a4cae06..32b8f08 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1500,7 +1500,7 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
 		priv->supplies[i].supply = supply_names[i];
 
-	ret = regulator_bulk_get(wm8350->dev, ARRAY_SIZE(priv->supplies),
+	ret = devm_regulator_bulk_get(wm8350->dev, ARRAY_SIZE(priv->supplies),
 				 priv->supplies);
 	if (ret != 0)
 		return ret;
@@ -1607,8 +1607,6 @@ static int  wm8350_codec_remove(struct snd_soc_codec *codec)
 
 	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
 
-	regulator_bulk_free(ARRAY_SIZE(priv->supplies), priv->supplies);
-
 	return 0;
 }
 
-- 
1.7.4.1
