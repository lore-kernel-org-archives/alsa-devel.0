From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] Enables SPDIF output on the Audigy2 Value.
Date: Sun, 13 Feb 2005 16:35:02 +0000
Message-ID: <420F81B6.8060500@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050903070104090408040805"
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7681F23A
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2005 17:35:03 +0100 (MET)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-32.mail.demon.net with esmtp (Exim 4.42)
	id 1D0Mi6-000LLc-9N
	for alsa-devel@alsa-project.org; Sun, 13 Feb 2005 16:35:03 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050903070104090408040805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It seems to work for PCM, but not AC3 yet.

Signed off: James Courtier-Dutton

--------------050903070104090408040805
Content-Type: text/plain;
 name="audig2value-spdif-enable.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audig2value-spdif-enable.diff.txt"

Index: alsa-driver/alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.42
diff -u -r1.42 emu10k1_main.c
--- alsa-driver/alsa-kernel/pci/emu10k1/emu10k1_main.c	29 Nov 2004 14:09:47 -0000	1.42
+++ alsa-driver/alsa-kernel/pci/emu10k1/emu10k1_main.c	13 Feb 2005 16:13:23 -0000
@@ -205,6 +205,15 @@
 		/* Setup SRCMulti Input Audio Enable */
 		outl(0x7b0000, emu->port + 0x20);
 		outl(0xFF000000, emu->port + 0x24);
+
+		/* Setup SPDIF Out Audio Enable */
+		/* The Audigy 2 Value has a separate SPDIF out,
+		 * so no need for a mixer switch
+		 */
+		outl(0x7a0000, emu->port + 0x20);
+		outl(0xFF000000, emu->port + 0x24);
+		tmp = inl(emu->port + A_IOCFG) & ~0x8; /* Clear bit 3 */
+		outl(tmp, emu->port + A_IOCFG);
 	}
 
 

--------------050903070104090408040805--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
