From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Re: PCM hw mixing with volume
Date: Tue, 09 Mar 2004 16:24:57 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078863897.1512.24.camel@localhost>
References: <200403091426.i29EQv9o016723@dhin.linuxaudiosystems.com>
	 <1078853140.18057.165.camel@renegade>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078853140.18057.165.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ove Kaaven <ovek@transgaming.com>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, 2004-03-09 at 13:25, Ove Kaaven wrote:
> tir, 09.03.2004 kl. 15.26 skrev Paul Davis:
> > >And by that time, games will be even more demanding than before, and
> > >still want to use those cycles for itself rather than software sound
> > >processing, so just sitting idle waiting for the ultimate
> > >infinite-megahertz cpu, that can do everything in no time, gains nob=
ody
> > >anything... at least our business won't.
> >=20
> > but don't you also want to be able to sell as many copies as possible
> > to as many satisfied customers as possible?
>=20
> I suppose that's basically the idea. Customers want full support for
> their hardware. Which includes HW mixing.

I agree.

> > if so, you have to pay
> > attention to whatever standards can be found for the domain at
> > hand. in this case, the AC97 codec spec (and its recent successor
> > whose name i forget) is about the most relevant thing i can think
> > of. AFAIK, AC97 etc. say nothing about the kinds of gain control and
> > mix routing that exist for multiple PCM streams.
>=20
> Yeah, we could consider AC97 to be a lowest common denominator. (That's
> not to say it is, since very old sound cards won't be compliant.)

AC97 means that you have at least one PCM stream. Nothing more than
that. IMHO its pointless to say AC97 is a hardware capability. Its one
way to accomplish a task that is common to any audio device.

> > ergo, there is no
> > standard way to do this that will work across a significant fraction
> > of the installed and/or potential user base.
>=20
> Are you mocking ALSA's plugin interface, too? Is there no "standard way=
"
> to play 22.050kHz streams using e.g. plughw? Or is plughw a design
> mistake? It can't be extended to use the route/volume plugin to adjust
> the volume of the stream in a "standard way", I suppose?

I think it would be interesting to apply several effects at once. But it
may be hard to come up with a clean design to accomplish that.

> > so, either ALSA can come up with such a thing, which might be
> > interesting but the manpower available to work on it is very limited,
> > or parties that have a vested interest in it can use an existing API
> > (SDL springs to mind, though i've never looked at it) or develop a ne=
w
> > one that provides a standard mechanism for doing wat you want.
>=20
> That's always going to be the case. It's Using Open Source In Business
> 101.

AFAIK, OpenAL was developed for such purposes, but unfortunately its
development is stuck. The Linux and MAC ports don't support any hardware
features yet. BTW, i'm designing a control interface for ALSA for OpenAL
(the current aureal driver, to be commited to public CVS in a few days,
includes its first steps).

> > i mean, even at the most basic level, the audio interface that is
> > built into my laptop motherboard (some intel nonsense) cannot do any
> > sample rate other than 48kHz! this is a high end laptop (HP Pavilion
> > zd7000, 3GHz processor, 1440x900 display, etc) ... think of the cycle=
s
> > that will be spent *resampling* your audio independently of the mixin=
g
> > step.
>=20
> Independently? No, our software mixing code resamples, adjusts volume,
> and mixes the stream into the buffer in one step. That's one reason
> we've decided not to use ALSA's plugin system, as they do it in several
> steps (you'd have to run it through the rate plugin, the route/volume
> plugin, and finally the dmix plugin). For best performance, we resample
> on our own when the sound chip is locked to 48kHz (if we didn't, we
> might end up letting each sound go through *two* resampling steps - one
> from the sound effect's sample rate to the mixer stream's sample rate,
> and another from the mixer stream's rate to the sound card's physical
> rate if they don't match, therefore it's better to simply make the mixe=
r
> stream's rate match the sound card's, so that each sound effect is
> resampled once and only once).

I agree. IMHO thats the most efficient way. Thats the way OpenAL handles
such a case, but there is still a inconsistency, because the current
OpenAL linux port -should- not provide software fallbacks, but it does
anything in software (since there is still no hardware support), so it
looks like software fallback will be provided inside the driver (ALSA).
Since it can't (shouldn't) live in kernel context, i guess it would go
into alsa-lib (plugin perhaps ?).

> > this type of BS seems to be growing more and more common.
>=20
> Perhaps they're thinking like you seem to, that the rise of CPU power
> will make hardware features obsolete. "Hardware has limitations,
> software don't." Same thing with winmodems. Why then do companies like
> Creative churn out sound cards with ever more powerful hardware
> features, if you're saying nobody should ever write code to take
> advantage of those hardware features?

I own a 4 year old soundcard, which provides 16 very high quality 3D
processor pipelines, and i still can't make use of it on any OS except
win98. That definitely sucks, and i'm still struggling to change that.

> Since we're ranting anyway: It's a similar situation with 3D graphics
> hardware, where the 3D cards get ever more powerful, even though the CP=
U
> power is going up. And yet the OpenGL folks (at least those working on
> DRI) say "it's not important for the app to know whether something is
> done in hardware or not", which I have yet to make sense of given the
> trend. It's obvious that the greatest in-game 3D on the planet could no=
t
> be done in smooth realtime on just a CPU without a GPU (particularly
> when the CPU is also supposed to control enemy AI, make 3D environmenta=
l
> effects on a 48kHz single-stream AC97 chip, communicate with other
> players via a winmodem, and so on), so why shouldn't there be a feature
> to tell that certain advanced 3D effects *could* be offloaded to
> hardware without getting more CPU load?

Using the CPU for all is bullshit. I have not seen any Mega Computer
outperforming in software the render quality and speed of a Rendition
Verit=E9 or a S3 ViRGE. The may be faster but at very poor quality.
Software audio mixing sucks just the same. IMHO dedicated processors
rules, in MODEM's, GPU's and audio boards.

> >  if i
> > was in your position (specifically, if i have to assume that my user
> > base spent a (comparatively) lot of money on a graphics card, maybe
> > even paid for a 5.1 speaker setup, but are still using the
> > factory-provided audio interface, i would assume the absolute worst
> > capabilities for that interface that i could: single sample rate,
> > single PCM stream, no mixer.
>=20
> Assumptions are seldom worth much. We're not going to assume anything
> here. If the card has sufficient hardware features, we wish to use them
> for what they're worth, since that's what they're there for. If it
> doesn't have them, then we obviously fall back to the old software
> mixing code that's been in our codebase forever. Is a customer who says
> "I spent $500 on this new great sound card, but the sound is just as
> lousy as before" a happy one? I think not.

I agree.

> > and btw, i wasn't suggesting that you just "sit there waiting". my
> > point was that the time you might spend working on this could be spen=
t
> > working on something else, and by the time you're done, CPU speed
> > increases will have done this particular task for you.
>=20
> If ALSA provides the interface, it's just a matter of using it instead
> of software mixing. There's no magic involved that's going to take
> man-years to accomplish.

Those specific interfaces don't exist yet, but the kcontrol interface
can be used easily for that purpose. Its just a matter of designing them
accordingly.

Best Regards

Manuel Jander




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
