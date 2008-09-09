From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 02/24] sound/pci: coding style fixes: au88x0
Date: Tue, 9 Sep 2008 05:45:58 +0400
Message-ID: <20080909014558.GF6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id DCA352447A
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:46:07 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1534318fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:46:07 -0700 (PDT)
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



- <asm/io.h> -> <linux/io.h>
- remove trailing whitespaces
- convert comments

Only compile tested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/au88x0/au88x0.c        |   46 ++++----
 sound/pci/au88x0/au88x0.h        |    4 +-
 sound/pci/au88x0/au88x0_a3d.c    |   46 ++++----
 sound/pci/au88x0/au88x0_core.c   |  254 +++++++++++++++++++-------------------
 sound/pci/au88x0/au88x0_eq.c     |   24 ++--
 sound/pci/au88x0/au88x0_mixer.c  |    2 +-
 sound/pci/au88x0/au88x0_mpu401.c |    2 +-
 sound/pci/au88x0/au88x0_pcm.c    |   46 ++++----
 sound/pci/au88x0/au88x0_synth.c  |   46 ++++----
 sound/pci/au88x0/au88x0_xtalk.c  |   26 ++--
 sound/pci/au88x0/au88x0_xtalk.h  |    2 +-
 11 files changed, 249 insertions(+), 249 deletions(-)

diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index 68368e4..440be0b 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -125,7 +125,7 @@ static int snd_vortex_dev_free(struct snd_device *device)
 
 	vortex_gameport_unregister(vortex);
 	vortex_core_shutdown(vortex);
-	// Take down PCI interface.
+	/* Take down PCI interface. */
 	free_irq(vortex->irq, vortex);
 	iounmap(vortex->mmio);
 	pci_release_regions(vortex->pci_dev);
@@ -148,7 +148,7 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 
 	*rchip = NULL;
 
-	// check PCI availability (DMA).
+	/* check PCI availability (DMA). */
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0 ||
@@ -166,7 +166,7 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 
 	chip->card = card;
 
-	// initialize the stuff
+	/* initialize the stuff */
 	chip->pci_dev = pci;
 	chip->io = pci_resource_start(pci, 0);
 	chip->vendor = pci->vendor;
@@ -174,8 +174,8 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 	chip->card = card;
 	chip->irq = -1;
 
-	// (1) PCI resource allocation
-	// Get MMIO area
+	/* (1) PCI resource allocation */
+	/* Get MMIO area */
 	//
 	if ((err = pci_request_regions(pci, CARD_NAME_SHORT)) != 0)
 		goto regions_out;
@@ -205,9 +205,9 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 	chip->irq = pci->irq;
 
 	pci_set_master(pci);
-	// End of PCI setup.
+	/* End of PCI setup. */
 
-	// Register alsa root device.
+	/* Register alsa root device. */
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
 		goto alloc_out;
 	}
@@ -228,7 +228,7 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 	pci_release_regions(chip->pci_dev);
       regions_out:
 	pci_disable_device(chip->pci_dev);
-	//FIXME: this not the right place to unregister the gameport
+	/* FIXME: this not the right place to unregister the gameport */
 	vortex_gameport_unregister(chip);
 	kfree(chip);
 	return err;
@@ -243,64 +243,64 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	vortex_t *chip;
 	int err;
 
-	// (1)
+	/* (1) */
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 	if (!enable[dev]) {
 		dev++;
 		return -ENOENT;
 	}
-	// (2)
+	/* (2) */
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
 	if (card == NULL)
 		return -ENOMEM;
 
-	// (3)
+	/* (3) */
 	if ((err = snd_vortex_create(card, pci, &chip)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
 	snd_vortex_workaround(pci, pcifix[dev]);
 
-	// Card details needed in snd_vortex_midi
+	/* Card details needed in snd_vortex_midi */
 	strcpy(card->driver, CARD_NAME_SHORT);
 	sprintf(card->shortname, "Aureal Vortex %s", CARD_NAME_SHORT);
 	sprintf(card->longname, "%s at 0x%lx irq %i",
 		card->shortname, chip->io, chip->irq);
 
-	// (4) Alloc components.
-	// ADB pcm.
+	/* (4) Alloc components. */
+	/* ADB pcm. */
 	if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_ADB, NR_ADB)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
 #ifndef CHIP_AU8820
-	// ADB SPDIF
+	/* ADB SPDIF */
 	if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_SPDIF, 1)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	// A3D
+	/* A3D */
 	if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_A3D, NR_A3D)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
 #endif
 	/*
-	   // ADB I2S
+	   //ADB I2S
 	   if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_I2S, 1)) < 0) {
 	   snd_card_free(card);
 	   return err;
 	   }
 	 */
 #ifndef CHIP_AU8810
-	// WT pcm.
+	/* WT pcm. */
 	if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_WT, NR_WT)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
 #endif
-	// snd_ac97_mixer and Vortex mixer.
+	/* snd_ac97_mixer and Vortex mixer. */
 	if ((err = snd_vortex_mixer(chip)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -329,12 +329,12 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	}
 #endif
 
-	// (5)
+	/* (5) */
 	if ((err = pci_read_config_word(pci, PCI_DEVICE_ID,
 				  &(chip->device))) < 0) {
 		snd_card_free(card);
 		return err;
-	}	
+	}
 	if ((err = pci_read_config_word(pci, PCI_VENDOR_ID,
 				  &(chip->vendor))) < 0) {
 		snd_card_free(card);
@@ -354,12 +354,12 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	}
 #endif
 
-	// (6)
+	/* (6) */
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	// (7)
+	/* (7) */
 	pci_set_drvdata(pci, card);
 	dev++;
 	vortex_connect_default(chip, 1);
diff --git a/sound/pci/au88x0/au88x0.h b/sound/pci/au88x0/au88x0.h
index cf46bba..02e949d 100644
--- a/sound/pci/au88x0/au88x0.h
+++ b/sound/pci/au88x0/au88x0.h
@@ -13,13 +13,13 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
- 
+
 #ifndef __SOUND_AU88X0_H
 #define __SOUND_AU88X0_H
 
 #ifdef __KERNEL__
 #include <linux/pci.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/rawmidi.h>
diff --git a/sound/pci/au88x0/au88x0_a3d.c b/sound/pci/au88x0/au88x0_a3d.c
index 649849e..526fb5f 100644
--- a/sound/pci/au88x0/au88x0_a3d.c
+++ b/sound/pci/au88x0/au88x0_a3d.c
@@ -49,7 +49,7 @@ static void
 a3dsrc_GetTimeConsts(a3dsrc_t * a, short *HrtfTrack, short *ItdTrack,
 		     short *GTrack, short *CTrack)
 {
-	// stub!
+	/* stub! */
 }
 
 #endif
@@ -219,7 +219,7 @@ static void a3dsrc_GetHrtfState(a3dsrc_t * a, a3d_Hrtf_t aa, a3d_Hrtf_t b)
 {
 	vortex_t *vortex = (vortex_t *) (a->vortex);
 	int i;
-	// FIXME: verify this!
+	/* FIXME: verify this! */
 	for (i = 0; i < HRTF_SZ; i++)
 		aa[i] =
 		    hwread(vortex->mmio,
@@ -245,10 +245,10 @@ static void a3dsrc_GetHrtfOutput(a3dsrc_t * a, short *left, short *right)
 
 #endif
 
-/* Interaural Time Difference. 
- * "The other main clue that humans use to locate sounds, is called 
- * Interaural Time Difference (ITD). The differences in distance from 
- * the sound source to a listeners ears means  that the sound will 
+/* Interaural Time Difference.
+ * "The other main clue that humans use to locate sounds, is called
+ * Interaural Time Difference (ITD). The differences in distance from
+ * the sound source to a listeners ears means  that the sound will
  * reach one ear slightly before the other....", found somewhere with google.*/
 static void a3dsrc_SetItdTarget(a3dsrc_t * a, short litd, short ritd)
 {
@@ -265,7 +265,7 @@ static void a3dsrc_SetItdTarget(a3dsrc_t * a, short litd, short ritd)
 	hwwrite(vortex->mmio,
 		a3d_addrB(a->slice, a->source, A3D_B_ITDTarget),
 		(ritd << 0x10) | litd);
-	//hwwrite(vortex->mmio, addr(0x191DF+5, this04, this08), (ritd<<0x10)|litd);
+	/* hwwrite(vortex->mmio, addr(0x191DF+5, this04, this08), (ritd<<0x10)|litd); */
 }
 
 static void a3dsrc_SetItdCurrent(a3dsrc_t * a, short litd, short ritd)
@@ -283,7 +283,7 @@ static void a3dsrc_SetItdCurrent(a3dsrc_t * a, short litd, short ritd)
 	hwwrite(vortex->mmio,
 		a3d_addrB(a->slice, a->source, A3D_B_ITDCurrent),
 		(ritd << 0x10) | litd);
-	//hwwrite(vortex->mmio, addr(0x191DF+1, this04, this08), (ritd<<0x10)|litd);
+	/* hwwrite(vortex->mmio, addr(0x191DF+1, this04, this08), (ritd<<0x10)|litd); */
 }
 
 static void a3dsrc_SetItdDline(a3dsrc_t * a, a3d_ItdDline_t const dline)
@@ -392,7 +392,7 @@ static void a3dsrc_SetA3DSampleRate(a3dsrc_t * a, int sr)
 
 	esp0 = (((esp0 & 0x7fffffff) | 0xB8000000) & 0x7) | ((sr & 0x1f) << 3);
 	hwwrite(vortex->mmio, A3D_SLICE_Control + ((a->slice) << 0xd), esp0);
-	//hwwrite(vortex->mmio, 0x19C38 + (this08<<0xd), esp0);
+	/* hwwrite(vortex->mmio, 0x19C38 + (this08<<0xd), esp0); */
 }
 
 static void a3dsrc_EnableA3D(a3dsrc_t * a)
@@ -400,7 +400,7 @@ static void a3dsrc_EnableA3D(a3dsrc_t * a)
 	vortex_t *vortex = (vortex_t *) (a->vortex);
 	hwwrite(vortex->mmio, A3D_SLICE_Control + ((a->slice) << 0xd),
 		0xF0000001);
-	//hwwrite(vortex->mmio, 0x19C38 + (this08<<0xd), 0xF0000001);
+	/* hwwrite(vortex->mmio, 0x19C38 + (this08<<0xd), 0xF0000001); */
 }
 
 static void a3dsrc_DisableA3D(a3dsrc_t * a)
@@ -428,7 +428,7 @@ static void a3dsrc_GetA3DSampleRate(a3dsrc_t * a, int *sr)
 	vortex_t *vortex = (vortex_t *) (a->vortex);
 	*sr = ((hwread(vortex->mmio, A3D_SLICE_Control + (a->slice << 0xd))
 		>> 3) & 0x1f);
-	//*sr = ((hwread(vortex->mmio, 0x19C38 + (this08<<0xd))>>3)&0x1f);
+	/**sr = ((hwread(vortex->mmio, 0x19C38 + (this08<<0xd))>>3)&0x1f); */
 }
 
 static void a3dsrc_GetA3DControlReg(a3dsrc_t * a, unsigned long *ctrl)
