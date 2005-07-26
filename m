From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (1/2)
Date: Tue, 26 Jul 2005 12:51:47 +0200
Message-ID: <200507261251.48291.rjw__17996.0071262487$1122375222$gmane$org@sisk.pl>
References: <200507261247.05684.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.sisk.pl (grendel.sisk.pl [217.67.200.140])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id EA23D1C3
	for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2005 12:52:14 +0200 (MEST)
Received: from mail.sisk.pl ([127.0.0.1])
 by localhost (grendel [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 30188-05 for <alsa-devel@alsa-project.org>;
 Tue, 26 Jul 2005 12:50:37 +0200 (CEST)
In-Reply-To: <200507261247.05684.rjw@sisk.pl>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following patch adds free_irq() and request_irq() to the suspend and
resume, respectively, routines in the snd_intel8x0 driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- linux-2.6.13-rc3-git5/sound/pci/intel8x0.c	2005-07-23 19:26:43.000000000 +0200
+++ patched/sound/pci/intel8x0.c	2005-07-25 18:21:36.000000000 +0200
@@ -2373,6 +2373,8 @@ static int intel8x0_suspend(snd_card_t *
 	for (i = 0; i < 3; i++)
 		if (chip->ac97[i])
 			snd_ac97_suspend(chip->ac97[i]);
+	if (chip->irq >= 0)
+		free_irq(chip->irq, (void *)chip);
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -2384,7 +2386,14 @@ static int intel8x0_resume(snd_card_t *c
 
 	pci_enable_device(chip->pci);
 	pci_set_master(chip->pci);
-	snd_intel8x0_chip_init(chip, 0);
+	if (request_irq(chip->irq, snd_intel8x0_interrupt, SA_INTERRUPT|SA_SHIRQ, card->shortname, (void *)chip)) {
+		snd_printk("unable to grab IRQ %d\n", chip->irq);
+		chip->irq = -1;
+		pci_disable_device(chip->pci);
+		return -EBUSY;
+	}
+	synchronize_irq(chip->irq);
+	snd_intel8x0_chip_init(chip, 1);
 
 	/* refill nocache */
 	if (chip->fix_nocache)


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
