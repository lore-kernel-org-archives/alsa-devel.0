From: Itay Ben-Yaacov <nib_maps@yahoo.com>
Subject: Re: intel8x0 resume problems --now  in 1.0.0pre2 and pre3
Date: Mon, 1 Dec 2003 03:52:33 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031201115233.64619.qmail@web21005.mail.yahoo.com>
References: <s5hbrqsbwl5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrqsbwl5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> could you run diff between these two versions?

I ran 
cvs -z3 -d ':pserver:anonymous@cvs.alsa-project.org:/cvsroot/alsa'  diff -u -D 11/20/2003 -D
11/21/2003
On the alsa-kernel tree:



Index: Documentation/DocBook/writing-an-alsa-driver.tmpl
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl,v
retrieving revision 1.15
retrieving revision 1.16
diff -u -r1.15 -r1.16
--- Documentation/DocBook/writing-an-alsa-driver.tmpl	20 Oct 2003 15:26:16 -0000	1.15
+++ Documentation/DocBook/writing-an-alsa-driver.tmpl	20 Nov 2003 13:22:19 -0000	1.16
@@ -1295,7 +1295,7 @@
                   printk(KERN_ERR "error to set 28bit mask DMA\n");
                   return -ENXIO;
           }
-          pci_set_dma_mask(pci, 0x0fffffff);
+          pci_set_consistent_dma_mask(pci, 0x0fffffff);
 
           chip = snd_magic_kcalloc(mychip_t, 0, GFP_KERNEL);
           if (chip == NULL)
@@ -1413,7 +1413,7 @@
           printk(KERN_ERR "error to set 28bit mask DMA\n");
           return -ENXIO;
   }
-  pci_set_dma_mask(pci, 0x0fffffff);
+  pci_set_consistent_dma_mask(pci, 0x0fffffff);
 ]]>
           </programlisting>
         </informalexample>
