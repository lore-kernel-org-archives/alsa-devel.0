From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] usbaudio.c: fix for 8-bit PCM format
Date: Tue, 16 Sep 2003 08:35:21 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309160833210.26303-100000@studcom.urz.uni-halle.de>
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


All AUDIO_FORMAT_PCM formats are signed, even 8 bits.


Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.63
diff -u -r1.63 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	20 Aug 2003 09:59:59 -0000	1.63
+++ alsa-kernel/usb/usbaudio.c	16 Sep 2003 06:29:00 -0000
@@ -2002,7 +2002,7 @@
 		/* check the format byte size */
 		switch (fmt[5]) {
 		case 1:
-			pcm_format = SNDRV_PCM_FORMAT_U8;
+			pcm_format = SNDRV_PCM_FORMAT_S8;
 			break;
 		case 2:
 			pcm_format = SNDRV_PCM_FORMAT_S16_LE;




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
