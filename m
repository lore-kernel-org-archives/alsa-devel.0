From: Jiang zhe <zhe.jiang@intel.com>
Subject: Re: [PATCH]Device ID for Toshiba laptop which
	uses	AD1986A
Date: Mon, 24 Dec 2007 10:12:18 +0800
Message-ID: <1198462338.3811.2.camel@localhost.localdomain>
References: <1198115054.22122.8.camel@localhost.localdomain>
	<20071221193932.GF29292@serv.smile.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A787103913
	for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2007 03:11:48 +0100 (CET)
In-Reply-To: <20071221193932.GF29292@serv.smile.org.ua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andy@smile.org.ua>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-12-21 at 21:39 +0200, Andy Shevchenko wrote:
> Hi Jiang zhe!
> 
>  On Thu, Dec 20, 2007 at 09:44:14AM +0800, Jiang zhe wrote next:
> 
> > @@ -859,6 +859,7 @@ static struct snd_pci_quirk ad1986a_cfg_
> >  	SND_PCI_QUIRK(0x17aa, 0x1017, "Lenovo A60", AD1986A_3STACK),
> >  	SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo N100", AD1986A_LAPTOP_AUTOMUTE),
> >  	SND_PCI_QUIRK(0x17c0, 0x2017, "Samsung M50", AD1986A_LAPTOP),
> > +	SND_PCI_QUIRK(0x1179, 0xff40, "Toshiba", AD1986A_LAPTOP_EAPD),
> >  	{}
> >  };
> Please, keep list sorted by PCI SSID.
> 

Thank you very much! ^_^

--- alsa-driver-hg20071224/alsa-kernel/pci/hda/patch_analog.c	2007-12-21
09:00:06.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_analog.c	2007-12-24 10:07:54.000000000
+0800
@@ -848,6 +848,7 @@ static struct snd_pci_quirk ad1986a_cfg_
 	SND_PCI_QUIRK(0x1043, 0x81cb, "ASUS M2N", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x1043, 0x8234, "ASUS M2N", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x10de, 0xcb84, "ASUS A8N-VM", AD1986A_3STACK),
+	SND_PCI_QUIRK(0x1179, 0xff40, "Toshiba", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x144d, 0xb03c, "Samsung R55", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x144d, 0xc01e, "FSC V2060", AD1986A_LAPTOP),
 	SND_PCI_QUIRK(0x144d, 0xc023, "Samsung X60", AD1986A_LAPTOP_EAPD),
@@ -859,7 +860,6 @@ static struct snd_pci_quirk ad1986a_cfg_
 	SND_PCI_QUIRK(0x17aa, 0x1017, "Lenovo A60", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo N100", AD1986A_LAPTOP_AUTOMUTE),
 	SND_PCI_QUIRK(0x17c0, 0x2017, "Samsung M50", AD1986A_LAPTOP),
-	SND_PCI_QUIRK(0x1179, 0xff40, "Toshiba", AD1986A_LAPTOP_EAPD),
 	{}
 };
