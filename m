From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix ymfpci resource allocation
Date: Fri, 02 May 2003 11:35:46 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305021106390.15874-100000@studcom.urz.uni-halle.de>
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


ymfpci.c writes to chip->fm_res and chip->mpu_res before chip is
allocated. The patch below adds local variables to temporarily store these
pointers.

If, on YMF744/754 chips, fm_port and/or mpu_port aren't set, the driver
should pick useful default addresses. Using the current values of the
FMBASE and MPU401BASE registers is not a good idea because the default
values (0x388/0x330) are likely to collide with other sound cards. The PCI
resources are there to provide an address range which is guaranteed to be
valid, so the patch reverts to using them.

And I've added some other little fixes.


Clemens
-- 



- don't access chip->xx_res before chip is allocated
- use PCI resources as default legacy addresses
- the MIEN bit is needed, so the comment isn't :)
- use reg_area_phys for the card longname
- fix error path after call to snd_ymfpci_ac3_init()


Index: alsa-kernel/pci/ymfpci/ymfpci.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ymfpci/ymfpci.c,v
retrieving revision 1.21
diff -u -r1.21 ymfpci.c
--- alsa-kernel/pci/ymfpci/ymfpci.c	9 Apr 2003 13:17:16 -0000	1.21
+++ alsa-kernel/pci/ymfpci/ymfpci.c	2 May 2003 08:53:59 -0000
@@ -84,6 +84,8 @@
 {
 	static int dev;
 	snd_card_t *card;
+	struct resource *fm_res = NULL;
+	struct resource *mpu_res = NULL;
 	ymfpci_t *chip;
 	opl3_t *opl3;
 	char *str;
@@ -116,24 +118,18 @@

 	if (pci_id->device >= 0x0010) { /* YMF 744/754 */
 		if (fm_port[dev] < 0) {
-			// fm_port[dev] = pci_resource_start(pci, 1);
-			u16 addr;
-			pci_read_config_word(pci, PCIR_DSXG_FMBASE, &addr);
-			fm_port[dev] = addr;
+			fm_port[dev] = pci_resource_start(pci, 1);
 		}
 		if (fm_port[dev] >= 0 &&
-		    (chip->fm_res = request_region(fm_port[dev], 4, "YMFPCI OPL3")) != NULL) {
+		    (fm_res = request_region(fm_port[dev], 4, "YMFPCI OPL3")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_FMEN;
 			pci_write_config_word(pci, PCIR_DSXG_FMBASE, fm_port[dev]);
 		}
 		if (mpu_port[dev] < 0) {
-			// mpu_port[dev] = pci_resource_start(pci, 1) + 0x20;
-			u16 addr;
-			pci_read_config_word(pci, PCIR_DSXG_MPU401BASE, &addr);
-			mpu_port[dev] = addr;
+			mpu_port[dev] = pci_resource_start(pci, 1) + 0x20;
 		}
 		if (mpu_port[dev] >= 0 &&
-		    (chip->mpu_res = request_region(mpu_port[dev], 2, "YMFPCI MPU401")) != NULL) {
+		    (mpu_res = request_region(mpu_port[dev], 2, "YMFPCI MPU401")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_MEN;
 			pci_write_config_word(pci, PCIR_DSXG_MPU401BASE, mpu_port[dev]);
 		}
@@ -146,7 +142,7 @@
 		default: fm_port[dev] = -1; break;
 		}
 		if (fm_port[dev] > 0 &&
-		    (chip->fm_res = request_region(fm_port[dev], 4, "YMFPCI OPL3")) != NULL) {
+		    (fm_res = request_region(fm_port[dev], 4, "YMFPCI OPL3")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_FMEN;
 		} else {
 			legacy_ctrl2 &= ~YMFPCI_LEGACY2_FMIO;
@@ -160,15 +156,15 @@
 		default: mpu_port[dev] = -1; break;
 		}
 		if (mpu_port[dev] > 0 &&
-		    (chip->mpu_res = request_region(mpu_port[dev], 2, "YMFPCI MPU401")) != NULL) {
+		    (mpu_res = request_region(mpu_port[dev], 2, "YMFPCI MPU401")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_MEN;
 		} else {
 			legacy_ctrl2 &= ~YMFPCI_LEGACY2_MPUIO;
 			mpu_port[dev] = -1;
 		}
 	}
-	if (chip->mpu_res) {
+	if (mpu_res) {
-		legacy_ctrl |= YMFPCI_LEGACY_MIEN; /* FIXME: do we need this? */
+		legacy_ctrl |= YMFPCI_LEGACY_MIEN;
 		legacy_ctrl2 |= YMFPCI_LEGACY2_IMOD;
 	}
 	pci_read_config_word(pci, PCIR_DSXG_LEGACY, &old_legacy_ctrl);
@@ -178,8 +174,18 @@
 				     old_legacy_ctrl,
 			 	     &chip)) < 0) {
 		snd_card_free(card);
+		if (mpu_res) {
+			release_resource(mpu_res);
+			kfree_nocheck(mpu_res);
+		}
+		if (fm_res) {
+			release_resource(fm_res);
+			kfree_nocheck(fm_res);
+		}
 		return err;
 	}
+	chip->fm_res = fm_res;
+	chip->mpu_res = mpu_res;
 	if ((err = snd_ymfpci_pcm(chip, 0, NULL)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -230,7 +236,7 @@
 	sprintf(card->shortname, "Yamaha DS-XG PCI (%s)", str);
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
 		card->shortname,
-		chip->reg_area_virt,
+		chip->reg_area_phys,
 		chip->irq);

 	if ((err = snd_card_register(card)) < 0) {
Index: alsa-kernel/pci/ymfpci/ymfpci_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ymfpci/ymfpci_main.c,v
retrieving revision 1.34
diff -u -r1.34 ymfpci_main.c
--- alsa-kernel/pci/ymfpci/ymfpci_main.c	23 Apr 2003 10:02:05 -0000	1.34
+++ alsa-kernel/pci/ymfpci/ymfpci_main.c	2 May 2003 08:53:59 -0000
@@ -2252,8 +2252,10 @@
 		return -EIO;
 	}

-	if ((err = snd_ymfpci_ac3_init(chip)) < 0)
+	if ((err = snd_ymfpci_ac3_init(chip)) < 0) {
+		snd_ymfpci_free(chip);
 		return err;
+	}

 #ifdef CONFIG_PM
 	chip->saved_regs = vmalloc(YDSXGR_NUM_SAVED_REGS * sizeof(u32));




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
