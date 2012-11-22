From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/8] ALSA: vx: hard dependency on the standard
	fw loader
Date: Thu, 22 Nov 2012 17:54:55 +0100
Message-ID: <1353603300-3217-4-git-send-email-tiwai@suse.de>
References: <1353603300-3217-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A0A926157F
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 1A981A3A78
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

Yet again like previous two commits, drop the old hwdep user-space
firmware code from vx driver (snd-vxpocket and snd-vx222).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/vx_core.h     |   6 --
 sound/drivers/Kconfig       |   1 +
 sound/drivers/vx/vx_hwdep.c | 139 --------------------------------------------
 3 files changed, 1 insertion(+), 145 deletions(-)

diff --git a/include/sound/vx_core.h b/include/sound/vx_core.h
index 4f67c76..f634f8f 100644
--- a/include/sound/vx_core.h
+++ b/include/sound/vx_core.h
@@ -27,12 +27,6 @@
 #include <sound/hwdep.h>
 #include <linux/interrupt.h>
 
-#if defined(CONFIG_FW_LOADER) || defined(CONFIG_FW_LOADER_MODULE)
-#if !defined(CONFIG_USE_VXLOADER) && !defined(CONFIG_SND_VX_LIB) /* built-in kernel */
-#define SND_VX_FW_LOADER	/* use the standard firmware loader */
-#endif
-#endif
-
 struct firmware;
 struct device;
 
diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index 5e43841..7d02c32 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -14,6 +14,7 @@ config SND_OPL4_LIB
 
 config SND_VX_LIB
 	tristate
+	select FW_LOADER
 	select SND_HWDEP
 	select SND_PCM
 
diff --git a/sound/drivers/vx/vx_hwdep.c b/sound/drivers/vx/vx_hwdep.c
index 4a1fae9..3014b86 100644
--- a/sound/drivers/vx/vx_hwdep.c
+++ b/sound/drivers/vx/vx_hwdep.c
@@ -29,8 +29,6 @@
 #include <sound/hwdep.h>
 #include <sound/vx_core.h>
 
-#ifdef SND_VX_FW_LOADER
-
 MODULE_FIRMWARE("vx/bx_1_vxp.b56");
 MODULE_FIRMWARE("vx/bx_1_vp4.b56");
 MODULE_FIRMWARE("vx/x1_1_vx2.xlx");
@@ -119,142 +117,5 @@ void snd_vx_free_firmware(struct vx_core *chip)
 #endif
 }
 
-#else /* old style firmware loading */
-
-static int vx_hwdep_dsp_status(struct snd_hwdep *hw,
-			       struct snd_hwdep_dsp_status *info)
-{
-	static char *type_ids[VX_TYPE_NUMS] = {
-		[VX_TYPE_BOARD] = "vxboard",
-		[VX_TYPE_V2] = "vx222",
-		[VX_TYPE_MIC] = "vx222",
-		[VX_TYPE_VXPOCKET] = "vxpocket",
-		[VX_TYPE_VXP440] = "vxp440",
-	};
-	struct vx_core *vx = hw->private_data;
-
-	if (snd_BUG_ON(!type_ids[vx->type]))
-		return -EINVAL;
-	strcpy(info->id, type_ids[vx->type]);
-	if (vx_is_pcmcia(vx))
-		info->num_dsps = 4;
-	else
-		info->num_dsps = 3;
-	if (vx->chip_status & VX_STAT_CHIP_INIT)
-		info->chip_ready = 1;
-	info->version = VX_DRIVER_VERSION;
-	return 0;
-}
-
-static void free_fw(const struct firmware *fw)
-{
-	if (fw) {
-		vfree(fw->data);
-		kfree(fw);
-	}
-}
-
-static int vx_hwdep_dsp_load(struct snd_hwdep *hw,
-			     struct snd_hwdep_dsp_image *dsp)
-{
-	struct vx_core *vx = hw->private_data;
-	int index, err;
-	struct firmware *fw;
-
-	if (snd_BUG_ON(!vx->ops->load_dsp))
-		return -ENXIO;
-
-	fw = kmalloc(sizeof(*fw), GFP_KERNEL);
-	if (! fw) {
-		snd_printk(KERN_ERR "cannot allocate firmware\n");
-		return -ENOMEM;
-	}
-	fw->size = dsp->length;
-	fw->data = vmalloc(fw->size);
-	if (! fw->data) {
-		snd_printk(KERN_ERR "cannot allocate firmware image (length=%d)\n",
-			   (int)fw->size);
-		kfree(fw);
-		return -ENOMEM;
-	}
-	if (copy_from_user((void *)fw->data, dsp->image, dsp->length)) {
-		free_fw(fw);
-		return -EFAULT;
-	}
-
-	index = dsp->index;
-	if (! vx_is_pcmcia(vx))
-		index++;
-	err = vx->ops->load_dsp(vx, index, fw);
-	if (err < 0) {
-		free_fw(fw);
-		return err;
-	}
-#ifdef CONFIG_PM
-	vx->firmware[index] = fw;
-#else
-	free_fw(fw);
-#endif
-
-	if (index == 1)
-		vx->chip_status |= VX_STAT_XILINX_LOADED;
-	if (index < 3)
-		return 0;
-
-	/* ok, we reached to the last one */
-	/* create the devices if not built yet */
-	if (! (vx->chip_status & VX_STAT_DEVICE_INIT)) {
-		if ((err = snd_vx_pcm_new(vx)) < 0)
-			return err;
-
-		if ((err = snd_vx_mixer_new(vx)) < 0)
-			return err;
-
-		if (vx->ops->add_controls)
-			if ((err = vx->ops->add_controls(vx)) < 0)
-				return err;
-
-		if ((err = snd_card_register(vx->card)) < 0)
-			return err;
-
-		vx->chip_status |= VX_STAT_DEVICE_INIT;
-	}
-	vx->chip_status |= VX_STAT_CHIP_INIT;
-	return 0;
-}
-
-
-/* exported */
-int snd_vx_setup_firmware(struct vx_core *chip)
-{
-	int err;
-	struct snd_hwdep *hw;
-
-	if ((err = snd_hwdep_new(chip->card, SND_VX_HWDEP_ID, 0, &hw)) < 0)
-		return err;
-
-	hw->iface = SNDRV_HWDEP_IFACE_VX;
-	hw->private_data = chip;
-	hw->ops.dsp_status = vx_hwdep_dsp_status;
-	hw->ops.dsp_load = vx_hwdep_dsp_load;
-	hw->exclusive = 1;
-	sprintf(hw->name, "VX Loader (%s)", chip->card->driver);
-	chip->hwdep = hw;
-
-	return snd_card_register(chip->card);
-}
-
-/* exported */
-void snd_vx_free_firmware(struct vx_core *chip)
-{
-#ifdef CONFIG_PM
-	int i;
-	for (i = 0; i < 4; i++)
-		free_fw(chip->firmware[i]);
-#endif
-}
-
-#endif /* SND_VX_FW_LOADER */
-
 EXPORT_SYMBOL(snd_vx_setup_firmware);
 EXPORT_SYMBOL(snd_vx_free_firmware);
-- 
1.8.0