Index: core/memalloc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/memalloc.c,v
retrieving revision 1.17
retrieving revision 1.18
diff -u -r1.17 -r1.18
--- core/memalloc.c	9 Oct 2003 10:21:44 -0000	1.17
+++ core/memalloc.c	20 Nov 2003 13:22:19 -0000	1.18
@@ -95,25 +95,25 @@
 {
 	void *ret;
 	u64 dma_mask;
-	unsigned long rmask;
+	unsigned long mask;
 
 	if (hwdev == NULL)
 		return pci_alloc_consistent(hwdev, size, dma_handle);
-	dma_mask = hwdev->dma_mask;
-	rmask = ~((unsigned long)dma_mask);
-	hwdev->dma_mask = 0xffffffff; /* do without masking */
+	dma_mask = hwdev->consistent_dma_mask;
+	mask = (unsigned long)dma_mask;
+	hwdev->consistent_dma_mask = 0xffffffff; /* do without masking */
 	ret = pci_alloc_consistent(hwdev, size, dma_handle);
-	hwdev->dma_mask = dma_mask; /* restore */
+	hwdev->consistent_dma_mask = dma_mask; /* restore */
 	if (ret) {
 		/* obtained address is out of range? */
-		if (((unsigned long)*dma_handle + size - 1) & rmask) {
+		if (((unsigned long)*dma_handle + size - 1) & ~mask) {
 			/* reallocate with the proper mask */
 			pci_free_consistent(hwdev, size, ret, *dma_handle);
 			ret = pci_alloc_consistent(hwdev, size, dma_handle);
 		}
 	} else {
 		/* wish to success now with the proper mask... */
-		if (dma_mask != 0xffffffff)
+		if (mask != 0xffffffffUL)
 			ret = pci_alloc_consistent(hwdev, size, dma_handle);
 	}
 	return ret;
@@ -640,13 +640,13 @@
 {
 	void *ptr;
 	dma_addr_t addr;
-	unsigned long rmask;
+	unsigned long mask;
 
-	rmask = ~(unsigned long)(pci ? pci->dma_mask : 0x00ffffff);
+	mask = pci ? (unsigned long)pci->consistent_dma_mask : 0x00ffffffUL;
 	ptr = (void *)__get_free_page(GFP_KERNEL);
 	if (ptr) {
 		addr = virt_to_phys(ptr);
-		if (((unsigned long)addr + PAGE_SIZE - 1) & rmask) {
+		if (((unsigned long)addr + PAGE_SIZE - 1) & ~mask) {
 			/* try to reallocate with the GFP_DMA */
 			free_page((unsigned long)ptr);
 			/* use GFP_ATOMIC for the DMA zone to avoid stall */
@@ -833,7 +833,7 @@
 			if (! enable[card++])
 				continue;
 			
-			if (pci_set_dma_mask(pci, dev->dma_mask) < 0) {
+			if (pci_set_consistent_dma_mask(pci, dev->dma_mask) < 0) {
 				printk(KERN_ERR "snd-page-alloc: cannot set DMA mask %lx for pci %04x:%04x\n", dev->dma_mask,
dev->vendor, dev->device);
 				continue;
 			}
Index: include/ac97_codec.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/ac97_codec.h,v
retrieving revision 1.36
retrieving revision 1.37
diff -u -r1.36 -r1.37
--- include/ac97_codec.h	18 Nov 2003 11:38:40 -0000	1.36
+++ include/ac97_codec.h	20 Nov 2003 15:59:32 -0000	1.37
@@ -479,7 +479,7 @@
 
 int snd_ac97_pcm_assign(ac97_bus_t *ac97,
 			unsigned short pcms_count,
-			struct ac97_pcm *pcms);
+			const struct ac97_pcm *pcms);
 int snd_ac97_pcm_open(struct ac97_pcm *pcm, unsigned int rate,
 		      enum ac97_pcm_cfg cfg, unsigned short slots);
 int snd_ac97_pcm_close(struct ac97_pcm *pcm);
Index: pci/als4000.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/als4000.c,v
retrieving revision 1.24
retrieving revision 1.25
diff -u -r1.24 -r1.25
--- pci/als4000.c	28 Oct 2003 11:28:01 -0000	1.24
+++ pci/als4000.c	20 Nov 2003 13:22:19 -0000	1.25
@@ -625,7 +625,7 @@
 		snd_printk("architecture does not support 24bit PCI busmaster DMA\n");
 		return -ENXIO;
 	}
-	pci_set_dma_mask(pci, 0x00ffffff);
+	pci_set_consistent_dma_mask(pci, 0x00ffffff);
 
 	gcr = pci_resource_start(pci, 0);
 	if ((res_gcr_port = request_region(gcr, 0x40, "ALS4000")) == NULL) {
Index: pci/azt3328.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/azt3328.c,v
retrieving revision 1.6
retrieving revision 1.7
diff -u -r1.6 -r1.7
--- pci/azt3328.c	28 Oct 2003 11:28:01 -0000	1.6
+++ pci/azt3328.c	20 Nov 2003 13:22:19 -0000	1.7
@@ -1365,7 +1365,7 @@
 		snd_printk("architecture does not support 24bit PCI busmaster DMA\n");
 		return -ENXIO;
 	}
-	pci_set_dma_mask(pci, 0x00ffffff);
+	pci_set_consistent_dma_mask(pci, 0x00ffffff);
 
 	chip->codec_port = pci_resource_start(pci, 0);
 	if ((chip->res_codec_port = request_region(chip->codec_port, 0x80, "Aztech AZF3328 I/O")) ==
NULL) {
Index: pci/es1938.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/es1938.c,v
retrieving revision 1.27
retrieving revision 1.28
diff -u -r1.27 -r1.28
--- pci/es1938.c	14 Aug 2003 11:05:38 -0000	1.27
+++ pci/es1938.c	20 Nov 2003 13:22:19 -0000	1.28
@@ -1402,7 +1402,7 @@
                 snd_printk("architecture does not support 24bit PCI busmaster DMA\n");
                 return -ENXIO;
         }
-	pci_set_dma_mask(pci, 0x00ffffff);
+	pci_set_consistent_dma_mask(pci, 0x00ffffff);
 
 	chip = snd_magic_kcalloc(es1938_t, 0, GFP_KERNEL);
 	if (chip == NULL)
Index: pci/es1968.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/es1968.c,v
retrieving revision 1.56
retrieving revision 1.57
diff -u -r1.56 -r1.57
--- pci/es1968.c	24 Oct 2003 13:44:20 -0000	1.56
+++ pci/es1968.c	20 Nov 2003 13:22:19 -0000	1.57
@@ -2567,7 +2567,7 @@
 		snd_printk("architecture does not support 28bit PCI busmaster DMA\n");
 		return -ENXIO;
 	}
-	pci_set_dma_mask(pci, 0x0fffffff);
+	pci_set_consistent_dma_mask(pci, 0x0fffffff);
 
 	chip = (es1968_t *) snd_magic_kcalloc(es1968_t, 0, GFP_KERNEL);
 	if (! chip)
Index: pci/intel8x0.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0.c,v
retrieving revision 1.97
retrieving revision 1.98
diff -u -r1.97 -r1.98
--- pci/intel8x0.c	18 Nov 2003 11:38:40 -0000	1.97
+++ pci/intel8x0.c	20 Nov 2003 15:59:32 -0000	1.98
@@ -892,8 +892,10 @@
 	err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
 	if (err < 0)
 		return err;
-	if (ichdev->pcm_open_flag)
+	if (ichdev->pcm_open_flag) {
 		snd_ac97_pcm_close(ichdev->pcm);
+		ichdev->pcm_open_flag = 0;
+	}
 	err = snd_ac97_pcm_open(ichdev->pcm, params_rate(hw_params),
 				params_channels(hw_params),
 				ichdev->pcm->r[0].slots);
@@ -906,8 +908,10 @@
 {
 	ichdev_t *ichdev = get_ichdev(substream);
 
-	if (ichdev->pcm_open_flag)
+	if (ichdev->pcm_open_flag) {
 		snd_ac97_pcm_close(ichdev->pcm);
+		ichdev->pcm_open_flag = 0;
+	}
 	return snd_pcm_lib_free_pages(substream);
 }
 
@@ -1765,14 +1769,16 @@
 		goto __err;
 	chip->ac97_bus = pbus;
 	ac97.pci = chip->pci;
-	if ((err = snd_ac97_mixer(pbus, &ac97, &x97)) < 0) {
-	      __err:
-		/* clear the cold-reset bit for the next chance */
-		if (chip->device_type != DEVICE_ALI)
-			iputdword(chip, ICHREG(GLOB_CNT), igetdword(chip, ICHREG(GLOB_CNT)) & ~ICH_AC97COLD);
-		return err;
+	for (i = 0; i < codecs; i++) {
+		ac97.num = i;
+		if ((err = snd_ac97_mixer(pbus, &ac97, &x97)) < 0) {
+			snd_printk(KERN_ERR "Unable to initialize codec #%d\n", i);
+			if (i == 0)
+				goto __err;
+			continue;
+		}
+		chip->ac97[i] = x97;
 	}
-	chip->ac97[0] = x97;
 	/* tune up the primary codec */
 	snd_ac97_tune_hardware(chip->ac97[0], ac97_quirks);
 	/* enable separate SDINs for ICH4 */
@@ -1784,7 +1790,7 @@
 		i -= 2;		/* do not allocate PCM2IN and MIC2 */
 	if (spdif_idx < 0)
 		i--;		/* do not allocate S/PDIF */
-	err = snd_ac97_pcm_assign(pbus, ARRAY_SIZE(ac97_pcm_defs), ac97_pcm_defs);
+	err = snd_ac97_pcm_assign(pbus, i, ac97_pcm_defs);
 	if (err < 0)
 		goto __err;
 	chip->ichd[ICHD_PCMOUT].pcm = &pbus->pcms[0];
@@ -1826,6 +1832,12 @@
 	}
 	chip->in_ac97_init = 0;
 	return 0;
+
+ __err:
+	/* clear the cold-reset bit for the next chance */
+	if (chip->device_type != DEVICE_ALI)
+		iputdword(chip, ICHREG(GLOB_CNT), igetdword(chip, ICHREG(GLOB_CNT)) & ~ICH_AC97COLD);
+	return err;
 }
 
 
Index: pci/maestro3.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/maestro3.c,v
retrieving revision 1.43
retrieving revision 1.44
diff -u -r1.43 -r1.44
--- pci/maestro3.c	23 Oct 2003 14:34:52 -0000	1.43
+++ pci/maestro3.c	20 Nov 2003 13:22:19 -0000	1.44
@@ -2551,7 +2551,7 @@
 		snd_printk("architecture does not support 28bit PCI busmaster DMA\n");
 		return -ENXIO;
 	}
-	pci_set_dma_mask(pci, 0x0fffffff);
+	pci_set_consistent_dma_mask(pci, 0x0fffffff);
 
 	chip = snd_magic_kcalloc(m3_t, 0, GFP_KERNEL);
 	if (chip == NULL)
Index: pci/sonicvibes.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/sonicvibes.c,v
retrieving revision 1.27
retrieving revision 1.28
diff -u -r1.27 -r1.28
--- pci/sonicvibes.c	23 Oct 2003 14:34:52 -0000	1.27
+++ pci/sonicvibes.c	20 Nov 2003 13:22:19 -0000	1.28
@@ -1253,7 +1253,7 @@
                 snd_printk("architecture does not support 24bit PCI busmaster DMA\n");
                 return -ENXIO;
         }
-	pci_set_dma_mask(pci, 0x00ffffff);
+	pci_set_consistent_dma_mask(pci, 0x00ffffff);
 
 	sonic = snd_magic_kcalloc(sonicvibes_t, 0, GFP_KERNEL);
 	if (sonic == NULL)
Index: pci/ac97/ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.113
retrieving revision 1.114
diff -u -r1.113 -r1.114
--- pci/ac97/ac97_codec.c	18 Nov 2003 11:38:40 -0000	1.113
+++ pci/ac97/ac97_codec.c	20 Nov 2003 16:00:01 -0000	1.114
@@ -112,7 +112,8 @@
 { 0x414c4721, 0xfffffff0, "ALC650D",		patch_alc650,	NULL },
 { 0x414c4722, 0xfffffff0, "ALC650E",		patch_alc650,	NULL },
 { 0x414c4723, 0xfffffff0, "ALC650F",		patch_alc650,	NULL },
-{ 0x414c4760, 0xfffffff0, "ALC655",		patch_alc650,	NULL },
+{ 0x414c4760, 0xfffffff0, "ALC655",		patch_alc655,	NULL },
+{ 0x414c4780, 0xfffffff0, "ALC658",		patch_alc655,	NULL },
 { 0x414c4730, 0xffffffff, "ALC101",		NULL,		NULL },
 { 0x414c4740, 0xfffffff0, "ALC202",		NULL,		NULL },
 { 0x414c4750, 0xfffffff0, "ALC250",		NULL,		NULL },
@@ -1985,9 +1986,9 @@
 	snd_ac97_write(ac97, AC97_GENERAL_PURPOSE, 0);
 
 	snd_ac97_write(ac97, AC97_POWERDOWN, ac97->regs[AC97_POWERDOWN]);
-	snd_ac97_write(ac97, AC97_MASTER, 0x8000);
+	snd_ac97_write(ac97, AC97_MASTER, 0x8101);
 	for (i = 0; i < 10; i++) {
-		if (snd_ac97_read(ac97, AC97_MASTER) == 0x8000)
+		if (snd_ac97_read(ac97, AC97_MASTER) == 0x8101)
 			break;
 		mdelay(1);
 	}
@@ -1996,7 +1997,7 @@
 	if (ac97->bus->init)
 		ac97->bus->init(ac97);
 
-	is_ad18xx = (ac97->id & 0xffffff40) == AC97_ID_AD1881;
+	is_ad18xx = (ac97->flags & AC97_AD_MULTI);
 	if (is_ad18xx) {
 		/* restore the AD18xx codec configurations */
 		for (codec = 0; codec < 3; codec++) {
Index: pci/ac97/ac97_patch.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
retrieving revision 1.30
retrieving revision 1.31
diff -u -r1.30 -r1.31
--- pci/ac97/ac97_patch.c	3 Nov 2003 16:35:49 -0000	1.30
+++ pci/ac97/ac97_patch.c	20 Nov 2003 16:00:02 -0000	1.31
@@ -983,6 +983,8 @@
 	/* 7: Independent Master Volume Left */
 	/* 8: reserved */
 	AC97_SINGLE("Line-In As Surround", AC97_ALC650_MULTICH, 9, 1, 0),
+	/* 10: mic, see below */
+	/* 11-13: in IEC958 controls */
 	AC97_SINGLE("Swap Surround Slot", AC97_ALC650_MULTICH, 14, 1, 0),
 #if 0 /* always set in patch_alc650 */
 	AC97_SINGLE("IEC958 Input Clock Enable", AC97_ALC650_CLOCK, 0, 1, 0),
@@ -1102,6 +1104,98 @@
 			val = val | 0x100;
 		snd_ac97_write_cache(ac97, AC97_ALC650_GPIO_STATUS, val);
 	}
+
+	/* full DAC volume */
+	snd_ac97_write_cache(ac97, AC97_ALC650_SURR_DAC_VOL, 0x0808);
+	snd_ac97_write_cache(ac97, AC97_ALC650_LFE_DAC_VOL, 0x0808);
+	return 0;
+}
+
+static const snd_kcontrol_new_t snd_ac97_controls_alc655[] = {
+	AC97_SINGLE("Duplicate Front", AC97_ALC650_MULTICH, 0, 1, 0),
+	AC97_SINGLE("Line-In As Surround", AC97_ALC650_MULTICH, 9, 1, 0),
+	AC97_SINGLE("Mic As Center/LFE", AC97_ALC650_MULTICH, 10, 1, 0),
+};
+
+static int alc655_iec958_route_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	static char *texts_655[3] = { "PCM", "Analog In", "IEC958 In" };
+	static char *texts_658[4] = { "PCM", "Analog1 In", "Analog2 In", "IEC958 In" };
+	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = ac97->spec.dev_flags ? 4 : 3;
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
+	strcpy(uinfo->value.enumerated.name,
+	       ac97->spec.dev_flags ?
+	       texts_658[uinfo->value.enumerated.item] :
+	       texts_655[uinfo->value.enumerated.item]);
+	return 0;
+
+}
+
+static int alc655_iec958_route_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	val = ac97->regs[AC97_ALC650_MULTICH];
+	val = (val >> 12) & 3;
+	if (ac97->spec.dev_flags && val == 3)
+		val = 0;
+	ucontrol->value.enumerated.item[0] = val;
+	return 0;
+}
+
+static int alc655_iec958_route_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+	return snd_ac97_update_bits(ac97, AC97_ALC650_MULTICH, 3 << 12,
+				    (unsigned short)ucontrol->value.enumerated.item[0]);
+}
+
+static const snd_kcontrol_new_t snd_ac97_spdif_controls_alc655[] = {
+        AC97_SINGLE("IEC958 Capture Switch", AC97_ALC650_MULTICH, 11, 1, 0),
+        AC97_SINGLE("IEC958 Input Monitor", AC97_ALC650_MULTICH, 14, 1, 0),
+	{
+		.iface  = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name   = "IEC958 Playback Route",
+		.info   = alc655_iec958_route_info,
+		.get    = alc655_iec958_route_get,
+		.put    = alc655_iec958_route_put,
+	},
+};
+
+static int patch_alc655_specific(ac97_t * ac97)
+{
+	int err;
+
+	if ((err = patch_build_controls(ac97, snd_ac97_controls_alc655,
ARRAY_SIZE(snd_ac97_controls_alc655))) < 0)
+		return err;
+	if (ac97->ext_id & AC97_EI_SPDIF) {
+		if ((err = patch_build_controls(ac97, snd_ac97_spdif_controls_alc655,
ARRAY_SIZE(snd_ac97_spdif_controls_alc655))) < 0)
+			return err;
+	}
+	return 0;
+}
+
+static struct snd_ac97_build_ops patch_alc655_ops = {
+	.build_specific	= patch_alc655_specific
+};
+
+int patch_alc655(ac97_t * ac97)
+{
+	ac97->spec.dev_flags = (ac97->id == 0x414c4780); /* ALC658 */
+
+	ac97->build_ops = &patch_alc655_ops;
+
+	/* enable spdif in */
+	snd_ac97_write_cache(ac97, AC97_ALC650_CLOCK,
+			     snd_ac97_read(ac97, AC97_ALC650_MULTICH) | 0x8000);
+	snd_ac97_write_cache(ac97, AC97_ALC650_CLOCK,
+			     snd_ac97_read(ac97, AC97_ALC650_CLOCK) | 0x02);
 
 	/* full DAC volume */
 	snd_ac97_write_cache(ac97, AC97_ALC650_SURR_DAC_VOL, 0x0808);
Index: pci/ac97/ac97_patch.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.h,v
retrieving revision 1.11
retrieving revision 1.12
diff -u -r1.11 -r1.12
--- pci/ac97/ac97_patch.h	3 Nov 2003 10:42:13 -0000	1.11
+++ pci/ac97/ac97_patch.h	20 Nov 2003 16:00:02 -0000	1.12
@@ -46,6 +46,7 @@
 int patch_ad1981b(ac97_t * ac97);
 int patch_ad1985(ac97_t * ac97);
 int patch_alc650(ac97_t * ac97);
+int patch_alc655(ac97_t * ac97);
 int patch_cm9738(ac97_t * ac97);
 int patch_cm9739(ac97_t * ac97);
 int patch_vt1616(ac97_t * ac97);
Index: pci/ac97/ac97_pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_pcm.c,v
retrieving revision 1.2
retrieving revision 1.3
diff -u -r1.2 -r1.3
--- pci/ac97/ac97_pcm.c	18 Nov 2003 13:52:59 -0000	1.2
+++ pci/ac97/ac97_pcm.c	20 Nov 2003 15:59:32 -0000	1.3
@@ -260,7 +260,7 @@
 		unsigned short slots = 0;
 		if (ac97_is_rev22(ac97)) {
 			/* Note: it's simply emulation of AMAP behaviour */
-			u8 es;
+			u16 es;
 			es = ac97->regs[AC97_EXTENDED_STATUS] &= ~AC97_EI_DACS_SLOT_MASK;
 			switch (ac97->addr) {
 			case 1:
@@ -357,11 +357,7 @@
 		case AC97_PCM_MIC_ADC_RATE:	idx = AC97_RATES_MIC_ADC; break;
 		default:			idx = AC97_RATES_SPDIF; break;
 		}
-		if (rates == ~0) {
-			rates = pcm->r[dbl].codec[cidx]->rates[idx];
-		} else {
-			rates &= pcm->r[dbl].codec[cidx]->rates[idx];
-		}
+		rates &= pcm->r[dbl].codec[cidx]->rates[idx];
 	}
 	return rates;
 }
