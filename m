From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 02/13] ASoC: Intel: mark cht machine driver
	with nonatomic trigger
Date: Thu, 12 Feb 2015 09:59:54 +0530
Message-ID: <1423715405-4562-3-git-send-email-vinod.koul@intel.com>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 542A726512A
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 05:32:55 +0100 (CET)
In-Reply-To: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
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

The DSP messages are sent with nonatomic context, which include trigger
messages, so mark the driver as nonatomic

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/cht_bsw_rt5672.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/cht_bsw_rt5672.c b/sound/soc/intel/cht_bsw_rt5672.c
index ff016621583a..152e7703dd8a 100644
--- a/sound/soc/intel/cht_bsw_rt5672.c
+++ b/sound/soc/intel/cht_bsw_rt5672.c
@@ -218,6 +218,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.codec_name = "snd-soc-dummy",
 		.platform_name = "sst-mfld-platform",
 		.ignore_suspend = 1,
+		.nonatomic = true,
 		.dynamic = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
@@ -240,6 +241,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
+		.nonatomic = true,
 		.codec_dai_name = "rt5670-aif1",
 		.codec_name = "i2c-10EC5670:00",
 		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
-- 
1.7.9.5
