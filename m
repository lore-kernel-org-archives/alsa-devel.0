From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: No line in 2 or aux 2 for emu10k1
Date: Sat, 26 Mar 2005 16:44:43 -0500
Message-ID: <1111873484.783.6.camel@mindpipe>
References: <200503251824.10744.nightbreed@verizon.net>
	 <1111812200.24049.14.camel@mindpipe>
	 <200503260218.05813.nightbreed@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200503260218.05813.nightbreed@verizon.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: nightbreed@verizon.net
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-03-26 at 02:18 -0500, Gary Jones wrote:
> On Friday 25 March 2005 11:43 pm, you wrote:
> > On Fri, 2005-03-25 at 18:24 -0500, Gary Jones wrote:
> > > With the latest build of the alsa drivers using the cvs on March 25, 2005
> > > I can no longer get access to the line in 2 or aux 2. When I activate
> > > ld10k1 I can access it but, line in 1 and aux 1 vanishes. The 2 on the
> > > livedrive however, becomes very silent. I can hear noise but I can't
> > > adjust the volume on them. Well I mean I can move sliders on mixers but
> > > it does nothing for the volume. I have an audigy1.
> >
> > It works for me.  What exactly is your test procedure?
> >
> > Please try to establish when this stopped working.  You can build ALSA
> > CVS from Feb 1, 2005 with "cvs update -D 2005-02-01" for example.
> >
> > Lee
> 
> So far, this is what I have. I went back to March 20, 2005 and started from 
> there. All showed up and worked as it should. All inputs were visible and 
> worked fine. The 22nd, the same, it too, worked. The 23rd, total lock up of 
> the machine. Then finally, the 24th of March was a no show on the livedrive 
> inputs. So the 22nd was the last date that everything worked correctly for 
> me.
> The kernel I am currently using is 2.6.12-rc1 vanilla. Distro is Slackware 
> 10.1 but compiled from source.
> As far as a test procedure, I don't really have one of those. I just update 
> the cvs branch daily and compile all from driver to utilities and all in 
> between. Again, all worked up to the 22nd of March 2005.

