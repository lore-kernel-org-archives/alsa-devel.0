From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] em10k1x fixes
Date: Mon, 24 May 2004 19:00:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040524170054.GA14900@tuba.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

here is a patch with some emu10k1x fixes:

- it adds emu10k1x to the Makefile
- include sound/info.h added
- move snd_iprintf to the right position; it compiles now
- fix typo in snd_iprintf

bye,
martin

-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="emu.patch"

Index: alsa-driver/pci/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/Makefile,v
retrieving revision 1.24
diff -u -r1.24 Makefile
--- alsa-driver/pci/Makefile	8 Apr 2004 16:38:15 -0000	1.24
+++ alsa-driver/pci/Makefile	24 May 2004 15:20:02 -0000
@@ -11,7 +11,7 @@
 
 clean-files := intel8x0.c
 
-obj-$(CONFIG_SND) += pdplus/
+obj-$(CONFIG_SND) += pdplus/ emu10k1/
 
 snd-hdspm-objs := hdspm.o
 
Index: alsa-driver/pci/emu10k1/emu10k1x.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/emu10k1/emu10k1x.c,v
retrieving revision 1.1
diff -u -r1.1 emu10k1x.c
--- alsa-driver/pci/emu10k1/emu10k1x.c	14 May 2004 13:42:49 -0000	1.1
+++ alsa-driver/pci/emu10k1/emu10k1x.c	24 May 2004 15:20:26 -0000
@@ -33,6 +33,7 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
+#include <sound/info.h>
 
 MODULE_AUTHOR("Francisco Moraes <fmoraes@nc.rr.com>");
 MODULE_DESCRIPTION("EMU10K1X");
@@ -744,10 +745,11 @@
 				       snd_info_buffer_t * buffer)
 {
 	emu10k1x_t *emu = snd_magic_cast(emu10k1x_t, entry->private_data, return);
-	snd_iprintf(buffer, "Registers:\n\n");
 	unsigned long value,value1,value2;
 	unsigned long flags;
 	int i;
+
+	snd_iprintf(buffer, "Registers:\n\n");
 	for(i = 0; i < 0x40; i+=4) {
 		spin_lock_irqsave(&emu->emu_lock, flags);
 		value = inl(emu->port + i);
@@ -759,7 +761,7 @@
 		value = snd_emu10k1x_ptr_read(emu, i, 0);
 		value1 = snd_emu10k1x_ptr_read(emu, i, 1);
 		value2 = snd_emu10k1x_ptr_read(emu, i, 2);
-		snd_iprintf(buffer, "%02X: %08lX %08lX %08lX\n", i, value, value, value2);
+		snd_iprintf(buffer, "%02X: %08lX %08lX %08lX\n", i, value, value1, value2);
 	}
 }
 

--3MwIy2ne0vdjdPXF--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
