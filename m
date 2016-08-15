From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: quirk for mono
	speaker" to the asoc tree
Date: Mon, 15 Aug 2016 15:16:12 +0100
Message-ID: <E1bZIgW-0007SU-1C@debutante>
References: <1471037280-17433-3-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BEC4226788D
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 16:16:18 +0200 (CEST)
In-Reply-To: <1471037280-17433-3-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: quirk for mono speaker

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

>From 68817cdb3b9f1a19ac6741cdb7151f463d86ec7f Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 12 Aug 2016 16:27:45 -0500
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: quirk for mono speaker

Some Baytrail devices only have a mono speaker, add quirk and enable
it for T100TAF.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 2d3441d58d6f..421a53cfa53f 100644
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
2.8.1
