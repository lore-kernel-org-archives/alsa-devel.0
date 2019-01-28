From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-acpi: add static inline fallbacks
	when CONFIG_ACPI=n" to the asoc tree
Date: Mon, 28 Jan 2019 12:35:18 +0000 (GMT)
Message-ID: <20190128123518.4DB9B1127D29@debutante.sirena.org.uk>
References: <20190125201617.21319-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 77935267454
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 13:35:20 +0100 (CET)
In-Reply-To: <20190125201617.21319-1-pierre-louis.bossart@linux.intel.com>
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

   ASoC: soc-acpi: add static inline fallbacks when CONFIG_ACPI=n

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

>From 5e484ec1758b95e6420787fc17f0e8c5e152c264 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 25 Jan 2019 14:16:17 -0600
Subject: [PATCH] ASoC: soc-acpi: add static inline fallbacks when
 CONFIG_ACPI=n

Fix compilation issues reported by 0day-Kbuild with sparc64 w/ SOF.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
