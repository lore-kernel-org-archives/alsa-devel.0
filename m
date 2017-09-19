From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht_bsw_max98090: add gpio-based
	jack detection" to the asoc tree
Date: Tue, 19 Sep 2017 14:45:16 +0100
Message-ID: <E1duIpw-00080E-A5@debutante>
References: <20170908051309.19028-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4279B266D18
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 15:45:30 +0200 (CEST)
In-Reply-To: <20170908051309.19028-8-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cht_bsw_max98090: add gpio-based jack detection

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

>From 355b3552d59f471bfaf41cf7c6cc0a6fa193b303 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Sep 2017 00:13:09 -0500
Subject: [PATCH] ASoC: Intel: cht_bsw_max98090: add gpio-based jack detection

Jacks are created but only enabled when the external TI chip is
present, this probably never worked as well. Forklift the gpio-based
code from the legacy byt-max98090 driver, with however a less strict
error check. It's fine to let users enjoy their device even if
jack detection doesn't work - it almost never does without quirks...

Tested on Lenovo100s

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 56 +++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index e5da091abe48..6519604b9577 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -159,6 +159,40 @@ static struct notifier_block cht_jack_nb = {
 	.notifier_call = cht_ti_jack_event,
 };
 
+static struct snd_soc_jack_pin hs_jack_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
+static struct snd_soc_jack_gpio hs_jack_gpios[] = {
+	{
+		.name		= "hp",
+		.report		= SND_JACK_HEADPHONE | SND_JACK_LINEOUT,
+		.debounce_time	= 200,
+	},
+	{
+		.name		= "mic",
+		.invert		= 1,
+		.report		= SND_JACK_MICROPHONE,
+		.debounce_time	= 200,
+	},
+};
+
+static const struct acpi_gpio_params hp_gpios = { 0, 0, false };
+static const struct acpi_gpio_params mic_gpios = { 1, 0, false };
+
+static const struct acpi_gpio_mapping acpi_max98090_gpios[] = {
+	{ "hp-gpios", &hp_gpios, 1 },
+	{ "mic-gpios", &mic_gpios, 1 },
+	{},
+};
+
 static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 {
 	int ret;
@@ -178,15 +212,29 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE;
 
 	ret = snd_soc_card_jack_new(runtime->card, "Headset Jack",
-					jack_type, jack, NULL, 0);
+				    jack_type, jack,
+				    hs_jack_pins, ARRAY_SIZE(hs_jack_pins));
 	if (ret) {
 		dev_err(runtime->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
 	}
 
+
 	if (ctx->ts3a227e_present)
 		snd_soc_jack_notifier_register(jack, &cht_jack_nb);
 
+	ret = snd_soc_jack_add_gpiods(runtime->card->dev->parent, jack,
+				      ARRAY_SIZE(hs_jack_gpios),
+				      hs_jack_gpios);
+	if (ret) {
+		/*
+		 * flag error but don't bail if jack detect is broken
+		 * due to platform issues or bad BIOS/configuration
+		 */
+		dev_err(runtime->dev,
+			"jack detection gpios not added, error %d\n", ret);
+	}
+
 	/*
 	 * The firmware might enable the clock at
 	 * boot (this information may or may not
@@ -363,6 +411,7 @@ static struct snd_soc_card snd_soc_card_cht = {
 
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret_val = 0;
 	struct cht_mc_private *drv;
 
@@ -375,6 +424,11 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		/* no need probe TI jack detection chip */
 		snd_soc_card_cht.aux_dev = NULL;
 		snd_soc_card_cht.num_aux_devs = 0;
+
+		ret_val = devm_acpi_dev_add_driver_gpios(dev->parent,
+							 acpi_max98090_gpios);
+		if (ret_val)
+			dev_dbg(dev, "Unable to add GPIO mapping table\n");
 	}
 
 	/* register the soc card */
-- 
2.14.1
