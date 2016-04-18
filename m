From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 0/4] ASoC: add graph base connection on
 simple-card
Date: Mon, 18 Apr 2016 09:38:27 +0200
Message-ID: <20160418093827.65b9f8a5bd2ec17cde2e7b5b@free.fr>
References: <871t68wxxe.wl%kuninori.morimoto.gx@renesas.com>
	<20160414110128.56a0da97d526cdcb8d5f1ddf@free.fr>
	<87h9f3jq3m.wl%kuninori.morimoto.gx@renesas.com>
	<87fuunjkio.wl%kuninori.morimoto.gx@renesas.com>
	<20160415133158.9c5c0dc7367325606c53ce17@free.fr>
	<87r3e3ej5t.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r3e3ej5t.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 18 Apr 2016 02:43:21 +0000
Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:

> But can I ask something ?
>=20
> > > > My concern is if audio side need to care/support "formal" graph=
 style,
> > > > I think all cpu/codec/card driver (and soc-core too ?) need to =
be updated,
> > > > but it is too much for me.
> > > > if fake graph style (like this patch) is OK, I'm happy to hack =
it more.
> > >=20
> > > This "fake graph style" means it is supporting both graph's "remo=
te-endpoint"
> > > and current simple-card's "sound-dai" (=3D not 100% graph style).
> (snip)
> > So, in brief:
> > - the simple-card with only "sound-dai" works fine with or without =
a
> >   graph of ports,
> > - for a full use of the graph of ports, forget about the simple-car=
d.
>=20
> Q1
> If we use full graph style card, and if it would like to reuse curren=
t existing
> CPU/CODEC driver, then, I think CPU/CODEC driver should support graph=
 style too.
> (Now, I'm checking v4l2 side existing graph style driver)
> I know it is based on its current implementation, but basically YES ?
>=20
> Q2
> If Q1 was Yes, to keeping ABI compatibility,
> that CPU/CODEC driver should support both "phandle" and "graph" style=
 ?

Hi Kuninori,

When the cards are defined from a graph of ports, the CPU/CODEC drivers
do not need to know about this graph if they use a fixed numbering of
their DAIs (I think this is the case of all existing drivers but the
ones in my system). There is no useful information for these drivers
in the DT, so, they don't need any change when moving to a graph of
ports.

Such a move is done first in the DT by removing the simple-card node
and replacing the previous 'dai-link' definitions by couples of ports
in the CPU (audio controller) and in the CODEC device nodes.

The previous DAI properties (tdm-slots, clocks...) must also be moved
to the graph (ports of the graph links). As nothing exists about these
port properties in the DT documentation, they must be added.

The previous global (simple-)card properties (widgets, routing..) must
also be moved. Where? Simply to the main audio controller node.
They could be named 'audio-xxx' or included in an audio container.

Now, let's talk about the code. As there is no simple-card device to
create the card, an other piece of code must do the job.
The simplest way to run it is to put it in the audio controller:
when the audio controller scans the DT, it sees the card definitions
(audio-xxx' or audio container), so, it has all elements to create the
card.
This card is as generic as the simple-card, so it could be in the
sound/soc core.

So, in brief again: when using a full graph style card:
- there is no change in the CPU/CODEC drivers,
- there is no simple-card,
- the 'audio-graph-card's are created by the audio controllers which
  run a generic code.

--=20
Ken ar c'henta=F1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
