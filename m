From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/8] ALSA: mixart: hard dependency on the
	standard fw loader
Date: Thu, 22 Nov 2012 17:54:53 +0100
Message-ID: <1353603300-3217-2-git-send-email-tiwai@suse.de>
References: <1353603300-3217-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 26CA8260325
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 0C82BA37E0
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

It makes no longer sense to keep the old hwdep user-space firmware
loading, which has been deprecated since ages ago.

Just add a hard dependency on CONFIG_FW_LOADER and drop the useless
code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/Kconfig               |  1 +
 sound/pci/mixart/mixart_hwdep.c | 76 -----------------------------------------
 2 files changed, 1 insertion(+), 76 deletions(-)

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 6150eb1..4356892 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -707,6 +707,7 @@ config SND_MAESTRO3_INPUT
 
 config SND_MIXART
 	tristate "Digigram miXart"
+	select FW_LOADER
 	select SND_HWDEP
 	select SND_PCM
 	help
diff --git a/sound/pci/mixart/mixart_hwdep.c b/sound/pci/mixart/mixart_hwdep.c
index e0f4d87..ece1f83 100644
--- a/sound/pci/mixart/mixart_hwdep.c
+++ b/sound/pci/mixart/mixart_hwdep.c
@@ -546,14 +546,6 @@ static int mixart_dsp_load(struct mixart_mgr* mgr, int index, const struct firmw
 }
 
 
-#if defined(CONFIG_FW_LOADER) || defined(CONFIG_FW_LOADER_MODULE)
-#if !defined(CONFIG_USE_MIXARTLOADER) && !defined(CONFIG_SND_MIXART) /* built-in kernel */
-#define SND_MIXART_FW_LOADER	/* use the standard firmware loader */
-#endif
-#endif
-
-#ifdef SND_MIXART_FW_LOADER
-
 int snd_mixart_setup_firmware(struct mixart_mgr *mgr)
 {
 	static char *fw_files[3] = {
@@ -583,71 +575,3 @@ int snd_mixart_setup_firmware(struct mixart_mgr *mgr)
 MODULE_FIRMWARE("mixart/miXart8.xlx");
 MODULE_FIRMWARE("mixart/miXart8.elf");
 MODULE_FIRMWARE("mixart/miXart8AES.xlx");
-
-#else /* old style firmware loading */
-
-/* miXart hwdep interface id string */
-#define SND_MIXART_HWDEP_ID       "miXart Loader"
-
-static int mixart_hwdep_dsp_status(struct snd_hwdep *hw,
-				   struct snd_hwdep_dsp_status *info)
-{
-	struct mixart_mgr *mgr = hw->private_data;
-
-	strcpy(info->id, "miXart");
-        info->num_dsps = MIXART_HARDW_FILES_MAX_INDEX;
-
-	if (mgr->dsp_loaded & (1 <<  MIXART_MOTHERBOARD_ELF_INDEX))
-		info->chip_ready = 1;
-
-	info->version = MIXART_DRIVER_VERSION;
-	return 0;
-}
-
-static int mixart_hwdep_dsp_load(struct snd_hwdep *hw,
-				 struct snd_hwdep_dsp_image *dsp)
-{
-	struct mixart_mgr* mgr = hw->private_data;
-	struct firmware fw;
-	int err;
-
-	fw.size = dsp->length;
-	fw.data = vmalloc(dsp->length);
-	if (! fw.data) {
-		snd_printk(KERN_ERR "miXart: cannot allocate image size %d\n",
-			   (int)dsp->length);
-		return -ENOMEM;
-	}
-	if (copy_from_user((void *) fw.data, dsp->image, dsp->length)) {
-		vfree(fw.data);
-		return -EFAULT;
-	}
-	err = mixart_dsp_load(mgr, dsp->index, &fw);
-	vfree(fw.data);
-	if (err < 0)
-		return err;
-	mgr->dsp_loaded |= 1 << dsp->index;
-	return err;
-}
-
-int snd_mixart_setup_firmware(struct mixart_mgr *mgr)
-{
-	int err;
-	struct snd_hwdep *hw;
-
-	/* only create hwdep interface for first cardX (see "index" module parameter)*/
-	if ((err = snd_hwdep_new(mgr->chip[0]->card, SND_MIXART_HWDEP_ID, 0, &hw)) < 0)
-		return err;
-
-	hw->iface = SNDRV_HWDEP_IFACE_MIXART;
-	hw->private_data = mgr;
-	hw->ops.dsp_status = mixart_hwdep_dsp_status;
-	hw->ops.dsp_load = mixart_hwdep_dsp_load;
-	hw->exclusive = 1;
-	sprintf(hw->name,  SND_MIXART_HWDEP_ID);
-	mgr->dsp_loaded = 0;
-
-	return snd_card_register(mgr->chip[0]->card);
-}
-
-#endif /* SND_MIXART_FW_LOADER */
-- 
1.8.0
