From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 3/3] ASoC: stm32: sai: use
	devm_of_platform_populate()
Date: Wed, 22 Nov 2017 16:02:27 +0100
Message-ID: <1511362947-14747-4-git-send-email-olivier.moysan@st.com>
References: <1511362947-14747-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 4879A26721E
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 16:02:35 +0100 (CET)
In-Reply-To: <1511362947-14747-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

Use devm_of_platform_populate() instead of of_platform_depopulate()
to simplify driver code.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 0a1f064..d743b7d 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -124,7 +124,6 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 
 static int stm32_sai_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct stm32_sai_data *sai;
 	struct reset_control *rst;
 	struct resource *res;
@@ -184,14 +183,7 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	sai->set_sync = &stm32_sai_set_sync;
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
@@ -202,7 +194,6 @@ static int stm32_sai_remove(struct platform_device *pdev)
 		.of_match_table = stm32_sai_ids,
 	},
 	.probe = stm32_sai_probe,
-	.remove = stm32_sai_remove,
 };
 
 module_platform_driver(stm32_sai_driver);
-- 
1.9.1