@@ -378,7 +374,7 @@
  */
 int snd_ac97_pcm_assign(ac97_bus_t *bus,
 			unsigned short pcms_count,
-			struct ac97_pcm *pcms)
+			const struct ac97_pcm *pcms)
 {
 	int i, j, k;
 	struct ac97_pcm *pcm, *rpcms, *rpcm;
@@ -389,7 +385,7 @@
 	unsigned int rates;
 	ac97_t *codec;
 
-	rpcms = snd_kcalloc(sizeof(struct ac97_pcm), GFP_KERNEL);
+	rpcms = snd_kcalloc(sizeof(struct ac97_pcm) * pcms_count, GFP_KERNEL);
 	if (rpcms == NULL)
 		return -ENOMEM;
 	memset(avail_slots, 0, sizeof(avail_slots));
@@ -421,6 +417,7 @@
 		rpcm->exclusive = pcm->exclusive;
 		rpcm->private_value = pcm->private_value;
 		rpcm->bus = bus;
+		rpcm->rates = ~0;
 		slots = pcm->r[0].slots;
 		for (j = 0; j < 4 && slots; j++) {
 			rates = ~0;
@@ -448,11 +445,7 @@
 			}
 			slots &= ~tmp;
 			rpcm->r[0].slots |= tmp;
-			if (j == 0) {
-				pcm->rates = rates;
-			} else {
-				pcm->rates &= rates;
-			}
+			rpcm->rates &= rates;
 		}
 	}
 	bus->pcms_count = pcms_count;
