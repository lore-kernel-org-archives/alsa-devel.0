From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-acpi: remove asoc_plat_name field"
	to the asoc tree
Date: Tue, 12 Feb 2019 16:58:15 +0000 (GMT)
Message-ID: <20190212165815.03E661128113@debutante.sirena.org.uk>
References: <20190208234557.7816-17-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 04E442673F8
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 17:58:15 +0100 (CET)
In-Reply-To: <20190208234557.7816-17-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-acpi: remove asoc_plat_name field

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

>From ecefff3e5b9b6a427a1a78c0c3f5eb147fd2d761 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Feb 2019 17:45:56 -0600
Subject: [PATCH] ASoC: soc-acpi: remove asoc_plat_name field

This field was never used, let's remove it

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-acpi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 6cbbeed9cdd0..655e4e010cc8 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -86,8 +86,6 @@ struct snd_soc_acpi_mach_params {
  *  is not constant since this field may be updated at run-time
  * @sof_fw_filename: Sound Open Firmware file name, if enabled
  * @sof_tplg_filename: Sound Open Firmware topology file name, if enabled
- * @asoc_plat_name: ASoC platform name, used for binding machine drivers
- * if non NULL
  * @new_mach_data: machine driver private data fixup
  */
 /* Descriptor for SST ASoC machine driver */
@@ -102,7 +100,6 @@ struct snd_soc_acpi_mach {
 	struct snd_soc_acpi_mach_params mach_params;
 	const char *sof_fw_filename;
 	const char *sof_tplg_filename;
-	const char *asoc_plat_name;
 	struct platform_device * (*new_mach_data)(void *pdata);
 };
 
-- 
2.20.1
