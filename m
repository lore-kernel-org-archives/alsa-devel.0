From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: Fix GPIO headset detection
	regression" to the asoc tree
Date: Tue, 22 Aug 2017 13:49:36 +0100
Message-ID: <E1dk8ci-0000RP-2j@finisterre>
References: <s5ha82svcod.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7826726762C
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 14:49:39 +0200 (CEST)
In-Reply-To: <s5ha82svcod.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5670: Fix GPIO headset detection regression

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

>From 804e73adf5cf4b3aea3b6ce058f4dc0191143821 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 22 Aug 2017 07:44:52 +0200
Subject: [PATCH] ASoC: rt5670: Fix GPIO headset detection regression

RT5670 codec driver and its machine driver for Intel CHT assume the
implicit GPIO mapping on the index 0 while BIOS on most devices don't
provide it.  The recent commit f10e4bf6632b ("gpio: acpi: Even more
tighten up ACPI GPIO lookups") restricts such cases and it resulted in
a regression where the headset jack setup fails like:

  rt5670 i2c-10EC5672:00: ASoC: Cannot get gpio at index 0: -2
  rt5670 i2c-10EC5672:00: Adding jack GPIO failed

For fixing this, we need to provide the GPIO mapping explicitly in the
machine driver.  Also this patch corrects the string to be passed to
gpiolib to match with the pre-given mapping, too.

Fixes: f10e4bf6632b ("gpio: acpi: Even more tighten up ACPI GPIO lookups")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=115531
Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c               |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 0ec7985ed306..054b613cb0d0 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -567,7 +567,7 @@ int rt5670_set_jack_detect(struct snd_soc_codec *codec,
 
 	rt5670->jack = jack;
 	rt5670->hp_gpio.gpiod_dev = codec->dev;
-	rt5670->hp_gpio.name = "headphone detect";
+	rt5670->hp_gpio.name = "headset";
 	rt5670->hp_gpio.report = SND_JACK_HEADSET |
 		SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2;
 	rt5670->hp_gpio.debounce_time = 150;
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index bc2a52de06a3..f597d5582223 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -184,6 +184,13 @@ static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static const struct acpi_gpio_params headset_gpios = { 0, 0, false };
+
+static const struct acpi_gpio_mapping cht_rt5672_gpios[] = {
+	{ "headset-gpios", &headset_gpios, 1 },
+	{},
+};
+
 static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 {
 	int ret;
@@ -191,6 +198,9 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
 
+	if (devm_acpi_dev_add_driver_gpios(codec->dev, cht_rt5672_gpios))
+		dev_warn(runtime->dev, "Unable to add GPIO mapping table\n");
+
 	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
 	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0xF, 4, 24);
 	if (ret < 0) {
-- 
2.13.2
