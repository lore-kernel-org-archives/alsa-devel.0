From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: configure DMIC for
	machine sklnau8825adi" to the asoc tree
Date: Tue, 31 May 2016 18:45:48 +0100
Message-ID: <E1b7njg-0005zU-Di@debutante>
References: <1464708168-6349-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32B86266267
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 19:45:53 +0200 (CEST)
In-Reply-To: <1464708168-6349-1-git-send-email-yong.zhi@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yong Zhi <yong.zhi@intel.com>
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, yang.a.fang@intel.com, broonie@kernel.org, sathya.prakash.m.r@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: configure DMIC for machine sklnau8825adi

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From cfa12367f8e032e515853a3ae12545dee18b9806 Mon Sep 17 00:00:00 2001
From: Yong Zhi <yong.zhi@intel.com>
Date: Tue, 31 May 2016 10:22:48 -0500
Subject: [PATCH] ASoC: Intel: boards: configure DMIC for machine sklnau8825adi

This machine driver can support 2 or 4 DMIC configuration, so
apply the ch constraint according to driver pdata.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 2647d885ee00..22f2e9d84e72 100644
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
 
 struct skl_hdmi_pcm {
 	struct list_head head;
@@ -367,7 +370,7 @@ static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 {
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
-	if (params_channels(params) == 2)
+	if (params_channels(params) == 2 || DMIC_CH(dmic_constraints) == 2)
 		channels->min = channels->max = 2;
 	else
 		channels->min = channels->max = 4;
@@ -405,13 +408,23 @@ static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
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
@@ -676,6 +689,7 @@ static struct snd_soc_card skylake_audio_card = {
 static int skylake_audio_probe(struct platform_device *pdev)
 {
 	struct skl_nau88125_private *ctx;
+	struct skl_machine_pdata *pdata;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
 	if (!ctx)
@@ -686,6 +700,11 @@ static int skylake_audio_probe(struct platform_device *pdev)
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
2.8.1