Index: pci/ali5451/ali5451.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ali5451/ali5451.c,v
retrieving revision 1.39
retrieving revision 1.40
diff -u -r1.39 -r1.40
--- pci/ali5451/ali5451.c	23 Oct 2003 14:34:53 -0000	1.39
+++ pci/ali5451/ali5451.c	20 Nov 2003 13:22:19 -0000	1.40
@@ -2110,7 +2110,7 @@
 		snd_printk("architecture does not support 31bit PCI busmaster DMA\n");
 		return -ENXIO;
 	}
-	pci_set_dma_mask(pci, 0x7fffffff);
+	pci_set_consistent_dma_mask(pci, 0x7fffffff);
 
 	if ((codec = snd_magic_kcalloc(ali_t, 0, GFP_KERNEL)) == NULL)
 		return -ENOMEM;
Index: pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.26
retrieving revision 1.27
diff -u -r1.26 -r1.27
--- pci/emu10k1/emu10k1_main.c	7 Nov 2003 17:52:01 -0000	1.26
+++ pci/emu10k1/emu10k1_main.c	20 Nov 2003 13:22:20 -0000	1.27
@@ -604,7 +604,7 @@
 		return -ENOMEM;
 	/* set the DMA transfer mask */
 	emu->dma_mask = is_audigy ? AUDIGY_DMA_MASK : EMU10K1_DMA_MASK;
