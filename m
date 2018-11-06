From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: acpi: define common interface for
	machine driver configuration" to the asoc tree
Date: Tue,  6 Nov 2018 18:07:00 +0000 (GMT)
Message-ID: <20181106180700.A1367112266B@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FC862678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 19:07:01 +0100 (CET)
In-Reply-To: 
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: acpi: define common interface for machine driver configuration

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

>From 8679284b37e9e2d529d60d1acc4133af4aa5dd34 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 1 Nov 2018 16:34:48 -0500
Subject: [PATCH] ASoC: acpi: define common interface for machine driver
 configuration

The machine drivers may need information provided by the platform
driver.  Currently the information is passed using pdata specific to
each plaform driver. This prevents other drivers, such as SOF, from
reusing machine drivers directly.

Add a new structure which contains the required fields.

This proposal requires a bit more work on the platform side but this
generic interface helps reuse code directly.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-acpi.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index e45b2330d16a..5154c6359609 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -37,6 +37,19 @@ snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
 struct snd_soc_acpi_mach *
 snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines);
 
+/**
+ * snd_soc_acpi_mach_params: interface for machine driver configuration
+ *
+ * @acpi_ipc_irq_index: used for BYT-CR detection
+ * @platform: string used for HDaudio codec support
+ * @codec_mask: used for HDAudio support
+ */
+struct snd_soc_acpi_mach_params {
+	u32 acpi_ipc_irq_index;
+	const char *platform;
+	u32 codec_mask;
+};
+
 /**
  * snd_soc_acpi_mach: ACPI-based machine descriptor. Most of the fields are
  * related to the hardware, except for the firmware and topology file names.
@@ -68,6 +81,7 @@ struct snd_soc_acpi_mach {
 	struct snd_soc_acpi_mach * (*machine_quirk)(void *arg);
 	const void *quirk_data;
 	void *pdata;
+	struct snd_soc_acpi_mach_params mach_params;
 	const char *sof_fw_filename;
 	const char *sof_tplg_filename;
 	const char *asoc_plat_name;
-- 
2.19.0.rc2
