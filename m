From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] ice1712.c: fix coding style
Date: Sun, 7 Sep 2008 14:17:02 +0400
Message-ID: <20080907101702.GD6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id E25721037F7
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Sep 2008 12:17:12 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1079137fgg.44
	for <alsa-devel@alsa-project.org>; Sun, 07 Sep 2008 03:17:12 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

before:
total: 113 errors, 169 warnings, 2786 lines checked
total: 26 errors, 24 warnings, 504 lines checked

after:
total: 14 errors, 163 warnings, 2799 lines checked
total: 0 errors, 24 warnings, 504 lines checked

Compile tested only.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/ice1712/ice1712.c |  237 +++++++++++++++++++++++--------------------
 sound/pci/ice1712/ice1712.h |   52 +++++-----
 2 files changed, 151 insertions(+), 138 deletions(-)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 05ffab6..5b44238 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -17,7 +17,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 /*
   NOTES:
@@ -35,7 +35,7 @@
  *
  *  2002.11.26	James Stafford <jstafford@ampltd.com>
  *	Added support for VT1724 (Envy24HT)
- *	I have left out support for 176.4 and 192 KHz for the moment. 
+ *	I have left out support for 176.4 and 192 KHz for the moment.
  *  I also haven't done anything with the internal S/PDIF transmitter or the MPU-401
  *
  *  2003.02.20  Taksahi Iwai <tiwai@suse.de>
@@ -47,7 +47,7 @@
  */
 
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -123,7 +123,7 @@ static unsigned int PRO_RATE_DEFAULT = 44100;
 /*
  *  Basic I/O
  */
- 
+
 /* check whether the clock mode is spdif-in */
 static inline int is_spdif_master(struct snd_ice1712 *ice)
 {
@@ -135,13 +135,13 @@ static inline int is_pro_rate_locked(struct snd_ice1712 *ice)
 	return is_spdif_master(ice) || PRO_RATE_LOCKED;
 }
 
-static inline void snd_ice1712_ds_write(struct snd_ice1712 * ice, u8 channel, u8 addr, u32 data)
+static inline void snd_ice1712_ds_write(struct snd_ice1712 *ice, u8 channel, u8 addr, u32 data)
 {
 	outb((channel << 4) | addr, ICEDS(ice, INDEX));
 	outl(data, ICEDS(ice, DATA));
 }
 
