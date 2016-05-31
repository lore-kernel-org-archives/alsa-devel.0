From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH v4 2/2] ASoC: Intel: boards: configure DMIC for
	machine sklnau8825max
Date: Tue, 31 May 2016 10:24:03 -0500
Message-ID: <1464708243-6407-1-git-send-email-yong.zhi@intel.com>
References: <1464182357-1305-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 603F726671C
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 17:24:09 +0200 (CEST)
In-Reply-To: <1464182357-1305-1-git-send-email-yong.zhi@intel.com>
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
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index fc3f475..afc6f74 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -23,12 +23,15 @@
 #include <sound/soc.h>
 #include "../../codecs/nau8825.h"
 #include "../../codecs/hdac_hdmi.h"
+#include "../skylake/skl.h"
 
 #define SKL_NUVOTON_CODEC_DAI	"nau8825-hifi"
 #define SKL_MAXIM_CODEC_DAI "HiFi"
+#define DMIC_CH(p)     p->list[p->count-1]
 
 static struct snd_soc_jack skylake_headset;
 static struct snd_soc_card skylake_audio_card;
+static const struct snd_pcm_hw_constraint_list *dmic_constraints;
 
 struct skl_hdmi_pcm {
 	struct list_head head;
@@ -339,7 +342,7 @@ static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 	struct snd_interval *channels = hw_param_interval(params,
 				SNDRV_PCM_HW_PARAM_CHANNELS);
 
-	if (params_channels(params) == 2)
+	if (params_channels(params) == 2 || DMIC_CH(dmic_constraints) == 2)
 		channels->min = channels->max = 2;
 	else
 		channels->min = channels->max = 4;
@@ -357,13 +360,23 @@ static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
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
-			&constraints_dmic_channels);
+			dmic_constraints);
 
 	return snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
@@ -624,6 +637,7 @@ static struct snd_soc_card skylake_audio_card = {
 static int skylake_audio_probe(struct platform_device *pdev)
 {
 	struct skl_nau8825_private *ctx;
+	struct skl_machine_pdata *pdata;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
 	if (!ctx)
@@ -634,6 +648,11 @@ static int skylake_audio_probe(struct platform_device *pdev)
 	skylake_audio_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&skylake_audio_card, ctx);
 
+	pdata = dev_get_drvdata(&pdev->dev);
+	if (pdata)
+		dmic_constraints = pdata->dmic_num == 2 ?
+			&constraints_dmic_2ch : &constraints_dmic_channels;
+
 	return devm_snd_soc_register_card(&pdev->dev, &skylake_audio_card);
 }
 
-- 
2.7.4
