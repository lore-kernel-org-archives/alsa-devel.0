From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: add generic dt-card support
Date: Fri, 23 Jan 2015 19:34:56 +0100
Message-ID: <20150123193456.276ea512@armhf>
References: <cover.1421868426.git.moinejf@free.fr>
	<d0c66c2e2f200119f9990fa52a503b1a4af6238f.1421868426.git.moinejf@free.fr>
	<54C0088F.9070609@metafoo.de>
	<20150122090723.50ac0156@armhf>
	<54C14EB3.8080305@metafoo.de>
	<20150123131554.623003f9@armhf>
	<54C252F4.9000504@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54C252F4.9000504-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 23 Jan 2015 14:56:04 +0100
Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:

> On 01/23/2015 01:15 PM, Jean-Francois Moine wrote:
> [...]
> > The DT should describe the hardware, and the simple-card mixes hard=
ware
> > and software.
> > For example, the kirkwood controller may create 2 CPU DAIs. With th=
e
> > simple-card, the DT contains a number to reference these DAIs (for
> > example, implicitly, <audio1 0> references the I2S output). So, wha=
t if
> > the controller creates only one DAI, or, what if the FreeBSD/OpenBS=
D/..
> > driver does not set the same references to these DAIs?
> > The graph of port fixes this problem.
>=20
> Even with the simple-card bindings there are no software specific bit=
s. The=20
> DAI that is referenced in your example is the physical DAI as it exis=
ts in=20
> the hardware. Which DAI maps to which specifier is defined in the dev=
icetree=20
> bindings definition for the hardware unit.

There is no first or second output in the kirkwood controller; there
are I2S and S/PDIF outputs. Their hardware controls are done by bits in
the different registers. Then, the driver may define its DAIs in any
order and assign any DAI ID to these DAIs. So, for a given DAI, there
is no relation between its type (I2s or S/PDIF), index in the dai
driver (=3D asoc component index) and ID.

In the simple-card DT, the CPU DAI (as the CODEC DAI) is referenced by
a phandle (the audio-controller) and a number which should identify the
DAI. This number is translated to a DAI name thanks to the function
snd_soc_get_dai_name(). This function scans the components and returns
the name of the DAI (component) supported by the audio controller with
the searched number equal to the component index (there is no 'xlate'
function).

So, with the simple-card, the CPU or CODEC DAI binding (phandle +
number) identifies what the software has put in its table, but not a
hardware entity.

> > More: a simple audio card may easily be created from a graph of por=
ts
> > as the simple-card does, but by the audio-controller (sorry, I also
> > forgot the kirkwood patch for this in my previous patch request).
> > In case of complex cards, the links and properties of this graph ma=
y
> > also be used by board specific card devices.
> >
> >> One issue is how to deal with multi-point-to-multi-point links. I2=
S/TDM is a
> >> bus and can have more than one reader/writer.
> >>
> >> The second issue is how to describe the clock and frame master
> >> relationships. Multiple different buses can share the same clock a=
nd frame
> >> generator. E.g. typically the capture and playback stream are link=
ed in this
> >> way.
> >
> > The ports and endpoints may contain properties to describe these
> > configurations. Complex cases should be handled by specific card
> > builders.
>=20
> Could you describe in detail what a card builder is and how to decide=
 when=20
> and how a card builder is executed?

A card builder is a device which
- scans the graph of ports,
- fills the struct snd_soc_card according to the links between the
  ports and their properties,
- and, eventually, calls snd_soc_register_card().

The simple card builder, 'dt-card' (maybe a better name would have been
'graph-card'), acts just like the simple-card except that it does not
appear in the DT. Its creation is done by an audio controller.

=46or complex cards, a card builder would be the same as an actual card
driver, but with the capability to know about the board thanks to the
graph of ports. Its creation could be done by a compatible device in
the DT (as actually) or by the unique or a 'master' audio controller.

A card builder is subject to a PROBE_DEFER after calling
snd_soc_register_card(), so, when it is created by an audio controller,
this last one should have created its own resources.

An audio controller does the following:
- initialize the hardware and software,
- create the DAIs from:
	- the graph of ports or
	- default values
- register these DAIs and
- if the DAIs where created by a graph of port,
	create the card builder.

> > On the other hand, where would this information appear in the graph=
?
> > As I understood, on card creation, the widgets and routes, which ap=
pear
> > at the card level, redefine the CPU and CODEC DAI definitions.
>=20
> What do you mean by "redefine the CPU and CODEC DAI definitions".
>=20
> >=20
> > With a DT graph, each CPU/CODEC would know exactly the widgets and
> > routes it has to define.
>=20
> Which widgets/routes do you mean?

Well, forget about this. I never clearly understood why some widgets
and routes had to be defined at card level.

> >> Your example is a relative simple one where you do not have any ad=
ditional
> >> audio fabric on the board itself.
> >
> > Right, and that's why I'd be glad to have quickly something in the
> > kernel. More properties could be added later as there would be requ=
ests.
>=20
> I'd agree if this was some kind of kernel internal stuff, but this is=
=20
> creating ABI and we have to maintain it forever. Rushing this in with=
out=20
> proper discussion and consideration of the more complex use-cases is =
in my=20
> opinion not a good idea.

Using a graph of port to describe the audio subsystem has been pushed
forwards by many people for a long time, as shown by the creation of
the document Documentation/devicetree/bindings/graph.txt.

Anyway, I am also glad to have this discussion.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
