From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 2/4] ASoC: sst_platform: trivial coding style
	fix
Date: Tue, 06 Sep 2011 15:21:34 +0800
Message-ID: <20110906072134.7310.30710.stgit@localhost>
References: <20110906072129.7310.6960.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id C79191038BB
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 09:19:04 +0200 (CEST)
In-Reply-To: <20110906072129.7310.6960.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>
Cc: Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 3e78260..d99f253 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -469,7 +469,7 @@ static struct platform_driver sst_platform_driver = {
 static int __init sst_soc_platform_init(void)
 {
 	pr_debug("sst_soc_platform_init called\n");
-	return  platform_driver_register(&sst_platform_driver);
+	return platform_driver_register(&sst_platform_driver);
 }
 module_init(sst_soc_platform_init);
 
