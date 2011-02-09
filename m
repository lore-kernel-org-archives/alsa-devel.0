From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 1/3] ASoC: Davinci: Use resource_size() helper
	function
Date: Wed,  9 Feb 2011 18:39:52 +0530
Message-ID: <1297256994-17137-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E15C2440F
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 14:10:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, sshtylyov@mvista.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch modifies the Davinci i2s and mcasp drivers
to make use of the resource_size() helper function for readability.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 sound/soc/davinci/davinci-i2s.c   |    6 +++---
 sound/soc/davinci/davinci-mcasp.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 9e0e565..f8c8487 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -658,7 +658,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ioarea = request_mem_region(mem->start, (mem->end - mem->start) + 1,
+	ioarea = request_mem_region(mem->start, resource_size(mem),
 				    pdev->name);
 	if (!ioarea) {
 		dev_err(&pdev->dev, "McBSP region already claimed\n");
@@ -731,7 +731,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 err_free_mem:
 	kfree(dev);
 err_release_region:
-	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	release_mem_region(mem->start, resource_size(mem));
 
 	return ret;
 }
@@ -747,7 +747,7 @@ static int davinci_i2s_remove(struct platform_device *pdev)
 	dev->clk = NULL;
 	kfree(dev);
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	release_mem_region(mem->start, resource_size(mem));
 
 	return 0;
 }
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index fb55d2c..9b5d5ca 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -868,7 +868,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	}
 
 	ioarea = request_mem_region(mem->start,
-			(mem->end - mem->start) + 1, pdev->name);
+			resource_size(mem), pdev->name);
 	if (!ioarea) {
 		dev_err(&pdev->dev, "Audio region already claimed\n");
 		ret = -EBUSY;
@@ -933,7 +933,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	return 0;
 
 err_release_region:
-	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	release_mem_region(mem->start, resource_size(mem));
 err_release_data:
 	kfree(dev);
 
@@ -951,7 +951,7 @@ static int davinci_mcasp_remove(struct platform_device *pdev)
 	dev->clk = NULL;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	release_mem_region(mem->start, resource_size(mem));
 
 	kfree(dev);
 
-- 
1.6.2.4
