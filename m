From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: add per-voice PTR register dump to /proc entry
Date: Sat, 13 Nov 2004 20:01:26 -0500
Message-ID: <1100394086.2458.18.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Summary: This patch adds a register dump for each voice to the /proc
entry.  This functionality will be key for improving the voice allocator
for multichannel support.  Currently these all go in the main file; I
can split these into a file per voice if desired.

Sample output for an idle (15) and running (16) voice:

Voice 15 PTR registers
PTR 0x0 0x0
PTR 0x1 0x0
PTR 0x2 0xffff
PTR 0x3 0xffff
PTR 0x4 0x0
PTR 0x5 0x0
PTR 0x6 0x0
PTR 0x7 0x10
PTR 0x8 0x0
PTR 0x9 0x400000
PTR 0xa 0x32101000
PTR 0xb 0x32101000
PTR 0xc 0x31d3fff
PTR 0xd 0x31d3fff
PTR 0xe 0x33ea901
PTR 0xf 0x33ea901
PTR 0x10 0x0
PTR 0x11 0x0
PTR 0x12 0x0
PTR 0x13 0x0
PTR 0x14 0x0
PTR 0x15 0x0
PTR 0x16 0x0
PTR 0x17 0x0
PTR 0x18 0x0
PTR 0x19 0xffff
PTR 0x1a 0x0
PTR 0x1b 0x0
PTR 0x1c 0x18
PTR 0x1d 0x18
PTR 0x1e 0x0
PTR 0x1f 0x0
PTR 0x20 0x0
PTR 0x21 0x0
PTR 0x22 0x0
PTR 0x23 0x0
PTR 0x24 0x0
PTR 0x25 0x0
PTR 0x26 0x0
PTR 0x27 0x0
PTR 0x28 0x0
PTR 0x29 0x0
PTR 0x2a 0x0
PTR 0x2b 0x0
PTR 0x2c 0x0
PTR 0x2d 0x0
PTR 0x2e 0x0
PTR 0x2f 0x0
PTR 0x30 0x0
PTR 0x31 0x0
PTR 0x32 0x0
PTR 0x33 0x0
PTR 0x34 0x0
PTR 0x35 0x0
PTR 0x36 0x0
PTR 0x37 0x0
PTR 0x38 0x0
PTR 0x39 0x0
PTR 0x3a 0x0
PTR 0x3b 0x0
PTR 0x3c 0x0
PTR 0x3d 0x0
PTR 0x3e 0x0
PTR 0x3f 0x0

Voice 16 PTR registers
PTR 0x0 0x3acdbe58
PTR 0x1 0x3acdff00
PTR 0x2 0xffffffff
PTR 0x3 0xffffffff
PTR 0x4 0xaf00
PTR 0x5 0xff00
PTR 0x6 0x400
PTR 0x7 0x4400
PTR 0x8 0x2002521
PTR 0x9 0x2e91000
PTR 0xa 0x32104400
PTR 0xb 0x32104400
PTR 0xc 0x63f4009
PTR 0xd 0x31d3fff
PTR 0xe 0x73ea901
PTR 0xf 0x73ea901
PTR 0x10 0x0
PTR 0x11 0x7f7f
PTR 0x12 0x7f7f
PTR 0x13 0x8000
PTR 0x14 0x8000
PTR 0x15 0x0
PTR 0x16 0x7f
PTR 0x17 0x8000
PTR 0x18 0xde0b
PTR 0x19 0xff
PTR 0x1a 0x7f
PTR 0x1b 0x0
PTR 0x1c 0x0
PTR 0x1d 0x0
PTR 0x1e 0x0
PTR 0x1f 0x0
PTR 0x20 0x2d002d
PTR 0x21 0x220022
PTR 0x22 0x2f002f
PTR 0x23 0x2f002f
PTR 0x24 0x2d002d
PTR 0x25 0x2a002a
PTR 0x26 0x270027
PTR 0x27 0x170017
PTR 0x28 0x2f002f
PTR 0x29 0x2a002a
PTR 0x2a 0x2d002d
PTR 0x2b 0x2d002d
PTR 0x2c 0x2f002f
PTR 0x2d 0x270027
PTR 0x2e 0x2d002d
PTR 0x2f 0x320032
PTR 0x30 0x2d002d
PTR 0x31 0x220022
PTR 0x32 0x2f002f
PTR 0x33 0x2f002f
PTR 0x34 0x2d002d
PTR 0x35 0x2a002a
PTR 0x36 0x270027
PTR 0x37 0x170017
PTR 0x38 0x2f002f
PTR 0x39 0x2a002a
PTR 0x3a 0x2d002d
PTR 0x3b 0x2d002d
PTR 0x3c 0x2f002f
PTR 0x3d 0x270027
PTR 0x3e 0x2d002d
PTR 0x3f 0x320032

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Index: alsa-kernel/pci/emu10k1/emuproc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emuproc.c,v
retrieving revision 1.21
diff -u -r1.21 emuproc.c
--- alsa-kernel/pci/emu10k1/emuproc.c	6 Sep 2004 15:05:19 -0000	1.21
+++ alsa-kernel/pci/emu10k1/emuproc.c	14 Nov 2004 00:54:45 -0000
@@ -178,7 +178,7 @@
 	unsigned int val;
 	int nefx = emu->audigy ? 64 : 32;
 	char **outputs = emu->audigy ? audigy_outs : creative_outs;
-	int idx;
+	int idx, reg;
 	
 	snd_iprintf(buffer, "EMU10K1\n\n");
 	val = emu->audigy ?
@@ -219,6 +219,17 @@
 	snd_iprintf(buffer, "\nZoomed Video\n");
 	snd_iprintf(buffer, "Rate Locked           : %s\n", val & SRCS_RATELOCKED ? "on" : "off");
 	snd_iprintf(buffer, "Estimated Sample Rate : 0x%x\n", val & SRCS_ESTSAMPLERATE);
+	
+	// per-voice parameters
+	for (idx = 0; idx < NUM_G; idx++) {
+	    snd_iprintf(buffer, "\nVoice %i PTR registers\n", idx);
+	    for (reg = 0x0; reg < 0x40; reg++) {
+		snd_iprintf(buffer, "PTR 0x%x 0x%x\n",
+			reg,
+			snd_emu10k1_ptr_read(emu, reg, idx));
+	    }
+	}
+
 }
 
 static void snd_emu10k1_proc_acode_read(snd_info_entry_t *entry, 
@@ -318,7 +329,7 @@
 	snd_info_entry_t *entry;
 	
 	if (! snd_card_proc_new(emu->card, "emu10k1", &entry))
-		snd_info_set_text_ops(entry, emu, 1024, snd_emu10k1_proc_read);
+		snd_info_set_text_ops(entry, emu, 65536, snd_emu10k1_proc_read);
 
 	if (! snd_card_proc_new(emu->card, "fx8010_gpr", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;





-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
