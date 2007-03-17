From: Rene Herman <rene.herman@gmail.com>
Subject: Re: isa_bus: sb8
Date: Sun, 18 Mar 2007 00:28:34 +0100
Message-ID: <45FC79A2.6080807@gmail.com>
References: <45E4A2F5.3080607@gmail.com> <20070317195829.GA6455@sygehus.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070317195829.GA6455@sygehus.dk>
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

On 03/17/2007 08:58 PM, Rask Ingemann Lambertsen wrote:

> On Tue, Feb 27, 2007 at 10:30:29PM +0100, Rene Herman wrote:

>> 1. sb8 only probed for it's port, and then failed the load with
>> "can't grab irq 65535". This does away with the port autoprobe as
>> well; if you insist, I can add back irq and dma autoprobe instead
>> as well.
> 
> I have an Aztech Sound Galaxy NX Pro which means EEPROM instead of 
> jumpers for port, irq and dma configuration. Autoprobe would be nice
> for irq and dma because I only know that the port is 0x220.

The unfortunate thing is that autoprobe on ISA is a quite horribly bad 
idea...

On a PCI/ISA system you need to know the IRQ and DMA channel(s) the card 
is using _anyway_ since you need to tell the BIOS to not hand those out 
to PCI or ISA-PnP cards (or, in the case of IRQs, even tell it to make 
that IRQ available to ISA).

Having the driver promise to figure things out for you automatically to 
then only have it fail anyway since you didn't reserve the resources in 
the BIOS (something it's not going to be able to provide you with a good 
diagnostic for) stinks. You stand a much better chance of figuring out 
what you did wrong if you actually have to spell it out.

ISA only systems don't have the BIOS setup problem but then we're 
talking 386/486 systems and the number of those in active use which 
aren't operated by the type of PC archeologist who'd be actively 
insulted if someone implies they shouldn't specify it all manually 
(that's me) makes for a heck of an excuse to also delete the port 
autoprobe to avoid the other and main problem with ISA autoprobing; 
poking around a non-discoverable bus willy-nilly can have certain bad 
consequences. Most famously, locking up a NE2000 NIC by touching its 
ports...

Now, in actual practice, port autoprobing doesn't in fact cause all that 
much trouble so even if it might conceptually be wrong, it's also a bit 
of an "oh well" kind of situation. The sb8 driver indeed does not probe 
for IRQ and DMA (perhaps due the above considerations, I don't know) and 
the patch you replied to removed the port probe mainly due to 
consistency. Ie, specify nothing or specify it all, but let's not have 
some per-driver random ruleset.

(the old OSS driver also needs io= passed in, by the way).

I need to fast forward my attempts to alsa-current but things are being 
annoying again and I'm not finding the time. I'll try and gather Iwai's 
input on my next submission for SB8. I also still need to figure out if 
it's expected that all my "DSP 2.1" SB8 cards can't set their volumes to 
anything other than max. I do seem to have snd-sgalaxy working...

But thanks for the comment. I believe I'm seeing that doing IRQ and DMA 
autoprobe would actually be really messy (and there's that BIOS setup 
thing) but the reply is logged...

By the way -- are you in fact using a SG NX Pro? Not a SG NX Pro 16 or 
some other 16-bit SG? The NX Pro should have an FCCID of I38-MMSD802. If 
you are in fact using a 16-bit SG the card's better of being used in 
it's native WSS mode, though snd-sgalaxy.

>> However, when I tried driving an SB16 with the SB8 driver, it
>> didn't actually work. Would you happen to know/remember if this is
>> expected? Or is it a "bug"?
> 
> IIRC, the SB16 is not SBPro compatible. Look at the Sound Blaster 
> Hardware Programming Guide.

I haven't looked closely at the guts of the driver itself yet but as far 
as I'm aware, it _should_ work. The SB16 could certainly run all those 
DOS games that were programmed against an SB8 fine.

Rene.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
