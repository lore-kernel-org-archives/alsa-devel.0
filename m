From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] opening input-only rawmidi subdevice fails
Date: Tue, 22 Oct 2002 09:05:08 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210220856350.14267-100000@studcom.urz.uni-halle.de>
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


snd_rawmidi_hw_open() always queries the output stream when opening a
specific subdevice.

Index: alsa-lib/src/rawmidi/rawmidi_hw.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/rawmidi/rawmidi_hw.c,v
retrieving revision 1.23
diff -u -r1.23 rawmidi_hw.c
--- alsa-lib/src/rawmidi/rawmidi_hw.c	24 Apr 2002 08:50:44 -0000	1.23
+++ alsa-lib/src/rawmidi/rawmidi_hw.c	22 Oct 2002 06:54:13 -0000
@@ -242,6 +242,10 @@
 	}
 	if (subdevice >= 0) {
 		memset(&info, 0, sizeof(info));
+		if (inputp)
+			info.stream = SNDRV_RAWMIDI_STREAM_INPUT;
+		else
+			info.stream = SNDRV_RAWMIDI_STREAM_OUTPUT;
 		if (ioctl(fd, SNDRV_RAWMIDI_IOCTL_INFO, &info) < 0) {
 			SYSERR("SNDRV_RAWMIDI_IOCTL_INFO failed");
 			ret = -errno;


... and snd_rawmidi_ioctl() doesn't like that. Oops.

Index: alsa-kernel/core/rawmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/rawmidi.c,v
retrieving revision 1.22
diff -u -r1.22 rawmidi.c
--- alsa-kernel/core/rawmidi.c	21 Oct 2002 18:28:20 -0000	1.22
+++ alsa-kernel/core/rawmidi.c	22 Oct 2002 06:53:54 -0000
@@ -685,8 +685,12 @@
 			return -EFAULT;
 		switch (stream) {
 		case SNDRV_RAWMIDI_STREAM_INPUT:
+			if (rfile->input == NULL)
+				return -EINVAL;
 			return snd_rawmidi_info_user(rfile->input, info);
 		case SNDRV_RAWMIDI_STREAM_OUTPUT:
+			if (rfile->output == NULL)
+				return -EINVAL;
 			return snd_rawmidi_info_user(rfile->output, info);
 		default:
 			return -EINVAL;



I didn't find anything else while testing my USB MIDI rawmidi patch, so
I think it's safe to apply it now.


Clemens



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future of 
Java(TM) technology. Join the Java Community Process(SM) (JCP(SM)) 
program now. http://ad.doubleclick.net/clk;4699841;7576301;v?
http://www.sun.com/javavote
