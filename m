From: Fedor Karpelevitch <fedor@karpelevitch.net>
Subject: [PATCH]Re: [2.4]ALi M5451 sound hangs on init; workaround
Date: Fri, 13 Dec 2002 07:10:55 -0800
Sender: Fedor Karpelevitch <fedor@karpelevitch.net>
Message-ID: <200212130710.55520.fedor@karpelevitch.net>
References: <200212110715.20617.fedor@apache.org> <200212111142.31709.fedor@apache.org> <1039641154.18412.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/hf+96xSOxc4hV4"
Return-path: <bounce-debian-laptop=debian-laptop=m.gmane.org@lists.debian.org>
In-Reply-To: <1039641154.18412.28.camel@irongate.swansea.linux.org.uk>
Resent-Message-ID: <LcmECD.A.39D.Q_f-9@murphy>
List-Post: <mailto:debian-laptop@lists.debian.org>
List-Help: <mailto:debian-laptop-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-laptop-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-laptop-request@lists.debian.org?subject=unsubscribe>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Vicente Aguilar <bisente@bisente.com>, alsa-devel@lists.sourceforge.net, Debian-Laptops <debian-laptop@lists.debian.org>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_/hf+96xSOxc4hV4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Среда 11 Декабрь 2002 13:12, Alan Cox wrote:
> On Wed, 2002-12-11 at 19:42, Fedor Karpelevitch wrote:
> > So I wonder what toggling those bits is supposed to change. I
> > would test that somehow then
>
> 6 channel audio mode

so here is the patch against 2.4.21-pre1 (I beleive it should equally 
apply to 20-ac2)
It works for me and fixes all four occurences of that error in the 
driver.

Fedor



--Boundary-00=_/hf+96xSOxc4hV4
Content-Type: text/plain;
  charset="iso-8859-1";
  name="patch-tridfix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-tridfix.txt"

--- linux-2.4.21-pre1-tridfix/drivers/sound/trident.c.orig	2002-12-12 15:28:00.000000000 -0800
+++ linux-2.4.21-pre1-tridfix/drivers/sound/trident.c	2002-12-12 15:30:48.000000000 -0800
@@ -3368,15 +3368,17 @@
         pci_dev = pci_find_device(PCI_VENDOR_ID_AL,PCI_DEVICE_ID_AL_M1533, pci_dev);
         if (pci_dev == NULL)
                 return -1;
-	temp = 0x80;
-	pci_write_config_byte(pci_dev, 0x59, ~temp);
+	pci_read_config_byte(pci_dev, 0x59, &temp);
+	temp &= ~0x80;
+	pci_write_config_byte(pci_dev, 0x59, temp);
 	
 	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, pci_dev);
 	if (pci_dev == NULL)
                 return -1;
 
-	temp = 0x20;
-	pci_write_config_byte(pci_dev, 0xB8, ~temp);
+	pci_read_config_byte(pci_dev, 0xB8, &temp);
+	temp &= ~0x20;
+	pci_write_config_byte(pci_dev, 0xB8, temp);
 
 	return 0;
 }
@@ -3390,13 +3392,15 @@
 	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pci_dev);
 	if (pci_dev == NULL)
                 return -1;
-	temp = 0x80;
+	pci_read_config_byte(pci_dev, 0x59, &temp);
+	temp |= 0x80;
 	pci_write_config_byte(pci_dev, 0x59, temp);
 	
 	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, pci_dev);
  	if (pci_dev == NULL)
                 return -1;
-	temp = 0x20;
+	pci_read_config_byte(pci_dev, (int)0xB8, &temp);
+	temp |= 0x20;
 	pci_write_config_byte(pci_dev, (int)0xB8,(u8) temp);
 	if (chan_nums == 6) {
 		dwValue = inl(TRID_REG(card, ALI_SCTRL)) | 0x000f0000;

--Boundary-00=_/hf+96xSOxc4hV4--
