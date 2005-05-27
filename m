From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [PATCH 2/2] Modem drivers update
Date: Sat, 28 May 2005 02:53:23 +0300
Message-ID: <20050527235323.GD22222@tecr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Modem drivers (atiixp-modem, intel8x0m, via82xx-modem) migration
for using MC97 generic modem mixer for off-hook operation.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-kernel/pci/intel8x0m.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0m.c,v
retrieving revision 1.32
diff -u -b -B -r1.32 intel8x0m.c
--- alsa-kernel/pci/intel8x0m.c	11 Apr 2005 15:58:26 -0000	1.32
+++ alsa-kernel/pci/intel8x0m.c	27 May 2005 01:24:29 -0000
@@ -35,7 +35,6 @@
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
-#include <sound/control.h>
 #include <sound/initval.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
@@ -292,60 +291,9 @@
 #endif
 	{ 0, }
 };
-static int snd_intel8x0m_switch_default_get(snd_kcontrol_t *kcontrol,
-					    snd_ctl_elem_value_t *ucontrol);
-static int snd_intel8x0m_switch_default_put(snd_kcontrol_t *kcontrol,
-					    snd_ctl_elem_value_t *ucontrol);
-static int snd_intel8x0m_switch_default_info(snd_kcontrol_t *kcontrol,
-					     snd_ctl_elem_info_t *uinfo);
-
-#define PRIVATE_VALUE_INITIALIZER(r,m) (((r) & 0xffff) << 16 | ((m) & 0xffff))
-#define PRIVATE_VALUE_MASK(control) ((control)->private_value & 0xffff)
-#define PRIVATE_VALUE_REG(control) (((control)->private_value >> 16) & 0xffff)
-
-static snd_kcontrol_new_t snd_intel8x0m_mixer_switches[] __devinitdata = {
-  { .name  = "Off-hook Switch",
-    .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-    .info  = snd_intel8x0m_switch_default_info,
-    .get   = snd_intel8x0m_switch_default_get,
-    .put   = snd_intel8x0m_switch_default_put,
-    .private_value = PRIVATE_VALUE_INITIALIZER(AC97_GPIO_STATUS,AC97_GPIO_LINE1_OH)
-  }
-};
 
 MODULE_DEVICE_TABLE(pci, snd_intel8x0m_ids);
 
-static int snd_intel8x0m_switch_default_info(snd_kcontrol_t *kcontrol,
-					     snd_ctl_elem_info_t *uinfo)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 1;
-	return 0;
-}
-
-static int snd_intel8x0m_switch_default_get(snd_kcontrol_t *kcontrol,
-					    snd_ctl_elem_value_t *ucontrol)
-{
-	unsigned short mask = PRIVATE_VALUE_MASK(kcontrol);
-	unsigned short reg = PRIVATE_VALUE_REG(kcontrol);
-	intel8x0_t *chip = snd_kcontrol_chip(kcontrol);
-	unsigned int status;
-	status = snd_ac97_read(chip->ac97, reg) & mask ? 1 : 0;
-	ucontrol->value.integer.value[0] = status;
-	return 0;
-}
-static int snd_intel8x0m_switch_default_put(snd_kcontrol_t *kcontrol,
-					    snd_ctl_elem_value_t *ucontrol)
-{
-	unsigned short mask = PRIVATE_VALUE_MASK(kcontrol);
-	unsigned short reg = PRIVATE_VALUE_REG(kcontrol);
-	intel8x0_t *chip = snd_kcontrol_chip(kcontrol);
-	unsigned short new_status = ucontrol->value.integer.value[0] ? mask : ~mask;
-	return snd_ac97_update_bits(chip->ac97, reg,
-				    mask, new_status);
-}
 /*
  *  Lowlevel I/O - busmaster
  */
