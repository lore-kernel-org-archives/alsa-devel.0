From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: Please help me fix the CS4610 driver.
Date: Thu, 16 Oct 2003 13:14:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031016111447.GA11164@rhlx01.fht-esslingen.de>
References: <E1A9zH5-0002k2-00@sc8-sf-list2.sourceforge.net>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E1A9zH5-0002k2-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: iLLfated <l8tr3000@yahoo.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Oct 15, 2003 at 08:55:26PM -0700, alsa-devel-request@lists.sourceforge.net wrote:
> Message: 3
> Date: Wed, 15 Oct 2003 12:18:28 -0700 (PDT)
> From: iLLfated <l8tr3000@yahoo.com>
> To: alsa-devel@lists.sourceforge.net
> Subject: [Alsa-devel] Please help me fix the CS4610 driver.
> 
> Greetings,
> 
>   I've been trying unsuccessfully to get my CS46xx
> sound working on my thinkpad for days now and have
> determined its a driver issue. I've written up this
> web page which shows all steps i've taken to get the
> card partially working (and their results):
> 
> http://home.earthlink.net/~nix4ever/info/alsa_prob/alsa.html
> 
> If any additional information is needed please contact
> me to test patches or any other conigurations. I'd try
> to fix the driver myself
> although its a bit beyond my current coding skill
> level and i'm lost when examining the code.
First, did you try "modinfo cs46xx"?
There's some Thinkpad stuff there...

Second, the
Sound Fusion CS46xx soundcard not found or device busy
message is in alsa-driver/pci/cs46xx/cs46xx.c/alsa_card_cs46xx_init()
when pci_module_init() failed.
pci_module_init most likely calls some hardware probing functions of the
driver (in this case: pci_driver.probe, which is set to
snd_card_cs46xx_probe()).
Thus, you definitely need to find out where exactly snd_card_cs46xx_probe()
fails and why.
Add some trace logs to this function to get some messages about where it fails,
then recompile.

Good luck!

Andreas Mohr


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
