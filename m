From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] try to load seq drivers multiple times
Date: Mon, 14 Oct 2002 11:56:47 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210141144250.3103-100000@studcom.urz.uni-halle.de>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

If the sequencer device for a card is requested unsuccessfully (e.g.
"pmidi -l" when a USB MIDI device isn't yet connected), the device is
plugged in, and then the device is accessed, ALSA doesn't load the
sequencer driver.

The reason for this is that snd_seq_client_use_ptr() assumes that the
sequencer driver cannot be loaded when the card driver has failed to load
before.

This patch removes the "!card_requested" protection from the call to
snd_seq_device_load_drivers().


-- 
Clemens


Index: core/seq/seq_clientmgr.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq_clientmgr.c,v
retrieving revision 1.15
diff -u -r1.15 seq_clientmgr.c
--- core/seq/seq_clientmgr.c	13 Aug 2002 16:13:34 -0000	1.15
+++ core/seq/seq_clientmgr.c	14 Oct 2002 09:34:21 -0000
@@ -152,9 +152,11 @@
 			}
 		} else if (clientid >= 64 && clientid < 128) {
 			int card = (clientid - 64) / 8;
-			if (card < snd_ecards_limit && ! card_requested[card]) {
-				card_requested[card] = 1;
-				snd_request_card(card);
+			if (card < snd_ecards_limit) {
+				if (! card_requested[card]) {
+					card_requested[card] = 1;
+					snd_request_card(card);
+				}
 				snd_seq_device_load_drivers();
 			}
 		}



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
