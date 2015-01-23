From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: add generic dt-card support
Date: Fri, 23 Jan 2015 13:15:54 +0100
Message-ID: <20150123131554.623003f9@armhf>
References: <cover.1421868426.git.moinejf@free.fr>
	<d0c66c2e2f200119f9990fa52a503b1a4af6238f.1421868426.git.moinejf@free.fr>
	<54C0088F.9070609@metafoo.de>
	<20150122090723.50ac0156@armhf>
	<54C14EB3.8080305@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54C14EB3.8080305-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 22 Jan 2015 20:25:39 +0100
Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:

> On 01/22/2015 09:07 AM, Jean-Francois Moine wrote:
> > On Wed, 21 Jan 2015 21:14:07 +0100
> > Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
> >
> >> [...]
> >>> +	card->dai_link->dai_fmt =3D
> >>> +		snd_soc_of_parse_daifmt(of_cpu, "dt-audio-card,",
> >>> +					NULL, NULL) &
> >>> +			~SND_SOC_DAIFMT_MASTER_MASK;
> >>
> >>
> >> This one does not seem to be in the bindings documentation.
> >
> > Sorry, I forgot to remove it from the patch.
>=20
> Ah, too bad this was the part I was most interested in. I think that =
using=20

This code was a remainder of simple-card.

Setting the audio format in the CPU side of the link is of no interest
when this format is the same for all CODECs. In this case, the audio
controller may set itself this format when it creates its DAIs, and,
then, the audio format is an audio controller property.

On the other hand, when the format depends on the remote endpoints, it
should appear in the graph in the CODEC ports.

> the generic of graph framework as a unified way for expressing non-co=
ntrol=20
> links is a good idea, whether it be for audio, video or something els=
e.

We discussed about the graph of ports last year
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/07063=
4.html
but some pieces of software were lacking, as the multi-codec links.

> But I think there are some open questions that need to be address whe=
n=20
> coming up with a specification for audio so we do not have to write y=
et=20
> another incompatible DT spec in 3 months time.

The DT should describe the hardware, and the simple-card mixes hardware
and software.
=46or example, the kirkwood controller may create 2 CPU DAIs. With the
simple-card, the DT contains a number to reference these DAIs (for
example, implicitly, <audio1 0> references the I2S output). So, what if
the controller creates only one DAI, or, what if the FreeBSD/OpenBSD/..
driver does not set the same references to these DAIs?
The graph of port fixes this problem.

More: a simple audio card may easily be created from a graph of ports
as the simple-card does, but by the audio-controller (sorry, I also
forgot the kirkwood patch for this in my previous patch request).
In case of complex cards, the links and properties of this graph may
also be used by board specific card devices.

> One issue is how to deal with multi-point-to-multi-point links. I2S/T=
DM is a=20
> bus and can have more than one reader/writer.
>=20
> The second issue is how to describe the clock and frame master=20
> relationships. Multiple different buses can share the same clock and =
frame=20
> generator. E.g. typically the capture and playback stream are linked =
in this=20
> way.

The ports and endpoints may contain properties to describe these
configurations. Complex cases should be handled by specific card
builders.

> How are we going to handle bus specific properties. Properties which =
are=20
> neither a property of either of the endpoints on the link, but of the=
 link=20
> itself.

This is already the case for the bus types of the kirkwood controller,
I2S or S/PDIF. Such properties may appear in either local or remote
port, or in both.

> > BTW, the graph of port should also contain pieces of the audio spec=
ific
> > hardware information as the ones found in the simple-card (clock,
> > GPIO, ...). This information could be written as generic device nod=
e
> > properties. i.e without any prefix.
> >
> > I was also wondering about some of these properties, as widgets and
> > routing. They seem to be software information and Linux specific.
> > Must these properties appear in the DTs?
>=20
> Well last time I checked the speaker on my board was hardware not sof=
tware=20
> and wasn't Linux specific either ;) Those widgets and routing represe=
nt the=20
> (typically analog) audio fabric on the board and are part of the hard=
ware=20
> description. This is not even ASoC or devicetree specific, e.g. HDA u=
ses a=20
> similar concept where the BIOS provides a description of which pins o=
f the=20
> audio CODEC is connected to which speaker, microphone, etc. And espec=
ially=20
> on embedded boards the audio fabric can become quite complex.

OK. I looked if the widgets and routes could also be described in a
graph, but, it complexifies the syntax. So, this information could have
the same syntax as in the simple-card.

On the other hand, where would this information appear in the graph?
As I understood, on card creation, the widgets and routes, which appear
at the card level, redefine the CPU and CODEC DAI definitions.

With a DT graph, each CPU/CODEC would know exactly the widgets and
routes it has to define.

> Your example is a relative simple one where you do not have any addit=
ional=20
> audio fabric on the board itself.

Right, and that's why I'd be glad to have quickly something in the
kernel. More properties could be added later as there would be requests=
=2E

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
