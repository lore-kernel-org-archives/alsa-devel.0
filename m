From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: soc-acpi: add static inline fallbacks
	when CONFIG_ACPI=n
Date: Fri, 25 Jan 2019 14:16:17 -0600
Message-ID: <20190125201617.21319-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F4B72666B3
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:16:23 +0100 (CET)
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

Fix compilation issues reported by 0day-Kbuild with sparc64 w/ SOF.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-acpi.h | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 266e64e3c24c..6cbbeed9cdd0 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -22,20 +22,37 @@ struct snd_soc_acpi_package_context {
 #define SND_ACPI_I2C_ID_LEN (4 + ACPI_ID_LEN + 3 + 1)
 
 #if IS_ENABLED(CONFIG_ACPI)
+/* acpi match */
+struct snd_soc_acpi_mach *
+snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines);
+
 bool snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
 				    struct snd_soc_acpi_package_context *ctx);
+
+/* check all codecs */
+struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg);
+
 #else
+/* acpi match */
+static inline struct snd_soc_acpi_mach *
+snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
+{
+	return NULL;
+}
+
 static inline bool
 snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
 				   struct snd_soc_acpi_package_context *ctx)
 {
 	return false;
 }
-#endif
 
-/* acpi match */
-struct snd_soc_acpi_mach *
-snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines);
+/* check all codecs */
+static inline struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
+{
+	return NULL;
+}
+#endif
 
 /**
  * snd_soc_acpi_mach_params: interface for machine driver configuration
@@ -105,7 +122,4 @@ struct snd_soc_acpi_codecs {
 	u8 codecs[SND_SOC_ACPI_MAX_CODECS][ACPI_ID_LEN];
 };
 
-/* check all codecs */
-struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg);
-
 #endif
-- 
2.17.1
