From: Clemens Ladisch <clemens@ladisch.de>
Subject: [linux-usb-devel] PATCH: usb-uhci: fix iso async unlink oops
Date: Mon, 24 Nov 2003 08:37:49 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0311240830340.2835-100000@studcom.urz.uni-halle.de>
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
To: linux-usb-devel@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Without this patch, usb-uhci oopses after ALSA 1.0's snd-usb-audio has
asynchronously unlinked its URBs. Apparently, the code for handling
still-active TDs forgets to check whether the TD actually must be
unlinked.


--- linux-2.4.23-rc1/drivers/usb/host/usb-uhci.c.orig	Sun Nov 23 00:11:22 2003
+++ linux-2.4.23-rc1/drivers/usb/host/usb-uhci.c	Sun Nov 23 01:23:45 2003
@@ -2554,13 +2554,14 @@
 		if (is_td_active(desc)) {
 			// means we have completed the last TD, but not the TDs before
 			desc->hw.td.status &= cpu_to_le32(~TD_CTRL_ACTIVE);
 			dbg("TD still active (%x)- grrr. paranoia!", le32_to_cpu(desc->hw.td.status));
 			ret = -EXDEV;
 			urb->iso_frame_desc[i].status = ret;
-			unlink_td (s, desc, 1);
+			if (mode == PROCESS_ISO_REGULAR)
+				unlink_td (s, desc, 1);
 			// FIXME: immediate deletion may be dangerous
 			goto err;
 		}

 		if (mode == PROCESS_ISO_REGULAR)
 			unlink_td (s, desc, 1);




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
