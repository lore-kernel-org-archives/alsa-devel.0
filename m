From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: fix display of send routing in /proc
Date: Sat, 20 Nov 2004 01:25:51 -0500
Message-ID: <1100931951.5178.6.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-atxCXh8b3wgqXa8rXP03"
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
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org


--=-atxCXh8b3wgqXa8rXP03
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The emu10k1's send routing is a per channel setting.  The emu10k1 has 4
sends per channel, the Audigy 8.  Currently we only display the first 4
sends for the first channel.  This patch updates the /proc file to
display the send routing for all 64 channels, and to display the last 4
sends if present.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>



--=-atxCXh8b3wgqXa8rXP03
Content-Disposition: attachment; filename=emuproc.patch
Content-Type: text/x-patch; name=emuproc.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa/alsa-kernel/pci/emu10k1/emuproc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emuproc.c,v
retrieving revision 1.21
diff -u -r1.21 emuproc.c
--- alsa/alsa-kernel/pci/emu10k1/emuproc.c	6 Sep 2004 15:05:19 -0000	1.21
+++ alsa/alsa-kernel/pci/emu10k1/emuproc.c	20 Nov 2004 06:18:09 -0000
@@ -175,32 +175,45 @@
 	};
 
 	emu10k1_t *emu = entry->private_data;
-	unsigned int val;
+	unsigned int val, val1;
 	int nefx = emu->audigy ? 64 : 32;
 	char **outputs = emu->audigy ? audigy_outs : creative_outs;
 	int idx;
 	
 	snd_iprintf(buffer, "EMU10K1\n\n");
-	val = emu->audigy ?
-		snd_emu10k1_ptr_read(emu, A_FXRT1, 0) :
-		snd_emu10k1_ptr_read(emu, FXRT, 0);
 	snd_iprintf(buffer, "Card                  : %s\n",
 		    emu->audigy ? "Audigy" : (emu->APS ? "EMU APS" : "Creative"));
 	snd_iprintf(buffer, "Internal TRAM (words) : 0x%x\n", emu->fx8010.itram_size);
 	snd_iprintf(buffer, "External TRAM (words) : 0x%x\n", (int)emu->fx8010.etram_pages.bytes);
 	snd_iprintf(buffer, "\n");
-	if (emu->audigy) {
-		snd_iprintf(buffer, "Effect Send Routing   : A=%i, B=%i, C=%i, D=%i\n",
-			    val & 0x3f,
-			    (val >> 8) & 0x3f,
-			    (val >> 16) & 0x3f,
-			    (val >> 24) & 0x3f);
-	} else {
-		snd_iprintf(buffer, "Effect Send Routing   : A=%i, B=%i, C=%i, D=%i\n",
-			    (val >> 16) & 0x0f,
-			    (val >> 20) & 0x0f,
-			    (val >> 24) & 0x0f,
-			    (val >> 28) & 0x0f);
+	snd_iprintf(buffer, "Effect Send Routing   :\n");
+	for (idx = 0; idx < NUM_G; idx++) {
+		val = emu->audigy ?
+			snd_emu10k1_ptr_read(emu, A_FXRT1, idx) :
+			snd_emu10k1_ptr_read(emu, FXRT, idx);
+		val1 = emu->audigy ?
+			snd_emu10k1_ptr_read(emu, A_FXRT2, idx) :
+			0;
+		if (emu->audigy) {
+			snd_iprintf(buffer, "Ch%i: A=%i, B=%i, C=%i, D=%i, ",
+				idx,
+				val & 0x3f,
+				(val >> 8) & 0x3f,
+				(val >> 16) & 0x3f,
+				(val >> 24) & 0x3f);
+			snd_iprintf(buffer, "E=%i, F=%i, G=%i, H=%i\n",
+				val1 & 0x3f,
+				(val1 >> 8) & 0x3f,
+				(val1 >> 16) & 0x3f,
+				(val1 >> 24) & 0x3f);
+		} else {
+			snd_iprintf(buffer, "Ch%i: A=%i, B=%i, C=%i, D=%i\n",
+				idx,
+				(val >> 16) & 0x0f,
+				(val >> 20) & 0x0f,
+				(val >> 24) & 0x0f,
+				(val >> 28) & 0x0f);
+		}
 	}
 	snd_iprintf(buffer, "\nCaptured FX Outputs   :\n");
 	for (idx = 0; idx < nefx; idx++) {
@@ -318,7 +331,7 @@
 	snd_info_entry_t *entry;
 	
 	if (! snd_card_proc_new(emu->card, "emu10k1", &entry))
-		snd_info_set_text_ops(entry, emu, 1024, snd_emu10k1_proc_read);
+		snd_info_set_text_ops(entry, emu, 2048, snd_emu10k1_proc_read);
 
 	if (! snd_card_proc_new(emu->card, "fx8010_gpr", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;

--=-atxCXh8b3wgqXa8rXP03--



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