-	if (pci_set_dma_mask(pci, emu->dma_mask) < 0) {
+	if (pci_set_consistent_dma_mask(pci, emu->dma_mask) < 0) {
 		snd_printk(KERN_ERR "architecture does not support PCI busmaster DMA with mask 0x%lx\n",
emu->dma_mask);
 		snd_magic_kfree(emu);
 		return -ENXIO;
Index: pci/ice1712/ice1712.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/ice1712.c,v
retrieving revision 1.36
retrieving revision 1.37
diff -u -r1.36 -r1.37
--- pci/ice1712/ice1712.c	23 Oct 2003 14:34:53 -0000	1.36
+++ pci/ice1712/ice1712.c	20 Nov 2003 13:22:20 -0000	1.37
@@ -2365,7 +2365,7 @@
 		snd_printk("architecture does not support 28bit PCI busmaster DMA\n");
 		return -ENXIO;
 	}
-	pci_set_dma_mask(pci, 0x0fffffff);
+	pci_set_consistent_dma_mask(pci, 0x0fffffff);
 
 	ice = snd_magic_kcalloc(ice1712_t, 0, GFP_KERNEL);
 	if (ice == NULL)
Index: pci/ice1712/ice1724.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/ice1724.c,v
retrieving revision 1.20
retrieving revision 1.21
diff -u -r1.20 -r1.21
--- pci/ice1712/ice1724.c	10 Nov 2003 18:00:50 -0000	1.20
+++ pci/ice1712/ice1724.c	20 Nov 2003 13:22:20 -0000	1.21
@@ -1801,7 +1801,7 @@
         /* enable PCI device */
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	pci_set_dma_mask(pci, 0xffffffff); 
+	pci_set_consistent_dma_mask(pci, 0xffffffff); 
 
 	ice = snd_magic_kcalloc(ice1712_t, 0, GFP_KERNEL);
 	if (ice == NULL)
Index: pci/trident/trident_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/trident/trident_main.c,v
retrieving revision 1.48
retrieving revision 1.49
diff -u -r1.48 -r1.49
--- pci/trident/trident_main.c	23 Oct 2003 14:34:53 -0000	1.48
+++ pci/trident/trident_main.c	20 Nov 2003 13:22:20 -0000	1.49
@@ -3527,7 +3527,7 @@
 		snd_printk("architecture does not support 30bit PCI busmaster DMA\n");
 		return -ENXIO;
 	}
