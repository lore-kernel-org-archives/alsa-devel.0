From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 3/4] ASoC: Intel: Remove ignore suspend
	support
Date: Tue, 24 Feb 2015 11:39:46 +0530
Message-ID: <1424758188-15569-4-git-send-email-vinod.koul@intel.com>
References: <1424758188-15569-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 14B362604EA
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 07:12:49 +0100 (CET)
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

In our platform we want platform and codec driver routines to get invoked
and don't need the machine routines so remove here

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/cht_bsw_rt5672.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/cht_bsw_rt5672.c b/sound/soc/intel/cht_bsw_rt5672.c
index a5098d6f988b..67db5101bc89 100644
--- a/sound/soc/intel/cht_bsw_rt5672.c
+++ b/sound/soc/intel/cht_bsw_rt5672.c
@@ -215,7 +215,6 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.codec_name = "snd-soc-dummy",
 		.platform_name = "sst-mfld-platform",
-		.ignore_suspend = 1,
 		.nonatomic = true,
 		.dynamic = 1,
 		.dpcm_playback = 1,
@@ -246,7 +245,6 @@ static struct snd_soc_dai_link cht_dailink[] = {
 					| SND_SOC_DAIFMT_CBS_CFS,
 		.init = cht_codec_init,
 		.be_hw_params_fixup = cht_codec_fixup,
-		.ignore_suspend = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.ops = &cht_be_ssp2_ops,
-- 
1.7.9.5