@@ -463,7 +463,7 @@ static void a3dsrc_ZeroSliceIO(a3dsrc_t * a)
 static void a3dsrc_ZeroState(a3dsrc_t * a)
 {
 
-	//printk("vortex: ZeroState slice: %d, source %d\n", a->slice, a->source);
+	/* printk("vortex: ZeroState slice: %d, source %d\n", a->slice, a->source); */
 
 	a3dsrc_SetAtmosState(a, 0, 0, 0, 0);
 	a3dsrc_SetHrtfState(a, A3dHrirZeros, A3dHrirZeros);
@@ -500,7 +500,7 @@ static void a3dsrc_ZeroStateA3D(a3dsrc_t * a)
 	for (i = 0; i < 4; i++) {
 		a->slice = i;
 		a3dsrc_ZeroSliceIO(a);
-		//a3dsrc_ZeroState(a);
+		/* a3dsrc_ZeroState(a); */
 	}
 	a->source = var2;
 	a->slice = var;
@@ -524,8 +524,8 @@ static void a3dsrc_ProgramPipe(a3dsrc_t * a)
 	a3dsrc_SetHrtfTarget(a, A3dHrirImpulse, A3dHrirImpulse);
 
 	/* Test: Sounds saturated. */
-	//a3dsrc_SetHrtfCurrent(a, A3dHrirSatTest, A3dHrirSatTest);
-	//a3dsrc_SetHrtfTarget(a, A3dHrirSatTest, A3dHrirSatTest);      
+	/* a3dsrc_SetHrtfCurrent(a, A3dHrirSatTest, A3dHrirSatTest); */
+	/* a3dsrc_SetHrtfTarget(a, A3dHrirSatTest, A3dHrirSatTest); */
 }
 
 /* VDB = Vortex audio Dataflow Bus */
