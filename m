From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] ymfpci interrupt fix
Date: Mon, 05 May 2003 08:31:39 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305050829530.4924-100000@studcom.urz.uni-halle.de>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


The interrupt status register has 16 bits, not 32.
And the other interrupt bits should be cleared regardless of the state of
the timer interrupt bit.


Index: alsa-kernel/pci/ymfpci/ymfpci_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ymfpci/ymfpci_main.c,v
retrieving revision 1.34
diff -u -r1.34 ymfpci_main.c
--- alsa-kernel/pci/ymfpci/ymfpci_main.c	23 Apr 2003 10:02:05 -0000	1.34
+++ alsa-kernel/pci/ymfpci/ymfpci_main.c	5 May 2003 06:28:23 -0000
@@ -779,11 +779,11 @@
 		}
 	}

-	status = snd_ymfpci_readl(chip, YDSXGR_INTFLAG);
+	status = snd_ymfpci_readw(chip, YDSXGR_INTFLAG);
 	if (status & 1) {
 		/* timer handler */
-		snd_ymfpci_writel(chip, YDSXGR_INTFLAG, ~0);
 	}
+	snd_ymfpci_writew(chip, YDSXGR_INTFLAG, status);

 	if (chip->rawmidi)
 		snd_mpu401_uart_interrupt(irq, chip->rawmidi->private_data, regs);




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
