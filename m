From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/7] ASoC: Intel: bytcht_es8316: Replace
	GFP_ATOMIC with GFP_KERNEL
Date: Fri, 20 Apr 2018 16:14:27 +0530
Message-ID: <1524221072-11040-3-git-send-email-vinod.koul@intel.com>
References: <1524221072-11040-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id DF3302673D4
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 12:40:04 +0200 (CEST)
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

In snd_byt_cht_es8316_mc_probe which is not atomic context, we use
GFP_ATOMIC flag with memory allocation, fix that by using GFP_KERNEL.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 305e7f4fe55a..adc26dfc7d65 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -243,7 +243,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	int i;
 	int ret = 0;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-- 
2.7.4
