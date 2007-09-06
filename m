From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] Gallant SC-6000 driver (4th version)
Date: Thu, 06 Sep 2007 08:49:11 +0200
Message-ID: <46dfa2e7d6be4@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B74A1037F5
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 08:49:12 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> On 09/05/2007 10:25 PM, Krzysztof Helt wrote:
> > I have left the ISA autodetection. It makes driver usage
simpler for user.
> > The base port, mpu port and mss port can be read from jumper
settings,
> >but irq or dma is not settable. A system may figure out which
one is free =

> >and use it.

> The problem is that this "simplification" might actually leave
the non-aware =

> user scratching his head for far longer than if he has to spell
things out.

I know it may not work all the time, but you can always fall back
to giving number.
If the simple autodetection works, it helps.

> Even without that problem, we have the problem of IRQs that's
only _appear_ =

> to be free. IRQ7 for example will usually be assigned to the
first parallel =

> port but will only show up as taken if the parport driver is
loaded. Often, =

> it'll still actually work, but (again) here for example, it
does not.

Actually, the parport_pc driver is loaded by the udev by default,
so the IRQ7 =

cannot be requested (I tested - IRQ7 request failed even if I had
not used the printer).

> It's not like people using legacy ISA in this day and age are
not normally =

> nerds anyway...

That's the best argument.

> Yes. I am looking at the sound galaxy driver at the moment and
am in fact =

> now trying to think of why I want to use the WSS part of the
card and not =

> just the SBP part. In DOS, the card is setup in SB Pro mode by
default as =

> well, and the CS42xx seems to only be present really for
Windows Sound =

> System compatibility for old 16-bit Windows.

IIRC from SB Pro times, the SB Pro specification said it
supported only 16 bit of output (ment either 16-bit mono or 8-bit
stereo). The SB16 supported stereo
16-bit audio.
I don't know what is expected from WSS, but if the SB Pro mode gives
full duplex 16-bit stereo, there is no reason to use WSS mode.

>> (I do not have the CS4231 based card but I should have it next
week -
>> Sound Galaxy Waverider).

> Am testing on that one currently -- will post the driver before
next week.

I'll be happy to test it too.

> Quite sure that 5 works by the way? On a Sound Galaxy, 5 only
works for the
> SB part (and 11 only for the WSS).

It is the IRQ found most times as the first free during card
tests. It worked on all
free IRQs from the range (the 10 or 11 is occupied by USB/PS2 and
I haven't
 bothered to make it free).
It seems that ASC-9308 is more capable (in this respect) than SG
chips.

Regards,
Krzysztof

----------------------------------------------------
Pierwsza od pi=EAtnastu lat ksi=B1=BFka =

V=E1clava Havla "Tylko kr=F3tko prosz=EA" - ju=BF w ksi=EAgarniach!  =

http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fhavel.html&s=
id=3D15