OK.  I looked at the diff, and it's 700+ lines for
alsa-kernel/pci/emu10k1/*.

The changes are the patches to improve the detection of card
capabilities from James, and the patches to reduce stack usage and fix
the bugs I introduced in the voice allocator from Takashi.

I have attached the diff from 2005-03-22 to 2005-03-24 for reference.
The obvious suspect is the card capabilities patch.  James, any ideas?

Lee

? alsa-kernel/pci/emu10k1/alsafoo.patch
Index: README.CVS
===================================================================
RCS file: /cvsroot/alsa/README.CVS,v
retrieving revision 1.4
retrieving revision 1.5
diff -u -r1.4 -r1.5
--- README.CVS	9 Mar 2005 11:16:52 -0000	1.4
+++ README.CVS	22 Mar 2005 10:15:35 -0000	1.5
@@ -13,13 +13,16 @@
 
 Additions:
 
-Patch-level: [Low],[High]
+Patch-level: [Low],[High],[Merged]
   - when patch level is High, the changeset is propagated to ALSA BK tree
-    immediately; use this with caution - only small bugfixes should have
-    this line
+    immediately; use this with caution - only small urgent bugfixes should
+    have this line
   - when patch level is Low, the changeset is propagated to ALSA BK tree
     in next "development" round of Linux kernel (one or two rc versions);
     it's default (thus it might be ommited)
+  - when patch level is Merged, the changeset contains changes from
+    the mainstream kernel tree (and should not be propagated to ALSA BK
+    tree again)
 
 Exceptions:
 -----------
Index: alsa-kernel/pci/emu10k1/emu10k1.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1.c,v
retrieving revision 1.33
retrieving revision 1.35
diff -u -r1.33 -r1.35
--- alsa-kernel/pci/emu10k1/emu10k1.c	17 Mar 2005 15:55:16 -0000	1.33
+++ alsa-kernel/pci/emu10k1/emu10k1.c	23 Mar 2005 16:56:03 -0000	1.35
@@ -198,23 +198,11 @@
 	}
 #endif
  
-	if (emu->audigy && (emu->serial == 0x10011102) ) {
-		strcpy(card->driver, "Audigy2");
-		strcpy(card->shortname, "Sound Blaster Audigy2_Value");
-	} else if (emu->audigy && (emu->revision == 4) ) {
-		strcpy(card->driver, "Audigy2");
-		strcpy(card->shortname, "Sound Blaster Audigy2");
-	} else if (emu->audigy) {
-		strcpy(card->driver, "Audigy");
-		strcpy(card->shortname, "Sound Blaster Audigy");
-	} else if (emu->APS) {
-		strcpy(card->driver, "E-mu APS");
-		strcpy(card->shortname, "E-mu APS");
-	} else {
-		strcpy(card->driver, "EMU10K1");
-		strcpy(card->shortname, "Sound Blaster Live!");
-	}
-	sprintf(card->longname, "%s (rev.%d, serial:0x%x) at 0x%lx, irq %i", card->shortname, emu->revision, emu->serial, emu->port, emu->irq);
+	strcpy(card->driver, emu->card_capabilities->driver);
+	strcpy(card->shortname, emu->card_capabilities->name);
+	snprintf(card->longname, sizeof(card->longname),
+		 "%s (rev.%d, serial:0x%x) at 0x%lx, irq %i",
+		 card->shortname, emu->revision, emu->serial, emu->port, emu->irq);
 
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
Index: alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.45
retrieving revision 1.47
diff -u -r1.45 -r1.47
--- alsa-kernel/pci/emu10k1/emu10k1_main.c	17 Mar 2005 15:55:16 -0000	1.45
+++ alsa-kernel/pci/emu10k1/emu10k1_main.c	23 Mar 2005 16:56:03 -0000	1.47
@@ -612,6 +612,85 @@
 	return snd_emu10k1_free(emu);
 }
 
+/* vendor, device, subsystem, emu10k1_chip, emu10k2_chip, ca0102_chip, ca0108_chip, ca0151_chip, spk71, spdif_bug, ac97_chip, ecard, driver, name */
+
+static emu_chip_details_t emu_chip_details[] = {
+	/* Audigy 2 Value AC3 out does not work yet. Need to find out how to turn off interpolators.*/
+	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x10011102,
+	 .driver = "Audigy2", .name = "Audigy 2 Value [SB0400]", 
+	 .emu10k2_chip = 1,
+	 .ca0108_chip = 1,
+	 .spk71 = 1} ,
+	{.vendor = 0x1102, .device = 0x0008, 
+	 .driver = "Audigy2", .name = "Audigy 2 Value [Unknown]", 
+	 .emu10k2_chip = 1,
+	 .ca0108_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20071102,
+	 .driver = "Audigy2", .name = "Audigy 4 PRO [SB0380]", 
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0151_chip = 1,
+	 .spk71 = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20021102,
+	 .driver = "Audigy2", .name = "Audigy 2 ZS [SB0350]", 
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0151_chip = 1,
+	 .spk71 = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20011102,
+	 .driver = "Audigy2", .name = "Audigy 2 ZS [2001]", 
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0151_chip = 1,
+	 .spk71 = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10071102,
+	 .driver = "Audigy2", .name = "Audigy 2 [SB0240]", 
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0151_chip = 1,
+	 .spk71 = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10051102,
+	 .driver = "Audigy2", .name = "Audigy 2 EX [1005]", 
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0151_chip = 1,
+	 .spdif_bug = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10021102,
+	 .driver = "Audigy2", .name = "Audigy 2 Platinum [SB0240P]", 
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0151_chip = 1,
+	 .spk71 = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004,
+	 .driver = "Audigy", .name = "Audigy 1 or 2 [Unknown]", 
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .spdif_bug = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x40011102,
+	 .driver = "EMU10K1", .name = "E-mu APS [4001]", 
+	 .emu10k1_chip = 1,
+	 .ecard = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
+	 .driver = "EMU10K1", .name = "SB Live 5.1", 
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0002,
+	 .driver = "EMU10K1", .name = "SB Live [Unknown]", 
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1} ,
+	{ } /* terminator */
+};
+
 int __devinit snd_emu10k1_create(snd_card_t * card,
 		       struct pci_dev * pci,
 		       unsigned short extin_mask,
@@ -623,15 +702,14 @@
 	emu10k1_t *emu;
 	int err;
 	int is_audigy;
+	unsigned char revision;
+	const emu_chip_details_t *c;
 	static snd_device_ops_t ops = {
 		.dev_free =	snd_emu10k1_dev_free,
 	};
 	
 	*remu = NULL;
 
-	// is_audigy = (int)pci->driver_data;
-	is_audigy = (pci->device == 0x0004) || ( (pci->device == 0x0008) );
-
 	/* enable PCI device */
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
@@ -641,15 +719,6 @@
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
-	/* set the DMA transfer mask */
-	emu->dma_mask = is_audigy ? AUDIGY_DMA_MASK : EMU10K1_DMA_MASK;
-	if (pci_set_dma_mask(pci, emu->dma_mask) < 0 ||
-	    pci_set_consistent_dma_mask(pci, emu->dma_mask) < 0) {
-		snd_printk(KERN_ERR "architecture does not support PCI busmaster DMA with mask 0x%lx\n", emu->dma_mask);
-		kfree(emu);
-		pci_disable_device(pci);
-		return -ENXIO;
-	}
 	emu->card = card;
 	spin_lock_init(&emu->reg_lock);
 	spin_lock_init(&emu->emu_lock);
@@ -664,8 +733,43 @@
 	emu->irq = -1;
 	emu->synth = NULL;
 	emu->get_synth_voice = NULL;
+	/* read revision & serial */
+	pci_read_config_byte(pci, PCI_REVISION_ID, &revision);
+	emu->revision = revision;
+	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &emu->serial);
+	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &emu->model);
+	emu->card_type = EMU10K1_CARD_CREATIVE;
+	snd_printdd("vendor=0x%x, device=0x%x, subsystem_vendor_id=0x%x, subsystem_id=0x%x\n",pci->vendor, pci->device, emu->serial, emu->model);
 
