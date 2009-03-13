From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: How can PCI resource allocation fail?
Date: Thu, 12 Mar 2009 20:36:30 -0600
Message-ID: <49B9C6AE.5050308@gmail.com>
References: <49B9959F.1080705@digadd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758217AbZCMCiw@vger.kernel.org>
In-Reply-To: <49B9959F.1080705@digadd.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Christian P. Schmidt" <schmidt@digadd.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Christian P. Schmidt wrote:
> Hi all,
> 
> I'm toying with the alsa-driver for the Creative Labs X-Fi. I'm working on the PCI Express version of this card, though, which is
> the same as the PCI version plus a PCIe to PCI bridge but has a different ID:
> 
>           +-1c.2-[0000:03-04]----00.0-[0000:04]----00.0  1102:0009
> 
> 03:00.0 PCI bridge: Creative Labs Device 7006
> 04:00.0 Audio device: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
> 
> Now, after adding the ID, the driver fails:
> 
> [46833.487579] CA0106 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [46833.487586] CA0106 0000:04:00.0: PCI INT A disabled
> [46833.487588] cannot allocate the port
> [46833.487594] CA0106: probe of 0000:04:00.0 failed with error -16
> 
> The actual error is occurring in
> 
> 	chip->port = pci_resource_start(pci, 0);
> 	chip->res_port = request_region(chip->port, pci_resource_len(pci,0), "snd_ca0106");
> 	if (!chip->res_port) {
> 		snd_ca0106_free(chip);
> 		printk(KERN_ERR "cannot allocate the port\n");
> 		return -EBUSY;
> 	}
> 
> This from /proc/iomem:
> 
> f9f00000-f9ffffff : PCI Bus 0000:03
>   f9f00000-f9ffffff : PCI Bus 0000:04
>     f9ffc000-f9ffffff : 0000:04:00.0
> 
> Some additional debug output tells me that the code is actually trying to allocate 16k starting from f9ffc000. What could be
> potential reasons for the failure? Do I have to do something with the bridge before I can try to request the region?

request_region is requesting IO ports. The PCI BAR on the card is MMIO 
memory, not IO ports, so request_mem_region has to be used. It's 
possible that this driver isn't set up to handle MMIO space.
