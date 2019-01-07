From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcht_es8316: Add input-map
	support" to the asoc tree
Date: Mon,  7 Jan 2019 12:30:44 +0000 (GMT)
Message-ID: <20190107123044.AA0BB1127490@debutante.sirena.org.uk>
References: <20190103134535.13861-9-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 650B5267BC5
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 13:30:45 +0100 (CET)
In-Reply-To: <20190103134535.13861-9-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcht_es8316: Add input-map support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 730501a91d94b652275e049e101ed44cdbfdf31b Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 3 Jan 2019 14:45:33 +0100
Subject: [PATCH] ASoC: Intel: bytcht_es8316: Add input-map support

After adding jack-detect support we have 3 microphone input switches:
"Microphone 1", "Microphone 2" and "Headset Mic". But the ES8316 has only
2 microphone inputs.

In the app-note explaining how to use the codec and on the 3 boards I
have one input is used for an internal microphone and one for the headset
microphone. On the 2 CHT boards I have the internal mic is on on MIC1 and
the headset mic is on MIC2, on the BYTCR board I have it is the other way
around.

This commit replaces the 2 "Microphone 1" and "Microphone 2" input switches
with a single "Internal Mic" switch and adds support for selecting either
possible input mapping.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 58 ++++++++++++++++++--------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 8e504fca4624..941a66f94660 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -47,6 +47,12 @@ struct byt_cht_es8316_private {
 	bool speaker_en;
 };
 
+enum {
+	BYT_CHT_ES8316_INTMIC_IN1_MAP,
+	BYT_CHT_ES8316_INTMIC_IN2_MAP,
+};
+
+#define BYT_CHT_ES8316_MAP(quirk)		((quirk) & GENMASK(3, 0))
 #define BYT_CHT_ES8316_SSP0			BIT(16)
 
 static int quirk;
@@ -57,6 +63,10 @@ MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static void log_quirks(struct device *dev)
 {
+	if (BYT_CHT_ES8316_MAP(quirk) == BYT_CHT_ES8316_INTMIC_IN1_MAP)
+		dev_info(dev, "quirk IN1_MAP enabled");
+	if (BYT_CHT_ES8316_MAP(quirk) == BYT_CHT_ES8316_INTMIC_IN2_MAP)
+		dev_info(dev, "quirk IN2_MAP enabled");
 	if (quirk & BYT_CHT_ES8316_SSP0)
 		dev_info(dev, "quirk SSP0 enabled");
 }
@@ -81,14 +91,7 @@ static const struct snd_soc_dapm_widget byt_cht_es8316_widgets[] = {
 	SND_SOC_DAPM_SPK("Speaker", NULL),
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-
-	/*
-	 * The codec supports two analog microphone inputs. I have only
-	 * tested MIC1. A DMIC route could also potentially be added
-	 * if such functionality is found on another platform.
-	 */
-	SND_SOC_DAPM_MIC("Microphone 1", NULL),
-	SND_SOC_DAPM_MIC("Microphone 2", NULL),
+	SND_SOC_DAPM_MIC("Internal Mic", NULL),
 
 	SND_SOC_DAPM_SUPPLY("Speaker Power", SND_SOC_NOPM, 0, 0,
 			    byt_cht_es8316_speaker_power_event,
@@ -96,10 +99,6 @@ static const struct snd_soc_dapm_widget byt_cht_es8316_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route byt_cht_es8316_audio_map[] = {
-	{"MIC1", NULL, "Microphone 1"},
-	{"MIC2", NULL, "Microphone 2"},
-	{"MIC1", NULL, "Headset Mic"},
-
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
 
@@ -112,6 +111,16 @@ static const struct snd_soc_dapm_route byt_cht_es8316_audio_map[] = {
 	{"Speaker", NULL, "Speaker Power"},
 };
 
+static const struct snd_soc_dapm_route byt_cht_es8316_intmic_in1_map[] = {
+	{"MIC1", NULL, "Internal Mic"},
+	{"MIC2", NULL, "Headset Mic"},
+};
+
+static const struct snd_soc_dapm_route byt_cht_es8316_intmic_in2_map[] = {
+	{"MIC2", NULL, "Internal Mic"},
+	{"MIC1", NULL, "Headset Mic"},
+};
+
 static const struct snd_soc_dapm_route byt_cht_es8316_ssp0_map[] = {
 	{"Playback", NULL, "ssp0 Tx"},
 	{"ssp0 Tx", NULL, "modem_out"},
@@ -132,8 +141,7 @@ static const struct snd_kcontrol_new byt_cht_es8316_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speaker"),
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
-	SOC_DAPM_PIN_SWITCH("Microphone 1"),
-	SOC_DAPM_PIN_SWITCH("Microphone 2"),
+	SOC_DAPM_PIN_SWITCH("Internal Mic"),
 };
 
 static struct snd_soc_jack_pin byt_cht_es8316_jack_pins[] = {
@@ -158,6 +166,21 @@ static int byt_cht_es8316_init(struct snd_soc_pcm_runtime *runtime)
 
 	card->dapm.idle_bias_off = true;
 
+	switch (BYT_CHT_ES8316_MAP(quirk)) {
+	case BYT_CHT_ES8316_INTMIC_IN1_MAP:
+	default:
+		custom_map = byt_cht_es8316_intmic_in1_map;
+		num_routes = ARRAY_SIZE(byt_cht_es8316_intmic_in1_map);
+		break;
+	case BYT_CHT_ES8316_INTMIC_IN2_MAP:
+		custom_map = byt_cht_es8316_intmic_in2_map;
+		num_routes = ARRAY_SIZE(byt_cht_es8316_intmic_in2_map);
+		break;
+	}
+	ret = snd_soc_dapm_add_routes(&card->dapm, custom_map, num_routes);
+	if (ret)
+		return ret;
+
 	if (quirk & BYT_CHT_ES8316_SSP0) {
 		custom_map = byt_cht_es8316_ssp0_map;
 		num_routes = ARRAY_SIZE(byt_cht_es8316_ssp0_map);
@@ -444,10 +467,11 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	/* Check for BYTCR or other platform and setup quirks */
 	if (x86_match_cpu(baytrail_cpu_ids) &&
 	    mach->mach_params.acpi_ipc_irq_index == 0) {
-		/* On BYTCR default to SSP0 */
-		quirk = BYT_CHT_ES8316_SSP0;
+		/* On BYTCR default to SSP0, internal-mic-in2-map */
+		quirk = BYT_CHT_ES8316_SSP0 | BYT_CHT_ES8316_INTMIC_IN2_MAP;
 	} else {
-		quirk = 0;
+		/* Others default to internal-mic-in1-map */
+		quirk = BYT_CHT_ES8316_INTMIC_IN1_MAP;
 	}
 	if (quirk_override != -1) {
 		dev_info(dev, "Overriding quirk 0x%x => 0x%x\n", quirk,
-- 
2.20.1
