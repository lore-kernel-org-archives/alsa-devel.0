From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: [Fwd: Re: Support for platform bus]
Date: Thu, 01 Sep 2005 19:44:49 +0100
Message-ID: <1125600289.3384.11.camel@mayday.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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



On Thu, 2005-09-01 at 16:44 +0200, Takashi Iwai wrote:
> At Thu, 01 Sep 2005 00:42:36 +0100,
> Adrian McMenamin wrote:
> > 
> > I am attempting to write an ALSA driver for the sound card on the
> > Dreamcast.
> > 
> > I have this in the code:
> > 
> > 	snd_card_set_dev(dreamcastcard, &platform_bus);
> 
> The second argument is the pointer to struct device.
> You should have got a compiler warning about pointer cast.

Sorry are you saying it is, or it should be... because plaform_bus is
defined in patform.c as below:


20 struct device platform_bus = {
21         .bus_id         = "platform",
22 };

and is declared in device.h:


384 extern struct device platform_bus;

(lines are from 2.6.12)

And the guide to writing a driver states:

At some point, typically after calling snd_device_new(), you need to register the struct device of the chip you're handling for udev and co. ALSA provides a macro for compatibility with older kernels. Simply call like the following: 

  snd_card_set_dev(card, &pci->dev);
          

so that it stores the PCI's device pointer to the card. This will be
referred by ALSA core functions later when the devices are registered. 

In the case of non-PCI, pass the proper device struct pointer of the BUS
instead. (In the case of legacy ISA without PnP, you don't have to do
anything.) 


So what have I done wrong?


I don't get a compiler error either:

[adrian@mayday aica]$ touch snd_card_aica.c
[adrian@mayday aica]$ make ARCH=sh
CROSS_COMPILE=/home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-
make -C /home/adrian/linux-sh/linux-2.6.12.3
M=/home/adrian/linux-sh/aica modules
make[1]: Entering directory `/home/adrian/linux-sh/linux-2.6.12.3'
  CC [M]  /home/adrian/linux-sh/aica/snd_card_aica.o
  Building modules, stage 2.
  MODPOST
  LD [M]  /home/adrian/linux-sh/aica/snd_card_aica.ko
make[1]: Leaving directory `/home/adrian/linux-sh/linux-2.6.12.3'





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
