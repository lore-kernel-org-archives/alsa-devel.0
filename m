From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] maestro3: Add hardware volume control quirk list
Date: Fri, 20 May 2005 20:25:40 +0300
Message-ID: <20050520172540.GA27839@sci.fi>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Add a hardware volume quirk list to the maestro3 driver. Details were 
taken from the Windows driver. Hardware volume control is enabled only for 
the systems in the list.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 maestro3.c |  127 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 106 insertions(+), 21 deletions(-)

diff -urN linux/sound/pci/maestro3.c linux/sound/pci/maestro3.c
--- linux/sound/pci/maestro3.c	2005-05-20 20:03:02.000000000 +0300
+++ linux/sound/pci/maestro3.c	2005-05-20 20:08:11.000000000 +0300
@@ -779,6 +779,12 @@
 				   (e.g. for IrDA on Dell Inspirons) */
 };
 
+struct m3_hv_quirk {
+	u16 vendor, device, subsystem_vendor, subsystem_device;
+	u32 config;		/* ALLEGRO_CONFIG hardware volume bits */
+	int is_omnibook;	/* Do HP OmniBook GPIO magic? */
+};
+
 struct m3_list {
 	int curlen;
 	int mem_addr;
@@ -828,6 +834,7 @@
 
 	struct pci_dev *pci;
 	struct m3_quirk *quirk;
+	struct m3_hv_quirk *hv_quirk;
 
 	int dacs_active;
 	int timer_users;
@@ -856,7 +863,7 @@
 	snd_kcontrol_t *master_switch;
 	snd_kcontrol_t *master_volume;
 	struct tasklet_struct hwvol_tq;
-	
+
 #ifdef CONFIG_PM
 	u16 *suspend_mem;
 #endif
@@ -973,6 +980,71 @@
 	{ NULL }
 };
 
