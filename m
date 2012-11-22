From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/8] ALSA: pcxhr: hard dependency on the
	standard fw loader
Date: Thu, 22 Nov 2012 17:54:54 +0100
Message-ID: <1353603300-3217-3-git-send-email-tiwai@suse.de>
References: <1353603300-3217-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CE7F260727
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 1BDB3A4BDA
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
In-Reply-To: <1353603300-3217-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Like the previous commit for mixart, drop the home-baked fw loader
code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/Kconfig             |  1 +
 sound/pci/pcxhr/pcxhr_hwdep.c | 86 -------------------------------------------
 2 files changed, 1 insertion(+), 86 deletions(-)

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 4356892..59dbb70 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -728,6 +728,7 @@ config SND_NM256
 
 config SND_PCXHR
 	tristate "Digigram PCXHR"
+	select FW_LOADER
 	select SND_PCM
 	select SND_HWDEP
 	help
diff --git a/sound/pci/pcxhr/pcxhr_hwdep.c b/sound/pci/pcxhr/pcxhr_hwdep.c
index bf207e3..d995175 100644
--- a/sound/pci/pcxhr/pcxhr_hwdep.c
+++ b/sound/pci/pcxhr/pcxhr_hwdep.c
@@ -35,13 +35,6 @@
 #include "pcxhr_mix22.h"
 
 
-#if defined(CONFIG_FW_LOADER) || defined(CONFIG_FW_LOADER_MODULE)
-#if !defined(CONFIG_USE_PCXHRLOADER) && !defined(CONFIG_SND_PCXHR) /* built-in kernel */
-#define SND_PCXHR_FW_LOADER	/* use the standard firmware loader */
-#endif
-#endif
-
-
 static int pcxhr_sub_init(struct pcxhr_mgr *mgr);
 /*
  * get basic information and init pcxhr card
@@ -362,8 +355,6 @@ static int pcxhr_dsp_load(struct pcxhr_mgr *mgr, int index,
 /*
  * fw loader entry
  */
-#ifdef SND_PCXHR_FW_LOADER
-
 int pcxhr_setup_firmware(struct pcxhr_mgr *mgr)
 {
 	static char *fw_files[][5] = {
@@ -424,80 +415,3 @@ MODULE_FIRMWARE("pcxhr/xlxc924.dat");
 MODULE_FIRMWARE("pcxhr/dspe924.e56");
 MODULE_FIRMWARE("pcxhr/dspb924.b56");
 MODULE_FIRMWARE("pcxhr/dspd222.d56");
-
-
-#else /* old style firmware loading */
-
-/* pcxhr hwdep interface id string */
-#define PCXHR_HWDEP_ID       "pcxhr loader"
-
-
-static int pcxhr_hwdep_dsp_status(struct snd_hwdep *hw,
-				  struct snd_hwdep_dsp_status *info)
-{
-	struct pcxhr_mgr *mgr = hw->private_data;
-	sprintf(info->id, "pcxhr%d", mgr->fw_file_set);
-        info->num_dsps = PCXHR_FIRMWARE_FILES_MAX_INDEX;
-
-	if (hw->dsp_loaded & (1 << PCXHR_FIRMWARE_DSP_MAIN_INDEX))
-		info->chip_ready = 1;
-
-	info->version = PCXHR_DRIVER_VERSION;
-	return 0;
-}
-
-static int pcxhr_hwdep_dsp_load(struct snd_hwdep *hw,
-				struct snd_hwdep_dsp_image *dsp)
-{
-	struct pcxhr_mgr *mgr = hw->private_data;
-	int err;
-	struct firmware fw;
-
-	fw.size = dsp->length;
-	fw.data = vmalloc(fw.size);
-	if (! fw.data) {
-		snd_printk(KERN_ERR "pcxhr: cannot allocate dsp image "
-			   "(%lu bytes)\n", (unsigned long)fw.size);
-		return -ENOMEM;
-	}
-	if (copy_from_user((void *)fw.data, dsp->image, dsp->length)) {
-		vfree(fw.data);
-		return -EFAULT;
-	}
-	err = pcxhr_dsp_load(mgr, dsp->index, &fw);
-	vfree(fw.data);
-	if (err < 0)
-		return err;
-	mgr->dsp_loaded |= 1 << dsp->index;
-	return 0;
-}
-
-int pcxhr_setup_firmware(struct pcxhr_mgr *mgr)
-{
-	int err;
-	struct snd_hwdep *hw;
-
-	/* only create hwdep interface for first cardX
-	 * (see "index" module parameter)
-	 */
-	err = snd_hwdep_new(mgr->chip[0]->card, PCXHR_HWDEP_ID, 0, &hw);
-	if (err < 0)
-		return err;
-
-	hw->iface = SNDRV_HWDEP_IFACE_PCXHR;
-	hw->private_data = mgr;
-	hw->ops.dsp_status = pcxhr_hwdep_dsp_status;
-	hw->ops.dsp_load = pcxhr_hwdep_dsp_load;
-	hw->exclusive = 1;
-	/* stereo cards don't need fw_file_0 -> dsp_loaded = 1 */
-	hw->dsp_loaded = mgr->is_hr_stereo ? 1 : 0;
-	mgr->dsp_loaded = 0;
-	sprintf(hw->name, PCXHR_HWDEP_ID);
-
-	err = snd_card_register(mgr->chip[0]->card);
-	if (err < 0)
-		return err;
-	return 0;
-}
-
-#endif /* SND_PCXHR_FW_LOADER */
-- 
1.8.0