@@ -700,21 +648,6 @@
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
-static int snd_intel8x0m_pcm_trigger(snd_pcm_substream_t *substream, int cmd)
-{
-	/* hook off/on on start/stop */
-	/* Moved this to mixer control */
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-		break;
-	default:
-		return -EINVAL;
-	}
-	return snd_intel8x0_pcm_trigger(substream,cmd);
-}
-
 static int snd_intel8x0m_pcm_prepare(snd_pcm_substream_t * substream)
 {
 	intel8x0_t *chip = snd_pcm_substream_chip(substream);
@@ -810,7 +743,7 @@
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0m_pcm_prepare,
-	.trigger =	snd_intel8x0m_pcm_trigger,
+	.trigger =	snd_intel8x0_pcm_trigger,
 	.pointer =	snd_intel8x0_pcm_pointer,
 };
 
@@ -821,7 +754,7 @@
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0m_pcm_prepare,
-	.trigger =	snd_intel8x0m_pcm_trigger,
+	.trigger =	snd_intel8x0_pcm_trigger,
 	.pointer =	snd_intel8x0_pcm_pointer,
 };
 
@@ -949,7 +882,6 @@
 	ac97_t *x97;
 	int err;
 	unsigned int glob_sta = 0;
-	unsigned int idx;
 	static ac97_bus_ops_t ops = {
 		.write = snd_intel8x0_codec_write,
 		.read = snd_intel8x0_codec_read,
@@ -985,10 +917,6 @@
 		chip->ichd[ICHD_MDMIN].ac97 = x97;
 		chip->ichd[ICHD_MDMOUT].ac97 = x97;
 	}
-	for (idx = 0; idx < ARRAY_SIZE(snd_intel8x0m_mixer_switches); idx++) {
-		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_intel8x0m_mixer_switches[idx], chip))) < 0)
-			goto __err;
-	}
 
 	chip->in_ac97_init = 0;
 	return 0;
Index: alsa-kernel/pci/atiixp_modem.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/atiixp_modem.c,v
retrieving revision 1.17
diff -u -b -B -r1.17 atiixp_modem.c
--- alsa-kernel/pci/atiixp_modem.c	11 Apr 2005 15:58:25 -0000	1.17
+++ alsa-kernel/pci/atiixp_modem.c	27 May 2005 01:24:32 -0000
@@ -463,6 +463,11 @@
 static void snd_atiixp_ac97_write(ac97_t *ac97, unsigned short reg, unsigned short val)
 {
 	atiixp_t *chip = ac97->private_data;
+	if (reg == AC97_GPIO_STATUS) {
+		atiixp_write(chip, MODEM_OUT_GPIO,
+			(val << ATI_REG_MODEM_OUT_GPIO_DATA_SHIFT) | ATI_REG_MODEM_OUT_GPIO_EN);
+		return;
+	}
 	snd_atiixp_codec_write(chip, ac97->num, reg, val);
 }
 
