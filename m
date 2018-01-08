From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Replace snd_soc_acpi_check_hid with
	acpi_dev_present" to the asoc tree
Date: Mon, 08 Jan 2018 16:23:34 +0000
Message-ID: <E1eYaD0-0002JA-7A@debutante>
References: <20180105205536.10366-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DF6226750E
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 17:23:38 +0100 (CET)
In-Reply-To: <20180105205536.10366-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: jeremy@jcline.org, alsa-devel@alsa-project.org, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Replace snd_soc_acpi_check_hid with acpi_dev_present

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

>From 0d5ea120abc020fada1f7cb019ec37f13162e7af Mon Sep 17 00:00:00 2001
From: Jeremy Cline <jeremy@jcline.org>
Date: Fri, 5 Jan 2018 14:55:34 -0600
Subject: [PATCH] ASoC: Replace snd_soc_acpi_check_hid with acpi_dev_present

Replace snd_soc_acpi_check_hid() with the generic acpi_dev_present()
and remove the now unused snd_soc_acpi_check_hid function. This should
have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-acpi.h |  3 ---
 sound/soc/soc-acpi.c     | 32 ++------------------------------
 2 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index a7d8d335b043..057805489af3 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -49,9 +49,6 @@ snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
 struct snd_soc_acpi_mach *
 snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines);
 
-/* acpi check hid */
-bool snd_soc_acpi_check_hid(const u8 hid[ACPI_ID_LEN]);
-
 /**
  * snd_soc_acpi_mach: ACPI-based machine descriptor. Most of the fields are
  * related to the hardware, except for the firmware and topology file names.
diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index d4dd2efea45e..7f43c9bf3d09 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -49,41 +49,13 @@ const char *snd_soc_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
 }
 EXPORT_SYMBOL_GPL(snd_soc_acpi_find_name_from_hid);
 
-static acpi_status snd_soc_acpi_mach_match(acpi_handle handle, u32 level,
-				       void *context, void **ret)
-{
-	unsigned long long sta;
-	acpi_status status;
-
-	*(bool *)context = true;
-	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
-	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT))
-		*(bool *)context = false;
-
-	return AE_OK;
-}
-
-bool snd_soc_acpi_check_hid(const u8 hid[ACPI_ID_LEN])
-{
-	acpi_status status;
-	bool found = false;
-
-	status = acpi_get_devices(hid, snd_soc_acpi_mach_match, &found, NULL);
-
-	if (ACPI_FAILURE(status))
-		return false;
-
-	return found;
-}
-EXPORT_SYMBOL_GPL(snd_soc_acpi_check_hid);
-
 struct snd_soc_acpi_mach *
 snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
 {
 	struct snd_soc_acpi_mach *mach;
 
 	for (mach = machines; mach->id[0]; mach++) {
-		if (snd_soc_acpi_check_hid(mach->id) == true) {
+		if (acpi_dev_present(mach->id, NULL, -1)) {
 			if (mach->machine_quirk)
 				mach = mach->machine_quirk(mach);
 			return mach;
@@ -161,7 +133,7 @@ struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
 		return mach;
 
 	for (i = 0; i < codec_list->num_codecs; i++) {
-		if (snd_soc_acpi_check_hid(codec_list->codecs[i]) != true)
+		if (!acpi_dev_present(codec_list->codecs[i], NULL, -1))
 			return NULL;
 	}
 
-- 
2.15.1
