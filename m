From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 4/4] ASoC: Intel: Remove soc pm handling to
	allow platform driver handle it
Date: Tue, 24 Feb 2015 11:39:47 +0530
Message-ID: <1424758188-15569-5-git-send-email-vinod.koul@intel.com>
References: <1424758188-15569-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 004DC2604F0
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 07:12:51 +0100 (CET)
In-Reply-To: <1424758188-15569-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/cht_bsw_rt5672.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/cht_bsw_rt5672.c b/sound/soc/intel/cht_bsw_rt5672.c
index 67db5101bc89..bc8dcacd5e6a 100644
--- a/sound/soc/intel/cht_bsw_rt5672.c
+++ b/sound/soc/intel/cht_bsw_rt5672.c
@@ -283,7 +283,6 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 static struct platform_driver snd_cht_mc_driver = {
 	.driver = {
 		.name = "cht-bsw-rt5672",
-		.pm = &snd_soc_pm_ops,
 	},
 	.probe = snd_cht_mc_probe,
 };
-- 
1.7.9.5
