From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: fix missing rename from
	'reef' to 'sof'" to the asoc tree
Date: Fri, 22 Jun 2018 15:50:38 +0100
Message-ID: <E1fWNOY-0002jI-NB@debutante>
References: <20180621204735.6825-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 96A7B267713
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 16:50:47 +0200 (CEST)
In-Reply-To: <20180621204735.6825-1-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, KCHSU0@nuvoton.com, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: common: fix missing rename from 'reef' to 'sof'

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

>From bb450fa59c0772310ebcc704722dd8a0313bf8ed Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 21 Jun 2018 15:47:35 -0500
Subject: [PATCH] ASoC: Intel: common: fix missing rename from 'reef' to 'sof'

Somehow I missed the Nau8824 support which was added in 4.17. Oops

Fixes: 4f722a6a736 ("ASoC: Intel: common: rename 'reef' to 'sof' in ACPI matching table")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-cht-match.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 3c3f2f8585d7..91bb99b69601 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -122,8 +122,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-nau8824",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-nau8824.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-nau8824.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
-- 
2.18.0.rc2
