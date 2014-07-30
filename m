From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH] ASoC: Intel: mfld-pcm: Allocate platform data
Date: Wed, 30 Jul 2014 18:39:05 +0530
Message-ID: <1406725745-30776-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ED542650A0
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 15:30:15 +0200 (CEST)
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Platform data may be null during platform_device_add. Allocate platform
data before using.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index dbff2965a6e3..8dd1c0f6773f 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -694,7 +694,7 @@ static int sst_platform_probe(struct platform_device *pdev)
 {
 	struct sst_data *drv;
 	int ret;
-	struct sst_platform_data *pdata = pdev->dev.platform_data;
+	struct sst_platform_data *pdata;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (drv == NULL) {
@@ -702,6 +702,12 @@ static int sst_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (pdata == NULL) {
+		pr_err("kzalloc failed for pdata\n");
+		return -ENOMEM;
+	}
+
 	pdata->pdev_strm_map = dpcm_strm_map;
 	pdata->strm_map_size = ARRAY_SIZE(dpcm_strm_map);
 	drv->pdata = pdata;
-- 
1.9.0
