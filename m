From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix for Creamware Noah
Date: Fri, 27 Feb 2004 12:12:49 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402271151580.13003-100000@studcom.urz.uni-halle.de>
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

Hartmut Geissbauer wrote:
> That _has_ helped. Now the device is fully functional.



- search class-specific endpoint descriptor after the sync ep, too


Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.81
diff -u -r1.81 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	24 Feb 2004 08:44:33 -0000	1.81
+++ alsa-kernel/usb/usbaudio.c	27 Feb 2004 10:37:08 -0000
@@ -2324,6 +2324,9 @@
 		}

 		csep = snd_usb_find_desc(alts->endpoint[0].extra, alts->endpoint[0].extralen, NULL, USB_DT_CS_ENDPOINT);
+		/* Creamware Noah has this descriptor after the 2nd endpoint */
+		if (!csep && altsd->bNumEndpoints >= 2)
+			csep = snd_usb_find_desc(alts->endpoint[1].extra, alts->endpoint[1].extralen, NULL, USB_DT_CS_ENDPOINT);
 		if (!csep || csep[0] < 7 || csep[2] != EP_GENERAL) {
 			snd_printk(KERN_ERR "%d:%u:%d : no or invalid class specific endpoint descriptor\n",
 				   dev->devnum, iface_no, altno);





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
