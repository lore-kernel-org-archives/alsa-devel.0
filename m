From: Sasha Khapyorsky <sashak@smlink.com>
Subject: au88x0 modem [was: Re: Mo' better modem support]
Date: Tue, 13 Sep 2005 03:09:09 +0300
Message-ID: <20050913000909.GB19713@tecr>
References: <s5h64tfs8wm.wl%tiwai@suse.de> <431D554E.8050500@netvigator.com> <20050906142917.GA30523@sashak.softier1.local> <431E3771.8090303@netvigator.com> <20050907064449.GA8391@titan.lahn.de> <4321B5A4.5090803@netvigator.com> <20050911124530.GA16795@titan.lahn.de> <4325AEA3.1090602@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <4325AEA3.1090602@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>, pmhahn@titan.lahn.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 00:36 Tue 13 Sep     , Raymond wrote:
> >>cat /proc/asound/au8810/codec97#0/ac97#0-0+regs
> >0:7c = 8384
> >0:7e = 7605

> Is it STAC9705 ?
> 
> 18-bit full-duplex audio codec with intergrated modem analog front end.
> 
> http://www6.tomshardware.com/mobile/20010126/notebooks-06.html
> 
> What is the usage of MOT6269353 if it already connected to STAC9705 ?

It is likely secondary modem-only codec (Motorola/SiLabs).

Philipp,

Could you try the patch below? And then look again at '/proc/asond/au8810'?

This is against CVS, untested and may be dangerous because I know nothing
about au8810 (somebody knows, please comment).

Sasha.


Index: alsa-kernel/pci/au88x0/au8810.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au8810.h,v
retrieving revision 1.3
diff -u -p -r1.3 au8810.h
--- alsa-kernel/pci/au88x0/au8810.h	13 Apr 2004 15:26:27 -0000	1.3
+++ alsa-kernel/pci/au88x0/au8810.h	12 Sep 2005 23:35:26 -0000
@@ -171,9 +171,9 @@
 #define VORTEX_CODEC_CTRL	0x29184
 #define VORTEX_CODEC_EN		0x29190
 #define		EN_CODEC0	0x00000300
-#define 	EN_AC98		0x00000c00 /* Modem AC98 slots. */
+#define 	EN_MODEM	0x00000c00 /* Modem AC98 slots. */
 #define		EN_CODEC1	0x00003000
-#define		EN_CODEC	(EN_CODEC0 | EN_CODEC1)
+#define		EN_CODEC	(EN_CODEC0 | EN_MODEM | EN_CODEC1)
 #define		EN_SPORT	0x00030000
 #define		EN_SPDIF	0x000c0000
 
Index: alsa-kernel/pci/au88x0/au8820.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au8820.h,v
retrieving revision 1.3
diff -u -p -r1.3 au8820.h
--- alsa-kernel/pci/au88x0/au8820.h	13 Apr 2004 15:26:27 -0000	1.3
+++ alsa-kernel/pci/au88x0/au8820.h	12 Sep 2005 23:35:26 -0000
@@ -158,7 +158,10 @@
 /* CODEC */
 #define VORTEX_CODEC_CTRL 0x11984
 #define VORTEX_CODEC_EN 0x11990
-#define		EN_CODEC	0x00000300
+#define		EN_CODEC0	0x00000300
+#define		EN_MODEM	0x00000c00
+#define		EN_CODEC1	0x00003000
+#define		EN_CODEC	(EN_CODEC0|EN_MODEM|EN_CODEC1)
 #define		EN_SPORT	0x00030000
 #define		EN_SPDIF	0x000c0000
 #define VORTEX_CODEC_CHN 0x11880
Index: alsa-kernel/pci/au88x0/au8830.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au8830.h,v
retrieving revision 1.3
diff -u -p -r1.3 au8830.h
--- alsa-kernel/pci/au88x0/au8830.h	13 Apr 2004 15:26:27 -0000	1.3
+++ alsa-kernel/pci/au88x0/au8830.h	12 Sep 2005 23:35:27 -0000
@@ -203,12 +203,12 @@
 #define VORTEX_CODEC_SPORTCTRL 0x2918c
 
 #define VORTEX_CODEC_EN 0x29190
-#define		EN_AUDIO0		0x00000300
+#define		EN_CODEC0		0x00000300
 #define		EN_MODEM		0x00000c00
-#define		EN_AUDIO1		0x00003000
+#define		EN_CODEC1		0x00003000
 #define		EN_SPORT		0x00030000
 #define		EN_SPDIF		0x000c0000
-#define		EN_CODEC		(EN_AUDIO1 | EN_AUDIO0)
+#define		EN_CODEC		(EN_CODEC0|EN_MODEM|EN_CODEC1)
 
 #define VORTEX_SPDIF_SMPRATE	0x29194
 
Index: alsa-kernel/pci/au88x0/au88x0.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0.h,v
retrieving revision 1.11
diff -u -p -r1.11 au88x0.h
--- alsa-kernel/pci/au88x0/au88x0.h	22 Mar 2005 08:50:55 -0000	1.11
+++ alsa-kernel/pci/au88x0/au88x0.h	12 Sep 2005 23:35:27 -0000
@@ -135,7 +135,8 @@ struct snd_vortex {
 	snd_pcm_t *pcm[VORTEX_PCM_LAST];
 
 	snd_rawmidi_t *rmidi;	/* Legacy Midi interface. */
-	ac97_t *codec;
+	unsigned int num_of_codecs;
+	ac97_t *codecs[2];
 
 	/* Stream structs. */
 	stream_t dma_adb[NR_ADB];
Index: alsa-kernel/pci/au88x0/au88x0_core.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_core.c,v
retrieving revision 1.11
diff -u -p -r1.11 au88x0_core.c
--- alsa-kernel/pci/au88x0/au88x0_core.c	23 Feb 2005 11:00:31 -0000	1.11
+++ alsa-kernel/pci/au88x0/au88x0_core.c	12 Sep 2005 23:35:33 -0000
@@ -2511,6 +2511,11 @@ static void vortex_codec_init(vortex_t *
 	/* Enable codec channels 0 and 1. */
 	hwwrite(vortex->mmio, VORTEX_CODEC_EN,
 		hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_CODEC);
+	vortex->num_of_codecs = 1;
+	/* nothing know about that */
+	msleep(2);
+	if (hwread(vortex->mmio, VORTEX_CODEC_EN)&(EN_CODEC1|EN_MODEM))
+		vortex->num_of_codecs = 2;
 }
 
 static void
Index: alsa-kernel/pci/au88x0/au88x0_mixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_mixer.c,v
retrieving revision 1.5
diff -u -p -r1.5 au88x0_mixer.c
--- alsa-kernel/pci/au88x0/au88x0_mixer.c	23 Mar 2005 17:04:16 -0000	1.5
+++ alsa-kernel/pci/au88x0/au88x0_mixer.c	12 Sep 2005 23:35:33 -0000
@@ -15,7 +15,7 @@ static int __devinit snd_vortex_mixer(vo
 {
 	ac97_bus_t *pbus;
 	ac97_template_t ac97;
-	int err;
+	int i, err;
 	static ac97_bus_ops_t ops = {
 		.write = vortex_codec_write,
 		.read = vortex_codec_read,
@@ -27,7 +27,10 @@ static int __devinit snd_vortex_mixer(vo
 	// Intialize AC97 codec stuff.
 	ac97.private_data = vortex;
 	ac97.scaps = AC97_SCAP_NO_SPDIF;
-	err = snd_ac97_mixer(pbus, &ac97, &vortex->codec);
-	vortex->isquad = ((vortex->codec == NULL) ?  0 : (vortex->codec->ext_id&0x80));
+	for (i = 0 ; i < vortex->num_of_codecs ; i++) {
+		ac97.num = i;
+		err = snd_ac97_mixer(pbus, &ac97, &vortex->codecs[i]);
+	}
+	vortex->isquad = ((vortex->codecs[0] == NULL) ?  0 : (vortex->codecs[0]->ext_id&0x80));
 	return err;
 }


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
