From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH v2 3/3] ASoC: Intel: boards: configure DMIC for
	machine sklnau8825adi
Date: Wed, 25 May 2016 06:19:49 -0700
Message-ID: <1464182389-1419-1-git-send-email-yong.zhi@intel.com>
References: <ac23a9ba3795ed50bea2d88dc90b419238ef1542.1463673471.git.yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D10D2669D7
 for <alsa-devel@alsa-project.org>; Wed, 25 May 2016 15:17:30 +0200 (CEST)
In-Reply-To: <ac23a9ba3795ed50bea2d88dc90b419238ef1542.1463673471.git.yong.zhi@intel.com>
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
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, yang.a.fang@intel.com, sathya.prakash.m.r@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

This machine driver can support 2 or 4 DMIC configuration, so
apply the ch constraint according to driver pdata.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 73cbddb..d4e174f 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -27,12 +27,15 @@
 #include <sound/pcm_params.h>
 #include "../../codecs/nau8825.h"
 #include "../../codecs/hdac_hdmi.h"
+#include "../skylake/skl.h"
 
 #define SKL_NUVOTON_CODEC_DAI	"nau8825-hifi"
 #define SKL_SSM_CODEC_DAI	"ssm4567-hifi"
+#define DMIC_CH(p)     p->list[p->count-1]
 
 static struct snd_soc_jack skylake_headset;
 static struct snd_soc_card skylake_audio_card;
+static const struct snd_pcm_hw_constraint_list *dmic_constraints;
 
 enum {
 	SKL_DPCM_AUDIO_PB = 0,
@@ -325,7 +328,7 @@ static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 {
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
-	if (params_channels(params) == 2)
+	if (params_channels(params) == 2 || DMIC_CH(dmic_constraints) == 2)
 		channels->min = channels->max = 2;
 	else
 		channels->min = channels->max = 4;
@@ -363,11 +366,21 @@ static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
 	.mask = 0,
 };
 
+static const unsigned int dmic_2ch[] = {
+	2,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_dmic_2ch = {
+	.count = ARRAY_SIZE(dmic_2ch),
+	.list = dmic_2ch,
+	.mask = 0,
+};
+
 static int skylake_dmic_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	runtime->hw.channels_max = 4;
+	runtime->hw.channels_max = DMIC_CH(dmic_constraints);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 			&constraints_dmic_channels);
 
@@ -603,8 +616,14 @@ static struct snd_soc_card skylake_audio_card = {
 
 static int skylake_audio_probe(struct platform_device *pdev)
 {
+	struct skl_machine_pdata *pdata;
 	skylake_audio_card.dev = &pdev->dev;
 
+	pdata = dev_get_drvdata(&pdev->dev);
+	if (pdata)
+		dmic_constraints = pdata->dmic_num == 2 ?
+			&constraints_dmic_2ch : &constraints_dmic_channels;
+
 	return devm_snd_soc_register_card(&pdev->dev, &skylake_audio_card);
 }
 
-- 
1.9.1
