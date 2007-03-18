From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: [PATCH] ALSA/ad1816a: Fix modprobe snd_mpu401 &&
	modprobe snd_ad1816a
Date: Sun, 18 Mar 2007 20:28:07 +0100
Message-ID: <20070318192807.GA6339@sygehus.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Massimo Piccioni <dafastidio@libero.it>
List-Id: alsa-devel@alsa-project.org

From: Rask Ingemann Lambertsen <rask@sygehus.dk>

   The ad1816a driver fails if the mpu401 driver has been loaded first. This
patch against linux 2.6.20 fixes it by just ignoring the MPU-401 device in
that case, so that the rest of the sound card can be used. The ad1816a
driver already handles the MPU-401 device being unavailable due to lack of
resources in the same way.

Signed-off-by: Rask Ingemann Lambertsen <rask@sygehus.dk>
---

   Another way of fixing the failure would be to remove the MPU-401 related
code from the ad1816a driver, so the MPU-401 device is always handled by the
mpu401 driver. I'll write such a patch if you think that's better.

--- linux-2.6.20/sound/isa/ad1816a/ad1816a.c-orig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.20/sound/isa/ad1816a/ad1816a.c	2007-03-18 18:28:20.000000000 +0100
@@ -129,8 +129,8 @@ static int __devinit snd_card_ad1816a_pn
 	}
 	acard->devmpu = pnp_request_card_device(card, id->devs[1].id, NULL);
 	if (acard->devmpu == NULL) {
-		kfree(cfg);
-		return -EBUSY;
+		mpu_port[dev] = -1;
+		snd_printk(KERN_WARNING PFX "MPU401 device busy, skipping.\n");
 	}
 
 	pdev = acard->dev;
@@ -162,6 +162,10 @@ static int __devinit snd_card_ad1816a_pn
 	dma2[dev] = pnp_dma(pdev, 1);
 	irq[dev] = pnp_irq(pdev, 0);
 
+	if (acard->devmpu == NULL) {
+		kfree(cfg);
+		return 0;
+	}
 	pdev = acard->devmpu;
 	pnp_init_resource_table(cfg);
 
-- 
Rask Ingemann Lambertsen


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