-static inline u32 snd_ice1712_ds_read(struct snd_ice1712 * ice, u8 channel, u8 addr)
+static inline u32 snd_ice1712_ds_read(struct snd_ice1712 *ice, u8 channel, u8 addr)
 {
 	outb((channel << 4) | addr, ICEDS(ice, INDEX));
 	return inl(ICEDS(ice, DATA));
@@ -260,7 +260,7 @@ static unsigned short snd_ice1712_pro_ac97_read(struct snd_ac97 *ac97,
 static int snd_ice1712_digmix_route_ac97_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = inb(ICEMT(ice, MONITOR_ROUTECTRL)) & ICE1712_ROUTE_AC97 ? 1 : 0;
 	return 0;
 }
@@ -269,11 +269,12 @@ static int snd_ice1712_digmix_route_ac97_put(struct snd_kcontrol *kcontrol, stru
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned char val, nval;
-	
+
 	spin_lock_irq(&ice->reg_lock);
 	val = inb(ICEMT(ice, MONITOR_ROUTECTRL));
 	nval = val & ~ICE1712_ROUTE_AC97;
-	if (ucontrol->value.integer.value[0]) nval |= ICE1712_ROUTE_AC97;
+	if (ucontrol->value.integer.value[0])
+		nval |= ICE1712_ROUTE_AC97;
 	outb(nval, ICEMT(ice, MONITOR_ROUTECTRL));
 	spin_unlock_irq(&ice->reg_lock);
 	return val != nval;
@@ -329,7 +330,7 @@ static int snd_ice1712_cs8427_set_input_clock(struct snd_ice1712 *ice, int spdif
 	unsigned char reg[2] = { 0x80 | 4, 0 };   /* CS8427 auto increment | register number 4 + data */
 	unsigned char val, nval;
 	int res = 0;
-	
+
 	snd_i2c_lock(ice->i2c);
 	if (snd_i2c_sendbytes(ice->cs8427, reg, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
@@ -381,9 +382,9 @@ int __devinit snd_ice1712_init_cs8427(struct snd_ice1712 *ice, int addr)
 {
 	int err;
 
-	if ((err = snd_cs8427_create(ice->i2c, addr,
-				     (ice->cs8427_timeout * HZ) / 1000,
-				     &ice->cs8427)) < 0) {
+	err = snd_cs8427_create(ice->i2c, addr,
+		(ice->cs8427_timeout * HZ) / 1000, &ice->cs8427);
+	if (err < 0) {
 		snd_printk(KERN_ERR "CS8427 initialization failed\n");
 		return err;
 	}
@@ -395,9 +396,9 @@ int __devinit snd_ice1712_init_cs8427(struct snd_ice1712 *ice, int addr)
 
 static void snd_ice1712_set_input_clock_source(struct snd_ice1712 *ice, int spdif_is_master)
 {
-        /* change CS8427 clock source too */
-        if (ice->cs8427)
-                snd_ice1712_cs8427_set_input_clock(ice, spdif_is_master);
+	/* change CS8427 clock source too */
+	if (ice->cs8427)
+		snd_ice1712_cs8427_set_input_clock(ice, spdif_is_master);
 	/* notify ak4524 chip as well */
 	if (spdif_is_master) {
 		unsigned int i;
@@ -457,11 +458,12 @@ static irqreturn_t snd_ice1712_interrupt(int irq, void *dev_id)
 			u16 pbkstatus;
 			struct snd_pcm_substream *substream;
 			pbkstatus = inw(ICEDS(ice, INTSTAT));
-			//printk("pbkstatus = 0x%x\n", pbkstatus);
+			/* printk("pbkstatus = 0x%x\n", pbkstatus); */
 			for (idx = 0; idx < 6; idx++) {
 				if ((pbkstatus & (3 << (idx * 2))) == 0)
 					continue;
-				if ((substream = ice->playback_con_substream_ds[idx]) != NULL)
+				substream = ice->playback_con_substream_ds[idx];
+				if (substream != NULL)
 					snd_pcm_period_elapsed(substream);
 				outw(3 << (idx * 2), ICEDS(ice, INTSTAT));
 			}
@@ -507,7 +509,7 @@ static int snd_ice1712_playback_trigger(struct snd_pcm_substream *substream,
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
 	int result = 0;
 	u32 tmp;
-	
+
 	spin_lock(&ice->reg_lock);
 	tmp = snd_ice1712_read(ice, ICE1712_IREG_PBK_CTRL);
 	if (cmd == SNDRV_PCM_TRIGGER_START) {
@@ -532,7 +534,7 @@ static int snd_ice1712_playback_ds_trigger(struct snd_pcm_substream *substream,
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
 	int result = 0;
 	u32 tmp;
-	
+
 	spin_lock(&ice->reg_lock);
 	tmp = snd_ice1712_ds_read(ice, substream->number * 2, ICE1712_DSC_CONTROL);
 	if (cmd == SNDRV_PCM_TRIGGER_START) {
@@ -557,7 +559,7 @@ static int snd_ice1712_capture_trigger(struct snd_pcm_substream *substream,
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
 	int result = 0;
 	u8 tmp;
-	
+
 	spin_lock(&ice->reg_lock);
 	tmp = snd_ice1712_read(ice, ICE1712_IREG_CAP_CTRL);
 	if (cmd == SNDRV_PCM_TRIGGER_START) {
@@ -711,8 +713,7 @@ static snd_pcm_uframes_t snd_ice1712_capture_pointer(struct snd_pcm_substream *s
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
-static const struct snd_pcm_hardware snd_ice1712_playback =
-{
+static const struct snd_pcm_hardware snd_ice1712_playback = {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID |
@@ -731,8 +732,7 @@ static const struct snd_pcm_hardware snd_ice1712_playback =
 	.fifo_size =		0,
 };
 
-static const struct snd_pcm_hardware snd_ice1712_playback_ds =
-{
+static const struct snd_pcm_hardware snd_ice1712_playback_ds = {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID |
@@ -751,8 +751,7 @@ static const struct snd_pcm_hardware snd_ice1712_playback_ds =
 	.fifo_size =		0,
 };
 
-static const struct snd_pcm_hardware snd_ice1712_capture =
-{
+static const struct snd_pcm_hardware snd_ice1712_capture = {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID),
@@ -788,7 +787,7 @@ static int snd_ice1712_playback_ds_open(struct snd_pcm_substream *substream)
 
 	ice->playback_con_substream_ds[substream->number] = substream;
 	runtime->hw = snd_ice1712_playback_ds;
-	spin_lock_irq(&ice->reg_lock); 
+	spin_lock_irq(&ice->reg_lock);
 	tmp = inw(ICEDS(ice, INTMASK)) & ~(1 << (substream->number * 2));
 	outw(tmp, ICEDS(ice, INTMASK));
 	spin_unlock_irq(&ice->reg_lock);
@@ -821,7 +820,7 @@ static int snd_ice1712_playback_ds_close(struct snd_pcm_substream *substream)
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
 	u32 tmp;
 
-	spin_lock_irq(&ice->reg_lock); 
+	spin_lock_irq(&ice->reg_lock);
 	tmp = inw(ICEDS(ice, INTMASK)) | (3 << (substream->number * 2));
 	outw(tmp, ICEDS(ice, INTMASK));
 	spin_unlock_irq(&ice->reg_lock);
@@ -870,7 +869,7 @@ static struct snd_pcm_ops snd_ice1712_capture_ops = {
 	.pointer =	snd_ice1712_capture_pointer,
 };
 
-static int __devinit snd_ice1712_pcm(struct snd_ice1712 * ice, int device, struct snd_pcm ** rpcm)
+static int __devinit snd_ice1712_pcm(struct snd_ice1712 *ice, int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -900,7 +899,7 @@ static int __devinit snd_ice1712_pcm(struct snd_ice1712 * ice, int device, struc
 	return 0;
 }
 
-static int __devinit snd_ice1712_pcm_ds(struct snd_ice1712 * ice, int device, struct snd_pcm ** rpcm)
+static int __devinit snd_ice1712_pcm_ds(struct snd_ice1712 *ice, int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1029,14 +1028,14 @@ static void snd_ice1712_set_pro_rate(struct snd_ice1712 *ice, unsigned int rate,
 	if (inb(ICEMT(ice, PLAYBACK_CONTROL)) & (ICE1712_CAPTURE_START_SHADOW|
 						 ICE1712_PLAYBACK_PAUSE|
 						 ICE1712_PLAYBACK_START)) {
-	      __out:
+__out:
 		spin_unlock_irqrestore(&ice->reg_lock, flags);
 		return;
 	}
 	if (!force && is_pro_rate_locked(ice))
 		goto __out;
 
-        old = inb(ICEMT(ice, RATE));
+	old = inb(ICEMT(ice, RATE));
 	if (!force && old == val)
 		goto __out;
 	outb(val, ICEMT(ice, RATE));
@@ -1123,8 +1122,7 @@ static snd_pcm_uframes_t snd_ice1712_capture_pro_pointer(struct snd_pcm_substrea
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
-static const struct snd_pcm_hardware snd_ice1712_playback_pro =
-{
+static const struct snd_pcm_hardware snd_ice1712_playback_pro = {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID |
@@ -1143,8 +1141,7 @@ static const struct snd_pcm_hardware snd_ice1712_playback_pro =
 	.fifo_size =		0,
 };
 
-static const struct snd_pcm_hardware snd_ice1712_capture_pro =
-{
+static const struct snd_pcm_hardware snd_ice1712_capture_pro = {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID |
@@ -1238,7 +1235,7 @@ static struct snd_pcm_ops snd_ice1712_capture_pro_ops = {
 	.pointer =	snd_ice1712_capture_pro_pointer,
 };
 
-static int __devinit snd_ice1712_pcm_profi(struct snd_ice1712 * ice, int device, struct snd_pcm ** rpcm)
+static int __devinit snd_ice1712_pcm_profi(struct snd_ice1712 *ice, int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1262,7 +1259,7 @@ static int __devinit snd_ice1712_pcm_profi(struct snd_ice1712 * ice, int device,
 	ice->pcm_pro = pcm;
 	if (rpcm)
 		*rpcm = pcm;
-	
+
 	if (ice->cs8427) {
 		/* assign channels to iec958 */
 		err = snd_cs8427_iec958_build(ice->cs8427,
@@ -1272,7 +1269,8 @@ static int __devinit snd_ice1712_pcm_profi(struct snd_ice1712 * ice, int device,
 			return err;
 	}
 
-	if ((err = snd_ice1712_build_pro_mixer(ice)) < 0)
+	err = snd_ice1712_build_pro_mixer(ice);
+	if (err < 0)
 		return err;
 	return 0;
 }
@@ -1299,7 +1297,7 @@ static int snd_ice1712_pro_mixer_switch_get(struct snd_kcontrol *kcontrol, struc
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	int priv_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id) +
 		kcontrol->private_value;
-	
+
 	spin_lock_irq(&ice->reg_lock);
 	ucontrol->value.integer.value[0] =
 		!((ice->pro_volumes[priv_idx] >> 15) & 1);
@@ -1341,7 +1339,7 @@ static int snd_ice1712_pro_mixer_volume_get(struct snd_kcontrol *kcontrol, struc
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	int priv_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id) +
 		kcontrol->private_value;
-	
+
 	spin_lock_irq(&ice->reg_lock);
 	ucontrol->value.integer.value[0] =
 		(ice->pro_volumes[priv_idx] >> 0) & 127;
@@ -1406,7 +1404,7 @@ static struct snd_kcontrol_new snd_ice1712_multi_capture_analog_switch __devinit
 
 static struct snd_kcontrol_new snd_ice1712_multi_capture_spdif_switch __devinitdata = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = SNDRV_CTL_NAME_IEC958("Multi ",CAPTURE,SWITCH),
+	.name = SNDRV_CTL_NAME_IEC958("Multi ", CAPTURE, SWITCH),
 	.info = snd_ice1712_pro_mixer_switch_info,
 	.get = snd_ice1712_pro_mixer_switch_get,
 	.put = snd_ice1712_pro_mixer_switch_put,
@@ -1428,7 +1426,7 @@ static struct snd_kcontrol_new snd_ice1712_multi_capture_analog_volume __devinit
 
 static struct snd_kcontrol_new snd_ice1712_multi_capture_spdif_volume __devinitdata = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = SNDRV_CTL_NAME_IEC958("Multi ",CAPTURE,VOLUME),
+	.name = SNDRV_CTL_NAME_IEC958("Multi ", CAPTURE, VOLUME),
 	.info = snd_ice1712_pro_mixer_volume_info,
 	.get = snd_ice1712_pro_mixer_volume_get,
 	.put = snd_ice1712_pro_mixer_volume_put,
@@ -1448,7 +1446,7 @@ static int __devinit snd_ice1712_build_pro_mixer(struct snd_ice1712 *ice)
 		if (err < 0)
 			return err;
 	}
-	
+
 	if (ice->num_total_adcs > 0) {
 		struct snd_kcontrol_new tmp = snd_ice1712_multi_capture_analog_switch;
 		tmp.count = ice->num_total_adcs;
@@ -1495,7 +1493,7 @@ static void snd_ice1712_mixer_free_ac97(struct snd_ac97 *ac97)
 	ice->ac97 = NULL;
 }
 
-static int __devinit snd_ice1712_ac97_mixer(struct snd_ice1712 * ice)
+static int __devinit snd_ice1712_ac97_mixer(struct snd_ice1712 *ice)
 {
 	int err, bus_num = 0;
 	struct snd_ac97_template ac97;
@@ -1510,27 +1508,32 @@ static int __devinit snd_ice1712_ac97_mixer(struct snd_ice1712 * ice)
 	};
 
 	if (ice_has_con_ac97(ice)) {
-		if ((err = snd_ac97_bus(ice->card, bus_num++, &con_ops, NULL, &pbus)) < 0)
+		err = snd_ac97_bus(ice->card, bus_num++, &con_ops, NULL, &pbus);
+		if (err < 0)
 			return err;
 		memset(&ac97, 0, sizeof(ac97));
 		ac97.private_data = ice;
 		ac97.private_free = snd_ice1712_mixer_free_ac97;
-		if ((err = snd_ac97_mixer(pbus, &ac97, &ice->ac97)) < 0)
+		err = snd_ac97_mixer(pbus, &ac97, &ice->ac97);
+		if (err < 0)
 			printk(KERN_WARNING "ice1712: cannot initialize ac97 for consumer, skipped\n");
 		else {
-			if ((err = snd_ctl_add(ice->card, snd_ctl_new1(&snd_ice1712_mixer_digmix_route_ac97, ice))) < 0)
+			err = snd_ctl_add(ice->card, snd_ctl_new1(&snd_ice1712_mixer_digmix_route_ac97, ice));
+			if (err < 0)
 				return err;
 			return 0;
 		}
 	}
 
-	if (! (ice->eeprom.data[ICE_EEP1_ACLINK] & ICE1712_CFG_PRO_I2S)) {
-		if ((err = snd_ac97_bus(ice->card, bus_num, &pro_ops, NULL, &pbus)) < 0)
+	if (!(ice->eeprom.data[ICE_EEP1_ACLINK] & ICE1712_CFG_PRO_I2S)) {
+		err = snd_ac97_bus(ice->card, bus_num, &pro_ops, NULL, &pbus);
+		if (err < 0)
 			return err;
 		memset(&ac97, 0, sizeof(ac97));
 		ac97.private_data = ice;
 		ac97.private_free = snd_ice1712_mixer_free_ac97;
-		if ((err = snd_ac97_mixer(pbus, &ac97, &ice->ac97)) < 0)
+		err = snd_ac97_mixer(pbus, &ac97, &ice->ac97);
+		if (err < 0)
 			printk(KERN_WARNING "ice1712: cannot initialize pro ac97, skipped\n");
 		else
 			return 0;
@@ -1549,7 +1552,7 @@ static inline unsigned int eeprom_double(struct snd_ice1712 *ice, int idx)
 	return (unsigned int)ice->eeprom.data[idx] | ((unsigned int)ice->eeprom.data[idx + 1] << 8);
 }
 
-static void snd_ice1712_proc_read(struct snd_info_entry *entry, 
+static void snd_ice1712_proc_read(struct snd_info_entry *entry,
 				  struct snd_info_buffer *buffer)
 {
 	struct snd_ice1712 *ice = entry->private_data;
@@ -1585,15 +1588,15 @@ static void snd_ice1712_proc_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "  SPDOUT           : 0x%04x\n", (unsigned)inw(ICEMT(ice, ROUTE_SPDOUT)));
 	snd_iprintf(buffer, "  RATE             : 0x%02x\n", (unsigned)inb(ICEMT(ice, RATE)));
 	snd_iprintf(buffer, "  GPIO_DATA        : 0x%02x\n", (unsigned)snd_ice1712_get_gpio_data(ice));
-        snd_iprintf(buffer, "  GPIO_WRITE_MASK  : 0x%02x\n", (unsigned)snd_ice1712_read(ice, ICE1712_IREG_GPIO_WRITE_MASK));
+	snd_iprintf(buffer, "  GPIO_WRITE_MASK  : 0x%02x\n", (unsigned)snd_ice1712_read(ice, ICE1712_IREG_GPIO_WRITE_MASK));
 	snd_iprintf(buffer, "  GPIO_DIRECTION   : 0x%02x\n", (unsigned)snd_ice1712_read(ice, ICE1712_IREG_GPIO_DIRECTION));
 }
 
-static void __devinit snd_ice1712_proc_init(struct snd_ice1712 * ice)
+static void __devinit snd_ice1712_proc_init(struct snd_ice1712 *ice)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(ice->card, "ice1712", &entry))
+	if (!snd_card_proc_new(ice->card, "ice1712", &entry))
 		snd_info_set_text_ops(entry, ice, snd_ice1712_proc_read);
 }
 
@@ -1613,7 +1616,7 @@ static int snd_ice1712_eeprom_get(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
-	
+
 	memcpy(ucontrol->value.bytes.data, &ice->eeprom, sizeof(ice->eeprom));
 	return 0;
 }
@@ -1641,7 +1644,7 @@ static int snd_ice1712_spdif_default_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	if (ice->spdif.ops.default_get)
-		ice->spdif.ops.default_get(ice, ucontrol); 
+		ice->spdif.ops.default_get(ice, ucontrol);
 	return 0;
 }
 
@@ -1657,7 +1660,7 @@ static int snd_ice1712_spdif_default_put(struct snd_kcontrol *kcontrol,
 static struct snd_kcontrol_new snd_ice1712_spdif_default __devinitdata =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
-	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
+	.name =         SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
 	.info =		snd_ice1712_spdif_info,
 	.get =		snd_ice1712_spdif_default_get,
 	.put =		snd_ice1712_spdif_default_put
@@ -1709,7 +1712,7 @@ static struct snd_kcontrol_new snd_ice1712_spdif_maskc __devinitdata =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
-	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,CON_MASK),
+	.name =         SNDRV_CTL_NAME_IEC958("", PLAYBACK, CON_MASK),
 	.info =		snd_ice1712_spdif_info,
 	.get =		snd_ice1712_spdif_maskc_get,
 };
@@ -1718,7 +1721,7 @@ static struct snd_kcontrol_new snd_ice1712_spdif_maskp __devinitdata =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
-	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,PRO_MASK),
+	.name =         SNDRV_CTL_NAME_IEC958("", PLAYBACK, PRO_MASK),
 	.info =		snd_ice1712_spdif_info,
 	.get =		snd_ice1712_spdif_maskp_get,
 };
@@ -1746,7 +1749,7 @@ static struct snd_kcontrol_new snd_ice1712_spdif_stream __devinitdata =
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READWRITE |
 			 SNDRV_CTL_ELEM_ACCESS_INACTIVE),
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
-	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,PCM_STREAM),
+	.name =         SNDRV_CTL_NAME_IEC958("", PLAYBACK, PCM_STREAM),
 	.info =		snd_ice1712_spdif_info,
 	.get =		snd_ice1712_spdif_stream_get,
 	.put =		snd_ice1712_spdif_stream_put
@@ -1758,7 +1761,7 @@ int snd_ice1712_gpio_get(struct snd_kcontrol *kcontrol,
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned char mask = kcontrol->private_value & 0xff;
 	int invert = (kcontrol->private_value & (1<<24)) ? 1 : 0;
-	
+
 	snd_ice1712_save_gpio_status(ice);
 	ucontrol->value.integer.value[0] =
 		(snd_ice1712_gpio_read(ice) & mask ? 1 : 0) ^ invert;
@@ -1825,7 +1828,7 @@ static int snd_ice1712_pro_internal_clock_get(struct snd_kcontrol *kcontrol,
 		9, 6, 3, 1, 7, 4, 0, 12, 8, 5, 2, 11, 255, 255, 255, 10
 	};
 	unsigned char val;
-	
+
 	spin_lock_irq(&ice->reg_lock);
 	if (is_spdif_master(ice)) {
 		ucontrol->value.enumerated.item[0] = 13;
@@ -1867,7 +1870,7 @@ static int snd_ice1712_pro_internal_clock_put(struct snd_kcontrol *kcontrol,
 
 	if ((oval & ICE1712_SPDIF_MASTER) !=
 	    (inb(ICEMT(ice, RATE)) & ICE1712_SPDIF_MASTER))
-	        snd_ice1712_set_input_clock_source(ice, is_spdif_master(ice));
+		snd_ice1712_set_input_clock_source(ice, is_spdif_master(ice));
 
 	return change;
 }
@@ -1897,7 +1900,7 @@ static int snd_ice1712_pro_internal_clock_default_info(struct snd_kcontrol *kcon
 		"64000",	/* 10: 15 */
 		"88200",	/* 11: 11 */
 		"96000",	/* 12: 7 */
-		// "IEC958 Input",	/* 13: -- */
+		/* "IEC958 Input",	13: -- */
 	};
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
@@ -2026,7 +2029,7 @@ static int snd_ice1712_pro_route_info(struct snd_kcontrol *kcontrol,
 		"IEC958 In L", "IEC958 In R", /* 9-10 */
 		"Digital Mixer", /* 11 - optional */
 	};
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items =
@@ -2070,7 +2073,7 @@ static int snd_ice1712_pro_route_analog_put(struct snd_kcontrol *kcontrol,
 	int change, shift;
 	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	unsigned int val, old_val, nval;
-	
+
 	/* update PSDOUT */
 	if (ucontrol->value.enumerated.item[0] >= 11)
 		nval = idx < 2 ? 1 : 0; /* dig mixer (or pcm) */
@@ -2140,7 +2143,7 @@ static int snd_ice1712_pro_route_spdif_put(struct snd_kcontrol *kcontrol,
 	int change, shift;
 	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	unsigned int val, old_val, nval;
-	
+
 	/* update SPDOUT */
 	spin_lock_irq(&ice->reg_lock);
 	val = old_val = inw(ICEMT(ice, ROUTE_SPDOUT));
@@ -2182,7 +2185,7 @@ static struct snd_kcontrol_new snd_ice1712_mixer_pro_analog_route __devinitdata
 
 static struct snd_kcontrol_new snd_ice1712_mixer_pro_spdif_route __devinitdata = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Route",
+	.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, NONE) "Route",
 	.info = snd_ice1712_pro_route_info,
 	.get = snd_ice1712_pro_route_spdif_get,
 	.put = snd_ice1712_pro_route_spdif_put,
@@ -2204,7 +2207,7 @@ static int snd_ice1712_pro_volume_rate_get(struct snd_kcontrol *kcontrol,
 					   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = inb(ICEMT(ice, MONITOR_RATE));
 	return 0;
 }
@@ -2245,7 +2248,7 @@ static int snd_ice1712_pro_peak_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	int idx;
-	
+
 	spin_lock_irq(&ice->reg_lock);
 	for (idx = 0; idx < 22; idx++) {
 		outb(idx, ICEMT(ice, MONITOR_PEAKINDEX));
@@ -2296,12 +2299,12 @@ static int __devinit snd_ice1712_read_eeprom(struct snd_ice1712 *ice,
 	unsigned int i, size;
 	struct snd_ice1712_card_info * const *tbl, *c;
 
-	if (! modelname || ! *modelname) {
+	if (!modelname || !*modelname) {
 		ice->eeprom.subvendor = 0;
 		if ((inb(ICEREG(ice, I2C_CTRL)) & ICE1712_I2C_EEPROM) != 0)
 			ice->eeprom.subvendor = (snd_ice1712_read_i2c(ice, dev, 0x00) << 0) |
-				(snd_ice1712_read_i2c(ice, dev, 0x01) << 8) | 
-				(snd_ice1712_read_i2c(ice, dev, 0x02) << 16) | 
+				(snd_ice1712_read_i2c(ice, dev, 0x01) << 8) |
+				(snd_ice1712_read_i2c(ice, dev, 0x02) << 16) |
 				(snd_ice1712_read_i2c(ice, dev, 0x03) << 24);
 		if (ice->eeprom.subvendor == 0 ||
 		    ice->eeprom.subvendor == (unsigned int)-1) {
@@ -2318,12 +2321,12 @@ static int __devinit snd_ice1712_read_eeprom(struct snd_ice1712 *ice,
 	}
 	for (tbl = card_tables; *tbl; tbl++) {
 		for (c = *tbl; c->subvendor; c++) {
-			if (modelname && c->model && ! strcmp(modelname, c->model)) {
+			if (modelname && c->model && !strcmp(modelname, c->model)) {
 				printk(KERN_INFO "ice1712: Using board model %s\n", c->name);
 				ice->eeprom.subvendor = c->subvendor;
 			} else if (c->subvendor != ice->eeprom.subvendor)
 				continue;
-			if (! c->eeprom_size || ! c->eeprom_data)
+			if (!c->eeprom_size || !c->eeprom_data)
 				goto found;
 			/* if the EEPROM is given by the driver, use it */
 			snd_printdd("using the defined eeprom..\n");
@@ -2484,13 +2487,13 @@ static int __devinit snd_ice1712_build_controls(struct snd_ice1712 *ice)
 
 static int snd_ice1712_free(struct snd_ice1712 *ice)
 {
-	if (! ice->port)
+	if (!ice->port)
 		goto __hw_end;
 	/* mask all interrupts */
 	outb(0xc0, ICEMT(ice, IRQ));
 	outb(0xff, ICEREG(ice, IRQMASK));
 	/* --- */
-      __hw_end:
+__hw_end:
 	if (ice->irq >= 0)
 		free_irq(ice->irq, ice);
 
@@ -2515,7 +2518,7 @@ static int __devinit snd_ice1712_create(struct snd_card *card,
 					int omni,
 					int cs8427_timeout,
 					int dxr_enable,
-					struct snd_ice1712 ** r_ice1712)
+					struct snd_ice1712 **r_ice1712)
 {
 	struct snd_ice1712 *ice;
 	int err;
@@ -2525,8 +2528,9 @@ static int __devinit snd_ice1712_create(struct snd_card *card,
 
 	*r_ice1712 = NULL;
 
-        /* enable PCI device */
-	if ((err = pci_enable_device(pci)) < 0)
+	/* enable PCI device */
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 	/* check, if we can restrict PCI DMA transfers to 28 bits */
 	if (pci_set_dma_mask(pci, DMA_28BIT_MASK) < 0 ||
@@ -2570,7 +2574,8 @@ static int __devinit snd_ice1712_create(struct snd_card *card,
 	snd_ice1712_proc_init(ice);
 	synchronize_irq(pci->irq);
 
-	if ((err = pci_request_regions(pci, "ICE1712")) < 0) {
+	err = pci_request_regions(pci, "ICE1712");
+	if (err < 0) {
 		kfree(ice);
 		pci_disable_device(pci);
 		return err;
@@ -2586,7 +2591,7 @@ static int __devinit snd_ice1712_create(struct snd_card *card,
 		snd_ice1712_free(ice);
 		return -EIO;
 	}
-	
+
 	ice->irq = pci->irq;
 
 	if (snd_ice1712_read_eeprom(ice, modelname) < 0) {
@@ -2606,9 +2611,10 @@ static int __devinit snd_ice1712_create(struct snd_card *card,
 	     ICEREG(ice, IRQMASK));
 	outb(0x00, ICEMT(ice, IRQ));
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ice, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ice, &ops);
+	if (err < 0) {
 		snd_ice1712_free(ice);
- 		return err;
+		return err;
 	}
 
 	snd_card_set_dev(card, &pci->dev);
@@ -2648,10 +2654,10 @@ static int __devinit snd_ice1712_probe(struct pci_dev *pci,
 
 	strcpy(card->driver, "ICE1712");
 	strcpy(card->shortname, "ICEnsemble ICE1712");
-	
-	if ((err = snd_ice1712_create(card, pci, model[dev], omni[dev],
-				      cs8427_timeout[dev], dxr_enable[dev],
-				      &ice)) < 0) {
+
+	err = snd_ice1712_create(card, pci, model[dev], omni[dev],
+		cs8427_timeout[dev], dxr_enable[dev], &ice);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -2663,7 +2669,8 @@ static int __devinit snd_ice1712_probe(struct pci_dev *pci,
 				if (c->driver) /* specific driver? */
 					strcpy(card->driver, c->driver);
 				if (c->chip_init) {
-					if ((err = c->chip_init(ice)) < 0) {
+					err = c->chip_init(ice);
+					if (err < 0) {
 						snd_card_free(card);
 						return err;
 					}
@@ -2675,47 +2682,52 @@ static int __devinit snd_ice1712_probe(struct pci_dev *pci,
 	c = &no_matched;
  __found:
 
-	if ((err = snd_ice1712_pcm_profi(ice, pcm_dev++, NULL)) < 0) {
+	err = snd_ice1712_pcm_profi(ice, pcm_dev++, NULL);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	
+
 	if (ice_has_con_ac97(ice))
-		if ((err = snd_ice1712_pcm(ice, pcm_dev++, NULL)) < 0) {
+		err = snd_ice1712_pcm(ice, pcm_dev++, NULL);
+		if (err < 0) {
 			snd_card_free(card);
 			return err;
 		}
 
-	if ((err = snd_ice1712_ac97_mixer(ice)) < 0) {
+	err = snd_ice1712_ac97_mixer(ice);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
-	if ((err = snd_ice1712_build_controls(ice)) < 0) {
+	err = snd_ice1712_build_controls(ice);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
 	if (c->build_controls) {
-		if ((err = c->build_controls(ice)) < 0) {
+		err = c->build_controls(ice);
+		if (err < 0) {
 			snd_card_free(card);
 			return err;
 		}
 	}
 
 	if (ice_has_con_ac97(ice))
-		if ((err = snd_ice1712_pcm_ds(ice, pcm_dev++, NULL)) < 0) {
+		err = snd_ice1712_pcm_ds(ice, pcm_dev++, NULL);
+		if (err < 0) {
 			snd_card_free(card);
 			return err;
 		}
 
-	if (! c->no_mpu401) {
-		if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_ICE1712,
-					       ICEREG(ice, MPU1_CTRL),
-					       (c->mpu401_1_info_flags |
-						MPU401_INFO_INTEGRATED),
-					       ice->irq, 0,
-					       &ice->rmidi[0])) < 0) {
+	if (!c->no_mpu401) {
+		err = snd_mpu401_uart_new(card, 0, MPU401_HW_ICE1712,
+			ICEREG(ice, MPU1_CTRL),
+			(c->mpu401_1_info_flags | MPU401_INFO_INTEGRATED),
+			ice->irq, 0, &ice->rmidi[0]);
+		if (err < 0) {
 			snd_card_free(card);
 			return err;
 		}
@@ -2727,12 +2739,12 @@ static int __devinit snd_ice1712_probe(struct pci_dev *pci,
 
 		if (ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_2xMPU401) {
 			/*  2nd port used  */
-			if ((err = snd_mpu401_uart_new(card, 1, MPU401_HW_ICE1712,
-						       ICEREG(ice, MPU2_CTRL),
-						       (c->mpu401_2_info_flags |
-							MPU401_INFO_INTEGRATED),
-						       ice->irq, 0,
-						       &ice->rmidi[1])) < 0) {
+			err = snd_mpu401_uart_new(card, 1, MPU401_HW_ICE1712,
+				ICEREG(ice, MPU2_CTRL),
+				(c->mpu401_2_info_flags | MPU401_INFO_INTEGRATED),
+				ice->irq, 0, &ice->rmidi[1]);
+
+			if (err < 0) {
 				snd_card_free(card);
 				return err;
 			}
@@ -2750,7 +2762,8 @@ static int __devinit snd_ice1712_probe(struct pci_dev *pci,
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
 		card->shortname, ice->port, ice->irq);
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
diff --git a/sound/pci/ice1712/ice1712.h b/sound/pci/ice1712/ice1712.h
index 762fbd7..fdae6de 100644
--- a/sound/pci/ice1712/ice1712.h
+++ b/sound/pci/ice1712/ice1712.h
@@ -20,7 +20,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 #include <sound/control.h>
 #include <sound/ac97_codec.h>
@@ -112,7 +112,7 @@
  */
 
 #define ICEDS(ice, x) ((ice)->dmapath_port + ICE1712_DS_##x)
- 
+
 #define ICE1712_DS_INTMASK		0x00	/* word - interrupt mask */
 #define ICE1712_DS_INTSTAT		0x02	/* word - interrupt status */
 #define ICE1712_DS_DATA			0x04	/* dword - channel data */
@@ -121,7 +121,7 @@
 /*
  *  Consumer section channel registers
  */
- 
+
 #define ICE1712_DSC_ADDR0		0x00	/* dword - base address 0 */
 #define ICE1712_DSC_COUNT0		0x01	/* word - count 0 */
 #define ICE1712_DSC_ADDR1		0x02	/* dword - base address 1 */
@@ -138,7 +138,7 @@
 #define ICE1712_DSC_RATE		0x05	/* dword - rate */
 #define ICE1712_DSC_VOLUME		0x06	/* word - volume control */
 
-/* 
+/*
  *  Professional multi-track direct control registers
  */
 
@@ -214,7 +214,7 @@
 
 
 /*
- *  
+ *
  */
 
 struct snd_ice1712;
@@ -253,12 +253,12 @@ enum {
 	ICE_EEP1_ADC_ID2,
 	ICE_EEP1_ADC_ID3
 };
-	
+
 #define ice_has_con_ac97(ice)	(!((ice)->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_NO_CON_AC97))
 
 
 struct snd_ak4xxx_private {
-	unsigned int cif: 1;		/* CIF mode */
+	unsigned int cif:1;		/* CIF mode */
 	unsigned char caddr;		/* C0 and C1 bits */
 	unsigned int data_mask;		/* DATA gpio bit */
 	unsigned int clk_mask;		/* CLK gpio bit */
@@ -306,11 +306,11 @@ struct snd_ice1712 {
 	struct snd_pcm *pcm;
 	struct snd_pcm *pcm_ds;
 	struct snd_pcm *pcm_pro;
-        struct snd_pcm_substream *playback_con_substream;
-        struct snd_pcm_substream *playback_con_substream_ds[6];
-        struct snd_pcm_substream *capture_con_substream;
-        struct snd_pcm_substream *playback_pro_substream;
-        struct snd_pcm_substream *capture_pro_substream;
+	struct snd_pcm_substream *playback_con_substream;
+	struct snd_pcm_substream *playback_con_substream_ds[6];
+	struct snd_pcm_substream *capture_con_substream;
+	struct snd_pcm_substream *playback_pro_substream;
+	struct snd_pcm_substream *capture_pro_substream;
 	unsigned int playback_pro_size;
 	unsigned int capture_pro_size;
 	unsigned int playback_con_virt_addr[6];
@@ -326,15 +326,15 @@ struct snd_ice1712 {
 	struct snd_ice1712_eeprom eeprom;
 
 	unsigned int pro_volumes[20];
-	unsigned int omni: 1;		/* Delta Omni I/O */
-	unsigned int dxr_enable: 1;	/* Terratec DXR enable for DMX6FIRE */
-	unsigned int vt1724: 1;
-	unsigned int vt1720: 1;
-	unsigned int has_spdif: 1;	/* VT1720/4 - has SPDIF I/O */
-	unsigned int force_pdma4: 1;	/* VT1720/4 - PDMA4 as non-spdif */
-	unsigned int force_rdma1: 1;	/* VT1720/4 - RDMA1 as non-spdif */
-	unsigned int midi_output: 1;	/* VT1720/4: MIDI output triggered */
-	unsigned int midi_input: 1;	/* VT1720/4: MIDI input triggered */
+	unsigned int omni:1;		/* Delta Omni I/O */
+	unsigned int dxr_enable:1;	/* Terratec DXR enable for DMX6FIRE */
+	unsigned int vt1724:1;
+	unsigned int vt1720:1;
+	unsigned int has_spdif:1;	/* VT1720/4 - has SPDIF I/O */
+	unsigned int force_pdma4:1;	/* VT1720/4 - PDMA4 as non-spdif */
+	unsigned int force_rdma1:1;	/* VT1720/4 - RDMA1 as non-spdif */
+	unsigned int midi_output:1;	/* VT1720/4: MIDI output triggered */
+	unsigned int midi_input:1;	/* VT1720/4: MIDI input triggered */
 	unsigned int num_total_dacs;	/* total DACs */
 	unsigned int num_total_adcs;	/* total ADCs */
 	unsigned int cur_rate;		/* current rate */
@@ -351,7 +351,7 @@ struct snd_ice1712 {
 	struct snd_i2c_bus *i2c;		/* I2C bus */
 	struct snd_i2c_device *cs8427;	/* CS8427 I2C device */
 	unsigned int cs8427_timeout;	/* CS8427 reset timeout in HZ/100 */
-	
+
 	struct ice1712_gpio {
 		unsigned int direction;		/* current direction bits */
 		unsigned int write_mask;	/* current mask bits */
@@ -455,7 +455,7 @@ static inline int snd_ice1712_gpio_read_bits(struct snd_ice1712 *ice,
 {
 	ice->gpio.direction &= ~mask;
 	snd_ice1712_gpio_set_dir(ice, ice->gpio.direction);
-	return  (snd_ice1712_gpio_read(ice) & mask);
+	return  snd_ice1712_gpio_read(ice) & mask;
 }
 
 int snd_ice1712_spdif_build_controls(struct snd_ice1712 *ice);
@@ -467,13 +467,13 @@ int snd_ice1712_akm4xxx_build_controls(struct snd_ice1712 *ice);
 
 int snd_ice1712_init_cs8427(struct snd_ice1712 *ice, int addr);
 
-static inline void snd_ice1712_write(struct snd_ice1712 * ice, u8 addr, u8 data)
+static inline void snd_ice1712_write(struct snd_ice1712 *ice, u8 addr, u8 data)
 {
 	outb(addr, ICEREG(ice, INDEX));
 	outb(data, ICEREG(ice, DATA));
 }
 
-static inline u8 snd_ice1712_read(struct snd_ice1712 * ice, u8 addr)
+static inline u8 snd_ice1712_read(struct snd_ice1712 *ice, u8 addr)
 {
 	outb(addr, ICEREG(ice, INDEX));
 	return inb(ICEREG(ice, DATA));
@@ -491,7 +491,7 @@ struct snd_ice1712_card_info {
 	char *driver;
 	int (*chip_init)(struct snd_ice1712 *);
 	int (*build_controls)(struct snd_ice1712 *);
-	unsigned int no_mpu401: 1;
+	unsigned int no_mpu401:1;
 	unsigned int mpu401_1_info_flags;
 	unsigned int mpu401_2_info_flags;
 	const char *mpu401_1_name;
