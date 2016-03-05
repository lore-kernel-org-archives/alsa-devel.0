From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: use HID
	translation util" to the asoc tree
Date: Sat, 05 Mar 2016 21:25:00 +0900
Message-ID: <E1acBGW-0003J0-C0@finisterre>
References: <1457062599-10032-7-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 768882606F7
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:25:04 +0100 (CET)
In-Reply-To: <1457062599-10032-7-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: use HID translation util

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

>From a232b96dcece4761793d39b8fb2c9d050df30357 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 3 Mar 2016 21:36:38 -0600
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: use HID translation util

Remove hard-coded generation of codec name, use translation routine
to avoid issues with codec name not matching what the ACPI subsystem
registered

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index a06cd1f99190..032a2e753f0b 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -340,15 +340,31 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
 	struct sst_acpi_mach *mach;
+	const char *i2c_name = NULL;
+	int i;
+	int dai_index;
 
 	/* register the soc card */
 	byt_rt5640_card.dev = &pdev->dev;
 	mach = byt_rt5640_card.dev->platform_data;
 
+	/* fix index of codec dai */
+	dai_index = MERR_DPCM_COMPR + 1;
+	for (i = 0; i < ARRAY_SIZE(byt_rt5640_dais); i++) {
+		if (!strcmp(byt_rt5640_dais[i].codec_name, "i2c-10EC5640:00")) {
+			dai_index = i;
+			break;
+		}
+	}
+
 	/* fixup codec name based on HID */
-	snprintf(byt_rt5640_codec_name, sizeof(byt_rt5640_codec_name),
-		 "%s%s%s", "i2c-", mach->id, ":00");
-	byt_rt5640_dais[MERR_DPCM_COMPR+1].codec_name = byt_rt5640_codec_name;
+	i2c_name = sst_acpi_find_name_from_hid(mach->id);
+	if (i2c_name != NULL) {
+		snprintf(byt_rt5640_codec_name, sizeof(byt_rt5640_codec_name),
+			"%s%s", "i2c-", i2c_name);
+
+		byt_rt5640_dais[dai_index].codec_name = byt_rt5640_codec_name;
+	}
 
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5640_quirk_table);
-- 
2.7.0