-	emu->audigy = is_audigy;
+	for (c = emu_chip_details; c->vendor; c++) {
+		if (c->vendor == pci->vendor && c->device == pci->device) {
+			if (c->subsystem == emu->serial) break;
+			if (c->subsystem == 0) break;
+		}
+	}
+	if (c->vendor == 0) {
+		snd_printk(KERN_ERR "emu10k1: Card not recognised\n");
+		kfree(emu);
+		pci_disable_device(pci);
+		return -ENOENT;
+	}
+	emu->card_capabilities = c;
+	if (c->subsystem != 0)
+		snd_printdd("Sound card name=%s\n", c->name);
+	else
+		snd_printdd("Sound card name=%s, vendor=0x%x, device=0x%x, subsystem=0x%x\n", c->name, pci->vendor, pci->device, emu->serial);
+	
+	is_audigy = emu->audigy = c->emu10k2_chip;
+
+	/* set the DMA transfer mask */
+	emu->dma_mask = is_audigy ? AUDIGY_DMA_MASK : EMU10K1_DMA_MASK;
+	if (pci_set_dma_mask(pci, emu->dma_mask) < 0 ||
+	    pci_set_consistent_dma_mask(pci, emu->dma_mask) < 0) {
+		snd_printk(KERN_ERR "architecture does not support PCI busmaster DMA with mask 0x%lx\n", emu->dma_mask);
+		kfree(emu);
+		pci_disable_device(pci);
+		return -ENXIO;
+	}
 	if (is_audigy)
 		emu->gpr_base = A_FXGPREGBASE;
 	else
@@ -711,30 +815,15 @@
 	emu->memhdr->block_extra_size = sizeof(emu10k1_memblk_t) - sizeof(snd_util_memblk_t);
 
 	pci_set_master(pci);
-	/* read revision & serial */
-	pci_read_config_byte(pci, PCI_REVISION_ID, (char *)&emu->revision);
-	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &emu->serial);
-	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &emu->model);
-	emu->card_type = EMU10K1_CARD_CREATIVE;
-	if (emu->serial == 0x40011102) {
+
+	if (c->ecard) {
 		emu->card_type = EMU10K1_CARD_EMUAPS;
 		emu->APS = 1;
-		emu->no_ac97 = 1; /* APS has no AC97 chip */
-	}
-	else if (emu->revision == 4 && emu->serial == 0x10051102) {
-		/* Audigy 2 EX has apparently no effective AC97 controls
-		 * (for both input and output), so we skip the AC97 detections
-		 */
-		snd_printdd(KERN_INFO "Audigy2 EX is detected. skipping ac97.\n");
-		emu->no_ac97 = 1;	
-	}
-	
-	if (emu->revision == 4 && (emu->model == 0x2001 || emu->model == 0x2002)) {
-		/* Audigy 2 ZS */
-		snd_printdd(KERN_INFO "Audigy2 ZS is detected. setting 7.1 mode.\n");
-		emu->spk71 = 1;
 	}
+	if (! c->ac97_chip)
+		emu->no_ac97 = 1;
 	
+	emu->spk71 = c->spk71;
 	
 	emu->fx8010.fxbus_mask = 0x303f;
 	if (extin_mask == 0)
Index: alsa-kernel/pci/emu10k1/emu10k1x.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1x.c,v
retrieving revision 1.7
retrieving revision 1.8
diff -u -r1.7 -r1.8
--- alsa-kernel/pci/emu10k1/emu10k1x.c	21 Mar 2005 08:13:32 -0000	1.7
+++ alsa-kernel/pci/emu10k1/emu10k1x.c	23 Mar 2005 17:04:17 -0000	1.8
@@ -749,6 +749,7 @@
 
 	memset(&ac97, 0, sizeof(ac97));
 	ac97.private_data = chip;
+	ac97.scaps = AC97_SCAP_NO_SPDIF;
 	return snd_ac97_mixer(pbus, &ac97, &chip->ac97);
 }
 
Index: alsa-kernel/pci/emu10k1/emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.70
retrieving revision 1.73
diff -u -r1.70 -r1.73
--- alsa-kernel/pci/emu10k1/emufx.c	21 Mar 2005 19:45:01 -0000	1.70
+++ alsa-kernel/pci/emu10k1/emufx.c	23 Mar 2005 16:58:41 -0000	1.73
@@ -634,7 +634,8 @@
 	snd_ctl_elem_id_t __user *_id;
 	snd_ctl_elem_id_t id;
 	emu10k1_fx8010_control_gpr_t __user *_gctl;
