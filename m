From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] cmi8330: Allow MPU-401-less operation
Date: Tue, 7 Jul 2009 18:09:48 +0200
Message-ID: <200907071809.49437.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail.atlantis.sk [80.94.52.35])
	by alsa0.perex.cz (Postfix) with ESMTP id AD0BE2449E
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 18:09:55 +0200 (CEST)
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

Adding MPU-401 support to cmi8330 driver could cause a regression (non-working 
sound) on a system where there is no free IRQ for the MPU-401 device (which 
is not very uncommon as this card requires two separate IRQs plus a third one 
for MPU-401).


When MPU-401 PnP configuration fails (mostly because of unavailable IRQ), just 
ignore MPU-401 and continue without it.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-test/sound/isa/cmi8330.c	2009-07-06 22:39:24.000000000 +0200
+++ linux-2.6.30-pentium/sound/isa/cmi8330.c	2009-07-06 22:39:09.000000000 
+0200
@@ -389,12 +389,12 @@
 	pdev = acard->mpu;
 
 	err = pnp_activate_dev(pdev);
-	if (err < 0) {
-		snd_printk(KERN_ERR "MPU-401 PnP configure failure\n");
-		return -EBUSY;
+	if (err < 0)
+		snd_printk(KERN_ERR "MPU-401 PnP configure failure: will be disabled\n");
+	else {
+		mpuport[dev] = pnp_port_start(pdev, 0);
+		mpuirq[dev] = pnp_irq(pdev, 0);
 	}
-	mpuport[dev] = pnp_port_start(pdev, 0);
-	mpuirq[dev] = pnp_irq(pdev, 0);
 	return 0;
 }
 #endif


-- 
Ondrej Zary
