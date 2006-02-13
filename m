From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001835]: Patch to add volume control per voice for au88x0
Date: Mon, 13 Feb 2006 16:07:22 +0100
Message-ID: <635ff70d24ff83b6401e871b268f1ac3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 72CB5168
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 16:07:22 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1835> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1835
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-10-2006 03:28 CET
Last Modified:              02-13-2006 16:07 CET
======================================================================
Summary:                    Patch to add volume control per voice for au88x0
Description: 
As the proposed API "PCM volume control per snd_pcm_open()" have not been
finalised, I upload the program ( a workaround tool instead of demo ) to
test the new feature "Volume control per voice" for au88x0 using
SNDRV_CTL_ELEM_IFACE_PCM
======================================================================

----------------------------------------------------------------------
 Raymond - 02-11-06 11:19 
----------------------------------------------------------------------
Index: alsa-driver/alsa-kernel/pci/au88x0/au88x0.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0.c,v
retrieving revision 1.26
diff -u -r1.26 au88x0.c
--- alsa-driver/alsa-kernel/pci/au88x0/au88x0.c	13 Jan 2006 17:16:29
-0000	1.26
+++ alsa-driver/alsa-kernel/pci/au88x0/au88x0.c	11 Feb 2006 08:10:33
-0000
@@ -262,6 +262,11 @@
 	}
 	snd_vortex_workaround(pci, pcifix[dev]);
 	// (4) Alloc components.
+	// snd_ac97_mixer and Vortex mixer.
+	if ((err = snd_vortex_mixer(chip)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
 	// ADB pcm.
 	if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_ADB, NR_ADB)) < 0) {
 		snd_card_free(card);
@@ -293,11 +298,6 @@
 		return err;
 	}
 #endif
-	// snd_ac97_mixer and Vortex mixer.
-	if ((err = snd_vortex_mixer(chip)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
 	if ((err = snd_vortex_midi(chip)) < 0) {
 		snd_card_free(card);
 		return err;
Index: alsa-driver/alsa-kernel/pci/au88x0/au88x0.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0.h,v
retrieving revision 1.15
diff -u -r1.15 au88x0.h
--- alsa-driver/alsa-kernel/pci/au88x0/au88x0.h	13 Jan 2006 17:16:29
-0000	1.15
+++ alsa-driver/alsa-kernel/pci/au88x0/au88x0.h	11 Feb 2006 08:10:34
-0000
@@ -161,6 +161,9 @@
 	s8 mixxtlk[2];	/* crosstalk canceler mixer inputs. */
 #endif
 	u32 fixed_res[5];
+	snd_kcontrol_t *ctl_adb_pcm_vol[NR_ADB];
+	int mixin_adb[NR_ADB][4];
+	int adb_pcm_vol[NR_ADB][4];
 
 #ifndef CHIP_AU8820
 	/* Hardware equalizer structs */
@@ -244,7 +247,7 @@
 /* Connection  stuff. */
 static void vortex_connect_default(vortex_t * vortex, int en);
 static int vortex_adb_allocroute(vortex_t * vortex, int dma, int nr_ch,
-				 int dir, int type);
+				 int dir, int type, snd_pcm_substream_t *substream);
 static char vortex_adb_checkinout(vortex_t * vortex, int resmap[], int
out,
 				  int restype);
 #ifndef CHIP_AU8810
Index: alsa-driver/alsa-kernel/pci/au88x0/au88x0_core.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_core.c,v
retrieving revision 1.15
diff -u -r1.15 au88x0_core.c
--- alsa-driver/alsa-kernel/pci/au88x0/au88x0_core.c	13 Jan 2006 17:16:29
-0000	1.15
+++ alsa-driver/alsa-kernel/pci/au88x0/au88x0_core.c	11 Feb 2006 08:10:37
-0000
@@ -2038,8 +2038,6 @@
 }
 
 /* Default Connections  */
-static int
-vortex_adb_allocroute(vortex_t * vortex, int dma, int nr_ch, int dir, int
type);
 
 static void vortex_connect_default(vortex_t * vortex, int en)
 {
@@ -2099,10 +2097,11 @@
   Return: Return allocated DMA or same DMA passed as "dma" when dma >=
0.
 */
 static int
-vortex_adb_allocroute(vortex_t * vortex, int dma, int nr_ch, int dir, int
type)
+vortex_adb_allocroute(vortex_t * vortex, int dma, int nr_ch, int dir, int
type, 
+snd_pcm_substream_t *substream)
 {
 	stream_t *stream;
-	int i, en;
+	int i, en, subdev;
 	
 	if ((nr_ch == 3)
 	    || ((dir == SNDRV_PCM_STREAM_CAPTURE) && (nr_ch > 2)))
@@ -2125,6 +2124,7 @@
 	stream->dma = dma;
 	stream->dir = dir;
 	stream->type = type;
+	subdev = substream->number;
 
 	/* PLAYBACK ROUTES. */
 	if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -2152,7 +2152,10 @@
 						       0,
 						       sizeof(unsigned char) * VORTEX_RESOURCE_LAST);
 						return -EBUSY;
-					}
+					};
+					if (stream->type == VORTEX_PCM_ADB) {
+						vortex->mixin_adb[subdev][i] = mix[i];
+				        }
 				}
 			}
 		}
