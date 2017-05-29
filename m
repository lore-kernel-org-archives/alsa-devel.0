From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH 14/15] sound: stm32: use
	devm_of_platform_populate()
Date: Mon, 29 May 2017 17:46:02 +0200
Message-ID: <1496072763-31209-15-git-send-email-benjamin.gaignard@linaro.org>
References: <1496072763-31209-1-git-send-email-benjamin.gaignard@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 66F3C26683B
 for <alsa-devel@alsa-project.org>; Mon, 29 May 2017 17:46:44 +0200 (CEST)
Received: by mail-wm0-f41.google.com with SMTP id b84so60813409wmh.0
 for <alsa-devel@alsa-project.org>; Mon, 29 May 2017 08:46:44 -0700 (PDT)
In-Reply-To: <1496072763-31209-1-git-send-email-benjamin.gaignard@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Usage of devm_of_platform_populate() simplify driver code
by allowing to delete stm32_sai_remove().

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

CC: Liam Girdwood <lgirdwood@gmail.com>
CC: Mark Brown <broonie@kernel.org>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: Alexandre Torgue <alexandre.torgue@st.com>
CC: Olivier Moysan <olivier.moysan@st.com>
CC: alsa-devel@alsa-project.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 sound/soc/stm/stm32_sai.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 2a27a26..25304f8 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -34,7 +34,6 @@
 
 static int stm32_sai_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct stm32_sai_data *sai;
 	struct reset_control *rst;
 	struct resource *res;
@@ -86,14 +85,7 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	sai->pdev = pdev;
 	platform_set_drvdata(pdev, sai);
 
-	return of_platform_populate(np, NULL, NULL, &pdev->dev);
-}
-
-static int stm32_sai_remove(struct platform_device *pdev)
-{
-	of_platform_depopulate(&pdev->dev);
-
-	return 0;
+	return devm_of_platform_populate(&pdev->dev);
 }
 
 MODULE_DEVICE_TABLE(of, stm32_sai_ids);
@@ -104,7 +96,6 @@ static int stm32_sai_remove(struct platform_device *pdev)
 		.of_match_table = stm32_sai_ids,
 	},
 	.probe = stm32_sai_probe,
-	.remove = stm32_sai_remove,
 };
 
 module_platform_driver(stm32_sai_driver);
-- 
1.9.1
