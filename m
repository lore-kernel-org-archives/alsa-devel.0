From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] [resend] cmi8330: find OPL3 port automatically
Date: Wed, 8 Jul 2009 10:04:29 +0200
Message-ID: <200907081004.30913.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail.atlantis.sk [80.94.52.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 45A7F24679
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 10:04:35 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

My CMI8329 had OPL3 port specified in SB16 resources. But now I found out that 
it was my modification of the card's PnP EEPROM a couple of years ago (can be 
done using C9SETROM.EXE utility). I did it because the OPL3 port was 
completely missing from PnP data. It seems to be hardwired to 0x388 on 
CMI8329.


Find OPL3 port automatically by searching in WSS and SB16 resources. If not 
found, assume that it's hardwired to 0x388.


Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-test/sound/isa/cmi8330.c	2009-07-06 21:18:06.000000000 +0200
+++ linux-2.6.30-pentium/sound/isa/cmi8330.c	2009-07-06 21:45:29.000000000 
+0200
@@ -362,7 +362,7 @@
 	wssport[dev] = pnp_port_start(pdev, 0);
 	wssdma[dev] = pnp_dma(pdev, 0);
 	wssirq[dev] = pnp_irq(pdev, 0);
-	if (acard->type == CMI8330)
+	if (pnp_port_start(pdev, 1))
 		fmport[dev] = pnp_port_start(pdev, 1);
 
 	/* allocate SB16 resources */
@@ -377,8 +377,13 @@
 	sbdma8[dev] = pnp_dma(pdev, 0);
 	sbdma16[dev] = pnp_dma(pdev, 1);
 	sbirq[dev] = pnp_irq(pdev, 0);
-	if (acard->type == CMI8329)
-		fmport[dev] = pnp_port_start(pdev, 1);
+	/* On CMI8239, the OPL3 port might be present in SB16 PnP resources */
+	if (fmport[dev] == SNDRV_AUTO_PORT) {
+		if (pnp_port_start(pdev, 1))
+			fmport[dev] = pnp_port_start(pdev, 1);
+		else
+			fmport[dev] = 0x388;	/* Or hardwired */
+	}
 
 	/* allocate MPU-401 resources */
 	pdev = acard->mpu;

-- 
Ondrej Zary