@@ -2256,8 +2259,23 @@
 				     ADB_SPDIFOUT(1));
 		}
 #endif
-	/* CAPTURE ROUTES. */
+		if (stream->type == VORTEX_PCM_ADB) {
+			for (i=0; i<2; i++) {
+#ifdef AU8820_CHIP
+				vortex->adb_pcm_vol[subdev][i] = MIX_DEFIGAIN;
+#else
+				vortex->adb_pcm_vol[subdev][i] = 0;	
+#endif
+			};
+			if (VORTEX_IS_QUAD(vortex)) {
+				for (i=2; i<4; i++) {
+					vortex->adb_pcm_vol[subdev][i] = MIX_DEFIGAIN;
+				};
+			};
+			vortex->ctl_adb_pcm_vol[subdev]->private_value = dma;
+		};
 	} else {
+	/* CAPTURE ROUTES. */
 		int src[2], mix[2];
 
 		/* Get SRC and MIXER hardware resources. */
Index: alsa-driver/alsa-kernel/pci/au88x0/au88x0_pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_pcm.c,v
retrieving revision 1.11
diff -u -r1.11 au88x0_pcm.c
--- alsa-driver/alsa-kernel/pci/au88x0/au88x0_pcm.c	17 Nov 2005 14:55:19
-0000	1.11
+++ alsa-driver/alsa-kernel/pci/au88x0/au88x0_pcm.c	11 Feb 2006 08:10:38
-0000
@@ -116,6 +116,17 @@
 	.periods_max = 64,
 };
 #endif
+
+static void snd_vortex_notify_pcm_change(snd_card_t * card,
snd_kcontrol_t *kctl, int activate)
+{
+//	snd_runtime_check(kctl != NULL, return);
+	if (activate)
+		kctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
+	else
+		kctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_INACTIVE;
+	snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &(kctl->id));
+}
+
 /* open callback */
 static int snd_vortex_pcm_open(struct snd_pcm_substream *substream)
 {
@@ -171,11 +182,18 @@
 /* close callback */
 static int snd_vortex_pcm_close(struct snd_pcm_substream *substream)
 {
-	//vortex_t *chip = snd_pcm_substream_chip(substream);
+	vortex_t *vortex;
 	stream_t *stream = (stream_t *) substream->runtime->private_data;
 
 	// the hardware-specific codes will be here
 	if (stream != NULL) {
+		if (VORTEX_PCM_TYPE(substream->pcm) == VORTEX_PCM_ADB) {
+		    	if ( substream->stream == SNDRV_PCM_STREAM_PLAYBACK ) {
+				vortex = snd_pcm_substream_chip(substream);
+				snd_vortex_notify_pcm_change(vortex->card, 
+                               
		vortex->ctl_adb_pcm_vol[substream->number], 0);
+			};
+		};
 		stream->substream = NULL;
 		stream->nr_ch = 0;
 	}
@@ -214,16 +232,22 @@
 		if (stream != NULL)
 			vortex_adb_allocroute(chip, stream->dma,
 					      stream->nr_ch, stream->dir,
-					      stream->type);
+					      stream->type, substream);
 		/* Alloc routes. */
 		dma =
 		    vortex_adb_allocroute(chip, -1,
 					  params_channels(hw_params),
-					  substream->stream, type);
+					  substream->stream, type, substream);
 		if (dma < 0) {
 			spin_unlock_irq(&chip->lock);
 			return dma;
-		}
+		};
+	    	if ( substream->stream == SNDRV_PCM_STREAM_PLAYBACK ) {
+			if (VORTEX_PCM_TYPE(substream->pcm) == VORTEX_PCM_ADB ) {
+				snd_vortex_notify_pcm_change(chip->card, 
+					chip->ctl_adb_pcm_vol[substream->number], 1);
+			};
+		};
 		stream = substream->runtime->private_data = &chip->dma_adb[dma];
 		stream->substream = substream;
 		/* Setup Buffers. */