-	emu10k1_fx8010_control_gpr_t gctl;
+	emu10k1_fx8010_control_gpr_t *gctl;
+	int err;
 	
 	for (i = 0, _id = icode->gpr_del_controls;
 	     i < icode->gpr_del_control_count; i++, _id++) {
@@ -643,29 +644,42 @@
 		if (snd_emu10k1_look_for_ctl(emu, &id) == NULL)
 			return -ENOENT;
 	}
+	gctl = kmalloc(sizeof(*gctl), GFP_KERNEL);
+	if (! gctl)
+		return -ENOMEM;
+	err = 0;
 	for (i = 0, _gctl = icode->gpr_add_controls;
 	     i < icode->gpr_add_control_count; i++, _gctl++) {
-		if (copy_from_user(&gctl, _gctl, sizeof(gctl)))
-			return -EFAULT;
-		if (snd_emu10k1_look_for_ctl(emu, &gctl.id))
+		if (copy_from_user(gctl, _gctl, sizeof(*gctl))) {
+			err = -EFAULT;
+			goto __error;
+		}
+		if (snd_emu10k1_look_for_ctl(emu, &gctl->id))
 			continue;
 		down_read(&emu->card->controls_rwsem);
-		if (snd_ctl_find_id(emu->card, &gctl.id) != NULL) {
+		if (snd_ctl_find_id(emu->card, &gctl->id) != NULL) {
 			up_read(&emu->card->controls_rwsem);
-			return -EEXIST;
+			err = -EEXIST;
+			goto __error;
 		}
 		up_read(&emu->card->controls_rwsem);
-		if (gctl.id.iface != SNDRV_CTL_ELEM_IFACE_MIXER &&
-		    gctl.id.iface != SNDRV_CTL_ELEM_IFACE_PCM)
-			return -EINVAL;
+		if (gctl->id.iface != SNDRV_CTL_ELEM_IFACE_MIXER &&
+		    gctl->id.iface != SNDRV_CTL_ELEM_IFACE_PCM) {
+			err = -EINVAL;
+			goto __error;
+		}
 	}
 	for (i = 0, _gctl = icode->gpr_list_controls;
 	     i < icode->gpr_list_control_count; i++, _gctl++) {
 	     	/* FIXME: we need to check the WRITE access */
-		if (copy_from_user(&gctl, _gctl, sizeof(gctl)))
-			return -EFAULT;
+		if (copy_from_user(gctl, _gctl, sizeof(*gctl))) {
+			err = -EFAULT;
+			goto __error;
+		}
 	}
-	return 0;
+ __error:
+	kfree(gctl);
+	return err;
 }
 
 static void snd_emu10k1_ctl_private_free(snd_kcontrol_t *kctl)
