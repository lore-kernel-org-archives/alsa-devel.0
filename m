From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] usbmidi: remove superfluous error check
Date: Mon, 26 Jan 2004 10:04:35 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401261003280.6589-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


ENODEV actually never happens in a completion handler


Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.21
diff -u -r1.21 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	17 Jul 2003 17:42:25 -0000	1.21
+++ alsa-kernel/usb/usbmidi.c	26 Jan 2004 09:00:57 -0000
@@ -142,8 +142,7 @@
 {
 	if (status == -ENOENT)
 		return status; /* killed */
-	if (status == -ENODEV ||
-	    status == -EILSEQ ||
+	if (status == -EILSEQ ||
 	    status == -ETIMEDOUT)
 		return -ENODEV; /* device removed */
 	snd_printk(KERN_ERR "urb status %d\n", status);




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
