From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: remove an unnecessary printk
Date: Thu, 17 Feb 2005 18:14:43 -0500
Message-ID: <1108682083.15018.2.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-WmTRJnnf2LBk+1qP6Gmp"
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


--=-WmTRJnnf2LBk+1qP6Gmp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch removes an unnecessary printk accidentally left in the
multichannel patch.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--=-WmTRJnnf2LBk+1qP6Gmp
Content-Disposition: attachment; filename=voice.fix
Content-Type: text/x-patch; name=voice.fix; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-postv12/alsa-kernel/pci/emu10k1/voice.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/voice.c,v
retrieving revision 1.6
diff -u -r1.6 voice.c
--- alsa-postv12/alsa-kernel/pci/emu10k1/voice.c	16 Feb 2005 10:25:36 -0000	1.6
+++ alsa-postv12/alsa-kernel/pci/emu10k1/voice.c	17 Feb 2005 22:55:23 -0000
@@ -69,10 +69,8 @@
 		skip = 0;
 		for (k = 0; k < number; k++) {
 			voice = &emu->voices[(i+k) % NUM_G];
-			if (voice->use) {
-				printk("voice %d: use=1!\n", i+k);
+			if (voice->use)
 				skip = 1;
-			}
 		}
 		if (!skip) {
 			// printk("allocated voice %d\n", i);

--=-WmTRJnnf2LBk+1qP6Gmp--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
