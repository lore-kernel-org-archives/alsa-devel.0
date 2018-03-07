From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Not being able to
	find the codec ACPI-dev is an error" to the asoc tree
Date: Wed, 07 Mar 2018 14:13:35 +0000
Message-ID: <E1etZp1-0001L8-Cf@debutante>
References: <20180304143610.21125-11-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 97B25267048
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:13:46 +0100 (CET)
In-Reply-To: <20180304143610.21125-11-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Not being able to find the codec ACPI-dev is an error

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

>From e39cacc1b7de2a6d72ce49043c9cfd7dd129135a Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:35:58 +0100
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Not being able to find the codec
 ACPI-dev is an error

If we cannot find the codec ACPI-dev, then the snd-soc-core will not be
able to find the codec either and snd_soc_register_card() will just keep
exiting with -EPROBE_DEFER, filling the log with errors each time the
probe gets retried.

Instead simply log an error from the machine driver and exit with -ENODEV.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 456526a93dd5..105339c5b693 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -540,12 +540,13 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	/* fixup codec name based on HID */
 	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
-	if (i2c_name) {
-		snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
-			"%s%s", "i2c-", i2c_name);
-
-		byt_rt5651_dais[dai_index].codec_name = byt_rt5651_codec_name;
+	if (!i2c_name) {
+		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		return -ENODEV;
 	}
+	snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
+		"%s%s", "i2c-", i2c_name);
+	byt_rt5651_dais[dai_index].codec_name = byt_rt5651_codec_name;
 
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5651_quirk_table);
-- 
2.16.2
