From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix compiler warnings
Date: Mon, 24 Nov 2003 08:42:07 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0311240841180.2835-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Index: alsa-kernel/pci/ac97/ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.114
diff -u -r1.114 ac97_codec.c
--- alsa-kernel/pci/ac97/ac97_codec.c	20 Nov 2003 16:00:01 -0000	1.114
+++ alsa-kernel/pci/ac97/ac97_codec.c	24 Nov 2003 07:40:06 -0000
@@ -1793,7 +1793,7 @@

 	if (!ac97_is_audio(ac97) && !ac97_is_modem(ac97)) {
 		if (!(ac97->scaps & (AC97_SCAP_SKIP_AUDIO|AC97_SCAP_SKIP_MODEM)))
-			snd_printk(KERN_ERR "AC'97 %d access error (not audio or modem codec)\n", ac97->num, ac97->id);
+			snd_printk(KERN_ERR "AC'97 %d access error (not audio or modem codec)\n", ac97->num);
 		snd_ac97_free(ac97);
 		return -EACCES;
 	}
Index: alsa-kernel/pci/ac97/ac97_pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_pcm.c,v
retrieving revision 1.3
diff -u -r1.3 ac97_pcm.c
--- alsa-kernel/pci/ac97/ac97_pcm.c	20 Nov 2003 15:59:32 -0000	1.3
+++ alsa-kernel/pci/ac97/ac97_pcm.c	24 Nov 2003 07:40:06 -0000
@@ -377,7 +377,8 @@
 			const struct ac97_pcm *pcms)
 {
 	int i, j, k;
-	struct ac97_pcm *pcm, *rpcms, *rpcm;
+	const struct ac97_pcm *pcm;
+	struct ac97_pcm *rpcms, *rpcm;
 	unsigned short avail_slots[2][4];
 	unsigned short all_slots[2][4];
 	unsigned char rate_table[2][4];




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
