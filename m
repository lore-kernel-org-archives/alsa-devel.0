From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] display EFGH sends in proc file for audigy
Date: Wed, 17 Nov 2004 14:17:48 -0500
Message-ID: <1100719069.6930.38.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-bneBZQ3+0J0duhVc/Aim"
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


--=-bneBZQ3+0J0duhVc/Aim
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Currently we only display the first four sends even on the Audigy which
has 8 sends.  This obscures the fact that we set sends EFGH all to zero
by default which is technically illegal.  (Though it seems to work, the
kX Windows driver sets these last 4 sends to high channels (62-24) and
never sets two sends to the same address as the header file instructs).

This patch adds display of sends EFGH in the /proc file.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>



--=-bneBZQ3+0J0duhVc/Aim
Content-Description: 
Content-Disposition: attachment; filename=audigy-proc-add-efgh-sends.patch
Content-Type: text/x-patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa/alsa-kernel/pci/emu10k1/emuproc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emuproc.c,v
retrieving revision 1.21
diff -u -r1.21 emuproc.c
--- alsa/alsa-kernel/pci/emu10k1/emuproc.c	6 Sep 2004 15:05:19 -0000	1.21
+++ alsa/alsa-kernel/pci/emu10k1/emuproc.c	17 Nov 2004 19:11:50 -0000
@@ -175,7 +175,7 @@
 	};
 
 	emu10k1_t *emu = entry->private_data;
-	unsigned int val;
+	unsigned int val, val1;
 	int nefx = emu->audigy ? 64 : 32;
 	char **outputs = emu->audigy ? audigy_outs : creative_outs;
 	int idx;
@@ -184,6 +184,8 @@
 	val = emu->audigy ?
 		snd_emu10k1_ptr_read(emu, A_FXRT1, 0) :
 		snd_emu10k1_ptr_read(emu, FXRT, 0);
+	if (emu->audigy)
+		val2 = snd_emu10k1_ptr_read(emu, A_FXRT2, 0);
 	snd_iprintf(buffer, "Card                  : %s\n",
 		    emu->audigy ? "Audigy" : (emu->APS ? "EMU APS" : "Creative"));
 	snd_iprintf(buffer, "Internal TRAM (words) : 0x%x\n", emu->fx8010.itram_size);
@@ -195,6 +197,11 @@
 			    (val >> 8) & 0x3f,
 			    (val >> 16) & 0x3f,
 			    (val >> 24) & 0x3f);
+		snd_iprintf(buffer, "Effect Send Routing   : E=%i, F=%i, G=%i, H=%i\n",
+			    val1 & 0x3f,
+			    (val1 >> 8) & 0x3f,
+			    (val1 >> 16) & 0x3f,
+			    (val1 >> 24) & 0x3f);
 	} else {
 		snd_iprintf(buffer, "Effect Send Routing   : A=%i, B=%i, C=%i, D=%i\n",
 			    (val >> 16) & 0x0f,

--=-bneBZQ3+0J0duhVc/Aim--



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
