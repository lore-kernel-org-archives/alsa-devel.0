From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: 2.6.10: i810 more AC97 tunings
Date: Sun, 26 Dec 2004 23:41:38 +0000
Message-ID: <1104104497.16487.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1BCD62C0
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 01:45:31 +0100 (MET)
Received: from localhost.localdomain (unknown [81.2.110.250])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 8F4E63FED5
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 01:45:30 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: torvalds@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add some more funky AC97 knowledge to the intel8x0 driver. These come
from Red Hat and its partners and are included in our shipping code.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/sound/pci/intel8x0.c linux-2.6.10/sound/pci/intel8x0.c
--- linux.vanilla-2.6.10/sound/pci/intel8x0.c	2004-12-25 21:15:54.000000000 +0000
+++ linux-2.6.10/sound/pci/intel8x0.c	2004-12-26 16:56:04.660850232 +0000
@@ -1880,6 +1880,24 @@
 		.type = AC97_TUNE_HP_ONLY
 	},
 #endif
+	{
+		.vendor = 0x1028,
+		.device = 0x012d,
+		.name = "Dell Precision 450",	/* AD1981B*/
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x103c,
+		.device = 0x3008,
+		.name = "HP xw4200",	/* AD1981B*/
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x103c,
+		.device = 0x12f1,
+		.name = "HP xw8200",	/* AD1981B*/
+		.type = AC97_TUNE_HP_ONLY
+	},
 	{ } /* terminator */
 };
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