@@ -682,52 +696,59 @@
 {
 	unsigned int i, j;
 	emu10k1_fx8010_control_gpr_t __user *_gctl;
-	emu10k1_fx8010_control_gpr_t gctl;
-	snd_emu10k1_fx8010_ctl_t *ctl, nctl;
+	emu10k1_fx8010_control_gpr_t *gctl;
+	snd_emu10k1_fx8010_ctl_t *ctl, *nctl;
 	snd_kcontrol_new_t knew;
 	snd_kcontrol_t *kctl;
 	snd_ctl_elem_value_t *val;
 	int err = 0;
 
 	val = (snd_ctl_elem_value_t *)kmalloc(sizeof(*val), GFP_KERNEL);
-	if (!val)
-		return -ENOMEM;
+	gctl = kmalloc(sizeof(*gctl), GFP_KERNEL);
+	nctl = kmalloc(sizeof(*nctl), GFP_KERNEL);
+	if (!val || !gctl || !nctl) {
+		err = -ENOMEM;
+		goto __error;
+	}
+
 	for (i = 0, _gctl = icode->gpr_add_controls;
 	     i < icode->gpr_add_control_count; i++, _gctl++) {
-		if (copy_from_user(&gctl, _gctl, sizeof(gctl))) {
+		if (copy_from_user(gctl, _gctl, sizeof(*gctl))) {
 			err = -EFAULT;
 			goto __error;
 		}
-		snd_runtime_check(gctl.id.iface == SNDRV_CTL_ELEM_IFACE_MIXER ||
-		                  gctl.id.iface == SNDRV_CTL_ELEM_IFACE_PCM, err = -EINVAL; goto __error);
-		snd_runtime_check(gctl.id.name[0] != '\0', err = -EINVAL; goto __error);
-		ctl = snd_emu10k1_look_for_ctl(emu, &gctl.id);
+		snd_runtime_check(gctl->id.iface == SNDRV_CTL_ELEM_IFACE_MIXER ||
+		                  gctl->id.iface == SNDRV_CTL_ELEM_IFACE_PCM, err = -EINVAL; goto __error);
+		snd_runtime_check(gctl->id.name[0] != '\0', err = -EINVAL; goto __error);
+		ctl = snd_emu10k1_look_for_ctl(emu, &gctl->id);
 		memset(&knew, 0, sizeof(knew));
-		knew.iface = gctl.id.iface;
-		knew.name = gctl.id.name;
-		knew.index = gctl.id.index;
-		knew.device = gctl.id.device;
-		knew.subdevice = gctl.id.subdevice;
+		knew.iface = gctl->id.iface;
+		knew.name = gctl->id.name;
+		knew.index = gctl->id.index;
+		knew.device = gctl->id.device;
+		knew.subdevice = gctl->id.subdevice;
 		knew.info = snd_emu10k1_gpr_ctl_info;
 		knew.get = snd_emu10k1_gpr_ctl_get;
 		knew.put = snd_emu10k1_gpr_ctl_put;
-		memset(&nctl, 0, sizeof(nctl));
-		nctl.vcount = gctl.vcount;
-		nctl.count = gctl.count;
+		memset(nctl, 0, sizeof(*nctl));
+		nctl->vcount = gctl->vcount;
+		nctl->count = gctl->count;
 		for (j = 0; j < 32; j++) {
-			nctl.gpr[j] = gctl.gpr[j];
-			nctl.value[j] = ~gctl.value[j];	/* inverted, we want to write new value in gpr_ctl_put() */
-			val->value.integer.value[j] = gctl.value[j];
-		}
-		nctl.min = gctl.min;
-		nctl.max = gctl.max;
-		nctl.translation = gctl.translation;
+			nctl->gpr[j] = gctl->gpr[j];
+			nctl->value[j] = ~gctl->value[j];	/* inverted, we want to write new value in gpr_ctl_put() */
+			val->value.integer.value[j] = gctl->value[j];
+		}
+		nctl->min = gctl->min;
+		nctl->max = gctl->max;
+		nctl->translation = gctl->translation;
 		if (ctl == NULL) {
 			ctl = (snd_emu10k1_fx8010_ctl_t *)kmalloc(sizeof(*ctl), GFP_KERNEL);
-			if (ctl == NULL)
-				continue;
+			if (ctl == NULL) {
+				err = -ENOMEM;
+				goto __error;
+			}
 			knew.private_value = (unsigned long)ctl;
-			memcpy(ctl, &nctl, sizeof(nctl));
+			*ctl = *nctl;
 			if ((err = snd_ctl_add(emu->card, kctl = snd_ctl_new1(&knew, emu))) < 0) {
 				kfree(ctl);
 				goto __error;
@@ -737,15 +758,17 @@
 			list_add_tail(&ctl->list, &emu->fx8010.gpr_ctl);
 		} else {
 			/* overwrite */
-			nctl.list = ctl->list;
-			nctl.kcontrol = ctl->kcontrol;
-			memcpy(ctl, &nctl, sizeof(nctl));
+			nctl->list = ctl->list;
+			nctl->kcontrol = ctl->kcontrol;
+			*ctl = *nctl;
 			snd_ctl_notify(emu->card, SNDRV_CTL_EVENT_MASK_VALUE |
 			                          SNDRV_CTL_EVENT_MASK_INFO, &ctl->kcontrol->id);
 		}
 		snd_emu10k1_gpr_ctl_put(ctl->kcontrol, val);
 	}
       __error:
+	kfree(nctl);
+	kfree(gctl);
 	kfree(val);
 	return err;
 }
@@ -774,40 +797,47 @@
 {
 	unsigned int i = 0, j;
 	unsigned int total = 0;
-	emu10k1_fx8010_control_gpr_t gctl;
+	emu10k1_fx8010_control_gpr_t *gctl;
 	emu10k1_fx8010_control_gpr_t __user *_gctl;
 	snd_emu10k1_fx8010_ctl_t *ctl;
 	snd_ctl_elem_id_t *id;
 	struct list_head *list;
 
+	gctl = kmalloc(sizeof(*gctl), GFP_KERNEL);
+	if (! gctl)
+		return -ENOMEM;
+
 	_gctl = icode->gpr_list_controls;	
 	list_for_each(list, &emu->fx8010.gpr_ctl) {
 		ctl = emu10k1_gpr_ctl(list);
 		total++;
 		if (_gctl && i < icode->gpr_list_control_count) {
-			memset(&gctl, 0, sizeof(gctl));
+			memset(gctl, 0, sizeof(*gctl));
 			id = &ctl->kcontrol->id;
-			gctl.id.iface = id->iface;
-			strlcpy(gctl.id.name, id->name, sizeof(gctl.id.name));
-			gctl.id.index = id->index;
-			gctl.id.device = id->device;
-			gctl.id.subdevice = id->subdevice;
-			gctl.vcount = ctl->vcount;
-			gctl.count = ctl->count;
+			gctl->id.iface = id->iface;
+			strlcpy(gctl->id.name, id->name, sizeof(gctl->id.name));
+			gctl->id.index = id->index;
+			gctl->id.device = id->device;
+			gctl->id.subdevice = id->subdevice;
+			gctl->vcount = ctl->vcount;
+			gctl->count = ctl->count;
 			for (j = 0; j < 32; j++) {
-				gctl.gpr[j] = ctl->gpr[j];
-				gctl.value[j] = ctl->value[j];
+				gctl->gpr[j] = ctl->gpr[j];
+				gctl->value[j] = ctl->value[j];
 			}
-			gctl.min = ctl->min;
-			gctl.max = ctl->max;
-			gctl.translation = ctl->translation;
-			if (copy_to_user(_gctl, &gctl, sizeof(gctl)))
+			gctl->min = ctl->min;
+			gctl->max = ctl->max;
+			gctl->translation = ctl->translation;
+			if (copy_to_user(_gctl, gctl, sizeof(*gctl))) {
+				kfree(gctl);
 				return -EFAULT;
+			}
 			_gctl++;
 			i++;
 		}
 	}
 	icode->gpr_list_control_total = total;
+	kfree(gctl);
 	return 0;
 }
 
@@ -1339,6 +1369,7 @@
 	/* A_PUT_STEREO_OUTPUT(A_EXTOUT_FRONT_L, A_EXTOUT_FRONT_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS); */
 
 	/* IEC958 Optical Raw Playback Switch */ 
+	gpr_map[gpr++] = 0;
 	gpr_map[gpr++] = 0x1008;
 	gpr_map[gpr++] = 0xffff0000;
 	for (z = 0; z < 2; z++) {
@@ -1349,7 +1380,14 @@
 		A_SWITCH(icode, &ptr, tmp + 0, tmp + 2, gpr + z);
 		A_SWITCH_NEG(icode, &ptr, tmp + 1, gpr + z);
 		A_SWITCH(icode, &ptr, tmp + 1, playback + SND_EMU10K1_PLAYBACK_CHANNELS + z, tmp + 1);
-		A_OP(icode, &ptr, iACC3, A_EXTOUT(A_EXTOUT_FRONT_L + z), A_GPR(tmp + 0), A_GPR(tmp + 1), A_C_00000000);
+		if ((z==1) && (emu->card_capabilities->spdif_bug)) {
+			/* Due to a SPDIF output bug on some Audigy cards, this code delays the Right channel by 1 sample */
+			snd_printk("Installing spdif_bug patch: %s\n", emu->card_capabilities->name);
+			A_OP(icode, &ptr, iACC3, A_EXTOUT(A_EXTOUT_FRONT_L + z), A_GPR(gpr - 3), A_C_00000000, A_C_00000000);
+			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 3), A_GPR(tmp + 0), A_GPR(tmp + 1), A_C_00000000);
+		} else {
+			A_OP(icode, &ptr, iACC3, A_EXTOUT(A_EXTOUT_FRONT_L + z), A_GPR(tmp + 0), A_GPR(tmp + 1), A_C_00000000);
+		}
 	}
 	snd_emu10k1_init_stereo_onoff_control(controls + nctl++, "IEC958 Optical Raw Playback Switch", gpr, 0);
 	gpr += 2;
