From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.4]ALi M5451 sound hangs on init; workaround
Date: 11 Dec 2002 16:48:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1039625298.18087.61.camel@irongate.swansea.linux.org.uk>
References: <200212110715.20617.fedor@apache.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200212110715.20617.fedor@apache.org>
To: Fedor Karpelevitch <fedor@apache.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Vicente Aguilar <bisente@bisente.com>, alsa-devel@lists.sourceforge.net, Debian-Laptops <debian-laptop@lists.debian.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2002-12-11 at 15:15, Fedor Karpelevitch wrote:
> I have ALi M5451 souncard in my laptop (Compaq Presario 900z for those 
> searching) and it hangs the machine with any kernel I tried 
> (currently 2.4.20-ac1 + hirofumi patch). I traced it down to the line 
> where it hangs - that is drivers/sound/trident.c:3379 which says:
> pci_write_config_byte(pci_dev, 0xB8, ~temp);

Looking at the docs it looks like the code Matt Wu added may have 
been meant to do

	pci_read_config_byte(pci_dev, 0x59, temp)
	temp &= ~0x80
	pci_write...

and similarly for the other port

(Ditto with fixing setup_multi_cannnels)

Does it work sanely with those fixd ?
