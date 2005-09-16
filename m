From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Re: au88x0 modem
Date: Fri, 16 Sep 2005 21:47:08 +0300
Message-ID: <20050916184708.GF17864@tecr>
References: <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local> <20050916084653.GB524@titan.lahn.de> <432A8887.4020808@netvigator.com> <20050916103604.GA3168@titan.lahn.de> <432AB4B1.1050808@netvigator.com> <20050916144247.GA2425@titan.lahn.de> <20050916144907.GA2454@titan.lahn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050916144907.GA2454@titan.lahn.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Raymond <rayau@netvigator.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 16:49 Fri 16 Sep     , Philipp Matthias Hahn wrote:
> Hello!
> 
> On Fri, Sep 16, 2005 at 04:42:47PM +0200, Philipp Matthias Hahn wrote:
> > Looks like I lost the normal ac97#1-1* files in
> > /proc/asound/card0/codec97#0:
> > 	$ ls /proc/asound/card0/codec97#0/
> > 	mc97#1-1  mc97#1-1+regs
> 
> Worse, two times the directories "codec97#0" with the same name:

The patch is wrong, audio is removed, ac97bus is initialized twice.

I would suggest (after reboot) to use cleaned ALSA CVS version + two 
attached patches. Remember to build with '--with-debug=detect'.

Sasha.

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au88x0_codecid.patch"


This patch extends au88x0 AC97 codec access procedures to handle multiple
codecs properly.

Signed-off-by: Sasha Khapyorsky

Index: alsa-kernel/pci/au88x0/au8810.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au8810.h,v
retrieving revision 1.3
diff -u -p -r1.3 au8810.h
--- alsa-kernel/pci/au88x0/au8810.h	13 Apr 2004 15:26:27 -0000	1.3
+++ alsa-kernel/pci/au88x0/au8810.h	15 Sep 2005 12:23:52 -0000
@@ -178,11 +178,6 @@
 #define		EN_SPDIF	0x000c0000
 
 #define VORTEX_CODEC_CHN 	0x29080
-#define VORTEX_CODEC_WRITE	0x00800000
-#define VORTEX_CODEC_ADDSHIFT 	16
-#define VORTEX_CODEC_ADDMASK	0x7f0000	/* 0x000f0000 */
-#define VORTEX_CODEC_DATSHIFT	0
-#define VORTEX_CODEC_DATMASK	0xffff
 #define VORTEX_CODEC_IO		0x29188
 
 /* SPDIF */
Index: alsa-kernel/pci/au88x0/au8820.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au8820.h,v
retrieving revision 1.3
diff -u -p -r1.3 au8820.h
--- alsa-kernel/pci/au88x0/au8820.h	13 Apr 2004 15:26:27 -0000	1.3
+++ alsa-kernel/pci/au88x0/au8820.h	15 Sep 2005 12:23:52 -0000
@@ -162,11 +162,6 @@
 #define		EN_SPORT	0x00030000
 #define		EN_SPDIF	0x000c0000
 #define VORTEX_CODEC_CHN 0x11880
-#define VORTEX_CODEC_WRITE 0x00800000
-#define VORTEX_CODEC_ADDSHIFT 16
-#define VORTEX_CODEC_ADDMASK 0x7f0000	/* 0x000f0000 */
-#define VORTEX_CODEC_DATSHIFT 0
-#define VORTEX_CODEC_DATMASK 0xffff
 #define VORTEX_CODEC_IO 0x11988
 
 #define VORTEX_SPDIF_FLAGS		0x1005c	/* FIXME */
Index: alsa-kernel/pci/au88x0/au8830.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au8830.h,v
retrieving revision 1.3
diff -u -p -r1.3 au8830.h
--- alsa-kernel/pci/au88x0/au8830.h	13 Apr 2004 15:26:27 -0000	1.3
+++ alsa-kernel/pci/au88x0/au8830.h	15 Sep 2005 12:23:52 -0000
@@ -194,11 +194,6 @@
 
 #define VORTEX_CODEC_CTRL 0x29184
 #define VORTEX_CODEC_IO 0x29188
-#define 	VORTEX_CODEC_WRITE 0x00800000
-#define 	VORTEX_CODEC_ADDSHIFT 16
-#define 	VORTEX_CODEC_ADDMASK 0x7f0000	/* 0x000f0000 */
-#define 	VORTEX_CODEC_DATSHIFT 0
-#define 	VORTEX_CODEC_DATMASK 0xffff
 
 #define VORTEX_CODEC_SPORTCTRL 0x2918c
 
Index: alsa-kernel/pci/au88x0/au88x0.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0.h,v
retrieving revision 1.11
diff -u -p -r1.11 au88x0.h
--- alsa-kernel/pci/au88x0/au88x0.h	22 Mar 2005 08:50:55 -0000	1.11
+++ alsa-kernel/pci/au88x0/au88x0.h	15 Sep 2005 12:23:52 -0000
@@ -79,6 +79,14 @@
 #define VORTEX_RESOURCE_A3D	0x00000004
 #define VORTEX_RESOURCE_LAST	0x00000005
 
+/* codec io: VORTEX_CODEC_IO bits */
+#define VORTEX_CODEC_ID_SHIFT	24
+#define VORTEX_CODEC_WRITE	0x00800000
+#define VORTEX_CODEC_ADDSHIFT 	16
+#define VORTEX_CODEC_ADDMASK	0x7f0000
+#define VORTEX_CODEC_DATSHIFT	0
+#define VORTEX_CODEC_DATMASK	0xffff
+
 /* Check for SDAC bit in "Extended audio ID" AC97 register */
 //#define VORTEX_IS_QUAD(x) (((x)->codec == NULL) ?  0 : ((x)->codec->ext_id&0x80))
 #define VORTEX_IS_QUAD(x) ((x)->isquad)
Index: alsa-kernel/pci/au88x0/au88x0_core.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_core.c,v
retrieving revision 1.11
diff -u -p -r1.11 au88x0_core.c
--- alsa-kernel/pci/au88x0/au88x0_core.c	23 Feb 2005 11:00:31 -0000	1.11
+++ alsa-kernel/pci/au88x0/au88x0_core.c	15 Sep 2005 12:23:53 -0000
@@ -2532,7 +2532,8 @@ vortex_codec_write(ac97_t * codec, unsig
 	hwwrite(card->mmio, VORTEX_CODEC_IO,
 		((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
 		((data << VORTEX_CODEC_DATSHIFT) & VORTEX_CODEC_DATMASK) |
-		VORTEX_CODEC_WRITE);
+		VORTEX_CODEC_WRITE |
+		(codec->num << VORTEX_CODEC_ID_SHIFT) );
 
 	/* Flush Caches. */
 	hwread(card->mmio, VORTEX_CODEC_IO);
@@ -2554,7 +2555,8 @@ static unsigned short vortex_codec_read(
 		}
 	}
 	/* set up read address */
-	read_addr = ((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK);
+	read_addr = ((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
+		(codec->num << VORTEX_CODEC_ID_SHIFT) ;
 	hwwrite(card->mmio, VORTEX_CODEC_IO, read_addr);
 
 	/* wait for address */

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au88x0-modem.patch"

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

--XsQoSWH+UP9D9v3l--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
