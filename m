From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] seq_midi_emul.c: fix typo
Date: Mon, 24 Mar 2003 09:43:31 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0303240941570.21613-100000@studcom.urz.uni-halle.de>
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


fix typo


Index: alsa-kernel/core/seq/seq_midi_emul.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq_midi_emul.c,v
retrieving revision 1.9
diff -u -r1.9 seq_midi_emul.c
--- alsa-kernel/core/seq/seq_midi_emul.c	25 Feb 2003 12:35:44 -0000	1.9
+++ alsa-kernel/core/seq/seq_midi_emul.c	24 Mar 2003 08:41:12 -0000
@@ -561,7 +561,7 @@

 		} else if (buf[5] == 0x00 && buf[6] == 0x04) {
 			/* master volume */
-			parsed = SNDRV_MIDI_SYSEX_GS_REVERB_MODE;
+			parsed = SNDRV_MIDI_SYSEX_GS_MASTER_VOLUME;
 			chset->gs_master_volume = buf[7];

 		}




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