Index: alsa-kernel/pci/emu10k1/emumixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumixer.c,v
retrieving revision 1.33
retrieving revision 1.34
diff -u -r1.33 -r1.34
--- alsa-kernel/pci/emu10k1/emumixer.c	17 Mar 2005 16:00:43 -0000	1.33
+++ alsa-kernel/pci/emu10k1/emumixer.c	23 Mar 2005 17:04:17 -0000	1.34
@@ -806,6 +806,7 @@
 		memset(&ac97, 0, sizeof(ac97));
 		ac97.private_data = emu;
 		ac97.private_free = snd_emu10k1_mixer_free_ac97;
+		ac97.scaps = AC97_SCAP_NO_SPDIF;
 		if ((err = snd_ac97_mixer(pbus, &ac97, &emu->ac97)) < 0)
 			return err;
 		if (emu->audigy) {
@@ -923,11 +924,6 @@
 			return -ENOMEM;
 		if ((err = snd_ctl_add(card, kctl)))
 			return err;
-		if ((kctl = ctl_find(card, SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT))) != NULL) {
-			/* already defined by ac97, remove it */
-			/* FIXME: or do we need both controls? */
-			remove_ctl(card, SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT));
-		}
 		if ((kctl = snd_ctl_new1(&snd_emu10k1_spdif_control, emu)) == NULL)
 			return -ENOMEM;
 		if ((err = snd_ctl_add(card, kctl)))
