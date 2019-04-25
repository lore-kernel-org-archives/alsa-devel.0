From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcht_es8316: fix compilation
	warning" to the asoc tree
Date: Thu, 25 Apr 2019 20:26:18 +0100 (BST)
Message-ID: <20190425192623.38523441D3B@finisterre.ee.mobilebroadband>
References: <20190419201218.19821-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B918EF89765
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2019 21:26:24 +0200 (CEST)
In-Reply-To: <20190419201218.19821-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Paul Cercueil <paul@crapouillou.net>, hdegoede@redhat.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcht_es8316: fix compilation warning

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

>From 1fb1e93a1dc7c9673917a8081e144f48bde46495 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 19 Apr 2019 15:12:16 -0500
Subject: [PATCH] ASoC: Intel: bytcht_es8316: fix compilation warning

Remove warning below, align with other machine drivers.

bytcht_es8316.c:508:11: warning: cast from pointer to integer of
different size [-Wpointer-to-int-cast]

   quirk = (int)dmi_id->driver_data;
           ^
Fixes: a8d218f4fe811 ('ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+ II')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 38975827e276..e8c585ffd04d 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -61,7 +61,7 @@ enum {
 #define BYT_CHT_ES8316_MONO_SPEAKER		BIT(17)
 #define BYT_CHT_ES8316_JD_INVERTED		BIT(18)
 
-static int quirk;
+static unsigned long quirk;
 
 static int quirk_override = -1;
 module_param_named(quirk, quirk_override, int, 0444);
@@ -505,7 +505,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	/* Check for BYTCR or other platform and setup quirks */
 	dmi_id = dmi_first_match(byt_cht_es8316_quirk_table);
 	if (dmi_id) {
-		quirk = (int)dmi_id->driver_data;
+		quirk = (unsigned long)dmi_id->driver_data;
 	} else if (x86_match_cpu(baytrail_cpu_ids) &&
 	    mach->mach_params.acpi_ipc_irq_index == 0) {
 		/* On BYTCR default to SSP0, internal-mic-in2-map, mono-spk */
@@ -517,7 +517,8 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 			BYT_CHT_ES8316_MONO_SPEAKER;
 	}
 	if (quirk_override != -1) {
-		dev_info(dev, "Overriding quirk 0x%x => 0x%x\n", quirk,
+		dev_info(dev, "Overriding quirk 0x%x => 0x%x\n",
+			 (unsigned int)quirk,
 			 quirk_override);
 		quirk = quirk_override;
 	}
-- 
2.20.1
