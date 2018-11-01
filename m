From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 1/7] ASoC: acpi: define common interface for
	machine driver configuration
Date: Thu,  1 Nov 2018 16:34:48 -0500
Message-ID: <20181101213454.18894-2-pierre-louis.bossart@linux.intel.com>
References: <20181101213454.18894-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 509482678CA
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2018 22:35:13 +0100 (CET)
In-Reply-To: <20181101213454.18894-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The machine drivers may need information provided by the platform
driver.  Currently the information is passed using pdata specific to
each plaform driver. This prevents other drivers, such as SOF, from
reusing machine drivers directly.

Add a new structure which contains the required fields.

This proposal requires a bit more work on the platform side but this
generic interface helps reuse code directly.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.17.1
