From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] For detection of ALC650 rev.E
Date: Thu, 28 Aug 2003 13:40:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4DF851.6040002@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050005010203090600080207"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050005010203090600080207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I attach two diff files that add ALC650 revision detection.
We could also do revision detection on a lot of other Realtek chips if 
needed.
My ALC650 chip is revision 3 or Rev.F.

Cheers
James

--------------050005010203090600080207
Content-Type: text/plain;
 name="ac97_codec.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97_codec.c.diff"

--- ac97_codec.c.org	2003-08-28 12:59:49.991709168 +0100
+++ ac97_codec.c	2003-08-28 13:35:52.254995184 +0100
@@ -64,7 +64,7 @@
 { 0x414b4d00, 0xffffff00, "Asahi Kasei",	NULL,	NULL },
 { 0x41445300, 0xffffff00, "Analog Devices",	NULL,	NULL },
 { 0x414c4300, 0xffffff00, "Realtek",		NULL,	NULL },
-{ 0x414c4700, 0xffffff00, "Avance Logic",	NULL,	NULL },
+{ 0x414c4700, 0xffffff00, "Realtek",		NULL,	NULL },
 { 0x434d4900, 0xffffff00, "C-Media Electronics", NULL,	NULL },
 { 0x43525900, 0xffffff00, "Cirrus Logic",	NULL,	NULL },
 { 0x43585400, 0xffffff00, "Conexant",           NULL,	NULL },
@@ -109,6 +109,9 @@
 { 0x414c4320, 0xfffffff0, "RL5383", 		NULL,		NULL },
 { 0x414c4710, 0xfffffff0, "ALC200/200P",	NULL,		NULL },
 { 0x414c4720, 0xfffffff0, "ALC650",		patch_alc650,	NULL },
+{ 0x414c4721, 0xfffffff0, "ALC650D",		patch_alc650,	NULL },
+{ 0x414c4722, 0xfffffff0, "ALC650E",		patch_alc650,	NULL },
+{ 0x414c4723, 0xfffffff0, "ALC650F",		patch_alc650,	NULL },
 { 0x414c4730, 0xffffffff, "ALC101",		NULL,		NULL },
 { 0x414c4740, 0xfffffff0, "ALC202",		NULL,		NULL },
 { 0x414c4750, 0xfffffff0, "ALC250",		NULL,		NULL },
@@ -1598,6 +1601,7 @@
 	ac97_t *ac97;
 	char name[64];
 	unsigned long end_time;
+	unsigned int reg;
 	static snd_device_ops_t ops = {
 		.dev_free =	snd_ac97_dev_free,
 	};
@@ -1641,6 +1645,20 @@
 		snd_ac97_free(ac97);
 		return -EIO;
 	}
+	/* AC97 audio codec chip revision detection. */
+	/* Currently only Realtek ALC650 detection implemented. */
+        switch(ac97->id & 0xfffffff0) {
+        case 0x414c4720:        /* ALC650 */
+        	reg = snd_ac97_read(ac97, AC97_ALC650_REVISION);
+                if (((reg & 0x3f) >= 0) && ((reg & 0x3f) < 3))
+                        ac97->id = 0x414c4720;          /* Old version */
+                else if (((reg & 0x3f) >= 3) && ((reg & 0x3f) < 0x10))
+                        ac97->id = 0x414c4721;          /* D version */
+                else if ((reg&0x30) == 0x10)
+                        ac97->id = 0x414c4722;          /* E version */
+                else if ((reg&0x30) == 0x20)
+                        ac97->id = 0x414c4723;          /* F version */
+        }
 	
 	/* test for AC'97 */
 	if (! (ac97->scaps & AC97_SCAP_AUDIO)) {

--------------050005010203090600080207
Content-Type: text/plain;
 name="ac97_codec.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97_codec.h.diff"

--- ac97_codec.h.org	2003-08-28 13:16:33.621134304 +0100
+++ ac97_codec.h	2003-08-28 13:15:38.556505400 +0100
@@ -217,6 +217,7 @@
 #define AC97_ALC650_SURR_DAC_VOL	0x64
 #define AC97_ALC650_LFE_DAC_VOL		0x66
 #define AC97_ALC650_MULTICH	0x6a
+#define AC97_ALC650_REVISION    0x6e
 #define AC97_ALC650_CLOCK	0x7a
 
 /* specific - Yamaha YMF753 */

--------------050005010203090600080207--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
