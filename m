From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [patch] intel8x0m: 'semaphore is not ready' fix.
Date: Tue, 05 Apr 2005 03:37:46 +0300
Message-ID: <E1DJB55-0007Zg-B6@sc8-sf-mx1.sourceforge.net>
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Resent-To: alsa-devel@lists.sourceforge.net
Resent-message-id: <20050406135937.GB29860@sashak.softier.local>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Summary: Fix "semaphore is not ready" problem with snd-intel8x0m.

With some intel based ac97 modems codec access semaphore is not cleared
after 0x54 AC97 register (GPIO_STATUS) reads. This may causes problems
with newly applied modem mixer (Off-hook switch) and in other cases.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-kernel/pci/intel8x0m.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0m.c,v
retrieving revision 1.30
diff -u -b -B -r1.30 intel8x0m.c
--- alsa-kernel/pci/intel8x0m.c	8 Mar 2005 16:35:32 -0000	1.30
+++ alsa-kernel/pci/intel8x0m.c	2 Apr 2005 23:38:46 -0000
@@ -500,6 +500,8 @@
 			res = 0xffff;
 		}
 	}
+	if (reg == AC97_GPIO_STATUS)
+		iagetword(chip, 0); /* clear semaphore */
 	return res;
 }
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
