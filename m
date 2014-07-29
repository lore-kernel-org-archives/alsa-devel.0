From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_asrc: Use 'ifdef' for config options
Date: Tue, 29 Jul 2014 16:10:16 -0300
Message-ID: <1406661016-1478-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D7E82651F2
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 21:10:43 +0200 (CEST)
Received: by mail-vc0-f179.google.com with SMTP id hq11so205867vcb.10
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 12:10:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Guangyu.Chen@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following build errors that were observed by building with
make ARCH=microblaze allyesconfig:

>> sound/soc/fsl/fsl_asrc.c:906:5: warning: "CONFIG_PM_RUNTIME" is not defined [-Wundef]
    #if CONFIG_PM_RUNTIME
        ^
>> sound/soc/fsl/fsl_asrc.c:934:5: warning: "CONFIG_PM_SLEEP" is not defined [-Wundef]
    #if CONFIG_PM_SLEEP
        ^
>> sound/soc/fsl/fsl_asrc.c:906:5: warning: "CONFIG_PM_RUNTIME" is not defined [-Wundef]
    #if CONFIG_PM_RUNTIME
        ^
>> sound/soc/fsl/fsl_asrc.c:934:5: warning: "CONFIG_PM_SLEEP" is not defined [-Wundef]
    #if CONFIG_PM_SLEEP

Reported-by: kbuild test robot <fengguang.wu@intel.com> 
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_asrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 27a4a70..b9a2888 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -903,7 +903,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#if CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM_RUNTIME
 static int fsl_asrc_runtime_resume(struct device *dev)
 {
 	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
@@ -931,7 +931,7 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
 }
 #endif /* CONFIG_PM_RUNTIME */
 
-#if CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_SLEEP
 static int fsl_asrc_suspend(struct device *dev)
 {
 	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
-- 
1.8.3.2
