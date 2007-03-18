From: Rene Herman <rene.herman@gmail.com>
Subject: Re: isa_bus: sb8
Date: Sun, 18 Mar 2007 22:28:10 +0100
Message-ID: <45FDAEEA.3050904@gmail.com>
References: <45E4A2F5.3080607@gmail.com> <20070317195829.GA6455@sygehus.dk>
	<45FC79A2.6080807@gmail.com> <20070318005659.GA10328@sygehus.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070318005659.GA10328@sygehus.dk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 03/18/2007 01:56 AM, Rask Ingemann Lambertsen wrote:

(I'll look at the sb8 autoprobe issue)

>> By the way -- are you in fact using a SG NX Pro? Not a SG NX Pro 16 or 
>> some other 16-bit SG? The NX Pro should have an FCCID of I38-MMSD802. If 
>> you are in fact using a 16-bit SG the card's better of being used in 
>> it's native WSS mode, though snd-sgalaxy.

For the archives -- an "NX Pro 16" actually uses an AZT2316 chipset and 
should use the snd-azt2320 driver. The Sound Galaxy Nova 16, Nova 16 
Extra, Orion 16 and Pro 16 use the sbd-sgalaxy driver.

> The FCCID is I38-SGNXPRO.

Thanks, yes, that's a "real SB8 clone" as well. Don't have one...

The newer Sound Galaxy 16-bit boards also have just the base 0x220/0x240 
jumper and use the EEPROM for the other settings. At least the WSS IRQ 
and DMA channel on those can actually be set by software and I sort of 
suspect this might also be the case for the your card in fact, but well, 
no idea how and no hardware to try.

Rene.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