-	pci_set_dma_mask(pci, 0x3fffffff);
+	pci_set_consistent_dma_mask(pci, 0x3fffffff);
 	
 	trident = snd_magic_kcalloc(trident_t, 0, GFP_KERNEL);
 	if (trident == NULL)
@@ -3952,7 +3952,7 @@
 		return;
 
 	pci_enable_device(trident->pci);
-	pci_set_dma_mask(trident->pci, 0x3fffffff); /* to be sure */
+	pci_set_consistent_dma_mask(trident->pci, 0x3fffffff); /* FIXME: correct? */
 	pci_set_master(trident->pci); /* to be sure */
 
 	switch (trident->device) {
Index: usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.69
retrieving revision 1.70
diff -u -r1.69 -r1.70
--- usb/usbaudio.c	13 Nov 2003 12:36:44 -0000	1.69
+++ usb/usbaudio.c	20 Nov 2003 16:08:26 -0000	1.70
@@ -576,6 +576,7 @@
 	int err;
 
 	clear_bit(ctx->index, &subs->active_mask);
+	clear_bit(ctx->index, &subs->unlink_mask);
 	if (subs->running && subs->ops.retire(subs, substream->runtime, urb))
 		return;
 	if (! subs->running) /* can be stopped during retire callback */
@@ -601,6 +602,7 @@
 	int err;
 
 	clear_bit(ctx->index + 16, &subs->active_mask);
+	clear_bit(ctx->index + 16, &subs->unlink_mask);
 	if (subs->running && subs->ops.retire_sync(subs, substream->runtime, urb))
 		return;
 	if (! subs->running) /* can be stopped during retire callback */
@@ -1280,6 +1282,9 @@
 	/* some unit conversions in runtime */
 	subs->maxframesize = bytes_to_frames(runtime, subs->maxpacksize);
 	subs->curframesize = bytes_to_frames(runtime, subs->curpacksize);
+
+	/* deactivate urbs to be sure */
+	deactivate_urbs(subs, 0, 0);
 
 	return 0;
 }


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
