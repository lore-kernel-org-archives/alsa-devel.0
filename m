From: Fedor Karpelevitch <fedor@apache.org>
Subject: Re: [2.4]ALi M5451 sound hangs on init; workaround
Date: Wed, 11 Dec 2002 10:36:21 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212111036.21771.fedor@apache.org>
References: <200212110715.20617.fedor@apache.org> <1039625298.18087.61.camel@irongate.swansea.linux.org.uk> <200212110852.42778.fedor@apache.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200212110852.42778.fedor@apache.org>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fedor Karpelevitch <fedor@apache.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Vicente Aguilar <bisente@bisente.com>, alsa-devel@lists.sourceforge.net, Debian-Laptops <debian-laptop@lists.debian.org>
List-Id: alsa-devel@alsa-project.org

> > > I have ALi M5451 souncard in my laptop (Compaq Presario 900z
> > > for those searching) and it hangs the machine with any kernel I
> > > tried (currently 2.4.20-ac1 + hirofumi patch). I traced it down
> > > to the line where it hangs - that is
> > > drivers/sound/trident.c:3379 which says:
> > > pci_write_config_byte(pci_dev, 0xB8, ~temp);
> >
> > Looking at the docs it looks like the code Matt Wu added may have
> > been meant to do
> >
> > 	pci_read_config_byte(pci_dev, 0x59, temp)
> > 	temp &= ~0x80
> > 	pci_write...
>
> ---------------------
> I'll try it and will tell you what the result is. Anyway, what are
> those commands doing, i.e. what am I loosing when I comment it out?
> Is there some specific functionality I should test to see the
> result of these changes?
>
> > and similarly for the other port
> >
> > (Ditto with fixing setup_multi_cannnels)
> >
> > Does it work sanely with those fixd ?

here is what I i got it work with:

--------
static int ali_close_multi_channels(void)
{
        char temp = 0;
        struct pci_dev *pci_dev = NULL;

        pci_dev 
=pci_find_device(PCI_VENDOR_ID_AL,PCI_DEVICE_ID_AL_M1533,
                pci_dev);
        if (pci_dev == NULL)
                return -1;
-       temp = 0x80;
+       pci_read_config_byte(pci_dev, 0x59, &temp);
+      temp &= ~0x80;
-       pci_write_config_byte(pci_dev, 0x59, ~temp);
+       pci_write_config_byte(pci_dev, 0x59, temp);

        pci_dev = pci_find_device(PCI_VENDOR_ID_AL,
                PCI_DEVICE_ID_AL_M7101, pci_dev);
        if (pci_dev == NULL)
                return -1;

-       temp = 0x20;
+       pci_read_config_byte(pci_dev, 0xB8, &temp);
+       temp &= ~0x20
-       pci_write_config_byte(pci_dev, 0xB8, ~temp);  // the line I 
+       pci_write_config_byte(pci_dev, 0xB8, temp);  //commented out

        return 0;
}
---------------------

almost as I posted before, just passing pointers to the read method.
It works, but the question as to what is this supposed to affect 
remains...

should similar changes be made elsewhere in this driver? I better not 
change blindly what I do not quite understand...

Fedor


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
