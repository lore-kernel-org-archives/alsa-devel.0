From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: davinci-mcasp: Remove redundant use
	of of_match_ptr macro
Date: Wed, 22 May 2013 16:53:37 +0530
Message-ID: <1369221817-5123-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id A1657260304
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 13:37:24 +0200 (CEST)
Received: by mail-pd0-f175.google.com with SMTP id 6so1261005pdd.20
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 04:37:23 -0700 (PDT)
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
Cc: sachin.kamat@linaro.org, n-pandey@ti.com, broonie@kernel.org, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org

'mcasp_dt_ids' is always compiled in. Hence of_match_ptr is not
necessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/davinci/davinci-mcasp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 56ecfc7..94f1e46 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1023,7 +1023,7 @@ static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
 	struct device_node *np = pdev->dev.of_node;
 	struct snd_platform_data *pdata = NULL;
 	const struct of_device_id *match =
-			of_match_device(of_match_ptr(mcasp_dt_ids), &pdev->dev);
+			of_match_device(mcasp_dt_ids, &pdev->dev);
 
 	const u32 *of_serial_dir32;
 	u8 *of_serial_dir;
@@ -1256,7 +1256,7 @@ static struct platform_driver davinci_mcasp_driver = {
 	.driver		= {
 		.name	= "davinci-mcasp",
 		.owner	= THIS_MODULE,
-		.of_match_table = of_match_ptr(mcasp_dt_ids),
+		.of_match_table = mcasp_dt_ids,
 	},
 };
 
-- 
1.7.9.5
