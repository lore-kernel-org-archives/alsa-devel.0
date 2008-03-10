From: Spike <spike@spykes.net>
Subject: Re: X-Fi support in ALSA.
Date: Mon, 10 Mar 2008 19:49:07 -0400
Message-ID: <20080310194907.2bb71ebf@darius>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.spykes.net (dsl.spykes.net [76.10.173.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 76DC710385E
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 00:49:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James@superbug.co.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



> Hi,
>
> I have now had a chance to read some of the specs of the X-Fi cards. 
> aka. emu20k1.
> It turns out that some of the X-Fi cards have a compatibility mode.
> By default, they boot up in compatibility mode.
> The interesting point is that this "compatibility mode" is in fact
> the intel-HD standard so could use the intel-hda driver.
> For one X-Fi card with IDs:
> Device 1102:0009 Subsystem: 1102:0010
> works a bit with the ALSA hda-intel driver.
> So far, the off the shelf hda-intel driver, with simple PCIs
> adjustment, works for the above card, but only sound capture works so
> far, so probably some quirk would be needed.
> This compatibility mode works with the Windows Vista UAA drivers.
>
> Not all X-Fi cards support with compatibility mode. For example, any 
> card with (after a cold boot into Linux)
> Device 1102:0005 Subsystem: xxxx:xxxx
> will be X-Fi only.
>
> With regard to actual full X-Fi support, I am still in the progress of 
> creating a GPL emu20k1.h file, that is the first step towards an 
> snd-emu20k1 native ALSA driver.
>
> James

Hello,

That first ID is an X-Fi Xtreme Audio PCIe (CA0110-IBG) is it not? Not a
real EMU20K1 based X-Fi, fully software driven, and from what I read its
just a PCIe variation of the old CA0106. This thing will probably work
with snd-ca0106 if creative kept to their old tactics regarding their
low end X-Fi products.

As for supporting the real X-Fi's, this is great news, its been a very
longtime coming. One just has to question Creative's motives behind
finally releasing the datasheets out of the blue like that after more
than 2 years of trying to get them. Are these sheets under an NDA?
Full support of an X-Fi will probably also need a firmware loader.

If the PCIe CA0110-IBG doesn't share any common traits with a full
blown EMU20K1, then I think the real X-Fi's should be focused on first
as many more people are going to have these real X-Fi's that are
useless to them at the moment, (about 3 years remember).

I'll be around to help test code and can try anything you will require
to help out supporting a real X-Fi card.

02:08.0 Multimedia audio controller: Creative Labs SB X-Fi [1102:0005]
        Subsystem: Unknown device 415a:0034
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at a400 [size=32]
        Memory at efc00000 (64-bit, non-prefetchable) [size=2M]
        Memory at e8000000 (64-bit, non-prefetchable) [size=64M]

Bren
