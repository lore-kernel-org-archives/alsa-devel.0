From: yang.a.fang@intel.com
Subject: [PATCH 5/8] ASoc: Intel: boards: update ignore suspend
	for nau88l25_ssm4567 machine
Date: Fri, 11 Dec 2015 11:29:10 -0800
Message-ID: <1449862153-68738-5-git-send-email-yang.a.fang@intel.com>
References: <1449862153-68738-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B81C26568F
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 20:31:09 +0100 (CET)
In-Reply-To: <1449862153-68738-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, rohit.m.ainapure@intel.com, james.ausmus@intel.com, vinod.koul@intel.com, joe.konno@intel.com, yang.a.fang@intel.com, sathyanarayana.nujella@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

From: Yong Zhi <yong.zhi@intel.com>

We don't support ignore suspend on few devices so remove that.
Also since we support ignore susend on PDM DMIC, add that

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 9c9ebb8..8aa821c 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -187,6 +187,8 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 	nau8825_enable_jack_detect(codec, &skylake_headset);
 
+	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
+
 	return ret;
 }
 
@@ -285,7 +287,6 @@ static struct snd_soc_dai_link skylake_dais[] = {
 			SND_SOC_DAIFMT_IB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 		.init = skylake_ssm4567_codec_init,
-		.ignore_suspend = 1,
 		.ignore_pmdown_time = 1,
 		.be_hw_params_fixup = skylake_ssp_fixup,
 		.dpcm_playback = 1,
@@ -302,7 +303,6 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.init = skylake_nau8825_codec_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
-		.ignore_suspend = 1,
 		.ignore_pmdown_time = 1,
 		.be_hw_params_fixup = skylake_ssp_fixup,
 		.ops = &skylake_nau8825_ops,
-- 
1.7.9.5
