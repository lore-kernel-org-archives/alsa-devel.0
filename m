From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] seq-midi running status fix
Date: Mon, 24 Mar 2003 09:10:59 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0303240903260.19990-100000@studcom.urz.uni-halle.de>
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


When a seq-midi device is used multiple times, it doesn't reset the parser
when opening/closing the underlying rawmidi device, so it is possible that
the first command to the newly opened rawmidi device uses running status.
This may not work because the device may have been reset by the 0xff sent
when closing the rawmidi device before, or the user might have connected
another device.

This patch initializes the parser when opening the rawmidi device so that
the first command always includes the status byte.


Index: alsa-kernel/core/seq/seq_midi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq_midi.c,v
retrieving revision 1.13
diff -u -r1.13 seq_midi.c
--- alsa-kernel/core/seq/seq_midi.c	27 Feb 2003 11:10:36 -0000	1.13
+++ alsa-kernel core/seq/seq_midi.c	24 Mar 2003 07:52:56 -0000
@@ -236,6 +236,7 @@
 		snd_rawmidi_kernel_release(&msynth->output_rfile);
 		return err;
 	}
+	snd_midi_event_reset_decode(msynth->parser);
 	return 0;
 }





-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
