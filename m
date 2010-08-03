From: Ondrej Zary <linux@rainbow-software.org>
Subject: als4000: enable burst mode
Date: Tue, 3 Aug 2010 23:57:05 +0200
Message-ID: <201008032357.06661.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail1-out1.atlantis.sk [80.94.52.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 831DB24463
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 23:57:15 +0200 (CEST)
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

Enable burst mode to prevent dropouts during high PCI bus usage.
The card is useless in X without this because of dropouts when anything moves
on the screen (at least with PCI VGA card). Enabling this is also recommended
by the datasheet (page 48).

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.35-rc2/sound/pci/als4000.c	2010-06-06 05:43:24.000000000 +0200
+++ linux-2.6.35-rc3/sound/pci/als4000.c	2010-08-03 23:50:08.000000000 +0200
@@ -763,9 +763,9 @@ static void snd_als4000_configure(struct
 	/* SPECS_PAGE: 39 */
 	for (i = ALS4K_GCR91_DMA0_ADDR; i <= ALS4K_GCR96_DMA3_MODE_COUNT; ++i)
 		snd_als4k_gcr_write(chip, i, 0);
-	
+	/* enable burst mode to prevent dropouts during high PCI bus usage */
 	snd_als4k_gcr_write(chip, ALS4K_GCR99_DMA_EMULATION_CTRL,
-		snd_als4k_gcr_read(chip, ALS4K_GCR99_DMA_EMULATION_CTRL));
+		snd_als4k_gcr_read(chip, ALS4K_GCR99_DMA_EMULATION_CTRL) | 0x04);
 	spin_unlock_irq(&chip->reg_lock);
 }
 


-- 
Ondrej Zary
