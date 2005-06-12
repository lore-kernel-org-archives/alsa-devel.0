From: Raymond <rayau@netvigator.com>
Subject: Re: [Openvortex-dev] Re: [ALSA - driver 0001138]: errors when installing
 au8820 modules
Date: Sun, 12 Jun 2005 23:18:10 +0800
Message-ID: <42AC5232.3050303@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<s5h8y1n7af3.wl@alsa2.suse.de>	<42A5B7D4.50201@netvigator.com>	<200506071716.05194.alien999999999@users.sourceforge.net>	<s5hwtp6w2nw.wl@alsa2.suse.de>	<42A6B51F.20405@netvigator.com>	<s5h8y1lkv1c.wl@alsa2.suse.de> <42A7FF2D.7050801@netvigator.com> <42A81721.80702@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A81721.80702@mail.ru>
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
List-Id: alsa-devel@alsa-project.org

Igor Kovalenko wrote:
> Raymond wrote:
> 
>>Takashi Iwai wrote:
>>>Raymond wrote:
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
>>>
>>>And this sets up the missing sysfs stuff.
>>>
>>>
>>
>>So these changes are not neccesary(critical) for
>>au88x0_64_bits_compatible.patch  (AMD64 and X86_64 ) , just normal ALSA
>>cleanup.
>>
> 
> 
> Actually without snd_card_set_dev() you will get oops shortly because device
> pointer won't be available to driver.
> DMA mask cleanup is to follow general guidelines about consistent mapping.
> 

This patch (ALSA 1.0.2c, Kernel 2.6) had been posted on the 
openvortex-devel mailing list since Feb, 2004.

http://lists.nongnu.org/archive/html/openvortex-dev/2004-02/msg00010.html


Does it mean that 32bits machines will also get oops on Kernel 2.6 ?

Any unresolved bugs in ALSA BTS are related to the missing of 
"snd_card_set_dev(card, &pci->dev);" ?





-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
