From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: Set card long_name
	based on quirks" to the asoc tree
Date: Thu, 17 May 2018 17:38:53 +0100 (BST)
Message-ID: <20180517163853.5007944007E@finisterre.ee.mobilebroadband>
References: <20180508153604.23711-20-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B31B926766E
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:38:58 +0200 (CEST)
In-Reply-To: <20180508153604.23711-20-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: Set card long_name based on quirks

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

>From 063422ca2a9de238401c3848c1b3641c07b6316c Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 13 May 2018 09:24:35 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Set card long_name based on quirks

Many X86 devices using a BYT SoC + RT5640 codec are cheap devices with
generic DMI strings, causing snd_soc_set_dmi_name() to fail to set a
long_name, making it impossible for userspace to have a correct UCM
profile which only uses inputs / outputs which are actually hooked up
on the device.

Our quirks already specify which input the internal mic is connected to
and if a single (mono) speaker is used or if the device has stereo
speakers.

This commit sets a long_name based on the quirks so that userspace can
have UCM profiles doing the right thing based on the long_name.

Note that if we ever encounter the need for a special UCM profile for
some device we can add a quirk to set a specific long_name for the
device,

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 686d00405493..b0eec0a9b7b9 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -950,6 +950,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 static char byt_rt5640_codec_name[SND_ACPI_I2C_ID_LEN];
 static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
 static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
+static char byt_rt5640_long_name[40]; /* = "bytcr-rt5640-*-spk-*-mic" */
 
 static int byt_rt5640_suspend(struct snd_soc_card *card)
 {
@@ -1021,6 +1022,7 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
+	const char * const map_name[] = { "dmic1", "dmic2", "in1", "in3" };
 	const struct dmi_system_id *dmi_id;
 	struct byt_rt5640_private *priv;
 	struct snd_soc_acpi_mach *mach;
@@ -1184,6 +1186,13 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		}
 	}
 
+	snprintf(byt_rt5640_long_name, sizeof(byt_rt5640_long_name),
+		 "bytcr-rt5640-%s-spk-%s-mic",
+		 (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER) ?
+			"mono" : "stereo",
+		 map_name[BYT_RT5640_MAP(byt_rt5640_quirk)]);
+	byt_rt5640_card.long_name = byt_rt5640_long_name;
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5640_card);
 
 	if (ret_val) {
-- 
2.17.0
