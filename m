From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: broxton: reduce machine name for
	bxt_da7219_max98357a" to the asoc tree
Date: Tue, 19 Jun 2018 16:24:44 +0100
Message-ID: <E1fVIUu-0002RE-8q@debutante>
References: <1522817219-3750-2-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CAAB02676FE
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 17:24:50 +0200 (CEST)
In-Reply-To: <1522817219-3750-2-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, harshapriya.n@intel.com, broonie@kernel.org, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: broxton: reduce machine name for bxt_da7219_max98357a

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

>From 95555f580dca21fac5ea35c10fa92fa034bd403f Mon Sep 17 00:00:00 2001
From: Naveen Manohar <naveen.m@intel.com>
Date: Mon, 18 Jun 2018 13:29:35 -0500
Subject: [PATCH] ASoC: Intel: broxton: reduce machine name for
 bxt_da7219_max98357a

Use truncated names in bxt id table and bxt_da7219_max98357a machine
as platform device id table expects names to be less then 20chars.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 4 ++--
 sound/soc/intel/skylake/skl.c                 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 40eb979d5ac1..3aba5bcf806a 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -586,7 +586,7 @@ static int broxton_audio_probe(struct platform_device *pdev)
 static struct platform_driver broxton_audio = {
 	.probe = broxton_audio_probe,
 	.driver = {
-		.name = "bxt_da7219_max98357a_i2s",
+		.name = "bxt_da7219_max98357a",
 		.pm = &snd_soc_pm_ops,
 	},
 };
@@ -599,4 +599,4 @@ MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com>");
 MODULE_AUTHOR("Harsha Priya <harshapriya.n@intel.com>");
 MODULE_AUTHOR("Conrad Cooke <conrad.cooke@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:bxt_da7219_max98357a_i2s");
+MODULE_ALIAS("platform:bxt_da7219_max98357a");
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index f0d9793f872a..0a8f0768e987 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1093,7 +1093,7 @@ static struct snd_soc_acpi_mach sst_bxtp_devdata[] = {
 	},
 	{
 		.id = "DLGS7219",
-		.drv_name = "bxt_da7219_max98357a_i2s",
+		.drv_name = "bxt_da7219_max98357a",
 		.fw_filename = "intel/dsp_fw_bxtn.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &bxt_codecs,
-- 
2.17.1
