From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] Disable SPDIF in on ASUS W1000 motherboard as it does not
 have an spdif in.
Date: Mon, 03 Jan 2005 15:43:51 +0000
Message-ID: <41D96837.5030707@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080906010209020801080605"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

This is a multi-part message in MIME format.
--------------080906010209020801080605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here is a motherboard specific patch to fix sound output on the ASUS 
W1000 laptop.

--------------080906010209020801080605
Content-Type: text/plain;
 name="disable-spdif-in.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="disable-spdif-in.diff.txt"

Index: alsa-driver/alsa-kernel/include/ac97_codec.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/ac97_codec.h,v
retrieving revision 1.61
diff -u -r1.61 ac97_codec.h
--- alsa-driver/alsa-kernel/include/ac97_codec.h	27 Dec 2004 14:36:39 -0000	1.61
+++ alsa-driver/alsa-kernel/include/ac97_codec.h	3 Jan 2005 15:25:05 -0000
@@ -555,6 +555,7 @@
 	AC97_TUNE_ALC_JACK,	/* for Realtek, enable JACK detection */
 	AC97_TUNE_INV_EAPD,	/* inverted EAPD implementation */
 	AC97_TUNE_MUTE_LED,	/* EAPD bit works as mute LED */
+	AC97_TUNE_NO_SPDIF_IN,	/* NO SPDIF IN */
 };
 
 struct ac97_quirk {
Index: alsa-driver/alsa-kernel/pci/intel8x0.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0.c,v
retrieving revision 1.186
diff -u -r1.186 intel8x0.c
--- alsa-driver/alsa-kernel/pci/intel8x0.c	27 Dec 2004 14:36:39 -0000	1.186
+++ alsa-driver/alsa-kernel/pci/intel8x0.c	3 Jan 2005 15:25:06 -0000
@@ -1798,6 +1798,12 @@
 	},
  	{
 		.vendor = 0x1043,
+		.device = 0x1843,
+		.name = "ASUS W1000/CMI9739",
+		.type = AC97_TUNE_NO_SPDIF_IN
+	},
+ 	{
+		.vendor = 0x1043,
 		.device = 0x80f3,
 		.name = "ASUS ICH5/AD1985",
 		.type = AC97_TUNE_AD_SHARING
Index: alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.163
diff -u -r1.163 ac97_codec.c
--- alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c	3 Jan 2005 12:05:21 -0000	1.163
+++ alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c	3 Jan 2005 15:25:07 -0000
@@ -2460,6 +2460,16 @@
 	return 0;
 }
 
+static int tune_no_spdif_in(ac97_t *ac97)
+{
+	/* disable spdif in */
+	snd_ac97_write_cache(ac97, AC97_CM9739_SPDIF_CTRL,
+		snd_ac97_read(ac97, AC97_CM9739_SPDIF_CTRL) & ~0x01);
+	snd_ac97_write_cache(ac97, AC97_CM9739_MULTI_CHAN,
+		snd_ac97_read(ac97, AC97_CM9739_MULTI_CHAN) | (1 << 14));
+	return 0;
+}
+
 struct quirk_table {
 	const char *name;
 	int (*func)(ac97_t *);
@@ -2474,6 +2484,7 @@
 	{ "alc_jack", tune_alc_jack },
 	{ "inv_eapd", tune_inv_eapd },
 	{ "mute_led", tune_mute_led },
+	{ "no_spdif_in", tune_no_spdif_in },
 };
 
 /* apply the quirk with the given type */

--------------080906010209020801080605--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
