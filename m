From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/8] ASoC: ACPI: add new fields for SOF support
Date: Thu, 12 Oct 2017 18:49:40 -0500
Message-ID: <20171012234945.30318-4-pierre-louis.bossart@linux.intel.com>
References: <20171012234945.30318-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F03A266FBD
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 01:49:58 +0200 (CEST)
In-Reply-To: <20171012234945.30318-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

To prepare for SOF integration, we need new fields in the machine table.
It is intended that the same table is used for both closed-source and
open-source firmware to avoid repeating ACPI-related information
multiple times
No functional change

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-acpi.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 918d78e8c8d6..a7d8d335b043 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -55,10 +55,12 @@ bool snd_soc_acpi_check_hid(const u8 hid[ACPI_ID_LEN]);
 /**
  * snd_soc_acpi_mach: ACPI-based machine descriptor. Most of the fields are
  * related to the hardware, except for the firmware and topology file names.
+ * A platform supported by legacy and Sound Open Firmware (SOF) would expose
+ * all firmware/topology related fields.
  *
  * @id: ACPI ID (usually the codec's) used to find a matching machine driver.
  * @drv_name: machine driver name
- * @fw_filename: firmware file name.
+ * @fw_filename: firmware file name. Used when SOF is not enabled.
  * @board: board name
  * @machine_quirk: pointer to quirk, usually based on DMI information when
  * ACPI ID alone is not sufficient, wrong or misleading
@@ -66,6 +68,11 @@ bool snd_soc_acpi_check_hid(const u8 hid[ACPI_ID_LEN]);
  * audio codecs whose presence if checked with ACPI
  * @pdata: intended for platform data or machine specific-ops. This structure
  *  is not constant since this field may be updated at run-time
+ * @sof_fw_filename: Sound Open Firmware file name, if enabled
+ * @sof_tplg_filename: Sound Open Firmware topology file name, if enabled
+ * @asoc_plat_name: ASoC platform name, used for binding machine drivers
+ * if non NULL
+ * @new_mach_data: machine driver private data fixup
  */
 /* Descriptor for SST ASoC machine driver */
 struct snd_soc_acpi_mach {
@@ -76,6 +83,10 @@ struct snd_soc_acpi_mach {
 	struct snd_soc_acpi_mach * (*machine_quirk)(void *arg);
 	const void *quirk_data;
 	void *pdata;
+	const char *sof_fw_filename;
+	const char *sof_tplg_filename;
+	const char *asoc_plat_name;
+	struct platform_device * (*new_mach_data)(void *pdata);
 };
 
 #define SND_SOC_ACPI_MAX_CODECS 3
-- 
2.11.0
