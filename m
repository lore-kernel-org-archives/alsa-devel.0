From: alsadev@noid.net
Subject: intel8x0 (82801BA): swap headphone/master quirk patch
Date: Thu,  5 Feb 2004 18:13:18 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040206021318.A6A93EFC37@skyfire.absmc.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from remote.absmc.net ([198.217.112.6])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA16130
	for <alsa-devel@alsa-project.org>; Fri, 6 Feb 2004 03:13:58 +0100
Received: from aeon.absmc.org (monica.absmc.org [10.25.35.47])
	by remote.absmc.net (Postfix) with ESMTP id 79FB9180B9B
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2004 18:13:20 -0800 (PST)
Received: from skyfire.absmc.net (skyfire.absmc.org [10.25.46.207])
	by aeon.absmc.org (Postfix) with ESMTP id BB90B1177FE
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2004 18:13:15 -0800 (PST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org




My Intel motherboard (D845WN) has built-in intel8x0 (82801BA)
audio with the Headphone <--> Master swapping problem...

This fixed it for me:




--- ./pci/intel8x0.c.org        Wed Jan 28 18:56:24 2004
+++ ./pci/intel8x0.c    Wed Jan 28 21:59:02 2004
@@ -1751,6 +1751,12 @@
                .name = "Intel ICH5/AD1985",
                .type = AC97_TUNE_HP_ONLY
        },
+       {
+               .vendor = 0x8086,
+               .device = 0x4856,
+               .name = "Intel D845WN (82801BA)",
+               .type = AC97_TUNE_SWAP_HP
+       },
        { } /* terminator */
 };









-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
