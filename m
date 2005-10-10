From: R.Marek@sh.cvut.cz
Subject: [PATCH] ESS Solo1 IRQ issue take 2
Date: 10 Oct 2005 09:46:29 -0000
Message-ID: <20051010094629.12123.qmail@desitka.sh.cvut.cz>
References: <20051010085543.GB2369@elf.ucw.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051010085543.GB2369@elf.ucw.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net, pavel@suse.cz
List-Id: alsa-devel@alsa-project.org

Hello,

>ACK (modulo formatting). [It is probably best to cc alsa-devel or
>linux-kernel, even on small changes].
>Pavel

Ok here we go - second try.

This patch fixes the suspend/resume issue I'm having with ESS-Solo1
soundcard. Without this patch I might get after resume message
that kernel is disabling the IRQ5 (soundcard). If there was something
playing it wont continue after resume without this patch.

Signed-Off-By: Rudolf Marek <r.marek@sh.cvut.cz>

There is one thing left. When I suspending to ram or to disk while
playing something I got repeated sound what left without the IRQ.
Like ta ta ta ta ta ta you know that sound ;)
I tried to disable the DMA crt on the soundcard in suspend routine
but it wont help. Perhaps userspace process is stopped and is not
delivering new data?! Will pci_disable_device also disable the DMA?

Thanks,

Regards
Rudolf


--- a/sound/pci/es1938.c	2005-09-30 23:17:35.000000000 +0200
+++ b/pci/es1938.c	2005-10-02 01:23:31.000000000 +0200
@@ -1390,7 +1397,8 @@
 		*d = snd_es1938_reg_read(chip, *s);
 
 	outb(0x00, SLIO_REG(chip, IRQCONTROL)); /* disable irqs */
-
+	if (chip->irq >= 0)                                                                         
+		free_irq(chip->irq, (void *)chip);  
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -1401,6 +1409,7 @@
 	unsigned char *s, *d;
 
 	pci_enable_device(chip->pci);
+	request_irq(chip->pci->irq, snd_es1938_interrupt, SA_INTERRUPT|SA_SHIRQ, "ES1938", (void *)chip);
 	snd_es1938_chip_init(chip);
 
 	/* restore mixer-related registers */


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