@@ -534,7 +534,7 @@ static void a3dsrc_ClearVDBData(a3dsrc_t * a, unsigned long aa)
 {
 	vortex_t *vortex = (vortex_t *) (a->vortex);
 
-	// ((aa >> 2) << 8) - (aa >> 2)
+	/* ((aa >> 2) << 8) - (aa >> 2) */
 	hwwrite(vortex->mmio,
 		a3d_addrS(a->slice, A3D_SLICE_VDBDest) + (a->source << 2), 0);
 	hwwrite(vortex->mmio,
@@ -552,7 +552,7 @@ static void a3dsrc_ClearVDBData(a3dsrc_t * a, unsigned long aa)
 static void vortex_A3dSourceHw_Initialize(vortex_t * v, int source, int slice)
 {
 	a3dsrc_t *a3dsrc = &(v->a3d[source + (slice * 4)]);
-	//a3dsrc_t *a3dsrc = &(v->a3d[source + (slice*4)]);
+	/* a3dsrc_t *a3dsrc = &(v->a3d[source + (slice*4)]); */
 
 	a3dsrc->vortex = (void *)v;
 	a3dsrc->source = source;	/* source */
@@ -616,12 +616,12 @@ static void vortex_Vort3D_disable(vortex_t * v)
 static void vortex_Vort3D_connect(vortex_t * v, int en)
 {
 	int i;
-	
+
 // Disable AU8810 routes, since they seem to be wrong (in au8810.h).
 #ifdef CHIP_AU8810
 	return;
 #endif
-	
+
 #if 1
 	/* Alloc Xtalk mixin resources */
 	v->mixxtlk[0] =
@@ -642,7 +642,7 @@ static void vortex_Vort3D_connect(vortex_t * v, int en)
 
 	/* Connect A3D -> XTALK */
 	for (i = 0; i < 4; i++) {
-		// 2 outputs per each A3D slice. 
+		/* 2 outputs per each A3D slice. */
 		vortex_route(v, en, 0x11, ADB_A3DOUT(i * 2), ADB_XTALKIN(i));
 		vortex_route(v, en, 0x11, ADB_A3DOUT(i * 2) + 1, ADB_XTALKIN(5 + i));
 	}
@@ -689,8 +689,8 @@ static void vortex_Vort3D_InitializeSource(a3dsrc_t * a, int en)
 				     ItdTCDefault, GainTCDefault,
 				     CoefTCDefault);
 		/* Remark: zero gain is muted. */
-		//a3dsrc_SetGainTarget(a,0,0);
-		//a3dsrc_SetGainCurrent(a,0,0);
+		/* a3dsrc_SetGainTarget(a,0,0); */
+		/* a3dsrc_SetGainCurrent(a,0,0); */
 		a3dsrc_EnableA3D(a);
 	} else {
 		a3dsrc_DisableA3D(a);
@@ -764,7 +764,7 @@ snd_vortex_a3d_filter_info(struct snd_kcontrol *kcontrol,
 static int
 snd_vortex_a3d_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	//a3dsrc_t *a = kcontrol->private_data;
+	/* a3dsrc_t *a = kcontrol->private_data; */
 	/* No read yet. Would this be really useable/needed ? */
 
 	return 0;
diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.c
index b070e57..9009d38 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -16,7 +16,7 @@
 
 /*
     Vortex core low level functions.
-	
+
  Author: Manuel Jander (mjander@users.sourceforge.cl)
  These functions are mainly the result of translations made
  from the original disassembly of the au88x0 binary drivers,
@@ -73,7 +73,7 @@
  06-06-2003 Buffer shifter bugfix. Mixer volume fix.
  07-12-2003 A3D routing finally fixed. Believed to be OK.
  25-03-2004 Many thanks to Claudia, for such valuable bug reports.
- 
+
 */
 
 #include "au88x0.h"
@@ -112,7 +112,7 @@ static int vortex_mix_getvolume(vortex_t * vortex, unsigned char mix)
 {
 	int a;
 	a = hwread(vortex->mmio, VORTEX_MIX_VOL_A + (mix << 2)) & 0xff;
-	//FP2LinearFrac(a);
+	/* FP2LinearFrac(a); */
 	return (a);
 }
 
@@ -144,7 +144,7 @@ static void vortex_mix_rampvolume(vortex_t * vortex, int mix)
 {
 	int ch;
 	char a;
-	// This function is intended for ramping down only (see vortex_disableinput()).
+	/* This function is intended for ramping down only (see vortex_disableinput()). */
 	for (ch = 0; ch < 0x20; ch++) {
 		if (((1 << ch) & rampchs[mix]) == 0)
 			continue;
@@ -260,8 +260,8 @@ vortex_mix_disableinput(vortex_t * vortex, unsigned char mix, int channel,
 {
 	if (ramp) {
 		rampchs[mix] |= (1 << channel);
-		// Register callback.
-		//vortex_mix_startrampvolume(vortex);
+		/* Register callback. */
+		/* vortex_mix_startrampvolume(vortex); */
 		vortex_mix_killinput(vortex, mix, channel);
 	} else
 		vortex_mix_killinput(vortex, mix, channel);
@@ -283,7 +283,7 @@ vortex_mixer_addWTD(vortex_t * vortex, unsigned char mix, unsigned char ch)
 	while (temp & 0x10) {
 		prev = VORTEX_MIXER_RTBASE + ((temp & 0xf) << 2);
 		temp = hwread(vortex->mmio, prev);
-		//printk(KERN_INFO "vortex: mixAddWTD: while addr=%x, val=%x\n", prev, temp);
+		/* printk(KERN_INFO "vortex: mixAddWTD: while addr=%x, val=%x\n", prev, temp); */
 		if ((++lifeboat) > 0xf) {
 			printk(KERN_ERR
 			       "vortex_mixer_addWTD: lifeboat overflow\n");
@@ -299,7 +299,7 @@ static int
 vortex_mixer_delWTD(vortex_t * vortex, unsigned char mix, unsigned char ch)
 {
 	int esp14 = -1, esp18, eax, ebx, edx, ebp, esi = 0;
-	//int esp1f=edi(while)=src, esp10=ch;
+	/* int esp1f=edi(while)=src, esp10=ch; */
 
 	eax = hwread(vortex->mmio, VORTEX_MIXER_SR);
 	if (((1 << ch) & eax) == 0) {
@@ -313,15 +313,15 @@ vortex_mixer_delWTD(vortex_t * vortex, unsigned char mix, unsigned char ch)
 		if (mix == ebx) {
 			ebx = VORTEX_MIXER_RTBASE + (mix << 2);
 			edx = hwread(vortex->mmio, ebx);
-			//7b60
+			/* 7b60 */
 			hwwrite(vortex->mmio, ebp, edx);
 			hwwrite(vortex->mmio, ebx, 0);
 		} else {
-			//7ad3
+			/* 7ad3 */
 			edx =
 			    hwread(vortex->mmio,
 				   VORTEX_MIXER_RTBASE + (ebx << 2));
-			//printk(KERN_INFO "vortex: mixdelWTD: 1 addr=%x, val=%x, src=%x\n", ebx, edx, src);
+			/* printk(KERN_INFO "vortex: mixdelWTD: 1 addr=%x, val=%x, src=%x\n", ebx, edx, src); */
 			while ((edx & 0xf) != mix) {
 				if ((esi) > 0xf) {
 					printk(KERN_ERR
@@ -334,21 +334,21 @@ vortex_mixer_delWTD(vortex_t * vortex, unsigned char mix, unsigned char ch)
 				edx =
 				    hwread(vortex->mmio,
 					   VORTEX_MIXER_RTBASE + ebp);
-				//printk(KERN_INFO "vortex: mixdelWTD: while addr=%x, val=%x\n", ebp, edx);
+				/* printk(KERN_INFO "vortex: mixdelWTD: while addr=%x, val=%x\n", ebp, edx); */
 				esi++;
 			}
-			//7b30
+			/* 7b30 */
 			ebp = ebx << 2;
 			if (edx & 0x10) {	/* Delete entry in between others */
 				ebx = VORTEX_MIXER_RTBASE + ((edx & 0xf) << 2);
 				edx = hwread(vortex->mmio, ebx);
-				//7b60
+				/* 7b60 */
 				hwwrite(vortex->mmio,
 					VORTEX_MIXER_RTBASE + ebp, edx);
 				hwwrite(vortex->mmio, ebx, 0);
-				//printk(KERN_INFO "vortex mixdelWTD between addr= 0x%x, val= 0x%x\n", ebp, edx);
+				/* printk(KERN_INFO "vortex mixdelWTD between addr= 0x%x, val= 0x%x\n", ebp, edx); */
 			} else {	/* Delete last entry */
-				//7b83
+				/* 7b83 */
 				if (esp14 == -1)
 					hwwrite(vortex->mmio,
 						VORTEX_MIXER_CHNBASE +
@@ -358,7 +358,7 @@ vortex_mixer_delWTD(vortex_t * vortex, unsigned char mix, unsigned char ch)
 					hwwrite(vortex->mmio,
 						VORTEX_MIXER_RTBASE +
 						(esp14 << 2), ebx);
-					//printk(KERN_INFO "vortex mixdelWTD last addr= 0x%x, val= 0x%x\n", esp14, ebx);
+					/* printk(KERN_INFO "vortex mixdelWTD last addr= 0x%x, val= 0x%x\n", esp14, ebx); */
 				}
 				hwwrite(vortex->mmio,
 					VORTEX_MIXER_RTBASE + ebp, 0);
@@ -366,8 +366,8 @@ vortex_mixer_delWTD(vortex_t * vortex, unsigned char mix, unsigned char ch)
 			}
 		}
 	} else {
-		//printk(KERN_INFO "removed last mix\n");
-		//7be0
+		/* printk(KERN_INFO "removed last mix\n"); */
+		/* 7be0 */
 		vortex_mixer_dis_sr(vortex, ch);
 		hwwrite(vortex->mmio, ebp, 0);
 	}
@@ -379,7 +379,7 @@ static void vortex_mixer_init(vortex_t * vortex)
 	u32 addr;
 	int x;
 
-	// FIXME: get rid of this crap.
+	/* FIXME: get rid of this crap. */
 	memset(mchannels, 0, NR_MIXOUT * sizeof(int));
 	memset(rampchs, 0, NR_MIXOUT * sizeof(int));
 
@@ -572,12 +572,12 @@ static void vortex_src_setupchannel(vortex_t * card, unsigned char src,
 			unsigned int cr, unsigned int b, int sweep, int d,
 			int dirplay, int sl, unsigned int tr, int thsource)
 {
-	// noplayback: d=2,4,7,0xa,0xb when using first 2 src's.
-	// c: enables pitch sweep.
-	// looks like g is c related. Maybe g is a sweep parameter ?
-	// g = cvr
-	// dirplay: 0 = recording, 1 = playback
-	// d = src hw index.
+	/* noplayback: d=2,4,7,0xa,0xb when using first 2 src's. */
+	/* c: enables pitch sweep. */
+	/* looks like g is c related. Maybe g is a sweep parameter ? */
+	/* g = cvr */
+	/* dirplay: 0 = recording, 1 = playback */
+	/* d = src hw index. */
 
 	int esi, ebp = 0, esp10;
 
@@ -634,7 +634,7 @@ static void vortex_src_setupchannel(vortex_t * card, unsigned char src,
 	hwwrite(card->mmio, VORTEX_SRC_U2 + (src << 2),
 		(tr << 0x11) | (dirplay << 0x10) | (ebp << 0x8) | esp10);
 	/* 0x30f00 e=g=1 esp10=0 ebp=f */
-	//printk(KERN_INFO "vortex: SRC %d, d=0x%x, esi=0x%x, esp10=0x%x, ebp=0x%x\n", src, d, esi, esp10, ebp);
+	/* printk(KERN_INFO "vortex: SRC %d, d=0x%x, esi=0x%x, esp10=0x%x, ebp=0x%x\n", src, d, esi, esp10, ebp); */
 }
 
 static void vortex_srcblock_init(vortex_t * vortex)
@@ -647,15 +647,15 @@ static void vortex_srcblock_init(vortex_t * vortex)
 	   vortex_src_init(&vortex_src[x], x);
 	   }
 	 */
-	//addr = 0xcc3c;
-	//addr = 0x26c3c;
+	/* addr = 0xcc3c; */
+	/* addr = 0x26c3c; */
 	addr = VORTEX_SRC_RTBASE + 0x3c;
 	for (x = 0xf; x >= 0; x--) {
 		hwwrite(vortex->mmio, addr, 0);
 		addr -= 4;
 	}
-	//addr = 0xcc94;
-	//addr = 0x26c94;
+	/* addr = 0xcc94; */
+	/* addr = 0x26c94; */
 	addr = VORTEX_SRC_CHNBASE + 0x54;
 	for (x = 0x15; x >= 0; x--) {
 		hwwrite(vortex->mmio, addr, 0);
@@ -667,7 +667,7 @@ static int
 vortex_src_addWTD(vortex_t * vortex, unsigned char src, unsigned char ch)
 {
 	int temp, lifeboat = 0, prev;
-	// esp13 = src
+	/* esp13 = src */
 
 	temp = hwread(vortex->mmio, VORTEX_SRCBLOCK_SR);
 	if ((temp & (1 << ch)) == 0) {
@@ -677,12 +677,12 @@ vortex_src_addWTD(vortex_t * vortex, unsigned char src, unsigned char ch)
 	}
 	prev = VORTEX_SRC_CHNBASE + (ch << 2);	/*ebp */
 	temp = hwread(vortex->mmio, prev);
-	//while (temp & NR_SRC) {
+	/* while (temp & NR_SRC) { */
 	while (temp & 0x10) {
 		prev = VORTEX_SRC_RTBASE + ((temp & 0xf) << 2);	/*esp12 */
-		//prev = VORTEX_SRC_RTBASE + ((temp & (NR_SRC-1)) << 2); /*esp12*/
+		/* prev = VORTEX_SRC_RTBASE + ((temp & (NR_SRC-1)) << 2); esp12 */
 		temp = hwread(vortex->mmio, prev);
-		//printk(KERN_INFO "vortex: srcAddWTD: while addr=%x, val=%x\n", prev, temp);
+		/* printk(KERN_INFO "vortex: srcAddWTD: while addr=%x, val=%x\n", prev, temp); */
 		if ((++lifeboat) > 0xf) {
 			printk(KERN_ERR
 			       "vortex_src_addWTD: lifeboat overflow\n");
@@ -690,7 +690,7 @@ vortex_src_addWTD(vortex_t * vortex, unsigned char src, unsigned char ch)
 		}
 	}
 	hwwrite(vortex->mmio, VORTEX_SRC_RTBASE + ((temp & 0xf) << 2), src);
-	//hwwrite(vortex->mmio, prev, (temp & (NR_SRC-1)) | NR_SRC);
+	/* hwwrite(vortex->mmio, prev, (temp & (NR_SRC-1)) | NR_SRC); */
 	hwwrite(vortex->mmio, prev, (temp & 0xf) | 0x10);
 	return 1;
 }
@@ -699,7 +699,7 @@ static int
 vortex_src_delWTD(vortex_t * vortex, unsigned char src, unsigned char ch)
 {
 	int esp14 = -1, esp18, eax, ebx, edx, ebp, esi = 0;
-	//int esp1f=edi(while)=src, esp10=ch;
+	/* int esp1f=edi(while)=src, esp10=ch; */
 
 	eax = hwread(vortex->mmio, VORTEX_SRCBLOCK_SR);
 	if (((1 << ch) & eax) == 0) {
@@ -713,15 +713,15 @@ vortex_src_delWTD(vortex_t * vortex, unsigned char src, unsigned char ch)
 		if (src == ebx) {
 			ebx = VORTEX_SRC_RTBASE + (src << 2);
 			edx = hwread(vortex->mmio, ebx);
-			//7b60
+			/* 7b60 */
 			hwwrite(vortex->mmio, ebp, edx);
 			hwwrite(vortex->mmio, ebx, 0);
 		} else {
-			//7ad3
+			/* 7ad3 */
 			edx =
 			    hwread(vortex->mmio,
 				   VORTEX_SRC_RTBASE + (ebx << 2));
-			//printk(KERN_INFO "vortex: srcdelWTD: 1 addr=%x, val=%x, src=%x\n", ebx, edx, src);
+			/* printk(KERN_INFO "vortex: srcdelWTD: 1 addr=%x, val=%x, src=%x\n", ebx, edx, src); */
 			while ((edx & 0xf) != src) {
 				if ((esi) > 0xf) {
 					printk
@@ -734,21 +734,21 @@ vortex_src_delWTD(vortex_t * vortex, unsigned char src, unsigned char ch)
 				edx =
 				    hwread(vortex->mmio,
 					   VORTEX_SRC_RTBASE + ebp);
-				//printk(KERN_INFO "vortex: srcdelWTD: while addr=%x, val=%x\n", ebp, edx);
+				/* printk(KERN_INFO "vortex: srcdelWTD: while addr=%x, val=%x\n", ebp, edx); */
 				esi++;
 			}
-			//7b30
+			/* 7b30 */
 			ebp = ebx << 2;
 			if (edx & 0x10) {	/* Delete entry in between others */
 				ebx = VORTEX_SRC_RTBASE + ((edx & 0xf) << 2);
 				edx = hwread(vortex->mmio, ebx);
-				//7b60
+				/* 7b60 */
 				hwwrite(vortex->mmio,
 					VORTEX_SRC_RTBASE + ebp, edx);
 				hwwrite(vortex->mmio, ebx, 0);
-				//printk(KERN_INFO "vortex srcdelWTD between addr= 0x%x, val= 0x%x\n", ebp, edx);
+				/* printk(KERN_INFO "vortex srcdelWTD between addr= 0x%x, val= 0x%x\n", ebp, edx); */
 			} else {	/* Delete last entry */
-				//7b83
+				/* 7b83 */
 				if (esp14 == -1)
 					hwwrite(vortex->mmio,
 						VORTEX_SRC_CHNBASE +
@@ -758,7 +758,7 @@ vortex_src_delWTD(vortex_t * vortex, unsigned char src, unsigned char ch)
 					hwwrite(vortex->mmio,
 						VORTEX_SRC_RTBASE +
 						(esp14 << 2), ebx);
-					//printk(KERN_INFO"vortex srcdelWTD last addr= 0x%x, val= 0x%x\n", esp14, ebx);
+					/* printk(KERN_INFO"vortex srcdelWTD last addr= 0x%x, val= 0x%x\n", esp14, ebx); */
 				}
 				hwwrite(vortex->mmio,
 					VORTEX_SRC_RTBASE + ebp, 0);
@@ -766,14 +766,14 @@ vortex_src_delWTD(vortex_t * vortex, unsigned char src, unsigned char ch)
 			}
 		}
 	} else {
-		//7be0
+		/* 7be0 */
 		vortex_src_dis_sr(vortex, ch);
 		hwwrite(vortex->mmio, ebp, 0);
 	}
 	return 1;
 }
 
- /*FIFO*/ 
+ /*FIFO*/
 
 static void
 vortex_fifo_clearadbdata(vortex_t * vortex, int fifo, int x)
@@ -809,7 +809,7 @@ vortex_fifo_setadbctrl(vortex_t * vortex, int fifo, int b, int priority,
 		       int empty, int valid, int f)
 {
 	int temp, lifeboat = 0;
-	//int this_8[NR_ADB] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}; /* position */
+	/* int this_8[NR_ADB] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};  position */
 	int this_4 = 0x2;
 	/* f seems priority related.
 	 * CAsp4AdbDma::SetPriority is the only place that calls SetAdbCtrl with f set to 1
@@ -826,12 +826,12 @@ vortex_fifo_setadbctrl(vortex_t * vortex, int fifo, int b, int priority,
 	}
 	while (temp & FIFO_RDONLY);
 
-	// AU8830 semes to take some special care about fifo content (data).
-	// But i'm just to lazy to translate that :)
+	/* AU8830 semes to take some special care about fifo content (data). */
+	/* But i'm just to lazy to translate that :) */
 	if (valid) {
 		if ((temp & FIFO_VALID) == 0) {
-			//this_8[fifo] = 0;
-			vortex_fifo_clearadbdata(vortex, fifo, FIFO_SIZE);	// this_4
+			/* this_8[fifo] = 0; */
+			vortex_fifo_clearadbdata(vortex, fifo, FIFO_SIZE);	/* this_4 */
 #ifdef CHIP_AU8820
 			temp = (this_4 & 0x1f) << 0xb;
 #else
@@ -923,7 +923,7 @@ vortex_fifo_setwtctrl(vortex_t * vortex, int fifo, int ctrl, int priority,
 
 	if (valid) {
 		if ((temp & FIFO_VALID) == 0) {
-			vortex_fifo_clearwtdata(vortex, fifo, FIFO_SIZE);	// this_4
+			vortex_fifo_clearwtdata(vortex, fifo, FIFO_SIZE);	/* this_4 */
 #ifdef CHIP_AU8820
 			temp = (this_4 & 0x1f) << 0xb;
 #else
@@ -966,7 +966,7 @@ vortex_fifo_setwtctrl(vortex_t * vortex, int fifo, int ctrl, int priority,
 	hwwrite(vortex->mmio, VORTEX_FIFO_WTCTRL + (fifo << 2), temp);
 	hwread(vortex->mmio, VORTEX_FIFO_WTCTRL + (fifo << 2));
 
-/*	
+/*
     do {
 		temp = hwread(vortex->mmio, VORTEX_FIFO_WTCTRL + (fifo << 2));
 		if (lifeboat++ > 0xbb8) {
@@ -974,8 +974,8 @@ vortex_fifo_setwtctrl(vortex_t * vortex, int fifo, int ctrl, int priority,
 			break;
 		}
     } while ((temp & FIFO_RDONLY)&&(temp & FIFO_VALID)&&(temp != 0xFFFFFFFF));
-	
-	
+
+
 	if (valid) {
 		if (temp & FIFO_VALID) {
 			temp = 0x40000;
@@ -1001,8 +1001,8 @@ vortex_fifo_setwtctrl(vortex_t * vortex, int fifo, int ctrl, int priority,
 		temp |= 0x00400000;
 		hwwrite(vortex->mmio, VORTEX_FIFO_WTCTRL + (fifo << 2), temp);
 		temp = hwread(vortex->mmio, VORTEX_FIFO_WTCTRL + (fifo << 2));
-		//((temp >> 6) & 0x3f) 
-		
+		//((temp >> 6) & 0x3f)
+
 		priority = 0;
 		if (((temp & 0x0fc0) ^ ((temp >> 6) & 0x0fc0)) & 0FFFFFFC0)
 			vortex_fifo_clearwtdata(vortex, fifo, FIFO_SIZE);
@@ -1014,7 +1014,7 @@ vortex_fifo_setwtctrl(vortex_t * vortex, int fifo, int ctrl, int priority,
 		temp = (temp & 0xffffffdf) | ((empty & 1) << 5);
 		hwwrite(vortex->mmio, VORTEX_FIFO_WTCTRL + (fifo << 2), temp);
 	}
-	
+
 	*/
 
 	/*
@@ -1062,7 +1062,7 @@ static void vortex_fifo_init(vortex_t * vortex)
 #endif
 	/* trigger... */
 #ifdef CHIP_AU8820
-	hwwrite(vortex->mmio, 0xf8c0, 0xd03);	//0x0843 0xd6b
+	hwwrite(vortex->mmio, 0xf8c0, 0xd03);	/* 0x0843 0xd6b */
 #else
 #ifdef CHIP_AU8830
 	hwwrite(vortex->mmio, 0x17000, 0x61);	/* wt a */
@@ -1089,7 +1089,7 @@ static void vortex_adbdma_setfirstbuffer(vortex_t * vortex, int adbdma)
 static void vortex_adbdma_setstartbuffer(vortex_t * vortex, int adbdma, int sb)
 {
 	stream_t *dma = &vortex->dma_adb[adbdma];
-	//hwwrite(vortex->mmio, VORTEX_ADBDMA_START + (adbdma << 2), sb << (((NR_ADB-1)-((adbdma&0xf)*2))));
+	/* hwwrite(vortex->mmio, VORTEX_ADBDMA_START + (adbdma << 2), sb << (((NR_ADB-1)-((adbdma&0xf)*2)))); */
 	hwwrite(vortex->mmio, VORTEX_ADBDMA_START + (adbdma << 2),
 		sb << ((0xf - (adbdma & 0xf)) * 2));
 	dma->period_real = dma->period_virt = sb;
@@ -1135,7 +1135,7 @@ vortex_adbdma_setbuffers(vortex_t * vortex, int adbdma,
 			snd_pcm_sgbuf_get_addr(dma->substream, 0));
 		break;
 	}
-	//printk("vortex: cfg0 = 0x%x\nvortex: cfg1=0x%x\n", dma->cfg0, dma->cfg1);
+	/* printk("vortex: cfg0 = 0x%x\nvortex: cfg1=0x%x\n", dma->cfg0, dma->cfg1); */
 	hwwrite(vortex->mmio, VORTEX_ADBDMA_BUFCFG0 + (adbdma << 3), dma->cfg0);
 	hwwrite(vortex->mmio, VORTEX_ADBDMA_BUFCFG1 + (adbdma << 3), dma->cfg1);
 
@@ -1195,7 +1195,7 @@ static int vortex_adbdma_bufshift(vortex_t * vortex, int adbdma)
 			pp = dma->period_real + i;
 			if (pp >= 4)
 				pp -= 4;
-			//hwwrite(vortex->mmio, VORTEX_ADBDMA_BUFBASE+(((adbdma << 2)+pp) << 2), dma->table[p].addr);
+			/* hwwrite(vortex->mmio, VORTEX_ADBDMA_BUFBASE+(((adbdma << 2)+pp) << 2), dma->table[p].addr); */
 			hwwrite(vortex->mmio,
 				VORTEX_ADBDMA_BUFBASE + (((adbdma << 2) + pp) << 2),
 				snd_pcm_sgbuf_get_addr(dma->substream,
@@ -1222,7 +1222,7 @@ static void vortex_adbdma_resetup(vortex_t *vortex, int adbdma) {
 	int p, pp, i;
 
 	/* refresh hw page table */
-	for (i=0 ; i < 4 && i < dma->nr_periods; i++) {
+	for (i = 0; i < 4 && i < dma->nr_periods; i++) {
 		/* p: audio buffer page index */
 		p = dma->period_virt + i;
 		if (p >= dma->nr_periods)
@@ -1258,7 +1258,7 @@ static int inline vortex_adbdma_getlinearpos(vortex_t * vortex, int adbdma)
 
 static void vortex_adbdma_startfifo(vortex_t * vortex, int adbdma)
 {
-	int this_8 = 0 /*empty */ , this_4 = 0 /*priority */ ;
+	int this_8 = 0, /*empty */ this_4 = 0; /*priority */
 	stream_t *dma = &vortex->dma_adb[adbdma];
 
 	switch (dma->fifo_status) {
@@ -1325,7 +1325,7 @@ static void vortex_adbdma_pausefifo(vortex_t * vortex, int adbdma)
 	dma->fifo_status = FIFO_PAUSE;
 }
 
-#if 0				// Using pause instead
+#if 0				/* Using pause instead */
 static void vortex_adbdma_stopfifo(vortex_t * vortex, int adbdma)
 {
 	stream_t *dma = &vortex->dma_adb[adbdma];
@@ -1346,7 +1346,7 @@ static void vortex_adbdma_stopfifo(vortex_t * vortex, int adbdma)
 #ifndef CHIP_AU8810
 static void vortex_wtdma_setfirstbuffer(vortex_t * vortex, int wtdma)
 {
-	//int this_7c=dma_ctrl;
+	/* int this_7c=dma_ctrl; */
 	stream_t *dma = &vortex->dma_wt[wtdma];
 
 	hwwrite(vortex->mmio, VORTEX_WTDMA_CTRL + (wtdma << 2), dma->dma_ctrl);
@@ -1355,7 +1355,7 @@ static void vortex_wtdma_setfirstbuffer(vortex_t * vortex, int wtdma)
 static void vortex_wtdma_setstartbuffer(vortex_t * vortex, int wtdma, int sb)
 {
 	stream_t *dma = &vortex->dma_wt[wtdma];
-	//hwwrite(vortex->mmio, VORTEX_WTDMA_START + (wtdma << 2), sb << ((0x1f-(wtdma&0xf)*2)));
+	/* hwwrite(vortex->mmio, VORTEX_WTDMA_START + (wtdma << 2), sb << ((0x1f-(wtdma&0xf)*2))); */
 	hwwrite(vortex->mmio, VORTEX_WTDMA_START + (wtdma << 2),
 		sb << ((0xf - (wtdma & 0xf)) * 2));
 	dma->period_real = dma->period_virt = sb;
@@ -1410,7 +1410,7 @@ vortex_wtdma_setmode(vortex_t * vortex, int wtdma, int ie, int fmt, int d,
 {
 	stream_t *dma = &vortex->dma_wt[wtdma];
 
-	//dma->this_08 = e;
+	/* dma->this_08 = e; */
 	dma->dma_unknown = d;
 	dma->dma_ctrl = 0;
 	dma->dma_ctrl =
@@ -1501,7 +1501,7 @@ static int inline vortex_wtdma_getlinearpos(vortex_t * vortex, int wtdma)
 	int temp;
 
 	temp = hwread(vortex->mmio, VORTEX_WTDMA_STAT + (wtdma << 2));
-	//temp = (temp & POS_MASK) + (((temp>>WT_SUBBUF_SHIFT) & WT_SUBBUF_MASK)*(dma->cfg0&POS_MASK));
+	/* temp = (temp & POS_MASK) + (((temp>>WT_SUBBUF_SHIFT) & WT_SUBBUF_MASK)*(dma->cfg0&POS_MASK)); */
 	temp = (temp & POS_MASK) + ((dma->period_virt) * (dma->period_bytes));
 	return temp;
 }
@@ -1846,7 +1846,7 @@ vortex_connection_mixin_mix(vortex_t * vortex, int en, unsigned char mixin,
 {
 	if (en) {
 		vortex_mix_enableinput(vortex, mix, mixin);
-		vortex_mix_setinputvolumebyte(vortex, mix, mixin, MIX_DEFIGAIN);	// added to original code.
+		vortex_mix_setinputvolumebyte(vortex, mix, mixin, MIX_DEFIGAIN);	/* added to original code. */
 	} else
 		vortex_mix_disableinput(vortex, mix, mixin, a);
 }
@@ -1883,7 +1883,7 @@ vortex_connection_mix_adb(vortex_t * vortex, int en, unsigned char ch,
 			  unsigned char mix, unsigned char dest)
 {
 	vortex_route(vortex, en, ch, ADB_MIXOUT(mix), dest);
-	vortex_mix_setvolumebyte(vortex, mix, MIX_DEFOGAIN);	// added to original code.
+	vortex_mix_setvolumebyte(vortex, mix, MIX_DEFOGAIN);	/* added to original code. */
 }
 
 // mixer to src.
@@ -1892,7 +1892,7 @@ vortex_connection_mix_src(vortex_t * vortex, int en, unsigned char ch,
 			  unsigned char mix, unsigned char src)
 {
 	vortex_route(vortex, en, ch, ADB_MIXOUT(mix), ADB_SRCIN(src));
-	vortex_mix_setvolumebyte(vortex, mix, MIX_DEFOGAIN);	// added to original code.
+	vortex_mix_setvolumebyte(vortex, mix, MIX_DEFOGAIN);	/* added to original code. */
 }
 
 #if 0
@@ -1943,7 +1943,7 @@ vortex_connect_codecplay(vortex_t * vortex, int en, unsigned char mixers[])
 	vortex_connection_mix_adb(vortex, en, 0x11, mixers[1], ADB_CODECOUT(1));
 #else
 #if 1
-	// Connect front channels through EQ.
+	/* Connect front channels through EQ. */
 	vortex_connection_mix_adb(vortex, en, 0x11, mixers[0], ADB_EQIN(0));
 	vortex_connection_mix_adb(vortex, en, 0x11, mixers[1], ADB_EQIN(1));
 	/* Lower volume, since EQ has some gain. */
@@ -1959,10 +1959,10 @@ vortex_connect_codecplay(vortex_t * vortex, int en, unsigned char mixers[])
 					  ADB_CODECOUT(0 + 4));
 		vortex_connection_mix_adb(vortex, en, 0x11, mixers[3],
 					  ADB_CODECOUT(1 + 4));
-		//printk("SDAC detected ");
+		/* printk("SDAC detected "); */
 	}
 #else
-	// Use plain direct output to codec.
+	/* Use plain direct output to codec. */
 	vortex_connection_mix_adb(vortex, en, 0x11, mixers[0], ADB_CODECOUT(0));
 	vortex_connection_mix_adb(vortex, en, 0x11, mixers[1], ADB_CODECOUT(1));
 #endif
@@ -1989,7 +1989,7 @@ vortex_connect_codecrec(vortex_t * vortex, int en, unsigned char mixin0,
 static int resnum[VORTEX_RESOURCE_LAST] =
     { NR_ADB, NR_SRC, NR_MIXIN, NR_MIXOUT, NR_A3D };
 /*
- Checkout/Checkin resource of given type. 
+ Checkout/Checkin resource of given type.
  resmap: resource map to be used. If NULL means that we want to allocate
  a DMA resource (root of all other resources of a dma channel).
  out: Mean checkout if != 0. Else mean Checkin resource.
@@ -2013,7 +2013,7 @@ vortex_adb_checkinout(vortex_t * vortex, int resmap[], int out, int restype)
 					resmap[restype] |= (1 << i);
 				else
 					vortex->dma_adb[i].resources[restype] |= (1 << i);
-				//printk("vortex: ResManager: type %d out %d\n", restype, i);
+				/* printk("vortex: ResManager: type %d out %d\n", restype, i); */
 				return i;
 			}
 		}
@@ -2024,7 +2024,7 @@ vortex_adb_checkinout(vortex_t * vortex, int resmap[], int out, int restype)
 		for (i = 0; i < qty; i++) {
 			if (resmap[restype] & (1 << i)) {
 				resmap[restype] &= ~(1 << i);
-				//printk("vortex: ResManager: type %d in %d\n",restype, i);
+				/* printk("vortex: ResManager: type %d in %d\n",restype, i); */
 				return i;
 			}
 		}
@@ -2039,7 +2039,7 @@ vortex_adb_allocroute(vortex_t * vortex, int dma, int nr_ch, int dir, int type);
 
 static void vortex_connect_default(vortex_t * vortex, int en)
 {
-	// Connect AC97 codec.
+	/* Connect AC97 codec. */
 	vortex->mixplayb[0] = vortex_adb_checkinout(vortex, vortex->fixed_res, en,
 				  VORTEX_RESOURCE_MIXOUT);
 	vortex->mixplayb[1] = vortex_adb_checkinout(vortex, vortex->fixed_res, en,
@@ -2058,7 +2058,7 @@ static void vortex_connect_default(vortex_t * vortex, int en)
 				  VORTEX_RESOURCE_MIXIN);
 	vortex_connect_codecrec(vortex, en, MIX_CAPT(0), MIX_CAPT(1));
 
-	// Connect SPDIF
+	/* Connect SPDIF */
 #ifndef CHIP_AU8820
 	vortex->mixspdif[0] = vortex_adb_checkinout(vortex, vortex->fixed_res, en,
 				  VORTEX_RESOURCE_MIXOUT);
@@ -2069,20 +2069,20 @@ static void vortex_connect_default(vortex_t * vortex, int en)
 	vortex_connection_mix_adb(vortex, en, 0x14, vortex->mixspdif[1],
 				  ADB_SPDIFOUT(1));
 #endif
-	// Connect WT
+	/* Connect WT */
 #ifndef CHIP_AU8810
 	vortex_wt_connect(vortex, en);
 #endif
-	// A3D (crosstalk canceler and A3D slices). AU8810 disabled for now.
+	/* A3D (crosstalk canceler and A3D slices). AU8810 disabled for now. */
 #ifndef CHIP_AU8820
 	vortex_Vort3D_connect(vortex, en);
 #endif
-	// Connect I2S
+	/* Connect I2S */
+
+	/* Connect DSP interface for SQ3500 turbo (not here i think...) */
 
-	// Connect DSP interface for SQ3500 turbo (not here i think...)
+	/* Connect AC98 modem codec */
 
-	// Connect AC98 modem codec
-	
 }
 
 /*
@@ -2099,7 +2099,7 @@ vortex_adb_allocroute(vortex_t * vortex, int dma, int nr_ch, int dir, int type)
 {
 	stream_t *stream;
 	int i, en;
-	
+
 	if ((nr_ch == 3)
 	    || ((dir == SNDRV_PCM_STREAM_CAPTURE) && (nr_ch > 2)))
 		return -EBUSY;
@@ -2203,13 +2203,13 @@ vortex_adb_allocroute(vortex_t * vortex, int dma, int nr_ch, int dir, int type)
 #ifndef CHIP_AU8820
 			if (stream->type == VORTEX_PCM_A3D) {
 				vortex_connection_adbdma_src(vortex, en,
-							     src[nr_ch - 1], 
+							     src[nr_ch - 1],
 								 dma,
 							     src[i]);
 				vortex_route(vortex, en, 0x11, ADB_SRCOUT(src[i]), ADB_A3DIN(a3d));
 				/* XTalk test. */
-				//vortex_route(vortex, en, 0x11, dma, ADB_XTALKIN(i?9:4));
-				//vortex_route(vortex, en, 0x11, ADB_SRCOUT(src[i]), ADB_XTALKIN(i?4:9));
+				/* vortex_route(vortex, en, 0x11, dma, ADB_XTALKIN(i?9:4)); */
+				/* vortex_route(vortex, en, 0x11, ADB_SRCOUT(src[i]), ADB_XTALKIN(i?4:9)); */
 			}
 			if (stream->type == VORTEX_PCM_SPDIF)
 				vortex_route(vortex, en, 0x14,
@@ -2331,7 +2331,7 @@ vortex_adb_setsrc(vortex_t * vortex, int adbdma, unsigned int rate, int dir)
 	stream_t *stream = &(vortex->dma_adb[adbdma]);
 	int i, cvrt;
 
-	/* dir=1:play ; dir=0:rec */
+	/* dir=1:play; dir=0:rec */
 	if (dir)
 		cvrt = SRC_RATIO(rate, 48000);
 	else
@@ -2348,7 +2348,7 @@ vortex_adb_setsrc(vortex_t * vortex, int adbdma, unsigned int rate, int dir)
 
 static void vortex_settimer(vortex_t * vortex, int period)
 {
-	//set the timer period to <period> 48000ths of a second.
+	/* set the timer period to <period> 48000ths of a second. */
 	hwwrite(vortex->mmio, VORTEX_IRQ_STAT, period);
 }
 
@@ -2368,7 +2368,7 @@ static void vortex_disable_timer_int(vortex_t * card)
 #endif
 static void vortex_enable_int(vortex_t * card)
 {
-	// CAsp4ISR__EnableVortexInt_void_
+	/* CAsp4ISR__EnableVortexInt_void_ */
 	hwwrite(card->mmio, VORTEX_CTRL,
 		hwread(card->mmio, VORTEX_CTRL) | CTRL_IRQ_ENABLE);
 	hwwrite(card->mmio, VORTEX_IRQ_CTRL,
@@ -2387,26 +2387,26 @@ static irqreturn_t vortex_interrupt(int irq, void *dev_id)
 	int i, handled;
 	u32 source;
 
-	//check if the interrupt is ours.
+	/* check if the interrupt is ours. */
 	if (!(hwread(vortex->mmio, VORTEX_STAT) & 0x1))
 		return IRQ_NONE;
 
-	// This is the Interrupt Enable flag we set before (consistency check).
+	/* This is the Interrupt Enable flag we set before (consistency check). */
 	if (!(hwread(vortex->mmio, VORTEX_CTRL) & CTRL_IRQ_ENABLE))
 		return IRQ_NONE;
 
 	source = hwread(vortex->mmio, VORTEX_IRQ_SOURCE);
-	// Reset IRQ flags.
+	/* Reset IRQ flags. */
 	hwwrite(vortex->mmio, VORTEX_IRQ_SOURCE, source);
 	hwread(vortex->mmio, VORTEX_IRQ_SOURCE);
-	// Is at least one IRQ flag set?
+	/* Is at least one IRQ flag set? */
 	if (source == 0) {
 		printk(KERN_ERR "vortex: missing irq source\n");
 		return IRQ_NONE;
 	}
 
 	handled = 0;
-	// Attend every interrupt source.
+	/* Attend every interrupt source. */
 	if (unlikely(source & IRQ_ERR_MASK)) {
 		if (source & IRQ_FATAL) {
 			printk(KERN_ERR "vortex: IRQ fatal error\n");
@@ -2430,7 +2430,7 @@ static irqreturn_t vortex_interrupt(int irq, void *dev_id)
 		spin_lock(&vortex->lock);
 		for (i = 0; i < NR_ADB; i++) {
 			if (vortex->dma_adb[i].fifo_status == FIFO_START) {
-				if (vortex_adbdma_bufshift(vortex, i)) ;
+				if (vortex_adbdma_bufshift(vortex, i));
 				spin_unlock(&vortex->lock);
 				snd_pcm_period_elapsed(vortex->dma_adb[i].
 						       substream);
@@ -2440,7 +2440,7 @@ static irqreturn_t vortex_interrupt(int irq, void *dev_id)
 #ifndef CHIP_AU8810
 		for (i = 0; i < NR_WT; i++) {
 			if (vortex->dma_wt[i].fifo_status == FIFO_START) {
-				if (vortex_wtdma_bufshift(vortex, i)) ;
+				if (vortex_wtdma_bufshift(vortex, i));
 				spin_unlock(&vortex->lock);
 				snd_pcm_period_elapsed(vortex->dma_wt[i].
 						       substream);
@@ -2451,7 +2451,7 @@ static irqreturn_t vortex_interrupt(int irq, void *dev_id)
 		spin_unlock(&vortex->lock);
 		handled = 1;
 	}
-	//Acknowledge the Timer interrupt
+	/* Acknowledge the Timer interrupt */
 	if (source & IRQ_TIMER) {
 		hwread(vortex->mmio, VORTEX_IRQ_STAT);
 		handled = 1;
@@ -2510,7 +2510,7 @@ static void vortex_codec_init(vortex_t * vortex)
 }
 
 static void
-vortex_codec_write(struct snd_ac97 * codec, unsigned short addr, unsigned short data)
+vortex_codec_write(struct snd_ac97 *codec, unsigned short addr, unsigned short data)
 {
 
 	vortex_t *card = (vortex_t *) codec->private_data;
@@ -2529,13 +2529,13 @@ vortex_codec_write(struct snd_ac97 * codec, unsigned short addr, unsigned short
 		((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
 		((data << VORTEX_CODEC_DATSHIFT) & VORTEX_CODEC_DATMASK) |
 		VORTEX_CODEC_WRITE |
-		(codec->num << VORTEX_CODEC_ID_SHIFT) );
+		(codec->num << VORTEX_CODEC_ID_SHIFT));
 
 	/* Flush Caches. */
 	hwread(card->mmio, VORTEX_CODEC_IO);
 }
 
-static unsigned short vortex_codec_read(struct snd_ac97 * codec, unsigned short addr)
+static unsigned short vortex_codec_read(struct snd_ac97 *codec, unsigned short addr)
 {
 
 	vortex_t *card = (vortex_t *) codec->private_data;
@@ -2552,7 +2552,7 @@ static unsigned short vortex_codec_read(struct snd_ac97 * codec, unsigned short
 	}
 	/* set up read address */
 	read_addr = ((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
-		(codec->num << VORTEX_CODEC_ID_SHIFT) ;
+		(codec->num << VORTEX_CODEC_ID_SHIFT);
 	hwwrite(card->mmio, VORTEX_CODEC_IO, read_addr);
 
 	/* wait for address */
@@ -2579,10 +2579,10 @@ static void vortex_spdif_init(vortex_t * vortex, int spdif_sr, int spdif_mode)
 	/* CAsp4Spdif::InitializeSpdifHardware(void) */
 	hwwrite(vortex->mmio, VORTEX_SPDIF_FLAGS,
 		hwread(vortex->mmio, VORTEX_SPDIF_FLAGS) & 0xfff3fffd);
-	//for (i=0x291D4; i<0x29200; i+=4)
+	/* for (i = 0x291D4; i < 0x29200; i += 4) */
 	for (i = 0; i < 11; i++)
 		hwwrite(vortex->mmio, VORTEX_SPDIF_CFG1 + (i << 2), 0);
-	//hwwrite(vortex->mmio, 0x29190, hwread(vortex->mmio, 0x29190) | 0xc0000);
+	/* hwwrite(vortex->mmio, 0x29190, hwread(vortex->mmio, 0x29190) | 0xc0000); */
 	hwwrite(vortex->mmio, VORTEX_CODEC_EN,
 		hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_SPDIF);
 
@@ -2644,8 +2644,8 @@ static void vortex_spdif_init(vortex_t * vortex, int spdif_sr, int spdif_mode)
 		break;
 
 	}
-	/* looks like the next 2 lines transfer a 16-bit value into 2 8-bit 
-	   registers. seems to be for the standard IEC/SPDIF initialization 
+	/* looks like the next 2 lines transfer a 16-bit value into 2 8-bit
+	   registers. seems to be for the standard IEC/SPDIF initialization
 	   stuff */
 	hwwrite(vortex->mmio, VORTEX_SPDIF_CFG0, this_38 & 0xffff);
 	hwwrite(vortex->mmio, VORTEX_SPDIF_CFG1, this_38 >> 0x10);
@@ -2677,7 +2677,7 @@ static int __devinit vortex_core_init(vortex_t * vortex)
 
 	/* Init audio engine. */
 	vortex_adbdma_init(vortex);
-	hwwrite(vortex->mmio, VORTEX_ENGINE_CTRL, 0x0);	//, 0xc83c7e58, 0xc5f93e58
+	hwwrite(vortex->mmio, VORTEX_ENGINE_CTRL, 0x0);	/*, 0xc83c7e58, 0xc5f93e58 */
 	vortex_adb_init(vortex);
 	/* Init processing blocks. */
 	vortex_fifo_init(vortex);
@@ -2691,16 +2691,16 @@ static int __devinit vortex_core_init(vortex_t * vortex)
 #ifndef CHIP_AU8810
 	vortex_wt_init(vortex);
 #endif
-	// Moved to au88x0.c
-	//vortex_connect_default(vortex, 1);
+	/* Moved to au88x0.c */
+	/* vortex_connect_default(vortex, 1); */
 
 	vortex_settimer(vortex, 0x90);
-	// Enable Interrupts.
-	// vortex_enable_int() must be first !!
-	//  hwwrite(vortex->mmio, VORTEX_IRQ_CTRL, 0);
-	// vortex_enable_int(vortex);
-	//vortex_enable_timer_int(vortex);
-	//vortex_disable_timer_int(vortex);
+	/* Enable Interrupts. */
+	/* vortex_enable_int() must be first !! */
+	/*  hwwrite(vortex->mmio, VORTEX_IRQ_CTRL, 0); */
+	/* vortex_enable_int(vortex); */
+	/* vortex_enable_timer_int(vortex); */
+	/* vortex_disable_timer_int(vortex); */
 
 	printk(KERN_INFO "done.\n");
 	spin_lock_init(&vortex->lock);
@@ -2716,7 +2716,7 @@ static int vortex_core_shutdown(vortex_t * vortex)
 	vortex_eq_free(vortex);
 	vortex_Vort3D_disable(vortex);
 #endif
-	//vortex_disable_timer_int(vortex);
+	/* vortex_disable_timer_int(vortex); */
 	vortex_disable_int(vortex);
 	vortex_connect_default(vortex, 0);
 	/* Reset all DMA fifos. */
@@ -2725,8 +2725,8 @@ static int vortex_core_shutdown(vortex_t * vortex)
 	vortex_adb_init(vortex);
 
 	/* Disable MPU401 */
-	//hwwrite(vortex->mmio, VORTEX_IRQ_CTRL, hwread(vortex->mmio, VORTEX_IRQ_CTRL) & ~IRQ_MIDI);
-	//hwwrite(vortex->mmio, VORTEX_CTRL, hwread(vortex->mmio, VORTEX_CTRL) & ~CTRL_MIDI_EN);
+	/* hwwrite(vortex->mmio, VORTEX_IRQ_CTRL, hwread(vortex->mmio, VORTEX_IRQ_CTRL) & ~IRQ_MIDI); */
+	/* hwwrite(vortex->mmio, VORTEX_CTRL, hwread(vortex->mmio, VORTEX_CTRL) & ~CTRL_MIDI_EN); */
 
 	hwwrite(vortex->mmio, VORTEX_IRQ_CTRL, 0);
 	hwwrite(vortex->mmio, VORTEX_CTRL, 0);
@@ -2795,17 +2795,17 @@ vortex_translateformat(vortex_t * vortex, char bits, char nch, int encod)
 	switch (encod) {
 	case 0:
 		if (bits == 0x10)
-			a = 8;	// 16 bit
+			a = 8;	/* 16 bit */
 		break;
 	case 1:
 		if (bits == 8)
-			a = 1;	// 8 bit
+			a = 1;	/* 8 bit */
 		break;
 	case 2:
-		a = 2;		// U_LAW
+		a = 2;		/* U_LAW */
 		break;
 	case 3:
-		a = 3;		// A_LAW
+		a = 3;		/* A_LAW */
 		break;
 	}
 	switch (nch) {
diff --git a/sound/pci/au88x0/au88x0_eq.c b/sound/pci/au88x0/au88x0_eq.c
index 38602b8..5b911b9 100644
--- a/sound/pci/au88x0/au88x0_eq.c
+++ b/sound/pci/au88x0/au88x0_eq.c
@@ -4,7 +4,7 @@
  *
  *  Sun Jun  8 18:19:19 2003
  *  2003  Manuel Jander (mjander@users.sourceforge.net)
- *  
+ *
  *  02 July 2003: First time something works :)
  *  November 2003: A3D Bypass code completed but untested.
  *
@@ -32,7 +32,7 @@
 
 /*
  The Aureal Hardware EQ is found on AU8810 and AU8830 chips only.
- it has 4 inputs (2 for general mix, 2 for A3D) and 2 outputs (supposed 
+ it has 4 inputs (2 for general mix, 2 for A3D) and 2 outputs (supposed
  to be routed to the codec).
 */
 
@@ -444,9 +444,9 @@ static void vortex_EqHw_ZeroState(vortex_t * vortex)
 	vortex_EqHw_SetRightGainsTarget(vortex, eq_gains_zero);
 
 	vortex_EqHw_SetBypassGain(vortex, 0, 0);
-	//vortex_EqHw_SetCurrBypassGain(vortex, 0, 0);
+	/* vortex_EqHw_SetCurrBypassGain(vortex, 0, 0); */
 	vortex_EqHw_SetA3DBypassGain(vortex, 0, 0);
-	//vortex_EqHw_SetCurrA3DBypassGain(vortex, 0, 0);
+	/* vortex_EqHw_SetCurrA3DBypassGain(vortex, 0, 0); */
 	vortex_EqHw_SetLeftStates(vortex, eq_states_zero, asEqOutStateZeros);
 	vortex_EqHw_SetRightStates(vortex, eq_states_zero, asEqOutStateZeros);
 	vortex_EqHw_SetLevels(vortex, (u16 *) eq_levels);
@@ -570,7 +570,7 @@ vortex_Eqlzr_GetAllBands(vortex_t * vortex, u16 * gains, s32 *cnt)
 			return 1;
 		si++;
 	}
-	while (eq->this10 > si) ;
+	while (eq->this10 > si);
 	*cnt = si * 2;
 	return 0;
 }
@@ -597,7 +597,7 @@ vortex_Eqlzr_SetAllBands(vortex_t * vortex, u16 gains[], s32 count)
 	for (i = 0; i < count; i++) {
 		eq->this130[i] = gains[i];
 	}
-	
+
 	if (eq->this54)
 		return 0;
 	return vortex_Eqlzr_SetAllBandsFromActiveCoeffSet(vortex);
@@ -643,7 +643,7 @@ static void vortex_Eqlzr_ShutDownA3d(vortex_t * vortex)
 static void vortex_Eqlzr_SetBypass(vortex_t * vortex, u32 bp)
 {
 	eqlzr_t *eq = &(vortex->eq);
-	
+
 	if ((eq->this28) && (bp == 0)) {
 		/* EQ enabled */
 		vortex_Eqlzr_SetAllBandsFromActiveCoeffSet(vortex);
@@ -691,7 +691,7 @@ static void vortex_Eqlzr_init(vortex_t * vortex)
 	eqlzr_t *eq = &(vortex->eq);
 
 	/* Object constructor */
-	//eq->this04 = 0;
+	/* eq->this04 = 0; */
 	eq->this08 = 0;		/* Bypass gain with EQ in use. */
 	eq->this0a = 0x5999;
 	eq->this0c = 0x5999;	/* Bypass gain with EQ disabled. */
@@ -736,7 +736,7 @@ snd_vortex_eqtoggle_get(struct snd_kcontrol *kcontrol,
 {
 	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
 	eqlzr_t *eq = &(vortex->eq);
-	//int i = kcontrol->private_value;
+	/* int i = kcontrol->private_value; */
 
 	ucontrol->value.integer.value[0] = eq->this54 ? 0 : 1;
 
@@ -749,7 +749,7 @@ snd_vortex_eqtoggle_put(struct snd_kcontrol *kcontrol,
 {
 	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
 	eqlzr_t *eq = &(vortex->eq);
-	//int i = kcontrol->private_value;
+	/* int i = kcontrol->private_value; */
 
 	eq->this54 = ucontrol->value.integer.value[0] ? 0 : 1;
 	vortex_Eqlzr_SetBypass(vortex, eq->this54);
@@ -900,7 +900,7 @@ static int __devinit vortex_eq_init(vortex_t * vortex)
 		kcontrol->private_value = i;
 		if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
 			return err;
-		//vortex->eqctrl[i] = kcontrol;
+		/* vortex->eqctrl[i] = kcontrol; */
 	}
 	/* EQ band levels */
 	if ((kcontrol = snd_ctl_new1(&vortex_levels_kcontrol, vortex)) == NULL)
@@ -916,7 +916,7 @@ static int vortex_eq_free(vortex_t * vortex)
 	/*
 	   //FIXME: segfault because vortex->eqctrl[i] == 4
 	   int i;
-	   for (i=0; i<10; i++) {
+	   for (i = 0; i < 10; i++) {
 	   if (vortex->eqctrl[i])
 	   snd_ctl_remove(vortex->card, vortex->eqctrl[i]);
 	   }
diff --git a/sound/pci/au88x0/au88x0_mixer.c b/sound/pci/au88x0/au88x0_mixer.c
index c92f493..cd3daf8 100644
--- a/sound/pci/au88x0/au88x0_mixer.c
+++ b/sound/pci/au88x0/au88x0_mixer.c
@@ -23,7 +23,7 @@ static int __devinit snd_vortex_mixer(vortex_t * vortex)
 	if ((err = snd_ac97_bus(vortex->card, 0, &ops, NULL, &pbus)) < 0)
 		return err;
 	memset(&ac97, 0, sizeof(ac97));
-	// Intialize AC97 codec stuff.
+	/* Intialize AC97 codec stuff. */
 	ac97.private_data = vortex;
 	ac97.scaps = AC97_SCAP_NO_SPDIF;
 	err = snd_ac97_mixer(pbus, &ac97, &vortex->codec);
diff --git a/sound/pci/au88x0/au88x0_mpu401.c b/sound/pci/au88x0/au88x0_mpu401.c
index 0dc8d25..4d9154f 100644
--- a/sound/pci/au88x0/au88x0_mpu401.c
+++ b/sound/pci/au88x0/au88x0_mpu401.c
@@ -72,7 +72,7 @@ static int __devinit snd_vortex_midi(vortex_t * vortex)
 
 	/* Check if anything is OK. */
 	temp = hwread(vortex->mmio, VORTEX_MIDI_DATA);
-	if (temp != MPU401_ACK /*0xfe */ ) {
+	if (temp != MPU401_ACK /*0xfe */) {
 		printk(KERN_ERR "midi port doesn't acknowledge!\n");
 		return -ENODEV;
 	}
diff --git a/sound/pci/au88x0/au88x0_pcm.c b/sound/pci/au88x0/au88x0_pcm.c
index b9d2f20..149769f 100644
--- a/sound/pci/au88x0/au88x0_pcm.c
+++ b/sound/pci/au88x0/au88x0_pcm.c
@@ -13,12 +13,12 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
- 
+
 /*
  * Vortex PCM ALSA driver.
  *
  * Supports ADB and WT DMA. Unfortunately, WT channels do not run yet.
- * It remains stuck,and DMA transfers do not happen. 
+ * It remains stuck,and DMA transfers do not happen.
  */
 #include <sound/asoundef.h>
 #include <linux/time.h>
@@ -103,7 +103,7 @@ static struct snd_pcm_hardware snd_vortex_playback_hw_wt = {
 		 SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP_VALID),
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	.rates = SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_CONTINUOUS,	// SNDRV_PCM_RATE_48000,
+	.rates = SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_CONTINUOUS,	/* SNDRV_PCM_RATE_48000, */
 	.rate_min = 8000,
 	.rate_max = 48000,
 	.channels_min = 1,
@@ -121,7 +121,7 @@ static int snd_vortex_pcm_open(struct snd_pcm_substream *substream)
 	vortex_t *vortex = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
-	
+
 	/* Force equal size periods */
 	if ((err =
 	     snd_pcm_hw_constraint_integer(runtime,
@@ -170,10 +170,10 @@ static int snd_vortex_pcm_open(struct snd_pcm_substream *substream)
 /* close callback */
 static int snd_vortex_pcm_close(struct snd_pcm_substream *substream)
 {
-	//vortex_t *chip = snd_pcm_substream_chip(substream);
+	/* vortex_t *chip = snd_pcm_substream_chip(substream); */
 	stream_t *stream = (stream_t *) substream->runtime->private_data;
 
-	// the hardware-specific codes will be here
+	/* the hardware-specific codes will be here */
 	if (stream != NULL) {
 		stream->substream = NULL;
 		stream->nr_ch = 0;
@@ -191,7 +191,7 @@ snd_vortex_pcm_hw_params(struct snd_pcm_substream *substream,
 	stream_t *stream = (stream_t *) (substream->runtime->private_data);
 	int err;
 
-	// Alloc buffer memory.
+	/* Alloc buffer memory. */
 	err =
 	    snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
 	if (err < 0) {
@@ -203,7 +203,7 @@ snd_vortex_pcm_hw_params(struct snd_pcm_substream *substream,
 	   params_period_bytes(hw_params), params_channels(hw_params));
 	 */
 	spin_lock_irq(&chip->lock);
-	// Make audio routes and config buffer DMA.
+	/* Make audio routes and config buffer DMA. */
 	if (VORTEX_PCM_TYPE(substream->pcm) != VORTEX_PCM_WT) {
 		int dma, type = VORTEX_PCM_TYPE(substream->pcm);
 		/* Dealloc any routes. */
@@ -253,7 +253,7 @@ static int snd_vortex_pcm_hw_free(struct snd_pcm_substream *substream)
 	stream_t *stream = (stream_t *) (substream->runtime->private_data);
 
 	spin_lock_irq(&chip->lock);
-	// Delete audio routes.
+	/* Delete audio routes. */
 	if (VORTEX_PCM_TYPE(substream->pcm) != VORTEX_PCM_WT) {
 		if (stream != NULL)
 			vortex_adb_allocroute(chip, stream->dma,
@@ -280,7 +280,7 @@ static int snd_vortex_pcm_prepare(struct snd_pcm_substream *substream)
 	stream_t *stream = (stream_t *) substream->runtime->private_data;
 	int dma = stream->dma, fmt, dir;
 
-	// set up the hardware with the current configuration.
+	/* set up the hardware with the current configuration. */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		dir = 1;
 	else
@@ -297,7 +297,7 @@ static int snd_vortex_pcm_prepare(struct snd_pcm_substream *substream)
 #ifndef CHIP_AU8810
 	else {
 		vortex_wtdma_setmode(chip, dma, 1, fmt, 0, 0);
-		// FIXME: Set rate (i guess using vortex_wt_writereg() somehow).
+		/* FIXME: Set rate (i guess using vortex_wt_writereg() somehow). */
 		vortex_wtdma_setstartbuffer(chip, dma, 0);
 	}
 #endif
@@ -315,8 +315,8 @@ static int snd_vortex_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	spin_lock(&chip->lock);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		// do something to start the PCM engine
-		//printk(KERN_INFO "vortex: start %d\n", dma);
+		/* do something to start the PCM engine */
+		/* printk(KERN_INFO "vortex: start %d\n", dma); */
 		stream->fifo_enabled = 1;
 		if (VORTEX_PCM_TYPE(substream->pcm) != VORTEX_PCM_WT) {
 			vortex_adbdma_resetup(chip, dma);
@@ -330,12 +330,12 @@ static int snd_vortex_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 #endif
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		// do something to stop the PCM engine
-		//printk(KERN_INFO "vortex: stop %d\n", dma);
+		/* do something to stop the PCM engine */
+		/* printk(KERN_INFO "vortex: stop %d\n", dma); */
 		stream->fifo_enabled = 0;
 		if (VORTEX_PCM_TYPE(substream->pcm) != VORTEX_PCM_WT)
 			vortex_adbdma_pausefifo(chip, dma);
-		//vortex_adbdma_stopfifo(chip, dma);
+		/* vortex_adbdma_stopfifo(chip, dma); */
 #ifndef CHIP_AU8810
 		else {
 			printk(KERN_INFO "vortex: wt stop %d\n", dma);
@@ -344,7 +344,7 @@ static int snd_vortex_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 #endif
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		//printk(KERN_INFO "vortex: pause %d\n", dma);
+		/* printk(KERN_INFO "vortex: pause %d\n", dma); */
 		if (VORTEX_PCM_TYPE(substream->pcm) != VORTEX_PCM_WT)
 			vortex_adbdma_pausefifo(chip, dma);
 #ifndef CHIP_AU8810
@@ -353,7 +353,7 @@ static int snd_vortex_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 #endif
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		//printk(KERN_INFO "vortex: resume %d\n", dma);
+		/* printk(KERN_INFO "vortex: resume %d\n", dma); */
 		if (VORTEX_PCM_TYPE(substream->pcm) != VORTEX_PCM_WT)
 			vortex_adbdma_resumefifo(chip, dma);
 #ifndef CHIP_AU8810
@@ -384,7 +384,7 @@ static snd_pcm_uframes_t snd_vortex_pcm_pointer(struct snd_pcm_substream *substr
 	else
 		current_ptr = vortex_wtdma_getlinearpos(chip, dma);
 #endif
-	//printk(KERN_INFO "vortex: pointer = 0x%x\n", current_ptr);
+	/* printk(KERN_INFO "vortex: pointer = 0x%x\n", current_ptr); */
 	spin_unlock(&chip->lock);
 	return (bytes_to_frames(substream->runtime, current_ptr));
 }
@@ -498,7 +498,7 @@ static int __devinit snd_vortex_new_pcm(vortex_t *chip, int idx, int nr)
 	if (!chip || idx < 0 || idx >= VORTEX_PCM_LAST)
 		return -ENODEV;
 
-	/* idx indicates which kind of PCM device. ADB, SPDIF, I2S and A3D share the 
+	/* idx indicates which kind of PCM device. ADB, SPDIF, I2S and A3D share the
 	 * same dma engine. WT uses it own separate dma engine whcih cant capture. */
 	if (idx == VORTEX_PCM_ADB)
 		nr_capt = nr;
@@ -510,7 +510,7 @@ static int __devinit snd_vortex_new_pcm(vortex_t *chip, int idx, int nr)
 		return err;
 	strcpy(pcm->name, vortex_pcm_name[idx]);
 	chip->pcm[idx] = pcm;
-	// This is an evil hack, but it saves a lot of duplicated code.
+	/* This is an evil hack, but it saves a lot of duplicated code. */
 	VORTEX_PCM_TYPE(pcm) = idx;
 	pcm->private_data = chip;
 	/* set operators */
@@ -519,9 +519,9 @@ static int __devinit snd_vortex_new_pcm(vortex_t *chip, int idx, int nr)
 	if (idx == VORTEX_PCM_ADB)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
 				&snd_vortex_playback_ops);
-	
+
 	/* pre-allocation of Scatter-Gather buffers */
-	
+
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
 					      snd_dma_pci_data(chip->pci_dev),
 					      0x10000, 0x10000);
diff --git a/sound/pci/au88x0/au88x0_synth.c b/sound/pci/au88x0/au88x0_synth.c
index 978b856..1fcd430 100644
--- a/sound/pci/au88x0/au88x0_synth.c
+++ b/sound/pci/au88x0/au88x0_synth.c
@@ -41,10 +41,10 @@ static void vortex_wt_setstereo(vortex_t * vortex, u32 wt, u32 stereo)
 {
 	int temp;
 
-	//temp = hwread(vortex->mmio, 0x80 + ((wt >> 0x5)<< 0xf) + (((wt & 0x1f) >> 1) << 2));
+	/* temp = hwread(vortex->mmio, 0x80 + ((wt >> 0x5)<< 0xf) + (((wt & 0x1f) >> 1) << 2)); */
 	temp = hwread(vortex->mmio, WT_STEREO(wt));
 	temp = (temp & 0xfe) | (stereo & 1);
-	//hwwrite(vortex->mmio, 0x80 + ((wt >> 0x5)<< 0xf) + (((wt & 0x1f) >> 1) << 2), temp);
+	/* hwwrite(vortex->mmio, 0x80 + ((wt >> 0x5)<< 0xf) + (((wt & 0x1f) >> 1) << 2), temp); */
 	hwwrite(vortex->mmio, WT_STEREO(wt), temp);
 }
 
@@ -68,22 +68,22 @@ static int vortex_wt_allocroute(vortex_t * vortex, int wt, int nr_ch)
 	wt_voice_t *voice = &(vortex->wt_voice[wt]);
 	int temp;
 
-	//FIXME: WT audio routing.
+	/* FIXME: WT audio routing. */
 	if (nr_ch) {
 		vortex_fifo_wtinitialize(vortex, wt, 1);
 		vortex_fifo_setwtvalid(vortex, wt, 1);
 		vortex_wt_setstereo(vortex, wt, nr_ch - 1);
 	} else
 		vortex_fifo_setwtvalid(vortex, wt, 0);
-	
+
 	/* Set mixdown mode. */
 	vortex_wt_setdsout(vortex, wt, 1);
 	/* Set other parameter registers. */
 	hwwrite(vortex->mmio, WT_SRAMP(0), 0x880000);
-	//hwwrite(vortex->mmio, WT_GMODE(0), 0xffffffff);
+	/* hwwrite(vortex->mmio, WT_GMODE(0), 0xffffffff); */
 #ifdef CHIP_AU8830
 	hwwrite(vortex->mmio, WT_SRAMP(1), 0x880000);
-	//hwwrite(vortex->mmio, WT_GMODE(1), 0xffffffff);
+	/* hwwrite(vortex->mmio, WT_GMODE(1), 0xffffffff); */
 #endif
 	hwwrite(vortex->mmio, WT_PARM(wt, 0), 0);
 	hwwrite(vortex->mmio, WT_PARM(wt, 1), 0);
@@ -91,7 +91,7 @@ static int vortex_wt_allocroute(vortex_t * vortex, int wt, int nr_ch)
 
 	temp = hwread(vortex->mmio, WT_PARM(wt, 3));
 	printk(KERN_DEBUG "vortex: WT PARM3: %x\n", temp);
-	//hwwrite(vortex->mmio, WT_PARM(wt, 3), temp);
+	/* hwwrite(vortex->mmio, WT_PARM(wt, 3), temp); */
 
 	hwwrite(vortex->mmio, WT_DELAY(wt, 0), 0);
 	hwwrite(vortex->mmio, WT_DELAY(wt, 1), 0);
@@ -151,7 +151,7 @@ static void vortex_wt_connect(vortex_t * vortex, int en)
 #if 0
 static int vortex_wt_GetReg(vortex_t * vortex, char reg, int wt)
 {
-	//int eax, esi;
+	/* int eax, esi; */
 
 	if (reg == 4) {
 		return hwread(vortex->mmio, WT_PARM(wt, 3));
@@ -175,7 +175,7 @@ vortex_wt_SetReg2(vortex_t * vortex, unsigned char reg, int wt,
 	   return 0;
 
 	   if ((reg - 0x20) > 0) {
-	   if ((reg - 0x21) != 0) 
+	   if ((reg - 0x21) != 0)
 	   return 0;
 	   eax = ((((b & 0xff) << 0xb) + (edx & 0xff)) << 4) + 0x208; // param 2
 	   } else {
@@ -186,7 +186,7 @@ vortex_wt_SetReg2(vortex_t * vortex, unsigned char reg, int wt,
 	return 1;
 }
 
-/*public: static void __thiscall CWTHal::SetReg(unsigned char,int,unsigned long) */
+/*public: static void __thiscall CWTHal::SetReg(unsigned char, int, unsigned long) */
 #endif
 static int
 vortex_wt_SetReg(vortex_t * vortex, unsigned char reg, int wt,
@@ -213,38 +213,38 @@ vortex_wt_SetReg(vortex_t * vortex, unsigned char reg, int wt,
 	switch (reg) {
 		/* Voice specific parameters */
 	case 0:		/* running */
-		//printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_RUN(wt), (int)val);
+		/* printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_RUN(wt), (int)val); */
 		hwwrite(vortex->mmio, WT_RUN(wt), val);
 		return 0xc;
 		break;
 	case 1:		/* param 0 */
-		//printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_PARM(wt,0), (int)val);
+		/* printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_PARM(wt,0), (int)val); */
 		hwwrite(vortex->mmio, WT_PARM(wt, 0), val);
 		return 0xc;
 		break;
 	case 2:		/* param 1 */
-		//printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_PARM(wt,1), (int)val);
+		/* printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_PARM(wt,1), (int)val); */
 		hwwrite(vortex->mmio, WT_PARM(wt, 1), val);
 		return 0xc;
 		break;
 	case 3:		/* param 2 */
-		//printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_PARM(wt,2), (int)val);
+		/* printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_PARM(wt,2), (int)val); */
 		hwwrite(vortex->mmio, WT_PARM(wt, 2), val);
 		return 0xc;
 		break;
 	case 4:		/* param 3 */
-		//printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_PARM(wt,3), (int)val);
+		/* printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_PARM(wt,3), (int)val); */
 		hwwrite(vortex->mmio, WT_PARM(wt, 3), val);
 		return 0xc;
 		break;
 	case 6:		/* mute */
-		//printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_MUTE(wt), (int)val);
+		/* printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_MUTE(wt), (int)val); */
 		hwwrite(vortex->mmio, WT_MUTE(wt), val);
 		return 0xc;
 		break;
 	case 0xb:
 		{		/* delay */
-			//printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_DELAY(wt,0), (int)val);
+			/* printk("vortex: WT SetReg(0x%x) = 0x%08x\n", WT_DELAY(wt,0), (int)val); */
 			hwwrite(vortex->mmio, WT_DELAY(wt, 3), val);
 			hwwrite(vortex->mmio, WT_DELAY(wt, 2), val);
 			hwwrite(vortex->mmio, WT_DELAY(wt, 1), val);
@@ -272,7 +272,7 @@ vortex_wt_SetReg(vortex_t * vortex, unsigned char reg, int wt,
 		return 0;
 		break;
 	}
-	//printk("vortex: WT SetReg(0x%x) = 0x%08x\n", ecx, (int)val);
+	/* printk("vortex: WT SetReg(0x%x) = 0x%08x\n", ecx, (int)val); */
 	hwwrite(vortex->mmio, ecx, val);
 	return 1;
 }
@@ -289,7 +289,7 @@ static void vortex_wt_init(vortex_t * vortex)
 	var10 &= 0xfffffffe;
 	var10 &= 0xfffffbff;
 	var10 |= 0x1800;
-	// var10 = 0x1AA2
+	/* var10 = 0x1AA2 */
 	var4 = 0x10000000;
 	varc = 0x00830000;
 	var8 = 0x00830000;
@@ -355,7 +355,7 @@ static void vortex_wt_SetFrequency(vortex_t * vortex, int wt, unsigned int sr)
 	wt_voice_t *voice = &(vortex->wt_voice[wt]);
 	u32 eax, edx;
 
-	//FIXME: 64 bit operation.
+	/* FIXME: 64 bit operation. */
 	eax = ((sr << 0xf) * 0x57619F1) & 0xffffffff;
 	edx = (((sr << 0xf) * 0x57619F1)) >> 0x20;
 
@@ -384,9 +384,9 @@ static void vortex_wt_SetFrequency(vortex_t * vortex, int wt, unsigned int sr)
 	voice->parm0 &= 0xffff0001;
 	voice->parm0 |= (eax & 0x7fff) << 1;
 	voice->parm1 = voice->parm0 | 1;
-	// Wt: this_1D4
-	//AuWt::WriteReg((ulong)(this_1DC<<4)+0x200, (ulong)this_1E4);
-	//AuWt::WriteReg((ulong)(this_1DC<<4)+0x204, (ulong)this_1E8);
+	/* Wt: this_1D4 */
+	/* AuWt::WriteReg((ulong)(this_1DC<<4)+0x200, (ulong)this_1E4); */
+	/* AuWt::WriteReg((ulong)(this_1DC<<4)+0x204, (ulong)this_1E8); */
 	hwwrite(vortex->mmio, WT_PARM(wt, 0), voice->parm0);
 	hwwrite(vortex->mmio, WT_PARM(wt, 1), voice->parm1);
 }
diff --git a/sound/pci/au88x0/au88x0_xtalk.c b/sound/pci/au88x0/au88x0_xtalk.c
index b4151e2..c8acf62 100644
--- a/sound/pci/au88x0/au88x0_xtalk.c
+++ b/sound/pci/au88x0/au88x0_xtalk.c
@@ -64,7 +64,7 @@ static xtalk_gains_t const asXtalkGains1Chan = {
 static xtalk_gains_t const asXtalkGainsAllChan = {
 	0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF, 0, 0x7FFF, 0x7FFF, 0x7FFF, 0x7FFF,
 	0
-	    //0x7FFF,0x7FFF,0x7FFF,0x7FFF,0x7fff,0x7FFF,0x7FFF,0x7FFF,0x7FFF,0x7fff
+	    /* 0x7FFF,0x7FFF,0x7FFF,0x7FFF,0x7fff,0x7FFF,0x7FFF,0x7FFF,0x7FFF,0x7fff */
 };
 static xtalk_gains_t const asXtalkGainsZeros;
 
@@ -672,7 +672,7 @@ static void vortex_XtalkHw_ZeroIO(vortex_t * vortex)
 
 static void vortex_XtalkHw_ZeroState(vortex_t * vortex)
 {
-	vortex_XtalkHw_ZeroIO(vortex);	// inlined
+	vortex_XtalkHw_ZeroIO(vortex);	/* inlined */
 
 	vortex_XtalkHw_SetLeftEQ(vortex, 0, 0, asXtalkCoefsZeros);
 	vortex_XtalkHw_SetRightEQ(vortex, 0, 0, asXtalkCoefsZeros);
@@ -680,14 +680,14 @@ static void vortex_XtalkHw_ZeroState(vortex_t * vortex)
 	vortex_XtalkHw_SetLeftXT(vortex, 0, 0, asXtalkCoefsZeros);
 	vortex_XtalkHw_SetRightXT(vortex, 0, 0, asXtalkCoefsZeros);
 
-	vortex_XtalkHw_SetGains(vortex, asXtalkGainsZeros);	// inlined
+	vortex_XtalkHw_SetGains(vortex, asXtalkGainsZeros);	/* inlined */
 
-	vortex_XtalkHw_SetDelay(vortex, 0, 0);	// inlined
+	vortex_XtalkHw_SetDelay(vortex, 0, 0);	/* inlined */
 
-	vortex_XtalkHw_SetLeftDline(vortex, alXtalkDlineZeros);	// inlined
-	vortex_XtalkHw_SetRightDline(vortex, alXtalkDlineZeros);	// inlined
-	vortex_XtalkHw_SetLeftDline(vortex, alXtalkDlineZeros);	// inlined
-	vortex_XtalkHw_SetRightDline(vortex, alXtalkDlineZeros);	// inlined
+	vortex_XtalkHw_SetLeftDline(vortex, alXtalkDlineZeros);	/* inlined */
+	vortex_XtalkHw_SetRightDline(vortex, alXtalkDlineZeros);	/* inlined */
+	vortex_XtalkHw_SetLeftDline(vortex, alXtalkDlineZeros);	/* inlined */
+	vortex_XtalkHw_SetRightDline(vortex, alXtalkDlineZeros);	/* inlined */
 
 	vortex_XtalkHw_SetLeftEQStates(vortex, asXtalkInStateZeros,
 				       asXtalkOutStateZeros);
@@ -707,7 +707,7 @@ static void vortex_XtalkHw_ProgramPipe(vortex_t * vortex)
 	vortex_XtalkHw_SetLeftXT(vortex, 0, 0, asXtalkCoefsZeros);
 	vortex_XtalkHw_SetRightXT(vortex, 0, 0, asXtalkCoefsZeros);
 
-	vortex_XtalkHw_SetDelay(vortex, 0, 0);	// inlined
+	vortex_XtalkHw_SetDelay(vortex, 0, 0);	/* inlined */
 }
 
 static void vortex_XtalkHw_ProgramXtalkWide(vortex_t * vortex)
@@ -724,7 +724,7 @@ static void vortex_XtalkHw_ProgramXtalkWide(vortex_t * vortex)
 				  sXtalkWideShiftLeftXt,
 				  asXtalkWideCoefsLeftXt);
 
-	vortex_XtalkHw_SetDelay(vortex, wXtalkWideRightDelay, wXtalkWideLeftDelay);	// inlined
+	vortex_XtalkHw_SetDelay(vortex, wXtalkWideRightDelay, wXtalkWideLeftDelay);	/* inlined */
 }
 
 static void vortex_XtalkHw_ProgramXtalkNarrow(vortex_t * vortex)
@@ -743,13 +743,13 @@ static void vortex_XtalkHw_ProgramXtalkNarrow(vortex_t * vortex)
 				  sXtalkNarrowShiftLeftXt,
 				  asXtalkNarrowCoefsLeftXt);
 
-	vortex_XtalkHw_SetDelay(vortex, wXtalkNarrowRightDelay, wXtalkNarrowLeftDelay);	// inlined
+	vortex_XtalkHw_SetDelay(vortex, wXtalkNarrowRightDelay, wXtalkNarrowLeftDelay);	/* inlined */
 }
 
 static void vortex_XtalkHw_ProgramDiamondXtalk(vortex_t * vortex)
 {
 
-	//sDiamondKLeftEq,sDiamondKRightXt,asDiamondCoefsLeftEq
+	/* sDiamondKLeftEq,sDiamondKRightXt,asDiamondCoefsLeftEq */
 	vortex_XtalkHw_SetLeftEQ(vortex, sDiamondKLeftEq,
 				 sDiamondShiftLeftEq, asDiamondCoefsLeftEq);
 	vortex_XtalkHw_SetRightEQ(vortex, sDiamondKRightEq,
@@ -759,7 +759,7 @@ static void vortex_XtalkHw_ProgramDiamondXtalk(vortex_t * vortex)
 	vortex_XtalkHw_SetRightXT(vortex, sDiamondKLeftXt,
 				  sDiamondShiftLeftXt, asDiamondCoefsLeftXt);
 
-	vortex_XtalkHw_SetDelay(vortex, wDiamondRightDelay, wDiamondLeftDelay);	// inlined
+	vortex_XtalkHw_SetDelay(vortex, wDiamondRightDelay, wDiamondLeftDelay);	/* inlined */
 }
 
 static void vortex_XtalkHw_init(vortex_t * vortex)
diff --git a/sound/pci/au88x0/au88x0_xtalk.h b/sound/pci/au88x0/au88x0_xtalk.h
index 7f4534b..ead8453 100644
--- a/sound/pci/au88x0/au88x0_xtalk.h
+++ b/sound/pci/au88x0/au88x0_xtalk.h
@@ -22,7 +22,7 @@
  *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-/* The crosstalk canceler supports 5 stereo input channels. The result is 
+/* The crosstalk canceler supports 5 stereo input channels. The result is
    available at one single output route pair (stereo). */
 
 #ifndef _AU88X0_CXTALK_H
