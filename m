From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] Enable SPDIF input recording on ALC650 AC97 codecs. Works
 for PCM and AC3.
Date: Sat, 30 Aug 2003 17:49:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F50D59D.2070802@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040701080305090903080804"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA20619
	for <alsa-devel@alsa-project.org>; Sat, 30 Aug 2003 18:41:51 +0200
Received: from superbug.demon.co.uk ([158.152.58.16])
	by anchor-post-35.mail.demon.net with esmtp (Exim 3.36 #2)
	id 19t8nL-0004Q0-0Z
	for alsa-devel@alsa-project.org; Sat, 30 Aug 2003 17:41:47 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040701080305090903080804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.
This patch enables the SPDIF input of the Realtek ALC650 chip which is 
an AC97 compatible chip.
It also adds some data into the proc file system ac97 
/proc/asound/card0/ac97#0 file so one can see if the SPDIF is locked or not.

I can now record AC3 non-audio data from an Optical SPDIF socket on my 
Motherboard.

This only works for ALC650 Rev.E or above, so I guess I should really 
check for that.

Cheers
James


--------------040701080305090903080804
Content-Type: text/plain;
 name="spdif-record.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spdif-record.patch"

diff -ur linux-2.6.0-test4/include/sound/ac97_codec.h /usr/src/linux-beta/include/sound/ac97_codec.h
--- linux-2.6.0-test4/include/sound/ac97_codec.h	2003-08-23 00:56:25.000000000 +0100
+++ /usr/src/linux-beta/include/sound/ac97_codec.h	2003-08-30 16:19:46.000000000 +0100
@@ -214,11 +214,50 @@
 #define AC97_CXR_SPDIF_AC3	0x2
 
 /* specific - ALC */
+#define AC97_ALC650_SPDIF_INPUT_STATUS1	0x60
+/* S/PDIF input status 1 bit defines */
+#define AC97_ALC650_PRO             0x0001  /* Professional status */
+#define AC97_ALC650_NAUDIO          0x0002  /* Non audio stream */
+#define AC97_ALC650_COPY            0x0004  /* Copyright status */
+#define AC97_ALC650_PRE             0x0038  /* Preemphasis status */
+#define AC97_ALC650_PRE_SHIFT       3
+#define AC97_ALC650_MODE            0x00C0  /* Preemphasis status */
+#define AC97_ALC650_MODE_SHIFT      6
+#define AC97_ALC650_CC_MASK         0x7f00  /* Category Code mask */
+#define AC97_ALC650_CC_SHIFT        8
+#define AC97_ALC650_L               0x8000  /* Generation Level status */
+
+#define AC97_ALC650_SPDIF_INPUT_STATUS2	0x62
+/* S/PDIF input status 2 bit defines */
+#define AC97_ALC650_SOUCE_MASK      0x000f  /* Source number */
+#define AC97_ALC650_CHANNEL_MASK    0x00f0  /* Channel number */
+#define AC97_ALC650_CHANNEL_SHIFT   4 
+#define AC97_ALC650_SPSR_MASK       0x0f00  /* S/PDIF Sample Rate bits */
+#define AC97_ALC650_SPSR_SHIFT      8
+#define AC97_ALC650_SPSR_44K        0x0000  /* Use 44.1kHz Sample rate */
+#define AC97_ALC650_SPSR_48K        0x0200  /* Use 48kHz Sample rate */
+#define AC97_ALC650_SPSR_32K        0x0300  /* Use 32kHz Sample rate */
+#define AC97_ALC650_CLOCK_ACCURACY  0x3000  /* Clock accuracy */
+#define AC97_ALC650_CLOCK_SHIFT     12
+#define AC97_ALC650_CLOCK_LOCK      0x4000  /* Clock locked status */
+#define AC97_ALC650_V               0x8000  /* Validity status */
+
 #define AC97_ALC650_SURR_DAC_VOL	0x64
 #define AC97_ALC650_LFE_DAC_VOL		0x66
+#define AC97_ALC650_UNKNOWN1		0x68
 #define AC97_ALC650_MULTICH	0x6a
+#define AC97_ALC650_UNKNOWN2		0x6c
+#define AC97_ALC650_REVISION    0x6e
+#define AC97_ALC650_UNKNOWN3		0x70
+#define AC97_ALC650_UNKNOWN4		0x72
+#define AC97_ALC650_MISC	0x74
+#define AC97_ALC650_GPIO_SETUP  0x76
+#define AC97_ALC650_GPIO_STATUS 0x78
 #define AC97_ALC650_CLOCK	0x7a
 
+
+
+
 /* specific - Yamaha YMF753 */
 #define AC97_YMF753_DIT_CTRL2	0x66	/* DIT Control 2 */
 #define AC97_YMF753_3D_MODE_SEL	0x68	/* 3D Mode Select */
diff -ur linux-2.6.0-test4/sound/pci/ac97/ac97_patch.c /usr/src/linux-beta/sound/pci/ac97/ac97_patch.c
--- linux-2.6.0-test4/sound/pci/ac97/ac97_patch.c	2003-08-23 01:00:10.000000000 +0100
+++ /usr/src/linux-beta/sound/pci/ac97/ac97_patch.c	2003-08-30 17:35:31.488713520 +0100
@@ -874,8 +874,10 @@
 	val = snd_ac97_read(ac97, AC97_EXTENDED_STATUS);
 	if (val & AC97_EA_SPCV)
 		spdif = 1;
-
 	if (spdif) {
+		//enable AC97_ALC650_GPIO_SETUP, AC97_ALC650_CLOCK for R/W
+		snd_ac97_write_cache(ac97, AC97_ALC650_GPIO_STATUS, 
+			snd_ac97_read(ac97, AC97_ALC650_GPIO_STATUS) | 0x8000);
 		/* enable spdif in */
 		snd_ac97_write_cache(ac97, AC97_ALC650_CLOCK,
 				     snd_ac97_read(ac97, AC97_ALC650_CLOCK) | 0x03);
@@ -891,18 +893,18 @@
 		int mic_off;
 		mic_off = snd_ac97_read(ac97, AC97_ALC650_MULTICH) & (1 << 10);
 		/* GPIO0 direction */
-		val = snd_ac97_read(ac97, 0x76);
+		val = snd_ac97_read(ac97, AC97_ALC650_GPIO_SETUP);
 		if (mic_off)
 			val &= ~0x01;
 		else
 			val |= 0x01;
-		snd_ac97_write_cache(ac97, 0x76, val);
-		val = snd_ac97_read(ac97, 0x78);
+		snd_ac97_write_cache(ac97, AC97_ALC650_GPIO_SETUP, val);
+		val = snd_ac97_read(ac97, AC97_ALC650_GPIO_STATUS);
 		if (mic_off)
 			val &= ~0x100;
 		else
 			val = val | 0x100;
-		snd_ac97_write_cache(ac97, 0x78, val);
+		snd_ac97_write_cache(ac97, AC97_ALC650_GPIO_STATUS, val);
 	}
 
 	/* full DAC volume */
diff -ur linux-2.6.0-test4/sound/pci/ac97/ac97_proc.c /usr/src/linux-beta/sound/pci/ac97/ac97_proc.c
--- linux-2.6.0-test4/sound/pci/ac97/ac97_proc.c	2003-08-23 01:03:01.000000000 +0100
+++ /usr/src/linux-beta/sound/pci/ac97/ac97_proc.c	2003-08-30 16:55:06.000000000 +0100
@@ -38,7 +38,7 @@
 {
 	char name[64];
 	unsigned int id;
-	unsigned short val, tmp, ext, mext;
+	unsigned short val, tmp, ext, mext, spdif_in;
 	static const char *spdif_slots[4] = { " SPDIF=3/4", " SPDIF=7/8", " SPDIF=6/9", " SPDIF=res" };
 	static const char *spdif_rates[4] = { " Rate=44.1kHz", " Rate=res", " Rate=48kHz", " Rate=32kHz" };
 	static const char *spdif_rates_cs4205[4] = { " Rate=48kHz", " Rate=44.1kHz", " Rate=res", " Rate=res" };
@@ -151,7 +151,7 @@
 		snd_iprintf(buffer, "SPDIF Control    :%s%s%s%s Category=0x%x Generation=%i%s%s%s\n",
 			val & AC97_SC_PRO ? " PRO" : " Consumer",
 			val & AC97_SC_NAUDIO ? " Non-audio" : " PCM",
-			val & AC97_SC_COPY ? " Copyright" : "",
+			val & AC97_SC_COPY ? "" : " Copyright",
 			val & AC97_SC_PRE ? " Preemph50/15" : "",
 			(val & AC97_SC_CC_MASK) >> AC97_SC_CC_SHIFT,
 			(val & AC97_SC_L) >> 11,
@@ -165,6 +165,29 @@
 			    (val & AC97_SC_V ? " Enabled" : "") :
 			    (val & AC97_SC_V ? " Validity" : ""));
 	}
+	spdif_in = snd_ac97_read(ac97, AC97_ALC650_CLOCK);
+	if (spdif_in & 0x01) {
+	   val = snd_ac97_read(ac97, AC97_ALC650_SPDIF_INPUT_STATUS2);
+           if (val & AC97_ALC650_CLOCK_LOCK) {
+		val = snd_ac97_read(ac97, AC97_ALC650_SPDIF_INPUT_STATUS1);
+		snd_iprintf(buffer, "SPDIF In Status  :%s%s%s%s Category=0x%x Generation=%i",
+			val & AC97_ALC650_PRO ? " PRO" : " Consumer",
+			val & AC97_ALC650_NAUDIO ? " Non-audio" : " PCM",
+			val & AC97_ALC650_COPY ? "" : " Copyright",
+			val & AC97_ALC650_PRE ? " Preemph50/15" : "",
+			(val & AC97_ALC650_CC_MASK) >> AC97_ALC650_CC_SHIFT,
+			(val & AC97_ALC650_L) >> 15);
+		val = snd_ac97_read(ac97, AC97_ALC650_SPDIF_INPUT_STATUS2);
+		snd_iprintf(buffer, "%s Accuracy=%i%s%s\n",
+			spdif_rates[(val & AC97_ALC650_SPSR_MASK) >> AC97_ALC650_SPSR_SHIFT],
+			(val & AC97_ALC650_CLOCK_ACCURACY) >> AC97_ALC650_CLOCK_SHIFT,
+			(val & AC97_ALC650_CLOCK_LOCK ? " Locked" : " Unlocked"),
+			(val & AC97_ALC650_V ? " Validity?" : ""));
+           } else {
+		snd_iprintf(buffer, "SPDIF In Status  : Not Locked\n");
+           }
+	}
+
 
       __modem:
 	mext = snd_ac97_read(ac97, AC97_EXTENDED_MID);

--------------040701080305090903080804--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
