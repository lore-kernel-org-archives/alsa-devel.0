From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Re: Please help me fix the CS4610 driver.
Date: Thu, 16 Oct 2003 16:32:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8EBA16.7010804@superbug.demon.co.uk>
References: <E1A9zH5-0002k2-00@sc8-sf-list2.sourceforge.net> <20031016111447.GA11164@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031016111447.GA11164@rhlx01.fht-esslingen.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: andi@rhlx01.fht-esslingen.de
Cc: alsa-devel@lists.sourceforge.net, iLLfated <l8tr3000@yahoo.com>
List-Id: alsa-devel@alsa-project.org

Andreas Mohr wrote:
> Hi,
> 
> On Wed, Oct 15, 2003 at 08:55:26PM -0700, alsa-devel-request@lists.sourceforge.net wrote:
> 
>>Message: 3
>>Date: Wed, 15 Oct 2003 12:18:28 -0700 (PDT)
>>From: iLLfated <l8tr3000@yahoo.com>
>>To: alsa-devel@lists.sourceforge.net
>>Subject: [Alsa-devel] Please help me fix the CS4610 driver.
>>
>>Greetings,
>>
>>  I've been trying unsuccessfully to get my CS46xx
>>sound working on my thinkpad for days now and have
>>determined its a driver issue. I've written up this
>>web page which shows all steps i've taken to get the
>>card partially working (and their results):
>>
>>http://home.earthlink.net/~nix4ever/info/alsa_prob/alsa.html
>>
>>If any additional information is needed please contact
>>me to test patches or any other conigurations. I'd try
>>to fix the driver myself
>>although its a bit beyond my current coding skill
>>level and i'm lost when examining the code.
> 
> First, did you try "modinfo cs46xx"?
> There's some Thinkpad stuff there...
> 
> Second, the
> Sound Fusion CS46xx soundcard not found or device busy
> message is in alsa-driver/pci/cs46xx/cs46xx.c/alsa_card_cs46xx_init()
> when pci_module_init() failed.
> pci_module_init most likely calls some hardware probing functions of the
> driver (in this case: pci_driver.probe, which is set to
> snd_card_cs46xx_probe()).
> Thus, you definitely need to find out where exactly snd_card_cs46xx_probe()
> fails and why.
> Add some trace logs to this function to get some messages about where it fails,
> then recompile.
> 
> Good luck!
> 
> Andreas Mohr
> 

I think the problem is this Thinkpad has two sound chips.
cs4610 connected to the PCI bus.
cs4239 connected to the ISA bus with audio in/out connections. Not AC97.

It does not have any AC97 codec chip. Just a proprietory Cirrus link 
between the cs4610 and the cs4239. The current cs4610 kernel driver does 
not support this link yet, so therefore sound does not work.

iLLfated has now managed to use kernel 2.6 and PNPBIOS to enable the ISA 
bus and thus talk to the cs4239 directly with the cs4232 kernel module.

It would be nice to support the cs4610 to cs4239 link, but there is no 
information on how to get it working in any Cirrus spec documents.

Cheers
James




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
