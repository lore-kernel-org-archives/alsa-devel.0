From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH] ASoC: Intel: boards: Remove ignore_suspend for
	WoV streams
Date: Wed, 11 Jan 2017 21:18:05 -0800
Message-ID: <1484198285-16805-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 468BE26680F
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2017 06:12:36 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, chintan.m.patel@intel.com, sathyanarayana.nujella@intel.com, sathya.prakash.m.r@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

When Ref capture is used during S0IX, only the DSP pipelines
are needed, thus remove the ignore_suspend for WoV streams so
that DMA can be suspended, but keep them for WoV endpoints.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 1b4330c..02439ac 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -357,7 +357,6 @@ static int broxton_refcap_startup(struct snd_pcm_substream *substream)
 		.platform_name = "0000:00:0e.0",
 		.init = NULL,
 		.dpcm_capture = 1,
-		.ignore_suspend = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
 		.ops = &broxton_refcap_ops,
-- 
1.9.1
