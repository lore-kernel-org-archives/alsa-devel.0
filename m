From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: add support for ALC3270 codec"
	to the asoc tree
Date: Tue, 31 Jan 2017 21:17:32 +0000
Message-ID: <E1cYfnw-0000va-MZ@debutante>
References: <1485461385-14544-13-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C74C2673EF
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:17:41 +0100 (CET)
In-Reply-To: <1485461385-14544-13-git-send-email-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: add support for ALC3270 codec

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

>From bf92c6efc68add6b934a2790f650a675a4c38286 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 26 Jan 2017 14:09:40 -0600
Subject: [PATCH] ASoC: Intel: add support for ALC3270 codec

Use ACPI ID 10EC3270 to load machine driver for cht-bsw-rt5645
and add reference to 3270 to use the rt5645 mode

Tested on Asus T100HA

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c     | 3 +++
 sound/soc/intel/boards/cht_bsw_rt5645.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 8cc30dfbf87d..747c0f393d2d 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -499,6 +499,9 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
 						&chv_platform_data },
 	{"10EC5650", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
+	{"10EC3270", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
+						&chv_platform_data },
+
 	{"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index b175eee5d416..a97eef6860ff 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -500,6 +500,7 @@ static struct cht_acpi_card snd_soc_cards[] = {
 	{"10EC5640", CODEC_TYPE_RT5645, &snd_soc_card_chtrt5645},
 	{"10EC5645", CODEC_TYPE_RT5645, &snd_soc_card_chtrt5645},
 	{"10EC5648", CODEC_TYPE_RT5645, &snd_soc_card_chtrt5645},
+	{"10EC3270", CODEC_TYPE_RT5645, &snd_soc_card_chtrt5645},
 	{"10EC5650", CODEC_TYPE_RT5650, &snd_soc_card_chtrt5650},
 };
 
-- 
2.11.0
