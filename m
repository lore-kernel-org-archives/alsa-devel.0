From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 02/17] ASoC: Intel: bytcr_rt5640: quirk for
	mono speaker
Date: Fri, 12 Aug 2016 16:27:45 -0500
Message-ID: <1471037280-17433-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 36022265E38
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:46 +0200 (CEST)
In-Reply-To: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

Some Baytrail devices only have a mono speaker, add quirk and enable
it for T100TAF.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 2d3441d..421a53c 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -40,6 +40,7 @@ enum {
 
 #define BYT_RT5640_MAP(quirk)	((quirk) & 0xff)
 #define BYT_RT5640_DMIC_EN	BIT(16)
+#define BYT_RT5640_MONO_SPEAKER BIT(17)
 
 static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
 					BYT_RT5640_DMIC_EN;
@@ -63,10 +64,6 @@ static const struct snd_soc_dapm_route byt_rt5640_audio_map[] = {
 	{"IN2P", NULL, "Headset Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
-	{"Speaker", NULL, "SPOLP"},
-	{"Speaker", NULL, "SPOLN"},
-	{"Speaker", NULL, "SPORP"},
-	{"Speaker", NULL, "SPORN"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5640_intmic_dmic1_map[] = {
@@ -82,6 +79,18 @@ static const struct snd_soc_dapm_route byt_rt5640_intmic_in1_map[] = {
 	{"IN1P", NULL, "Internal Mic"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5640_stereo_spk_map[] = {
+	{"Speaker", NULL, "SPOLP"},
+	{"Speaker", NULL, "SPOLN"},
+	{"Speaker", NULL, "SPORP"},
+	{"Speaker", NULL, "SPORN"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5640_mono_spk_map[] = {
+	{"Speaker", NULL, "SPOLP"},
+	{"Speaker", NULL, "SPOLN"},
+};
+
 static const struct snd_kcontrol_new byt_rt5640_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -138,7 +147,9 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
 		},
-		.driver_data = (unsigned long *)BYT_RT5640_IN1_MAP,
+		.driver_data = (unsigned long *)(BYT_RT5640_IN1_MAP |
+						 BYT_RT5640_MONO_SPEAKER
+						 ),
 	},
 	{
 		.callback = byt_rt5640_quirk_cb,
@@ -200,6 +211,18 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
+	if (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER) {
+		ret = snd_soc_dapm_add_routes(&card->dapm,
+					byt_rt5640_mono_spk_map,
+					ARRAY_SIZE(byt_rt5640_mono_spk_map));
+	} else {
+		ret = snd_soc_dapm_add_routes(&card->dapm,
+					byt_rt5640_stereo_spk_map,
+					ARRAY_SIZE(byt_rt5640_stereo_spk_map));
+	}
+	if (ret)
+		return ret;
+
 	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN) {
 		ret = rt5640_dmic_enable(codec, 0, 0);
 		if (ret)
-- 
2.5.0
