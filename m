From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] Remove ARRAY_SIZE macro from SoundScape
Date: Mon, 7 Oct 2002 21:47:08 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210072047.g97Kl8Hh002568@wittsend.radionet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Now that the ARRAY_SIZE macro has been migrated to adriver.h, it can come out of here. And there's a whitespace diff too.

Chris

Index: alsa-driver/isa/sscape.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/isa/sscape.c,v
retrieving revision 1.7
diff -u -u -r1.7 sscape.c
--- alsa-driver/isa/sscape.c	7 Oct 2002 10:59:39 -0000	1.7
+++ alsa-driver/isa/sscape.c	7 Oct 2002 20:40:40 -0000
@@ -68,9 +68,6 @@
 static snd_card_t *sscape_card[SNDRV_CARDS];
 static unsigned __initdata sscape_count;
 
-#ifndef ARRAY_SIZE
-#  define ARRAY_SIZE(a)  (sizeof(a) / sizeof(a[0]))
-#endif
 
 #define MPU401_IO(i)     ((i) + 0)
 #define MIDI_DATA_IO(i)  ((i) + 0)
@@ -286,7 +283,7 @@
  * Also leaves all locking-issues to the caller ...
  */
 static int host_write_ctrl_unsafe(unsigned io_base, unsigned char data,
-		       unsigned timeout)
+                                  unsigned timeout)
 {
 	int err;
 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
