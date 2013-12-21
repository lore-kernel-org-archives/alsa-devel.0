From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: sam9x5_wm8731: Remove redundant
	of_match_ptr helper
Date: Sat, 21 Dec 2013 13:49:45 +0530
Message-ID: <1387613985-23420-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 9786E262600
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2013 09:23:02 +0100 (CET)
Received: by mail-pd0-f175.google.com with SMTP id w10so3446384pde.20
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2013 00:23:01 -0800 (PST)
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
Cc: sachin.kamat@linaro.org, broonie@kernel.org, nicolas.ferre@atmel.com
List-Id: alsa-devel@alsa-project.org

'sam9x5_wm8731_of_match' is always compiled in. Hence the
helper macro is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/atmel/sam9x5_wm8731.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index 7d6a9055874b..59df542afc7d 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -195,7 +195,7 @@ static struct platform_driver sam9x5_wm8731_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(sam9x5_wm8731_of_match),
+		.of_match_table = sam9x5_wm8731_of_match,
 	},
 	.probe = sam9x5_wm8731_driver_probe,
 	.remove = sam9x5_wm8731_driver_remove,
-- 
1.7.9.5
