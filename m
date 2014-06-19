From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: max98090: Remove needless defines and
	line feeds
Date: Thu, 19 Jun 2014 09:44:26 +0300
Message-ID: <1403160266-4571-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BF4E72651CF
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 08:44:34 +0200 (CEST)
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index d97f1ce7ff7d..6ea0fdd42eb5 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -26,10 +26,6 @@
 #include <sound/max98090.h>
 #include "max98090.h"
 
-#define DEBUG
-#define EXTMIC_METHOD
-#define EXTMIC_METHOD_TEST
-
 /* Allows for sparsely populated register maps */
 static struct reg_default max98090_reg[] = {
 	{ 0x00, 0x00 }, /* 00 Software Reset */
@@ -820,7 +816,6 @@ static int max98090_micinput_event(struct snd_soc_dapm_widget *w,
 	else
 		val = (val & M98090_MIC_PA2EN_MASK) >> M98090_MIC_PA2EN_SHIFT;
 
-
 	if (val >= 1) {
 		if (w->reg == M98090_REG_MIC1_INPUT_LEVEL) {
 			max98090->pa1en = val - 1; /* Update for volatile */
@@ -1140,7 +1135,6 @@ static const struct snd_kcontrol_new max98090_mixhprsel_mux =
 	SOC_DAPM_ENUM("MIXHPRSEL Mux", mixhprsel_mux_enum);
 
 static const struct snd_soc_dapm_widget max98090_dapm_widgets[] = {
-
 	SND_SOC_DAPM_INPUT("MIC1"),
 	SND_SOC_DAPM_INPUT("MIC2"),
 	SND_SOC_DAPM_INPUT("DMICL"),
@@ -1304,7 +1298,6 @@ static const struct snd_soc_dapm_widget max98090_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_widget max98091_dapm_widgets[] = {
-
 	SND_SOC_DAPM_INPUT("DMIC3"),
 	SND_SOC_DAPM_INPUT("DMIC4"),
 
@@ -1315,7 +1308,6 @@ static const struct snd_soc_dapm_widget max98091_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route max98090_dapm_routes[] = {
-
 	{"MIC1 Input", NULL, "MIC1"},
 	{"MIC2 Input", NULL, "MIC2"},
 
@@ -1493,17 +1485,14 @@ static const struct snd_soc_dapm_route max98090_dapm_routes[] = {
 	{"SPKR", NULL, "SPK Right Out"},
 	{"RCVL", NULL, "RCV Left Out"},
 	{"RCVR", NULL, "RCV Right Out"},
-
 };
 
 static const struct snd_soc_dapm_route max98091_dapm_routes[] = {
-
 	/* DMIC inputs */
 	{"DMIC3", NULL, "DMIC3_ENA"},
 	{"DMIC4", NULL, "DMIC4_ENA"},
 	{"DMIC3", NULL, "AHPF"},
 	{"DMIC4", NULL, "AHPF"},
-
 };
 
 static int max98090_add_widgets(struct snd_soc_codec *codec)
@@ -1531,7 +1520,6 @@ static int max98090_add_widgets(struct snd_soc_codec *codec)
 
 		snd_soc_dapm_add_routes(dapm, max98091_dapm_routes,
 			ARRAY_SIZE(max98091_dapm_routes));
-
 	}
 
 	return 0;
@@ -2221,7 +2209,6 @@ static void max98090_handle_pdata(struct snd_soc_codec *codec)
 		dev_err(codec->dev, "No platform data\n");
 		return;
 	}
-
 }
 
 static int max98090_probe(struct snd_soc_codec *codec)
-- 
2.0.0
