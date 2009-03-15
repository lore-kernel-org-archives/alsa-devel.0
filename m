From: Emmanuel Chanel <emmanuelchanel@gmail.com>
Subject: My PC has 6GB memory but the limitation of the
	alsa-driver is 4GB.
Date: Sun, 15 Mar 2009 14:02:36 +0900
Message-ID: <1237093356.3501.45.camel@localhost.localdomain>
References: <1237056610.21086.72.camel@localhost.localdomain>
	<fd3eb9bf0903141235v1878ae03h8e51b8bcebb4c87d@mail.gmail.com>
	<1237061065.2581.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F12624467
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 06:02:41 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id u3so630750tia.8
	for <alsa-devel@alsa-project.org>; Sat, 14 Mar 2009 22:02:39 -0700 (PDT)
In-Reply-To: <1237061065.2581.3.camel@localhost.localdomain>
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

The problem "Fedora 10 x86_64 alsa problem: Realtek ALC889A Audio
Codec(ATI azalia) not detected on alsa" seems solved.
I consulted #alsa on FreeNode. And Mr. Daniel Koukola discovered the
reason. He spared for 14 hours in all this evening and all this night
for my problem. Thank you very, very, much, Mr. Daniel Koukola!
See https://bugzilla.redhat.com/show_bug.cgi?id=489828 #17 and #18

------
[emmanuel@star1 hda]$ pwd
/home/emmanuel/Softwares/alsa-driver-1.0.19/alsa-kernel/pci/hda
[emmanuel@star1 hda]$ diff hda_intel.c{0,}
2215,2216c2215,2218
< 	if ((gcap & 0x01) && !pci_set_dma_mask(pci, DMA_64BIT_MASK))
< 		pci_set_consistent_dma_mask(pci, DMA_64BIT_MASK);
---
> 	/*	if ((gcap & 0x01) && !pci_set_dma_mask(pci, DMA_64BIT_MASK))
> 		pci_set_consistent_dma_mask(pci, DMA_64BIT_MASK); */
> 	pci_set_dma_mask(pci, DMA_32BIT_MASK);
> 	pci_set_consistent_dma_mask(pci, DMA_32BIT_MASK);

-- 
Emmanuel Chanel <emmanuelchanel@gmail.com>