Index: alsa-kernel/pci/emu10k1/emupcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
retrieving revision 1.45
retrieving revision 1.46
diff -u -r1.45 -r1.46
--- alsa-kernel/pci/emu10k1/emupcm.c	13 Mar 2005 08:55:50 -0000	1.45
+++ alsa-kernel/pci/emu10k1/emupcm.c	23 Mar 2005 17:01:31 -0000	1.46
@@ -275,11 +275,11 @@
 				       int master, int extra,
 				       emu10k1_voice_t *evoice,
 				       unsigned int start_addr,
-				       unsigned int end_addr)
+				       unsigned int end_addr,
+				       emu10k1_pcm_mixer_t *mix)
 {
 	snd_pcm_substream_t *substream = evoice->epcm->substream;
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	emu10k1_pcm_mixer_t *mix;
 	unsigned int silent_page, tmp;
 	int voice, stereo, w_16;
 	unsigned char attn, send_amount[8];
@@ -289,11 +289,6 @@
 	unsigned int ccis;
 
 	voice = evoice->number;
-	if (evoice->epcm->type == PLAYBACK_EFX) 
-		mix = &emu->efx_pcm_mixer[voice - evoice->epcm->voices[0]->number];
-	else
-		mix = &emu->pcm_mixer[substream->number];
-
 	stereo = runtime->channels == 2;
 	w_16 = snd_pcm_format_width(runtime->format) == 16;
 
@@ -497,14 +492,16 @@
 	}
 	end_addr += start_addr;
 	snd_emu10k1_pcm_init_voice(emu, 1, 1, epcm->extra,
-				   start_addr, end_addr);
+				   start_addr, end_addr, NULL);
 	start_addr = epcm->start_addr;
 	end_addr = epcm->start_addr + snd_pcm_lib_buffer_bytes(substream);
 	snd_emu10k1_pcm_init_voice(emu, 1, 0, epcm->voices[0],
-				   start_addr, end_addr);
+				   start_addr, end_addr,
+				   &emu->pcm_mixer[substream->number]);
 	if (epcm->voices[1])
 		snd_emu10k1_pcm_init_voice(emu, 0, 0, epcm->voices[1],
-					   start_addr, end_addr);
+					   start_addr, end_addr,
+					   &emu->pcm_mixer[substream->number]);
 	return 0;
 }
 
@@ -526,16 +523,18 @@
 	channel_size = ( end_addr - start_addr ) / NUM_EFX_PLAYBACK;
 
 	snd_emu10k1_pcm_init_voice(emu, 1, 1, epcm->extra,
-				   start_addr, start_addr + (channel_size / 2));
+				   start_addr, start_addr + (channel_size / 2), NULL);
 
 	/* only difference with the master voice is we use it for the pointer */
 	snd_emu10k1_pcm_init_voice(emu, 1, 0, epcm->voices[0],
-				   start_addr, start_addr + channel_size);
+				   start_addr, start_addr + channel_size,
+				   &emu->efx_pcm_mixer[0]);
 
 	start_addr += channel_size;
 	for (i = 1; i < NUM_EFX_PLAYBACK; i++) {
 		snd_emu10k1_pcm_init_voice(emu, 0, 0, epcm->voices[i],
-					   start_addr, start_addr+channel_size);
+					   start_addr, start_addr + channel_size,
+					   &emu->efx_pcm_mixer[i]);
 		start_addr += channel_size;
 	}
 
@@ -654,12 +653,13 @@
 	}
 }
 
-static void snd_emu10k1_playback_prepare_voice(emu10k1_t *emu, emu10k1_voice_t *evoice, int master, int extra)
+static void snd_emu10k1_playback_prepare_voice(emu10k1_t *emu, emu10k1_voice_t *evoice,
+					       int master, int extra,
+					       emu10k1_pcm_mixer_t *mix)
 {
 	snd_pcm_substream_t *substream;
 	snd_pcm_runtime_t *runtime;
-	emu10k1_pcm_mixer_t *mix;
-	unsigned int attn;
+	unsigned int attn, vattn;
 	unsigned int voice, tmp;
 
 	if (evoice == NULL)	/* skip second voice for mono */
@@ -668,15 +668,12 @@
 	runtime = substream->runtime;
 	voice = evoice->number;
 
-	mix = evoice->epcm->type == PLAYBACK_EFX
-		? &emu->efx_pcm_mixer[voice - evoice->epcm->voices[0]->number]
-		: &emu->pcm_mixer[substream->number];
-
 	attn = extra ? 0 : 0x00ff;
 	tmp = runtime->channels == 2 ? (master ? 1 : 2) : 0;
+	vattn = mix != NULL ? (mix->attn[tmp] << 16) : 0;
 	snd_emu10k1_ptr_write(emu, IFATN, voice, attn);
-	snd_emu10k1_ptr_write(emu, VTFT, voice, (mix->attn[tmp] << 16) | 0xffff);
-	snd_emu10k1_ptr_write(emu, CVCF, voice, (mix->attn[tmp] << 16) | 0xffff);
+	snd_emu10k1_ptr_write(emu, VTFT, voice, vattn | 0xffff);
+	snd_emu10k1_ptr_write(emu, CVCF, voice, vattn | 0xffff);
 	snd_emu10k1_ptr_write(emu, DCYSUSV, voice, 0x7f7f);
 	snd_emu10k1_voice_clear_loop_stop(emu, voice);
 }	
