From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Thu, 09 Jun 2005 16:34:53 +0800
Message-ID: <42A7FF2D.7050801@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<s5h8y1n7af3.wl@alsa2.suse.de>	<42A5B7D4.50201@netvigator.com>	<200506071716.05194.alien999999999@users.sourceforge.net>	<s5hwtp6w2nw.wl@alsa2.suse.de>	<42A6B51F.20405@netvigator.com> <s5h8y1lkv1c.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8y1lkv1c.wl@alsa2.suse.de>
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
> At Wed, 08 Jun 2005 17:06:39 +0800,
> Raymond wrote:
> 

> 
>>Is there any reason to make this change ?
>>
>>alsa-kernel/pci/au88x0/au88x0.c
>>@@ -144,15 +144,18 @@
>>         // check PCI availability (DMA).
>>         if ((err = pci_enable_device(pci)) < 0)
>>                 return err;
>>-       if (!pci_dma_supported(pci, VORTEX_DMA_MASK)) {
>>+        if (pci_set_dma_mask(pci, VORTEX_DMA_MASK) < 0 ||
>>+               pci_set_consistent_dma_mask(pci, VORTEX_DMA_MASK) < 0) {
>>                 printk(KERN_ERR "error to set DMA mask\n");
>>+               pci_disable_device(pci);
>>                 return -ENXIO;
>>         }
>>-       pci_set_dma_mask(pci, VORTEX_DMA_MASK);
> 
> 
> This is clean up.
> 
> 
>>         chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
>>-       if (chip == NULL)
>>+       if (chip == NULL) {
>>+               pci_disable_device(pci);
>>                 return -ENOMEM;
>>+       }
> 
> 
> This fixes the PCI state in the error path.
> 
> 
>>         chip->card = card;
>>
>>@@ -202,6 +205,8 @@
>>                 goto alloc_out;
>>         }
>>
>>+       snd_card_set_dev(card, &pci->dev);
>>+
>>         *rchip = chip;
> 
> 
> And this sets up the missing sysfs stuff.
> 
> 

So these changes are not neccesary(critical) for 
au88x0_64_bits_compatible.patch  (AMD64 and X86_64 ) , just normal ALSA 
cleanup.



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
