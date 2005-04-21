From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 1/3] maestro3: Fix interrupt ack and disable
Date: Thu, 21 Apr 2005 22:08:54 +0300 (EEST)
Message-ID: <20050421190854.462B47A@kuori.saunalahti.fi>
Content-Type: text
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Due to a typo interrupts were never actually acked or disabled.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 maestro3.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urN linux/sound/pci/maestro3.c linux/sound/pci/maestro3.c
--- linux/sound/pci/maestro3.c	2005-04-21 21:42:51.000000000 +0300
+++ linux/sound/pci/maestro3.c	2005-04-21 21:43:47.000000000 +0300
@@ -1605,7 +1605,7 @@
 #endif
 
 	/* ack ints */
-	snd_m3_outw(chip, HOST_INT_STATUS, status);
+	outb(status, chip->iobase + HOST_INT_STATUS);
 
 	return IRQ_HANDLED;
 }
@@ -2367,7 +2367,7 @@
 		kfree(chip->substreams);
 	}
 	if (chip->iobase) {
-		snd_m3_outw(chip, HOST_INT_CTRL, 0); /* disable ints */
+		outw(0, chip->iobase + HOST_INT_CTRL); /* disable ints */
 	}
 
 #ifdef CONFIG_PM



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