@@ -663,44 +668,33 @@
 {
 	atiixp_t *chip = snd_pcm_substream_chip(substream);
 	atiixp_dma_t *dma = (atiixp_dma_t *)substream->runtime->private_data;
-	unsigned int reg = 0;
-	int i;
+	int err = 0;
 
 	snd_assert(dma->ops->enable_transfer && dma->ops->flush_dma, return -EINVAL);
 
-	if (cmd != SNDRV_PCM_TRIGGER_START && cmd != SNDRV_PCM_TRIGGER_STOP)
-		return -EINVAL;
-
 	spin_lock(&chip->reg_lock);
-
-	/* hook off/on: via GPIO_OUT */
-	for (i = 0; i < NUM_ATI_CODECS; i++) {
-		if (chip->ac97[i]) {
-			reg = snd_ac97_read(chip->ac97[i], AC97_GPIO_STATUS);
-			break;
-	}
-	}
-	if(cmd == SNDRV_PCM_TRIGGER_START)
-		reg |= AC97_GPIO_LINE1_OH;
-	else
-		reg &= ~AC97_GPIO_LINE1_OH;
-	reg = (reg << ATI_REG_MODEM_OUT_GPIO_DATA_SHIFT) | ATI_REG_MODEM_OUT_GPIO_EN ;
-	atiixp_write(chip, MODEM_OUT_GPIO, reg);
-
-	if (cmd == SNDRV_PCM_TRIGGER_START) {
+	switch(cmd) {
+	case SNDRV_PCM_TRIGGER_START:
 		dma->ops->enable_transfer(chip, 1);
 		dma->running = 1;
-	} else {
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
 		dma->ops->enable_transfer(chip, 0);
 		dma->running = 0;
+		break;
+	default:
+		err = -EINVAL;
+		break;
 	}
+	if (! err) {
 	snd_atiixp_check_bus_busy(chip);
 	if (cmd == SNDRV_PCM_TRIGGER_STOP) {
 		dma->ops->flush_dma(chip);
 		snd_atiixp_check_bus_busy(chip);
 	}
+	}
 	spin_unlock(&chip->reg_lock);
-	return 0;
+	return err;
 }
 
 
Index: alsa-kernel/pci/via82xx_modem.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/via82xx_modem.c,v
retrieving revision 1.8
diff -u -b -B -r1.8 via82xx_modem.c
--- alsa-kernel/pci/via82xx_modem.c	20 May 2005 15:13:00 -0000	1.8
+++ alsa-kernel/pci/via82xx_modem.c	27 May 2005 01:24:35 -0000
@@ -420,7 +420,10 @@
 {
 	via82xx_t *chip = ac97->private_data;
 	unsigned int xval;
-	
+	if(reg == AC97_GPIO_STATUS) {
+		outl(val, VIAREG(chip, GPI_STATUS));
+		return;
+	}	
 	xval = !ac97->num ? VIA_REG_AC97_CODEC_ID_PRIMARY : VIA_REG_AC97_CODEC_ID_SECONDARY;
 	xval <<= VIA_REG_AC97_CODEC_ID_SHIFT;
 	xval |= reg << VIA_REG_AC97_CMD_SHIFT;
@@ -544,25 +547,6 @@
 	return 0;
 }
 
-static int snd_via82xx_modem_pcm_trigger(snd_pcm_substream_t * substream, int cmd)
-{
-	via82xx_t *chip = snd_pcm_substream_chip(substream);
-	unsigned int val = 0;
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		val = snd_ac97_read(chip->ac97, AC97_GPIO_STATUS);
-		outl(val|AC97_GPIO_LINE1_OH, VIAREG(chip, GPI_STATUS));
-		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-		val = snd_ac97_read(chip->ac97, AC97_GPIO_STATUS);
-		outl(val&~AC97_GPIO_LINE1_OH, VIAREG(chip, GPI_STATUS));
-		break;
-	default:
-		break;
-	}
-	return snd_via82xx_pcm_trigger(substream, cmd);
-}
-
 /*
  * pointer callbacks
  */
@@ -806,7 +790,7 @@
 	.hw_params =	snd_via82xx_hw_params,
 	.hw_free =	snd_via82xx_hw_free,
 	.prepare =	snd_via82xx_pcm_prepare,
-	.trigger =	snd_via82xx_modem_pcm_trigger,
+	.trigger =	snd_via82xx_pcm_trigger,
 	.pointer =	snd_via686_pcm_pointer,
 	.page =		snd_pcm_sgbuf_ops_page,
 };
@@ -819,7 +803,7 @@
 	.hw_params =	snd_via82xx_hw_params,
 	.hw_free =	snd_via82xx_hw_free,
 	.prepare =	snd_via82xx_pcm_prepare,
-	.trigger =	snd_via82xx_modem_pcm_trigger,
+	.trigger =	snd_via82xx_pcm_trigger,
 	.pointer =	snd_via686_pcm_pointer,
 	.page =		snd_pcm_sgbuf_ops_page,
 };


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
