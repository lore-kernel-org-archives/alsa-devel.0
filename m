From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/9] ASoC: Intel: bytcr_rt5651: Remove IN2
	input mappings
Date: Sun, 24 Jun 2018 16:06:29 +0200
Message-ID: <20180624140634.16835-5-hdegoede@redhat.com>
References: <20180624140634.16835-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 91631267353
 for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2018 16:06:45 +0200 (CEST)
In-Reply-To: <20180624140634.16835-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

BYT_RT5651_IN2_MAP was introduced in commit 39712db878a4 ("SoC: intel: byt:
Introduce new custom IN2 map"), uses in commit 2fe30129b0a6 ("ASoC: intel:
byt: Enable IN2 map quirk for a KIANO laptop"), only to be replaced by a
new BYT_RT5651_IN1_IN2_MAP quirk in commit ea261bd02a67 ("ASoC: intel:
byt: Introduce new map for dual mics") quickly afterwards, because the
KIANO laptop has 2 internal mics on IN1 and IN2 and the headset mic is
not in IN1 where the BYT_RT5651_IN2_MAP maps it, but on IN3.

Now that the KIANO quirk entry uses BYT_RT5651_IN1_IN2_MAP, there are no
users of BYT_RT5651_IN2_MAP left. This makes sense since the headset mic
seems to always be connected to IN3, so BYT_RT5651_IN2_MAP is not useful.

To deal with BYT_RT5651_IN2_MAP wrongly mapping the headset mic to IN1,
BYT_RT5651_IN2_HS_IN3_MAP was added in commit f026e0631780 ("ASoC: Intel:
bytcr_rt5651: Add new IN2_HS_IN3 input map and a quirk using it"). This
was based on the assumption then some devices have the internal mic
connected to IN2 only. Further testing has shown that this is wrong and the
internal mic is always connected to IN1 and sometimes to both IN1 and IN2.

TL;DR: Both BYT_RT5651_IN2_MAP and BYT_RT5651_IN2_HS_IN3_MAP are based on
on wrong assumptions from the past and are no longer useful now, so they
can both be removed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 30 ++-------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 57de730f74dd..c1bc3d4df841 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -42,10 +42,8 @@
 enum {
 	BYT_RT5651_DMIC_MAP,
 	BYT_RT5651_IN1_MAP,
-	BYT_RT5651_IN2_MAP,
 	BYT_RT5651_IN1_IN2_MAP,
 	BYT_RT5651_IN1_HS_IN3_MAP,
-	BYT_RT5651_IN2_HS_IN3_MAP,
 };
 
 enum {
@@ -102,14 +100,10 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk DMIC_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_MAP)
 		dev_info(dev, "quirk IN1_MAP enabled");
-	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN2_MAP)
-		dev_info(dev, "quirk IN2_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_IN2_MAP)
 		dev_info(dev, "quirk IN1_IN2_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_HS_IN3_MAP)
 		dev_info(dev, "quirk IN1_HS_IN3_MAP enabled");
-	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN2_HS_IN3_MAP)
-		dev_info(dev, "quirk IN2_HS_IN3_MAP enabled");
 	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
 		dev_info(dev, "quirk realtek,jack-detect-source %ld\n",
 			 BYT_RT5651_JDSRC(byt_rt5651_quirk));
@@ -258,12 +252,6 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {
 	{"IN2P", NULL, "Headset Mic"},
 };
 
-static const struct snd_soc_dapm_route byt_rt5651_intmic_in2_map[] = {
-	{"Internal Mic", NULL, "micbias1"},
-	{"IN1P", NULL, "Headset Mic"},
-	{"IN2P", NULL, "Internal Mic"},
-};
-
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_in2_map[] = {
 	{"Internal Mic", NULL, "micbias1"},
 	{"IN1P", NULL, "Internal Mic"},
@@ -277,12 +265,6 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_hs_in3_map[] = {
 	{"IN3P", NULL, "Headset Mic"},
 };
 
-static const struct snd_soc_dapm_route byt_rt5651_intmic_in2_hs_in3_map[] = {
-	{"Internal Mic", NULL, "micbias1"},
-	{"IN2P", NULL, "Internal Mic"},
-	{"IN3P", NULL, "Headset Mic"},
-};
-
 static const struct snd_soc_dapm_route byt_rt5651_ssp0_aif1_map[] = {
 	{"ssp0 Tx", NULL, "modem_out"},
 	{"modem_in", NULL, "ssp0 Rx"},
@@ -483,10 +465,6 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in1_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_map);
 		break;
-	case BYT_RT5651_IN2_MAP:
-		custom_map = byt_rt5651_intmic_in2_map;
-		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in2_map);
-		break;
 	case BYT_RT5651_IN1_IN2_MAP:
 		custom_map = byt_rt5651_intmic_in1_in2_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_in2_map);
@@ -495,10 +473,6 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in1_hs_in3_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_hs_in3_map);
 		break;
-	case BYT_RT5651_IN2_HS_IN3_MAP:
-		custom_map = byt_rt5651_intmic_in2_hs_in3_map;
-		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in2_hs_in3_map);
-		break;
 	default:
 		custom_map = byt_rt5651_intmic_dmic_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic_map);
@@ -744,9 +718,9 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
 	const char * const intmic_name[] =
-		{ "dmic", "in1", "in2", "in12", "in1", "in2" };
+		{ "dmic", "in1", "in12", "in1" };
 	const char * const hsmic_name[] =
-		{  "in2", "in2", "in1",  "in3", "in3", "in3" };
+		{  "in2", "in2", "in3", "in3" };
 	struct byt_rt5651_private *priv;
 	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
-- 
2.17.1