@@ -262,7 +286,7 @@
 		if (stream != NULL)
 			vortex_adb_allocroute(chip, stream->dma,
 					      stream->nr_ch, stream->dir,
-					      stream->type);
+					      stream->type, substream);
 	}
 #ifndef CHIP_AU8810
 	else {
@@ -498,6 +522,112 @@
 	},
 };
 
+/* ADB PCM Volume control */
+
+static int snd_vortex_adb_pcm_vol_info(snd_kcontrol_t *kcontrol,
snd_ctl_elem_info_t * uinfo)
+{
+	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = (VORTEX_IS_QUAD(vortex) ? 4 : 2);
+	uinfo->value.integer.min = -64;            // -48dB                   
+	uinfo->value.integer.max = 8;              //  +6dB
+	return 0;
+}
+
+static int snd_vortex_adb_pcm_vol_get(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
+{
+	int chn,subdevice;
+	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
+	subdevice = kcontrol->id.subdevice;
+	for (chn=0; chn<(VORTEX_IS_QUAD(vortex) ? 4 : 2 ); chn++) 
+		ucontrol->value.integer.value[chn] =
vortex->adb_pcm_vol[subdevice][chn];	
+	return 0;
+}
+
+static int snd_vortex_adb_pcm_change_vol(vortex_t *vortex,int mixin,int
mix,int volume)
+{
+        if ( volume < -64 )
+		vortex_mix_setinputvolumebyte(vortex, mix, mixin, 0x80);          
+	else
+		vortex_mix_setinputvolumebyte(vortex, mix, mixin, volume);          
+	return 0;
+}
+
+/*
+	Use the hardware mixer of the vortex chip to change the volume of pcm
substream
+*/
+static int snd_vortex_adb_pcm_vol_put(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
+{
+	int chn,changed,dma,subdev,no_of_speakers;
+	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
+	changed = 0;
+	if ( ( kcontrol->vd[0].access & SNDRV_CTL_ELEM_ACCESS_INACTIVE ) == 0 )
{
+		no_of_speakers = (VORTEX_IS_QUAD(vortex) ? 4 : 2);
+	        subdev = kcontrol->id.subdevice;
+		for (chn=0; chn<no_of_speakers; chn++) {
+			if ( vortex->adb_pcm_vol[subdev][chn] !=
ucontrol->value.integer.value[chn] )
+				changed=1;
+			vortex->adb_pcm_vol[subdev][chn] =
ucontrol->value.integer.value[chn];
+		};
+		dma = kcontrol->private_value;
+		switch(vortex->dma_adb[dma].nr_ch) {
+/*
+	Change the volume of the two/four speakers for mono pcm
+*/
+		case 1:
+			for (chn=0; chn<no_of_speakers; chn++) {  
+				snd_vortex_adb_pcm_change_vol(vortex,
+					vortex->mixin_adb[subdev][0],
+					vortex->mixplayb[chn], 
+					vortex->adb_pcm_vol[subdev][chn]);
+			};
+			break;
+		case 2:
+			for (chn=0; chn<2; chn++) {
+/*
+	Change the volume of the front speakers for stereo pcm
+*/
+				snd_vortex_adb_pcm_change_vol(vortex,
+					vortex->mixin_adb[subdev][chn],
+					vortex->mixplayb[chn], 
+					vortex->adb_pcm_vol[subdev][chn]);
+/*
+	Change the volume of the rear speakers for stereo pcm
+*/
+				if (VORTEX_IS_QUAD(vortex)) {
+				    	snd_vortex_adb_pcm_change_vol(
+                                       		vortex, 
+						vortex->mixin_adb[subdev][chn],
+						vortex->mixplayb[chn+2], 
+						vortex->adb_pcm_vol[subdev][chn+2]);
+				};
+			};
+			break;
+/*
+	Change the volume of the four speakers for 4-channels pcm
+*/
+		case 4:
+			for (chn=0; chn<4; chn++) {
+				snd_vortex_adb_pcm_change_vol(vortex,
+					vortex->mixin_adb[subdev][chn],
+					vortex->mixplayb[chn],
+					vortex->adb_pcm_vol[subdev][chn]);
+			};
+			break;
+		};
+	};
+	return changed;
+}
+
+static snd_kcontrol_new_t snd_vortex_adb_pcm_vol = {
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		"PCM Playback Volume",
+	.access = 	SNDRV_CTL_ELEM_ACCESS_READWRITE |
SNDRV_CTL_ELEM_ACCESS_INACTIVE,
+	.info =		snd_vortex_adb_pcm_vol_info,
+	.get =		snd_vortex_adb_pcm_vol_get,
+	.put =		snd_vortex_adb_pcm_vol_put,
+};
+
 /* create a pcm device */
 static int __devinit snd_vortex_new_pcm(vortex_t * chip, int idx, int
nr)
 {
@@ -546,5 +676,20 @@
 				return err;
 		}
 	}
+	if (VORTEX_PCM_TYPE(pcm) == VORTEX_PCM_ADB) {
+		for (i= 0; i<NR_ADB; i++) {
+			chip->ctl_adb_pcm_vol[i] =
snd_ctl_new1(&snd_vortex_adb_pcm_vol,chip);
+			if (!chip->ctl_adb_pcm_vol[i]) {
+				snd_printk("snd_ctl_new1() failed - adb_pcm_vol\n");
+				return -ENOMEM;
+			};
+			chip->ctl_adb_pcm_vol[i]->id.device = 0;
+			chip->ctl_adb_pcm_vol[i]->id.subdevice = i;
+                        if ((err = snd_ctl_add(chip->card,
chip->ctl_adb_pcm_vol[i])) < 0) {
+				snd_printk("snd_ctl_add() failed - adb_pcm_vol\n");
+				return err;
+			};
+		};
+	};
 	return 0;
 }

