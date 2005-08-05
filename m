From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Fri, 05 Aug 2005 20:46:07 +0800
Message-ID: <42F35F8F.4060808@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<s5h8y1n7af3.wl@alsa2.suse.de>	<42A5B7D4.50201@netvigator.com>	<200506071716.05194.alien999999999@users.sourceforge.net>	<s5hwtp6w2nw.wl@alsa2.suse.de>	<42A6B51F.20405@netvigator.com>	<s5h8y1lkv1c.wl@alsa2.suse.de>	<42EA4086.6030702@netvigator.com> <s5hoe8lbqe0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoe8lbqe0.wl%tiwai@suse.de>
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
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 29 Jul 2005 22:43:18 +0800,
> Raymond wrote:
> 
>>Takashi Iwai wrote:
>>
>>>At Wed, 08 Jun 2005 17:06:39 +0800,
>>>Raymond wrote:
>>>
>>>
>>>
>>>>Is there any reason to make this change ?
>>>>
>>>>alsa-kernel/pci/au88x0/au88x0.c
>>>>@@ -144,15 +144,18 @@
>>>>        // check PCI availability (DMA).
>>>>        if ((err = pci_enable_device(pci)) < 0)
>>>>                return err;
>>>>-       if (!pci_dma_supported(pci, VORTEX_DMA_MASK)) {
>>>>+        if (pci_set_dma_mask(pci, VORTEX_DMA_MASK) < 0 ||
>>>>+               pci_set_consistent_dma_mask(pci, VORTEX_DMA_MASK) < 0) {
>>>>                printk(KERN_ERR "error to set DMA mask\n");
>>>>+               pci_disable_device(pci);
>>>>                return -ENXIO;
>>>>        }
>>>>-       pci_set_dma_mask(pci, VORTEX_DMA_MASK);
>>>
>>>
>>>This is clean up.
>>>
>>>
>>>
>>>>        chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
>>>>-       if (chip == NULL)
>>>>+       if (chip == NULL) {
>>>>+               pci_disable_device(pci);
>>>>                return -ENOMEM;
>>>>+       }
>>>
>>>
>>>This fixes the PCI state in the error path.
>>>
>>>
>>>
>>>>        chip->card = card;
>>>>
>>>>@@ -202,6 +205,8 @@
>>>>                goto alloc_out;
>>>>        }
>>>>
>>>>+       snd_card_set_dev(card, &pci->dev);
>>>>+
>>>>        *rchip = chip;
>>>
>>>
>>>And this sets up the missing sysfs stuff.
>>>
>>>
>>
>>It seem that these two patches for Kernel 2.6 were lost when au88x0 
>>migrate from alsa-driver to alsa-kernel.
> 
> 
> You're right.  It seems dropped at that time accidentally.
> 
> Could you care to post a patch to fix them?
> 
> 


au88x0_fix_fc4.patch (file# 4739)

http://savannah.nongnu.org/patch/?func=detailitem&item_id=4107

posted in the open vortex project patch manager (item id #4107) add back 
the two patches lost during au88x0 migrate from alsa-driver to alsa-kernel.

http://savannah.nongnu.org/patch/download.php?item_id=4107&item_file_id=4739



These are the two patches lost during au88x0 migrate from alsa-driver to 
alsa-kernel.

http://www.mail-archive.com/alsa-cvslog@lists.sourceforge.net/msg03580.html

* fixed the DMA allocation.
   pci_set_dma_mask() is called together with pci_set_consistent_dma_mask().
   also clean up the double check of mask.

http://www.mail-archive.com/alsa-cvslog@lists.sourceforge.net/msg03642.html

* added snd_card_set_dev() macro.
* sysfsfied more pci, isapnp and usb drivers.









-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
