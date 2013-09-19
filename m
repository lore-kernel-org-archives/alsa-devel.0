From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: SPEAr spdif_out: Remove redundant
	variable
Date: Thu, 19 Sep 2013 12:23:44 +0530
Message-ID: <1379573624-15382-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 971DB26167D
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 08:53:33 +0200 (CEST)
Received: by mail-pd0-f169.google.com with SMTP id r10so8096006pdi.0
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 23:53:32 -0700 (PDT)
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
Cc: sachin.kamat@linaro.org, viresh.kumar@linaro.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Return directly and remove the intermediate local variable.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/spear/spdif_out.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
index 70fc4d6..b6ef6f7 100644
--- a/sound/soc/spear/spdif_out.c
+++ b/sound/soc/spear/spdif_out.c
@@ -280,7 +280,6 @@ static int spdif_out_probe(struct platform_device *pdev)
 	struct spdif_out_dev *host;
 	struct spear_spdif_platform_data *pdata;
 	struct resource *res;
-	int ret;
 
 	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
 	if (!host) {
@@ -307,9 +306,8 @@ static int spdif_out_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, host);
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &spdif_out_component,
-					      &spdif_out_dai, 1);
-	return ret;
+	return devm_snd_soc_register_component(&pdev->dev, &spdif_out_component,
+					       &spdif_out_dai, 1);
 }
 
 #ifdef CONFIG_PM
-- 
1.7.9.5