----------------------------------------------------------------------
 Raymond - 02-13-06 16:07 
----------------------------------------------------------------------
Patch to add device number to IEC958 kcontrol of au88x0
- spdif is device 1 of au88x0 


Index: alsa-driver/alsa-kernel/pci/au88x0/au88x0_pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_pcm.c,v
retrieving revision 1.11
diff -u -r1.11 au88x0_pcm.c
--- alsa-driver/alsa-kernel/pci/au88x0/au88x0_pcm.c	17 Nov 2005 14:55:19
-0000	1.11
+++ alsa-driver/alsa-kernel/pci/au88x0/au88x0_pcm.c	13 Feb 2006 15:01:37
-0000
@@ -542,9 +676,25 @@
 			kctl = snd_ctl_new1(&snd_vortex_mixer_spdif[i], chip);
 			if (!kctl)
 				return -ENOMEM;
+			kctl->id.device = 1;
 			if ((err = snd_ctl_add(chip->card, kctl)) < 0)
 				return err;
 		}
 	}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-10-06 03:28 Raymond        New Issue                                    
02-10-06 03:30 Raymond        File Added: iface_pcm.c                      
02-11-06 11:19 Raymond        Note Added: 0008014                          
02-13-06 16:07 Raymond        Note Added: 0008053                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
