From: Frank Neumann <beachnase@web.de>
Subject: Bug in aplay
Date: Sun, 27 Apr 2003 10:25:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E199hV9-0007Bs-00@smtp.web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__27_Apr_2003_10:25:37_+0200_0818b340"
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

This is a multi-part message in MIME format.

--Multipart_Sun__27_Apr_2003_10:25:37_+0200_0818b340
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi list,
aplay from the alsa-utils package has a small bug thatI had noticed for 
quite a while, but only last week I found the reason.

Situation: I often have e.g. a directory full of drum sounds as *.wav files
and play them with "aplay *.wav". This used to work just fine a few versions
ago, but recent versions only played part of a file, then jumped to the
next file, and after a couple of files playback got even shorter again.

The bug was introduced between versions 0.9.0rc7 and 0.9.0rc8 and it seems
as if the changes made then should clean up the source code a bit. In fact,
previous versions were also somewhat broken, but the bug did not show there.

I have attached a one-line patch. Check out the variable "pbrec_count"
(just named "count" in 0.9.0rc7) which was never reset to its initial 
value of -1 at the start of playback of a file when several files have to 
be played.

Greetings,
Frank

PS: Did noone ever notice this before? :-)

--Multipart_Sun__27_Apr_2003_10:25:37_+0200_0818b340
Content-Type: text/plain;
 name="aplay.diff"
Content-Disposition: attachment;
 filename="aplay.diff"
Content-Transfer-Encoding: 7bit

--- alsa-utils/aplay.c.orig	Sun Apr 27 10:15:38 2003
+++ alsa-utils/aplay.c	Sun Apr 27 10:17:13 2003
@@ -528,6 +528,7 @@
 				capture(NULL);
 		} else {
 			while (optind <= argc - 1) {
+				pbrec_count = (size_t)-1;
 				if (stream == SND_PCM_STREAM_PLAYBACK)
 					playback(argv[optind++]);
 				else

--Multipart_Sun__27_Apr_2003_10:25:37_+0200_0818b340--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