@@ -725,7 +722,9 @@
 	emu10k1_t *emu = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	emu10k1_pcm_t *epcm = runtime->private_data;
+	emu10k1_pcm_mixer_t *mix;
 	int result = 0;
+
 	// printk("trigger - emu10k1 = 0x%x, cmd = %i, pointer = %i\n", (int)emu, cmd, substream->ops->pointer(substream));
 	spin_lock(&emu->reg_lock);
 	switch (cmd) {
@@ -734,9 +733,10 @@
 		snd_emu10k1_playback_invalidate_cache(emu, 0, epcm->voices[0]);
 		/* follow thru */
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		snd_emu10k1_playback_prepare_voice(emu, epcm->voices[0], 1, 0);
-		snd_emu10k1_playback_prepare_voice(emu, epcm->voices[1], 0, 0);
-		snd_emu10k1_playback_prepare_voice(emu, epcm->extra, 1, 1);
+		mix = &emu->pcm_mixer[substream->number];
+		snd_emu10k1_playback_prepare_voice(emu, epcm->voices[0], 1, 0, mix);
+		snd_emu10k1_playback_prepare_voice(emu, epcm->voices[1], 0, 0, mix);
+		snd_emu10k1_playback_prepare_voice(emu, epcm->extra, 1, 1, NULL);
 		snd_emu10k1_playback_trigger_voice(emu, epcm->voices[0], 1, 0);
 		snd_emu10k1_playback_trigger_voice(emu, epcm->voices[1], 0, 0);
 		snd_emu10k1_playback_trigger_voice(emu, epcm->extra, 1, 1);
@@ -851,7 +851,7 @@
 	emu10k1_t *emu = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	emu10k1_pcm_t *epcm = runtime->private_data;
-	int i = 0;
+	int i;
 	int result = 0;
 
 	spin_lock(&emu->reg_lock);
@@ -865,16 +865,16 @@
 
 		/* follow thru */
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		snd_emu10k1_playback_prepare_voice(emu, epcm->voices[0], 0, 0);
-		snd_emu10k1_playback_prepare_voice(emu, epcm->extra, 1, 1);
-		for (i = 1; i < NUM_EFX_PLAYBACK; i++) {	
-			snd_emu10k1_playback_prepare_voice(emu, epcm->voices[i], 0, 0);
-		}
+		snd_emu10k1_playback_prepare_voice(emu, epcm->extra, 1, 1, NULL);
+		snd_emu10k1_playback_prepare_voice(emu, epcm->voices[0], 0, 0,
+						   &emu->efx_pcm_mixer[0]);
+		for (i = 1; i < NUM_EFX_PLAYBACK; i++)
+			snd_emu10k1_playback_prepare_voice(emu, epcm->voices[i], 0, 0,
+							   &emu->efx_pcm_mixer[i]);
 		snd_emu10k1_playback_trigger_voice(emu, epcm->voices[0], 0, 0);
 		snd_emu10k1_playback_trigger_voice(emu, epcm->extra, 1, 1);
-		for (i = 1; i < NUM_EFX_PLAYBACK; i++) {	
+		for (i = 1; i < NUM_EFX_PLAYBACK; i++)
 			snd_emu10k1_playback_trigger_voice(emu, epcm->voices[i], 0, 0);
-		}
 		epcm->running = 1;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
Index: alsa-kernel/pci/emu10k1/voice.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/voice.c,v
retrieving revision 1.8
retrieving revision 1.9
diff -u -r1.8 -r1.9
--- alsa-kernel/pci/emu10k1/voice.c	13 Mar 2005 08:53:53 -0000	1.8
+++ alsa-kernel/pci/emu10k1/voice.c	23 Mar 2005 17:01:31 -0000	1.9
@@ -62,15 +62,13 @@
 			continue;
 		}
 			
-		/* make sure the block of voices does not cross the 32 voice boundary */
-		//if (((i % 32) + number) > 32)
-		//	continue;
-
 		skip = 0;
 		for (k = 0; k < number; k++) {
 			voice = &emu->voices[(i+k) % NUM_G];
-			if (voice->use)
+			if (voice->use) {
 				skip = 1;
+				break;
+			}
 		}
 		if (!skip) {
 			// printk("allocated voice %d\n", i);




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
