From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 17/17] ASoC: soc-acpi: remove new_mach_data
	field
Date: Fri,  8 Feb 2019 17:45:57 -0600
Message-ID: <20190208234557.7816-18-pierre-louis.bossart@linux.intel.com>
References: <20190208234557.7816-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D3BC267A5C
 for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2019 00:46:18 +0100 (CET)
In-Reply-To: <20190208234557.7816-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

We never used this field (or in older SOF implementations), let's
remove it

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.17.1
