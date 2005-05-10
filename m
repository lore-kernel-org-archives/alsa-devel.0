From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: SB0060 emu_chip_details
Date: Tue, 10 May 2005 18:02:39 +0200
Message-ID: <20050510160239.GA32206@skinner.hem.za.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0E0A61C4
	for <alsa-devel@alsa-project.org>; Tue, 10 May 2005 18:05:53 +0200 (MEST)
Received: from mulder.hem.za.org (unknown [84.217.20.149])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 0D7D66FD3B
	for <alsa-devel@alsa-project.org>; Tue, 10 May 2005 18:02:42 +0200 (MEST)
Received: from skinner.hem.za.org ([fec0::202:44ff:fe1d:d021])
	by mulder.hem.za.org with esmtp (Exim 4.50)
	id 1DVXBw-00067i-6E
	for alsa-devel@alsa-project.org; Tue, 10 May 2005 18:02:40 +0200
Received: from mikael by skinner.hem.za.org with local (Exim 4.50)
	id 1DVXBv-0008Ph-TT
	for alsa-devel@alsa-project.org; Tue, 10 May 2005 18:02:39 +0200
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following patch adds SB0060 to emu_chip_details.

Regards,
Mikael Magnusson


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sb0060.patch"

Index: alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.55
diff -u -r1.55 emu10k1_main.c
--- alsa-kernel/pci/emu10k1/emu10k1_main.c	10 Apr 2005 14:43:35 -0000	1.55
+++ alsa-kernel/pci/emu10k1/emu10k1_main.c	10 May 2005 15:16:05 -0000
@@ -711,6 +711,12 @@
 	 .id = "APS",
 	 .emu10k1_chip = 1,
 	 .ecard = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80611102,
+	 .driver = "EMU10K1", .name = "SBLive! Player 5.1 [SB0060]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
 	 .driver = "EMU10K1", .name = "SB Live 5.1", 
 	 .id = "Live",

--ZGiS0Q5IWpPtfppv--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
