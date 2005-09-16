From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0 modem
Date: Fri, 16 Sep 2005 10:17:01 +0800
Message-ID: <432A2B1D.3040204@netvigator.com>
References: <20050911124530.GA16795@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <4329946B.9030407@netvigator.com> <200509152325.42883.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200509152325.42883.alien999999999@users.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alien <alien999999999@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net, openvortex-dev@nongnu.org, Sasha Khapyorsky <sashak@smlink.com>
List-Id: alsa-devel@alsa-project.org

Alien wrote:
> Op donderdag 15 september 2005 17:34, schreef Raymond:
> 
>>Sasha Khapyorsky wrote:
>>
>>>Great, the secondary modem codec is there. The valid codec id bits are
>>>24:25 (AC97 interface supports up to four codecs):
>>>
>>>#define VORTEX_CODEC_ID_SHIFT 24
>>>
>>>I will send cleaned codec access patch separately and will look what is
>>>next.
>>
>>It would be more easy to debug/maintain the driver if using different
>>read/write routines for audio and modem codec.
>>
>>Audio codec is always primary in sound card and audio/modem combo
>>
>>The existing vortex_codec_read() and vortex_codec_write() can remain
>>unchanged.
>>
>>Just add new routine vortex_modem_codec_read() vortex_modem_code_write()
>>to handle secondary/primary modem codec for audio/modem combo and PCI
>>modem card.
>>
>>http://www.nix.ru/autocatalog/modems/AurVcomPCIV90RTL_5817.html
>>
>>Make sure your patch is 32bits/64bits compatible
>>
>>AMD64 user may use the  PCI audio/modem combo card and PCI modem card.
> 
> 
> does that mean that PCI sound card is broken on AMD64 ?
> 
> cause, maybe that's why my snd-au8810 card gives problems...

http://www.amd.com/us-en/assets/content_type/DownloadableAssets/Porting_x86_Linux_device_drivers_to_AMD64_Technology.htm

Yes, the au88x0 driver in ALSA CVS is still broken on AMD64 until 
someone submit au88x0_amd64.patch

http://lists.nongnu.org/archive/html/openvortex-dev/2005-05/msg00000.html

I suspect your au8810 problem is caused by ACPI.
Erik has some volume problem on his au8830.

Igor Kovalenko (Diamond Sonic Impact S90) and penguinparty
report the patch work on their 64-bits machines.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1138


You still need feedback from
1) au8810 user on 32bits/64bits machines
2) au8820 user on 32bits machines
3) au8830 user on 32bits/64bits machines
4) mpu401 test

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1025
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1047


I only test the core part of the patch using my au8830 on 32bits machine.


diff -udr /tmp/yy/linux-2.6.11/sound/pci/au88x0/au88x0.c 
sound/pci/au88x0/au88x0.c
--- /tmp/yy/linux-2.6.11/sound/pci/au88x0/au88x0.c	2005-04-25 
22:22:07.000000000 +0400
+++ sound/pci/au88x0/au88x0.c	2005-04-25 22:24:36.000000000 +0400
@@ -144,15 +144,18 @@
  	// check PCI availability (DMA).
  	if ((err = pci_enable_device(pci)) < 0)
  		return err;
-	if (!pci_dma_supported(pci, VORTEX_DMA_MASK)) {
+        if (pci_set_dma_mask(pci, VORTEX_DMA_MASK) < 0 ||
+        	pci_set_consistent_dma_mask(pci, VORTEX_DMA_MASK) < 0) {
  		printk(KERN_ERR "error to set DMA mask\n");
+		pci_disable_device(pci);
  		return -ENXIO;
  	}
-	pci_set_dma_mask(pci, VORTEX_DMA_MASK);

  	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL)
+	if (chip == NULL) {
+		pci_disable_device(pci);
  		return -ENOMEM;
+	}

  	chip->card = card;

@@ -202,6 +205,8 @@
  		goto alloc_out;
  	}

+	snd_card_set_dev(card, &pci->dev);
+
  	*rchip = chip;

  	return 0;
diff -udr /tmp/yy/linux-2.6.11/sound/pci/au88x0/au88x0.h 
sound/pci/au88x0/au88x0.h
--- /tmp/yy/linux-2.6.11/sound/pci/au88x0/au88x0.h	2005-04-25 
22:22:07.000000000 +0400
+++ sound/pci/au88x0/au88x0.h	2005-05-07 11:25:54.000000000 +0400
@@ -41,8 +41,8 @@

  #define	VORTEX_DMA_MASK	0xffffffff

-#define	hwread(x,y) readl((x)+((y)>>2))
-#define	hwwrite(x,y,z) writel((z),(x)+((y)>>2))
+#define	hwread(x,y) readl((x)+(y))
+#define	hwwrite(x,y,z) writel((z),(x)+(y))

  /* Vortex MPU401 defines. */
  #define	MIDI_CLOCK_DIV		0x61
@@ -172,7 +172,7 @@

  	/* PCI hardware resources */
  	unsigned long io;
-	unsigned long __iomem *mmio;
+	void __iomem *mmio;
  	unsigned int irq;
  	spinlock_t lock;




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
