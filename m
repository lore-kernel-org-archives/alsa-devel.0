From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Re: 2.6.12-rc1-mm3, sound card lost id
Date: Tue, 29 Mar 2005 22:46:30 +0200
Message-ID: <20050329224630.069cda56.khali@linux-fr.org>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	<20050326111945.5eb58343.khali@linux-fr.org>
	<s5hr7hyiqra.wl@alsa2.suse.de>
	<20050329195721.385717aa.khali@linux-fr.org>
	<1112127424.5141.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from kraid.nerim.net (smtp-102-tuesday.nerim.net [62.4.16.102])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 43BB2233
	for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2005 22:46:27 +0200 (MEST)
In-Reply-To: <1112127424.5141.7.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Hi Lee,

> I think we just have to add this PCI id to the table.  I got the same
> result before James added the SBLive! platinum detection.
> 
> What is the output of 'lspci -v | grep -1 EMU10k1'?

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
        Subsystem: Creative Labs CT4832 SBLive! Value

and the one you didn't ask for:

00:0d.0 Class 0401: 1102:0002 (rev 06)
        Subsystem: 1102:8027

This made me realize that I could still try to hack it myself. The
following patch somehow helped:

--- linux-2.6.12-rc1-mm3/sound/pci/emu10k1/emu10k1_main.c.orig	2005-03-29 20:38:12.000000000 +0200
+++ linux-2.6.12-rc1-mm3/sound/pci/emu10k1/emu10k1_main.c	2005-03-29 22:32:23.000000000 +0200
@@ -680,6 +680,10 @@
 	 .driver = "EMU10K1", .name = "E-mu APS [4001]", 
 	 .emu10k1_chip = 1,
 	 .ecard = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
+	 .driver = "EMU10K1", .name = "SB Live Player 1024", 
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
 	 .driver = "EMU10K1", .name = "SB Live 5.1", 
 	 .emu10k1_chip = 1,


Now the card will be listed as "S1024" instead of "Unknown" so that's a
change. Looks like the short name is auto-generated? Unfortunately
that's still not "Live" as before so my mixer settings are not back yet.
And I believe that "Live" was a much better name than "S1024" too.

Thanks,
-- 
Jean Delvare


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
