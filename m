From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/7] ASoC: Intel: byt-max98090: Replace
	GFP_ATOMIC with GFP_KERNEL
Date: Fri, 20 Apr 2018 16:14:26 +0530
Message-ID: <1524221072-11040-2-git-send-email-vinod.koul@intel.com>
References: <1524221072-11040-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 68CB62673D3
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 12:40:03 +0200 (CEST)
In-Reply-To: <1524221072-11040-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

In byt_max98090_probe which is not atomic context, we use GFP_ATOMIC
flag with memory allocation, fix that by using GFP_KERNEL.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/byt-max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/byt-max98090.c b/sound/soc/intel/boards/byt-max98090.c
index 0f8b8209c020..f1283634b22b 100644
--- a/sound/soc/intel/boards/byt-max98090.c
+++ b/sound/soc/intel/boards/byt-max98090.c
@@ -151,7 +151,7 @@ static int byt_max98090_probe(struct platform_device *pdev)
 	struct byt_max98090_private *priv;
 	int ret_val;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		dev_err(&pdev->dev, "allocation failed\n");
 		return -ENOMEM;
-- 
2.7.4
