From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/9] ASoC: Intel: mfld-pcm: Fix to Store device
	context in sst_data
Date: Thu, 30 Oct 2014 16:21:44 +0530
Message-ID: <1414666312-4657-2-git-send-email-vinod.koul@intel.com>
References: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6949B26545A
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:32:32 +0100 (CET)
In-Reply-To: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

Some debug prints use dev context in sst_data. Store the device context for
the same.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index e7cf18d..6032f18 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -706,6 +706,7 @@ static int sst_platform_probe(struct platform_device *pdev)
 	pdata->pdev_strm_map = dpcm_strm_map;
 	pdata->strm_map_size = ARRAY_SIZE(dpcm_strm_map);
 	drv->pdata = pdata;
+	drv->pdev = pdev;
 	mutex_init(&drv->lock);
 	dev_set_drvdata(&pdev->dev, drv);
 
-- 
1.7.0.4
