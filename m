From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] ymfpci joystick resource allocation
Date: Mon, 16 Jun 2003 09:05:20 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306160904470.27784-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


- allocate io port for the gameport
- register gameport with the generic gameport layer
- allow pci resource as gameport address (YMF754/755)


Index: alsa-kernel/include/ymfpci.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/ymfpci.h,v
retrieving revision 1.9
diff -u -r1.9 ymfpci.h
--- alsa-kernel/include/ymfpci.h	9 Apr 2003 13:17:15 -0000	1.9
+++ alsa-kernel/include/ymfpci.h	16 Jun 2003 06:59:52 -0000
@@ -25,6 +25,7 @@
 #include "pcm.h"
 #include "rawmidi.h"
 #include "ac97_codec.h"
+#include <linux/gameport.h>

 #ifndef PCI_VENDOR_ID_YAMAHA
 #define PCI_VENDOR_ID_YAMAHA            0x1073
@@ -309,7 +310,12 @@
 	struct resource *mpu_res;

 	unsigned short old_legacy_ctrl;
+#if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
 	unsigned int joystick_port;
+	struct semaphore joystick_mutex;
+	struct resource *joystick_res;
+	struct gameport gameport;
+#endif

 	void *work_ptr;
 	dma_addr_t work_ptr_addr;
@@ -383,7 +389,9 @@
 int snd_ymfpci_pcm_spdif(ymfpci_t *chip, int device, snd_pcm_t **rpcm);
 int snd_ymfpci_pcm_4ch(ymfpci_t *chip, int device, snd_pcm_t **rpcm);
 int snd_ymfpci_mixer(ymfpci_t *chip, int rear_switch);
+#if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
 int snd_ymfpci_joystick(ymfpci_t *chip);
+#endif

 int snd_ymfpci_voice_alloc(ymfpci_t *chip, ymfpci_voice_type_t type, int pair, ymfpci_voice_t **rvoice);
 int snd_ymfpci_voice_free(ymfpci_t *chip, ymfpci_voice_t *pvoice);
Index: alsa-kernel/pci/ymfpci/ymfpci.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ymfpci/ymfpci.c,v
retrieving revision 1.22
diff -u -r1.22 ymfpci.c
--- alsa-kernel/pci/ymfpci/ymfpci.c	5 May 2003 14:14:59 -0000	1.22
+++ alsa-kernel/pci/ymfpci/ymfpci.c	16 Jun 2003 06:59:52 -0000
@@ -229,9 +229,11 @@
 			return err;
 		}
 	}
+#if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
 	if ((err = snd_ymfpci_joystick(chip)) < 0) {
 		printk(KERN_WARNING "ymfpci: cannot initialize joystick, skipping...\n");
 	}
+#endif
 	strcpy(card->driver, str);
 	sprintf(card->shortname, "Yamaha DS-XG PCI (%s)", str);
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
Index: alsa-kernel/pci/ymfpci/ymfpci_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ymfpci/ymfpci_main.c,v
retrieving revision 1.36
diff -u -r1.36 ymfpci_main.c
--- alsa-kernel/pci/ymfpci/ymfpci_main.c	5 May 2003 14:14:59 -0000	1.36
+++ alsa-kernel/pci/ymfpci/ymfpci_main.c	16 Jun 2003 06:59:53 -0000
@@ -1708,24 +1708,65 @@
  * joystick support
  */

+#if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
 static int ymfpci_joystick_ports[4] = {
 	0x201, 0x202, 0x204, 0x205
 };

+static int snd_ymfpci_get_joystick_port(ymfpci_t *chip, int index)
+{
+	if (index < 4)
+		return ymfpci_joystick_ports[index];
+	else
+		return pci_resource_start(chip->pci, 2);
+}
+
 static void setup_joystick_base(ymfpci_t *chip)
 {
-	if (chip->pci->device >= 0x0010) /* YMF 744/754 */
+	if (chip->device_id >= 0x0010) /* YMF 744/754 */
 		pci_write_config_word(chip->pci, PCIR_DSXG_JOYBASE,
-				      ymfpci_joystick_ports[chip->joystick_port]);
+				      snd_ymfpci_get_joystick_port(chip, chip->joystick_port));
 	else {
 		u16 legacy_ctrl2;
 		pci_read_config_word(chip->pci, PCIR_DSXG_ELEGACY, &legacy_ctrl2);
-		legacy_ctrl2 &= ~(3 << 6);
+		legacy_ctrl2 &= ~YMFPCI_LEGACY2_JSIO;
 		legacy_ctrl2 |= chip->joystick_port << 6;
 		pci_write_config_word(chip->pci, PCIR_DSXG_ELEGACY, legacy_ctrl2);
 	}
 }