+/* These values came from the Windows driver. */
+static struct m3_hv_quirk m3_hv_quirk_list[] = {
+	/* Allegro chips */
+	{ 0x125D, 0x1988, 0x0E11, 0x002E, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x0E11, 0x0094, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x0E11, 0xB112, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x0E11, 0xB114, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x103C, 0x0012, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x103C, 0x0018, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x103C, 0x001C, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x103C, 0x001D, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x103C, 0x001E, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x107B, 0x3350, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x10F7, 0x8338, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x10F7, 0x833C, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x10F7, 0x833D, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x10F7, 0x833E, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x10F7, 0x833F, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x13BD, 0x1018, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x13BD, 0x1019, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x13BD, 0x101A, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x14FF, 0x0F03, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x14FF, 0x0F04, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x14FF, 0x0F05, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x156D, 0xB400, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x156D, 0xB795, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x156D, 0xB797, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x156D, 0xC700, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
+	{ 0x125D, 0x1988, 0x1033, 0x80F1, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x1988, 0x103C, 0x001A, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD | REDUCED_DEBOUNCE, 0 }, /* HP OmniBook 6100 */
+	{ 0x125D, 0x1988, 0x107B, 0x340A, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x1988, 0x107B, 0x3450, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x1988, 0x109F, 0x3134, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x1988, 0x109F, 0x3161, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x1988, 0x144D, 0x3280, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x1988, 0x144D, 0x3281, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x1988, 0x144D, 0xC002, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x1988, 0x144D, 0xC003, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x1988, 0x1509, 0x1740, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x1988, 0x1610, 0x0010, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x1988, 0x1042, 0x1042, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1988, 0x107B, 0x9500, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1988, 0x14FF, 0x0F06, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1988, 0x1558, 0x8586, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1988, 0x161F, 0x2011, HV_CTRL_ENABLE, 0 },
+	/* Maestro3 chips */
+	{ 0x125D, 0x1998, 0x103C, 0x000E, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1998, 0x103C, 0x0010, HV_CTRL_ENABLE, 1 }, /* HP OmniBook 6000 */
+	{ 0x125D, 0x1998, 0x103C, 0x0011, HV_CTRL_ENABLE, 1 }, /* HP OmniBook 500 */
+	{ 0x125D, 0x1998, 0x103C, 0x001B, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1998, 0x104D, 0x80A6, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1998, 0x104D, 0x80AA, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1998, 0x107B, 0x5300, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1998, 0x110A, 0x1998, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1998, 0x13BD, 0x1015, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1998, 0x13BD, 0x101C, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1998, 0x13BD, 0x1802, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1998, 0x1599, 0x0715, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x1998, 0x5643, 0x5643, HV_CTRL_ENABLE, 0 },
+	{ 0x125D, 0x199A, 0x144D, 0x3260, HV_CTRL_ENABLE | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x199A, 0x144D, 0x3261, HV_CTRL_ENABLE | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x199A, 0x144D, 0xC000, HV_CTRL_ENABLE | REDUCED_DEBOUNCE, 0 },
+	{ 0x125D, 0x199A, 0x144D, 0xC001, HV_CTRL_ENABLE | REDUCED_DEBOUNCE, 0 },
+	{ 0 }
+};
 
 /*
  * lowlevel functions
@@ -2392,21 +2464,27 @@
 	       DISABLE_LEGACY);
 	pci_write_config_word(pcidev, PCI_LEGACY_AUDIO_CTRL, w);
 
-	/*
-	 * Volume buttons on some HP OmniBook laptops (500 and 6000 at least)
-	 * don't work correctly. This makes them work for the most part.
-	 * Volume up and down buttons on the laptop side work perfectly.
-	 * Fn+cursor_up (volme up) works, Fn+cursor_down (volume down) doesn't,
-	 * Fn+F8 (mute) works acts as volume up.
-	 */
-	outw(~(GPI_VOL_DOWN|GPI_VOL_UP), io + GPIO_MASK);
-	outw(inw(io + GPIO_DIRECTION) & ~(GPI_VOL_DOWN|GPI_VOL_UP), io + GPIO_DIRECTION);
-	outw((GPI_VOL_DOWN|GPI_VOL_UP), io + GPIO_DATA);
-	outw(0xffff, io + GPIO_MASK);
-
+	if (chip->hv_quirk && chip->hv_quirk->is_omnibook) {
+		/*
+		 * Volume buttons on some HP OmniBook laptops don't work
+		 * correctly. This makes them work for the most part.
+		 *
+		 * Volume up and down buttons on the laptop side work.
+		 * Fn+cursor_up (volme up) works.
+		 * Fn+cursor_down (volume down) doesn't work.
+		 * Fn+F7 (mute) works acts as volume up.
+		 */
+		outw(~(GPI_VOL_DOWN|GPI_VOL_UP), io + GPIO_MASK);
+		outw(inw(io + GPIO_DIRECTION) & ~(GPI_VOL_DOWN|GPI_VOL_UP), io + GPIO_DIRECTION);
+		outw((GPI_VOL_DOWN|GPI_VOL_UP), io + GPIO_DATA);
+		outw(0xffff, io + GPIO_MASK);
+	}
 	pci_read_config_dword(pcidev, PCI_ALLEGRO_CONFIG, &n);
-	n &= ~HV_BUTTON_FROM_GD;
-	n |= HV_CTRL_ENABLE | REDUCED_DEBOUNCE;
+	n &= ~(HV_CTRL_ENABLE | REDUCED_DEBOUNCE | HV_BUTTON_FROM_GD);
+	if (chip->hv_quirk)
+		n |= chip->hv_quirk->config;
+	/* For some reason we must always use reduced debounce. */
+	n |= REDUCED_DEBOUNCE;
 	n |= PM_CTRL_ENABLE | CLK_DIV_BY_49 | USE_PCI_TIMING;
 	pci_write_config_dword(pcidev, PCI_ALLEGRO_CONFIG, n);
 
@@ -2594,7 +2672,7 @@
 	m3_t *chip;
 	int i, err;
 	struct m3_quirk *quirk;
-	u16 subsystem_vendor, subsystem_device;
+	struct m3_hv_quirk *hv_quirk;
 	static snd_device_ops_t ops = {
 		.dev_free =	snd_m3_dev_free,
 	};
@@ -2632,18 +2710,25 @@
 	chip->pci = pci;
 	chip->irq = -1;
 
-	pci_read_config_word(pci, PCI_SUBSYSTEM_VENDOR_ID, &subsystem_vendor);
-	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &subsystem_device);
-
 	for (quirk = m3_quirk_list; quirk->vendor; quirk++) {
-		if (subsystem_vendor == quirk->vendor &&
-		    subsystem_device == quirk->device) {
+		if (pci->subsystem_vendor == quirk->vendor &&
+		    pci->subsystem_device == quirk->device) {
 			printk(KERN_INFO "maestro3: enabled hack for '%s'\n", quirk->name);
 			chip->quirk = quirk;
 			break;
 		}
 	}
 
+	for (hv_quirk = m3_hv_quirk_list; hv_quirk->vendor; hv_quirk++) {
+		if (pci->vendor == hv_quirk->vendor &&
+		    pci->device == hv_quirk->device &&
+		    pci->subsystem_vendor == hv_quirk->subsystem_vendor &&
+		    pci->subsystem_device == hv_quirk->subsystem_device) {
+			chip->hv_quirk = hv_quirk;
+			break;
+		}
+	}
+
 	chip->external_amp = enable_amp;
 	if (amp_gpio >= 0 && amp_gpio <= 0x0f)
 		chip->amp_gpio = amp_gpio;


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
