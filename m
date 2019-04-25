From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: align quirk
	override handling" to the asoc tree
Date: Thu, 25 Apr 2019 20:24:00 +0100 (BST)
Message-ID: <20190425192400.83A9B441D3B@finisterre.ee.mobilebroadband>
References: <20190419201218.19821-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E01C7F80C41
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2019 21:24:05 +0200 (CEST)
In-Reply-To: <20190419201218.19821-4-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, hdegoede@redhat.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: align quirk override handling

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

>From fb45befa7ea07399372266f09e562b26db5693c9 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 19 Apr 2019 15:12:18 -0500
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: align quirk override handling

As discussed on alsa-devel, a zero value is useful to get rid of all
quirks. Set default to -1 and align types as done in other machine
drivers.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 21c6675abd19..ca657c3e5726 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -102,8 +102,8 @@ static const struct acpi_gpio_mapping *byt_rt5651_gpios;
 static unsigned long byt_rt5651_quirk = BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN2_MAP;
 
-static unsigned int quirk_override;
-module_param_named(quirk, quirk_override, uint, 0444);
+static int quirk_override = -1;
+module_param_named(quirk, quirk_override, int, 0444);
 MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static void log_quirks(struct device *dev)
@@ -987,7 +987,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5651_quirk_table);
 
-	if (quirk_override) {
+	if (quirk_override != -1) {
 		dev_info(&pdev->dev, "Overriding quirk 0x%x => 0x%x\n",
 			 (unsigned int)byt_rt5651_quirk, quirk_override);
 		byt_rt5651_quirk = quirk_override;
-- 
2.20.1