+static int snd_ymfpci_enable_joystick(ymfpci_t *chip)
+{
+	u16 val;
+
+	chip->gameport.io = snd_ymfpci_get_joystick_port(chip, chip->joystick_port);
+	chip->joystick_res = request_region(chip->gameport.io, 1, "YMFPCI gameport");
+	if (!chip->joystick_res) {
+		snd_printk(KERN_WARNING "gameport port %#x in use\n", chip->gameport.io);
+		return 0;
+	}
+	setup_joystick_base(chip);
+	pci_read_config_word(chip->pci, PCIR_DSXG_LEGACY, &val);
+	val |= YMFPCI_LEGACY_JPEN;
+	pci_write_config_word(chip->pci, PCIR_DSXG_LEGACY, val);
+	gameport_register_port(&chip->gameport);
+	return 1;
+}
+
+static int snd_ymfpci_disable_joystick(ymfpci_t *chip)
+{
+	u16 val;
+
+	gameport_unregister_port(&chip->gameport);
+	pci_read_config_word(chip->pci, PCIR_DSXG_LEGACY, &val);
+	val &= ~YMFPCI_LEGACY_JPEN;
+	pci_write_config_word(chip->pci, PCIR_DSXG_LEGACY, val);
+	release_resource(chip->joystick_res);
+	kfree_nocheck(chip->joystick_res);
+	chip->joystick_res = NULL;
+	return 1;
+}
+
 static int snd_ymfpci_joystick_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
@@ -1741,36 +1782,41 @@
 	u16 val;

 	pci_read_config_word(chip->pci, PCIR_DSXG_LEGACY, &val);
-	ucontrol->value.integer.value[0] = (val & 0x04) ? 1 : 0;
+	ucontrol->value.integer.value[0] = (val & YMFPCI_LEGACY_JPEN) ? 1 : 0;
 	return 0;
 }

 static int snd_ymfpci_joystick_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
 	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
-	u16 val, oval;
+	int enabled, change;

-	pci_read_config_word(chip->pci, PCIR_DSXG_LEGACY, &oval);
-	val = oval & ~0x04;
-	if (ucontrol->value.integer.value[0])
-		val |= 0x04;
-	if (val != oval) {
-		setup_joystick_base(chip);
-		pci_write_config_word(chip->pci, PCIR_DSXG_LEGACY, val);
-		return 1;
+	down(&chip->joystick_mutex);
+	enabled = chip->joystick_res != NULL;
+	change = enabled != !! ucontrol->value.integer.value[0];
+	if (change) {
+		if (!enabled)
+			change = snd_ymfpci_enable_joystick(chip);
+		else
+			change = snd_ymfpci_disable_joystick(chip);
 	}
-	return 0;
+	up(&chip->joystick_mutex);
+	return change;
 }

 static int snd_ymfpci_joystick_addr_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
 {
-        uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-        uinfo->count = 1;
-        uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item >= 4)
-		uinfo->value.enumerated.item = 3;
-	sprintf(uinfo->value.enumerated.name, "port 0x%x", ymfpci_joystick_ports[uinfo->value.enumerated.item]);
-        return 0;
+	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
+	int ports = chip->device_id >= 0x0010 ? 5 : 4;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = ports;
+	if (uinfo->value.enumerated.item >= ports)
+		uinfo->value.enumerated.item = ports - 1;
+	sprintf(uinfo->value.enumerated.name, "port 0x%x",
+		snd_ymfpci_get_joystick_port(chip, uinfo->value.enumerated.item));
+	return 0;
 }

 static int snd_ymfpci_joystick_addr_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
@@ -1783,13 +1829,20 @@
 static int snd_ymfpci_joystick_addr_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
 	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
-	if (ucontrol->value.enumerated.item[0] != chip->joystick_port) {
-		snd_assert(ucontrol->value.enumerated.item[0] >= 0 && ucontrol->value.enumerated.item[0] < 4, return -EINVAL);
+	int change, enabled;
+
+	down(&chip->joystick_mutex);
+	change = ucontrol->value.enumerated.item[0] != chip->joystick_port;
+	if (change) {
+		enabled = chip->joystick_res != NULL;
+		if (enabled)
+			snd_ymfpci_disable_joystick(chip);
 		chip->joystick_port = ucontrol->value.enumerated.item[0];
-		setup_joystick_base(chip);
-		return 1;
+		if (enabled)
+			snd_ymfpci_enable_joystick(chip);
 	}
-	return 0;
+	up(&chip->joystick_mutex);
+	return change;
 }

 static snd_kcontrol_new_t snd_ymfpci_control_joystick __devinitdata = {
@@ -1819,6 +1872,7 @@
 		return err;
 	return 0;
 }
+#endif /* CONFIG_GAMEPORT */


 /*
@@ -2067,6 +2121,10 @@
 		release_resource(chip->fm_res);
 		kfree_nocheck(chip->fm_res);
 	}
+#if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
+	if (chip->joystick_res)
+		snd_ymfpci_disable_joystick(chip);
+#endif
 	if (chip->reg_area_virt)
 		iounmap((void *)chip->reg_area_virt);
 	if (chip->work_ptr)
@@ -2216,6 +2274,9 @@
 	spin_lock_init(&chip->voice_lock);
 	init_waitqueue_head(&chip->interrupt_sleep);
 	atomic_set(&chip->interrupt_sleep_count, 0);
+#if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
+	init_MUTEX(&chip->joystick_mutex);
+#endif
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;




-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
