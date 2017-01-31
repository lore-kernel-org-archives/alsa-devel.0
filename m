From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht_bsw_rt5645: harden ACPI
	device detection" to the asoc tree
Date: Tue, 31 Jan 2017 21:17:48 +0000
Message-ID: <E1cYfoC-00013K-60@debutante>
References: <1485461385-14544-14-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BFEF2673E8
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:17:57 +0100 (CET)
In-Reply-To: <1485461385-14544-14-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cht_bsw_rt5645: harden ACPI device detection

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

>From 42648c2270ca0c96935dfc5d0f5c4f8d2406cf75 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 26 Jan 2017 14:09:41 -0600
Subject: [PATCH] ASoC: Intel: cht_bsw_rt5645: harden ACPI device detection

Fix classic issue of having multiple codecs listed in DSDT
but a single one actually enabled. The previous code did
not handle such errors and could also lead to uninitalized
configurations

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 3684bdbd8598..3461e4a88ba8 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -407,22 +407,32 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	struct sst_acpi_mach *mach;
 	const char *i2c_name = NULL;
 	int dai_index = 0;
+	bool found = false;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
 	if (!drv)
 		return -ENOMEM;
 
+	mach = (&pdev->dev)->platform_data;
+
 	for (i = 0; i < ARRAY_SIZE(snd_soc_cards); i++) {
-		if (acpi_dev_found(snd_soc_cards[i].codec_id)) {
+		if (acpi_dev_found(snd_soc_cards[i].codec_id) &&
+			(!strncmp(snd_soc_cards[i].codec_id, mach->id, 8))) {
 			dev_dbg(&pdev->dev,
 				"found codec %s\n", snd_soc_cards[i].codec_id);
 			card = snd_soc_cards[i].soc_card;
 			drv->acpi_card = &snd_soc_cards[i];
+			found = true;
 			break;
 		}
 	}
+
+	if (!found) {
+		dev_err(&pdev->dev, "No matching HID found in supported list\n");
+		return -ENODEV;
+	}
+
 	card->dev = &pdev->dev;
-	mach = card->dev->platform_data;
 	sprintf(drv->codec_name, "i2c-%s:00", drv->acpi_card->codec_id);
 
 	/* set correct codec name */
-- 
2.11.0
