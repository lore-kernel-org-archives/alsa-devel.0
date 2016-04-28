From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/5] ASoC: Intel: Boards: remove ignore_suspend
	for WoV streams
Date: Thu, 28 Apr 2016 18:45:29 +0530
Message-ID: <1461849329-20364-6-git-send-email-vinod.koul@intel.com>
References: <1461849329-20364-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 321982667D3
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 15:10:52 +0200 (CEST)
In-Reply-To: <1461849329-20364-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

On WoV we can suspend the DMA and keep the DSP pipelines only On,
so remove the ignore_suspend for WoV streams but keep them for
WoV endpoints.

This helps in achieving better power by suspending DMAs

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 1 -
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   | 1 -
 sound/soc/intel/boards/skl_rt286.c              | 1 -
 3 files changed, 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 8ccc97c6255f..c3e85fb550cb 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -434,7 +434,6 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.platform_name = "0000:00:1f.3",
 		.init = NULL,
 		.dpcm_capture = 1,
-		.ignore_suspend = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
 		.ops = &skylaye_refcap_ops,
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index bde85bf989b8..0aeceaa6f3ba 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -482,7 +482,6 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.platform_name = "0000:00:1f.3",
 		.init = NULL,
 		.dpcm_capture = 1,
-		.ignore_suspend = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
 		.ops = &skylaye_refcap_ops,
diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 06de802898fb..e2b5b855ae71 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -338,7 +338,6 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.platform_name = "0000:00:1f.3",
 		.init = NULL,
 		.dpcm_capture = 1,
-		.ignore_suspend = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
-- 
1.9.1
