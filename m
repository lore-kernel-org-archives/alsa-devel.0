From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: add generic dt-card support
Date: Tue, 3 Feb 2015 20:31:30 +0100
Message-ID: <20150203203130.5d1cfc42@armhf>
References: <cover.1421868426.git.moinejf@free.fr>
	<d0c66c2e2f200119f9990fa52a503b1a4af6238f.1421868426.git.moinejf@free.fr>
	<54C0088F.9070609@metafoo.de>
	<20150122090723.50ac0156@armhf>
	<54C14EB3.8080305@metafoo.de>
	<20150123131554.623003f9@armhf>
	<54C252F4.9000504@metafoo.de>
	<20150123193456.276ea512@armhf>
	<20150123191343.GW21293@sirena.org.uk>
	<20150124083027.3b3a018f@armhf>
	<20150203164748.GR21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150203164748.GR21293-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Feb 2015 16:47:48 +0000
Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Sat, Jan 24, 2015 at 08:30:27AM +0100, Jean-Francois Moine wrote:
> > Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > > On Fri, Jan 23, 2015 at 07:34:56PM +0100, Jean-Francois Moine wro=
te:
>=20
> > > > The simple card builder, 'dt-card' (maybe a better name would h=
ave been
> > > > 'graph-card'), acts just like the simple-card except that it do=
es not
> > > > appear in the DT. Its creation is done by an audio controller.
>=20
> > > Which audio controller?  There may be several CPU side audio inte=
rfaces
> > > in the same card.  For example people often want to have both low
> > > latency and high latency audio paths from the CPU into the hardwa=
re (low
> > > latency tends to increase power burn).  SoC centric system design=
s do
> > > sometimes also have PDM I/O, expecting to be directly connected t=
o DMICs
> > > and so on, which results in a relatively large number of CPU inte=
rfaces.
>=20
> > The audio controller which creates the card depends on the complexi=
ty
> > of the card. When there are many controllers, it is up to the desig=
ner
> > to define either a master audio controller or to instantiate a 'car=
d'
> > device via the DT for doing the job.
>=20
> So how does the simple controller interact with a more complex one gi=
ven
> that it's somehow picking some controller node to start from?

A way to solve this problem could be to create only one card builder.
This creation could be explicit (created by the first active audio
controller) or implicit by the audio subsystem on the first controller =
or
CODEC creation.

Then, the card builder could scan all the DT looking for the audio
ports and create one or more cards according to the graph connectivity.

> > > > Well, forget about this. I never clearly understood why some wi=
dgets
> > > > and routes had to be defined at card level.
>=20
> > > Please do try to understand the idea of representing simple compo=
nents
> > > on the board and analogue interconects between devices - it's rea=
lly
> > > important and not something that can be neglected.
>=20
> > The problem is that this understanding would stay abstract: I have =
no
> > such a hardware. Anyway, if the representation can be done with the
> > simple-card, it may also be done with a graph of ports.
>=20
> If you have a device with any sort of speaker or microphone, or any s=
ort
> of external connector for interfacing with an external device like a
> headphone jack, then you have something that could be a widget.

I know what are the widgets and routes, I was just wondering why they
(especially the widgets) need to appear at the card level instead of
just being declared in the DAIs (from the platform or the DT).
And the same question may also be raised about the audio formats, clock=
s,
tdm's...

> > > That DT binding was done entirely in the context of video applica=
tions
> > > IIRC, this is the first time it's been discussed in this context.
>=20
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/0=
70622.html
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2015-January/0=
86273.html
>=20
> So there's been some in passing mentions, not really serious discussi=
on
> though...

I may go back about the card builder, but Russell's idea about
declaring the tda998x audio parameters by a port as declared in a graph
of ports seems fine to me. This declaration should be compatible with
the use of the simple-card.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
