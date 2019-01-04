From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcht_es8316: Set card
	long_name based on quirks" to the asoc tree
Date: Fri,  4 Jan 2019 17:08:48 +0000 (GMT)
Message-ID: <20190104170848.34D4E11270A3@debutante.sirena.org.uk>
References: <20190103134535.13861-10-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EDF03267C27
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 18:08:48 +0100 (CET)
In-Reply-To: <20190103134535.13861-10-hdegoede@redhat.com>
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

   ASoC: Intel: bytcht_es8316: Set card long_name based on quirks

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

>From 249d2fc9e55c324dda968252ea3ad0ac21c72b8f Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 3 Jan 2019 14:45:34 +0100
Subject: [PATCH] ASoC: Intel: bytcht_es8316: Set card long_name based on
 quirks

Depending on the input-map and on if 1 or 2 speakers are connected,
userspace needs to use a different UCM profile.

Since we already deal with quirks in the kernel driver and set the
input-map from the kernel, add a quirk for devices with a single / mono
speaker and set the card's long_name based on the input and speaker
quirks, so that userspace can use the long_name to pick the right UCM
profile.

This change, including how the long_name is build-up mirrors how we do
this in the bytcr_rt5640 and bytcr_rt5651 machine drivers.

Note since all devices I have access to use a mono speaker setup I've
chosen to default the speaker setting to mono.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 941a66f94660..cdf2061e7613 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -54,6 +54,7 @@ enum {
 
 #define BYT_CHT_ES8316_MAP(quirk)		((quirk) & GENMASK(3, 0))
 #define BYT_CHT_ES8316_SSP0			BIT(16)
+#define BYT_CHT_ES8316_MONO_SPEAKER		BIT(17)
 
 static int quirk;
 
@@ -69,6 +70,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk IN2_MAP enabled");
 	if (quirk & BYT_CHT_ES8316_SSP0)
 		dev_info(dev, "quirk SSP0 enabled");
+	if (quirk & BYT_CHT_ES8316_MONO_SPEAKER)
+		dev_info(dev, "quirk MONO_SPEAKER enabled\n");
 }
 
 static int byt_cht_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
@@ -352,6 +355,7 @@ static struct snd_soc_dai_link byt_cht_es8316_dais[] = {
 
 /* SoC card */
 static char codec_name[SND_ACPI_I2C_ID_LEN];
+static char long_name[50]; /* = "bytcht-es8316-*-spk-*-mic" */
 
 static int byt_cht_es8316_suspend(struct snd_soc_card *card)
 {
@@ -433,6 +437,7 @@ static const struct acpi_gpio_mapping byt_cht_es8316_gpios[] = {
 
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
+	const char * const mic_name[] = { "in1", "in2" };
 	struct byt_cht_es8316_private *priv;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_acpi_mach *mach;
@@ -467,11 +472,13 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	/* Check for BYTCR or other platform and setup quirks */
 	if (x86_match_cpu(baytrail_cpu_ids) &&
 	    mach->mach_params.acpi_ipc_irq_index == 0) {
-		/* On BYTCR default to SSP0, internal-mic-in2-map */
-		quirk = BYT_CHT_ES8316_SSP0 | BYT_CHT_ES8316_INTMIC_IN2_MAP;
+		/* On BYTCR default to SSP0, internal-mic-in2-map, mono-spk */
+		quirk = BYT_CHT_ES8316_SSP0 | BYT_CHT_ES8316_INTMIC_IN2_MAP |
+			BYT_CHT_ES8316_MONO_SPEAKER;
 	} else {
-		/* Others default to internal-mic-in1-map */
-		quirk = BYT_CHT_ES8316_INTMIC_IN1_MAP;
+		/* Others default to internal-mic-in1-map, mono-speaker */
+		quirk = BYT_CHT_ES8316_INTMIC_IN1_MAP |
+			BYT_CHT_ES8316_MONO_SPEAKER;
 	}
 	if (quirk_override != -1) {
 		dev_info(dev, "Overriding quirk 0x%x => 0x%x\n", quirk,
@@ -518,6 +525,10 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	}
 
 	/* register the soc card */
+	snprintf(long_name, sizeof(long_name), "bytcht-es8316-%s-spk-%s-mic",
+		 (quirk & BYT_CHT_ES8316_MONO_SPEAKER) ? "mono" : "stereo",
+		 mic_name[BYT_CHT_ES8316_MAP(quirk)]);
+	byt_cht_es8316_card.long_name = long_name;
 	byt_cht_es8316_card.dev = dev;
 	snd_soc_card_set_drvdata(&byt_cht_es8316_card, priv);
 
-- 
2.20.1
