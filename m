From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-acpi: remove new_mach_data field"
	to the asoc tree
Date: Tue, 12 Feb 2019 16:58:12 +0000 (GMT)
Message-ID: <20190212165812.D7BA31128113@debutante.sirena.org.uk>
References: <20190208234557.7816-18-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 872112673E2
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 17:58:15 +0100 (CET)
In-Reply-To: <20190208234557.7816-18-pierre-louis.bossart@linux.intel.com>
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

   ASoC: soc-acpi: remove new_mach_data field

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

>From b3d8f7cad1b41411de443018cc5323070db06ab2 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Feb 2019 17:45:57 -0600
Subject: [PATCH] ASoC: soc-acpi: remove new_mach_data field

We never used this field (or in older SOF implementations), let's
remove it

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-acpi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 655e4e010cc8..35b38e41e5b2 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -86,7 +86,6 @@ struct snd_soc_acpi_mach_params {
  *  is not constant since this field may be updated at run-time
  * @sof_fw_filename: Sound Open Firmware file name, if enabled
  * @sof_tplg_filename: Sound Open Firmware topology file name, if enabled
- * @new_mach_data: machine driver private data fixup
  */
 /* Descriptor for SST ASoC machine driver */
 struct snd_soc_acpi_mach {
@@ -100,7 +99,6 @@ struct snd_soc_acpi_mach {
 	struct snd_soc_acpi_mach_params mach_params;
 	const char *sof_fw_filename;
 	const char *sof_tplg_filename;
-	struct platform_device * (*new_mach_data)(void *pdata);
 };
 
 #define SND_SOC_ACPI_MAX_CODECS 3
-- 
2.20.1
