From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 10/14] ASoC: wm8960: Use devm_regmap_init_i2c()
Date: Mon, 26 Nov 2012 17:19:43 +0530
Message-ID: <1353930587-12907-11-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 93B5B26515B
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:47 +0100 (CET)
Received: by mail-da0-f51.google.com with SMTP id i30so2953117dad.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:47 -0800 (PST)
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

devm_regmap_init_i2c() is device managed and makes error
handling and code cleanup simpler. There was no explicit
regmap_exit call in this function which was probably a bug.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/wm8960.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index f0f6f660..cf09cb6 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1040,7 +1040,7 @@ static __devinit int wm8960_i2c_probe(struct i2c_client *i2c,
 	if (wm8960 == NULL)
 		return -ENOMEM;
 
-	wm8960->regmap = regmap_init_i2c(i2c, &wm8960_regmap);
+	wm8960->regmap = devm_regmap_init_i2c(i2c, &wm8960_regmap);
 	if (IS_ERR(wm8960->regmap))
 		return PTR_ERR(wm8960->regmap);
 
-- 
1.7.4.1
