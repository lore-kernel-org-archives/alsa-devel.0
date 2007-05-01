From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Support for SAM9407?
Date: Tue, 01 May 2007 14:52:47 +0200
Message-ID: <4637381F.9000607@gmail.com>
References: <20070501111831.35E301F50B1@ws1-2.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 6584D243F2
	for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2007 14:55:04 +0200 (CEST)
In-Reply-To: <20070501111831.35E301F50B1@ws1-2.us4.outblaze.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ash Willis <ashwillis@programmer.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/01/2007 01:18 PM, Ash Willis wrote:

> Hi, I've just been digging around for information on the old Dream
> SAM9407 chip. What's the current support status in ALSA for this chip?

Unsupported.

> I know some work was done on producing drivers for cards based on this
> chip and I know there were plans to port the efforts to ALSA. Did that
> ever happen? It doesn't seem so. Was there a specific reason why it
> wasn't ported in the end?

I don't know about reasons others may have had, but I have been working off 
and on, but significantly more off than on, on my TerraTec EWS64XL which is 
a Crystal CS4236 + SAM9407. Basically just two soundcards on one board. The 
CS4326 part works fine with the existing ALSA driver.

The EWS64XL itself is a very complex card with various functionality, such 
as switching the outputs to the SAM from the CS4236, hanging off one of two 
bitbanged I2C busses (that share one clockline), with having to manually 
setup the memory decoding logic after detecting what sort of SIMM you have 
installed, with the 'F' (front) and 'R' (rear) digital extensions with the 
digital out- and inputs both being available but different, with it having 
both coaxial and optical digital in that you have to switch around, with a 
dedicated clock chip for the SAM that can be programmed (by poking bits) to 
various clock rates, and so on, and so on.

Many (if not most, it's been quite some time since I looked at the driver 
and I'm not completely sure anymore about its current state) of those card 
details I have in fact figured out but I have only done some superficial 
probing around the SAM9407 itself. It's not a very nice chip in fact. It's 
strictly PIO only (over ISA!) and strictly firmware driven, with slightly to 
significantly different firmwares (and hence APIs) depending on the card 
upon which it sits and is poorly documented.

MIDI is the main objective of the SAM, but that sort of has gone the way of 
the dodo in itself and streaming PCM out an I/O port to the ISA bus is just 
not something that makes a great deal of sense when a few centimeters away 
you have a DMA capable CS4236 sitting that's already supported (and sounds 
very, very good -- it's just a well-built board). There's a pair of 20-bit 
DACs behing the SAM, but that's only an advantage for things like adding 
effects and I don't generally add effect to my music.

Basically, the SAM9407 is for (home-) musicians, but musicians have long ago 
gone to more capable hardware. For MIDI I myself have stuck a Yamaha DB-50XG 
on its front panel "waveblaster header" (which is routed to the CS4236 
MPU401 and its CD input) and that probably actually sounds better than the 
SAM ever would...

> In the interest of making ALSA that bit more complete as well as trying
> to improve my skills, I've been looking around for some older hardware
> that I can write drivers for.
> 
> This chip seems like a good candidate considering the cards haven't quite
> disappeared into oblivion :) I was looking into the possiblity of
> porting the remaining kernel OSS drivers to ALSA...but I can't even find
> any test hardware because they're so rare.

I'd think twice about the SAM. Other than the complexity of the cards on 
which it sits the SAM itself is also complex. Due to that PIO thing you'll 
need all sorts of double buffering and will need to feed the card from a 
kernel thread or something like that and will furthermore need to concern 
yourself with firmware loading, and yes, all the card details; on this EWS64 
you'd first need to know how to setup memory decoding for example before you 
can use it for the SAM and ofcourse, need to know to switch the outputs to 
the SAM to actually hear anything in the end. The OSS driver that still 
floats around the net is not something you'll enjoy looking at. It doesn't 
require a port but a rewrite from scratch.

For me this EWS64XL was the first reason I ever looked at ALSA and I _have_ 
thought about it twice and will in fact want to completely support it "some 
day" but there's quite a few things I want to happen "some day" ;-/

How about a Media Vision Pro Audio Spectrum 16? Those can still be found 
relatively easily and it's one the cards for which an OSS/Free driver is 
still kept in the tree. I have a pair of those as well so I'll happily test 
if you want to write a driver for it...

Rene.
