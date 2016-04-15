From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH 0/4] ASoC: add graph base connection on
 simple-card
Date: Fri, 15 Apr 2016 13:31:58 +0200
Message-ID: <20160415133158.9c5c0dc7367325606c53ce17@free.fr>
References: <871t68wxxe.wl%kuninori.morimoto.gx@renesas.com>
	<20160414110128.56a0da97d526cdcb8d5f1ddf@free.fr>
	<87h9f3jq3m.wl%kuninori.morimoto.gx@renesas.com>
	<87fuunjkio.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87fuunjkio.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>, Jose Abreu <Jose.Abreu@synopsys.com>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Fri, 15 Apr 2016 09:26:03 +0000
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> > > According to Documentation/devicetree/bindings/graph.txt section
> > > "Links between endpoints", the endpoint/remote-endpoint links are
> > > bi-directional and describe the physical links: the audio port of=
 the
> > > codec is connected to the audio controller and reverse.
> > > There is no reverse link from the codec to the 'simple-card'.
> > (snip)
> > > The codec associated to the HDMI transmitter declares 2 DAIs.
> > > It may choose to define the DAI numbers either in a fixed order
> > > (say 0 is always S/PDIF and 1 is always I2S), or dynamically, fol=
lowing
> > > the declaration of the ports (in the example, 0 is I2S and 1 is S=
/PDIF).
> >=20
> > My assumption was video/audio are using same port, but indeed
> > we need to care about more.
> >=20
> > But, if we need to describe both "video port" and "audio port" sepa=
rately
> > in graph, simple-card side doesn't need graph style IMO.
> > Because normal phandle style (=3D non graph style) is working alrea=
dy.
> >=20
> > I thought that describing both "video" and "audio" is too much.
> > -> assume that video/audio can share same port
> >  -> this patch
> >   -> but thoughtless :P
> >=20
> > I'm not sure, but do you think snd_soc_get_dai_name()::of_xlate_dai=
_name
> > can works for us ?
> >=20
> > My concern is if audio side need to care/support "formal" graph sty=
le,
> > I think all cpu/codec/card driver (and soc-core too ?) need to be u=
pdated,
> > but it is too much for me.
> > if fake graph style (like this patch) is OK, I'm happy to hack it m=
ore.
>=20
> This "fake graph style" means it is supporting both graph's "remote-e=
ndpoint"
> and current simple-card's "sound-dai" (=3D not 100% graph style).

Hi Kuninori,

Maybe I was not clear. Here is more information.

The simple-card must know the codec (DAI) device node and the DAI name
(found from the DAI number thanks to snd_soc_get_dai_name
()::of_xlate_dai_name()).

The actual definition "sound-dai" works directly in any case, with or
without a graph of ports. Indeed, the DAI of the codec must be known
(option fixed/dynamic number).

A graph of ports describes the links between the hardware components.
=46ox example, in the (Dove) Cubox, the HDMI transmitter receives video
(one port) from the video controller and audio (2 ports) from the audio
controller. The graph is:

video <-----------------------\
                              v
       | i2s <------> CODEC =3D HDMI transmitter
audio <               ^
       | s/pdif <-----/
                       \---> S/PDIF connector

In the DT, the HDMI is described by:

	hdmi: hdmi-encoder {
		...
		port@0 {
			port-type =3D "video";
			port-value =3D <0x230145>;
			hdmi_0: endpoint {
				remote-endpoint =3D <&lcd0_0>;
			};
		};
		port@1 {			/* AP1 =3D I2S */
			port-type =3D "audio-i2s";
			port-value =3D <0x03>;
			tda998x_i2s: endpoint {
				remote-endpoint =3D <&audio1_i2s>;
			};
		};
		port@2 {			 /* AP2 =3D S/PDIF */
			port-type =3D "audio-spdif";
			port-value =3D <0x04>;
			tda998x_spdif: endpoint {
				remote-endpoint =3D <&audio1_spdif1>;
			};
		};
	};

As you may see, there is no port link to any audio card definition as
the 'simple-card'.

When using the simple-card, my definition was:
	sound {
		compatible =3D "simple-audio-card";
		simple-audio-card,name =3D "Cubox Audio";

		simple-audio-card,dai-link@0 {	/* S/PDIF -> HDMI & S/PDIF */
			format =3D "i2s";
			cpu {
				sound-dai =3D <&audio1 1>;
			};
			codec {
				sound-dai =3D <&hdmi 0>, <&spdif_codec>;
			};
		};

		simple-audio-card,dai-link@1 {	/* I2S -> HDMI */
			format =3D "i2s";
			cpu {
				sound-dai =3D <&audio1 0>;
			};
			codec {
				sound-dai =3D <&hdmi 1>;
			};
		};
	};

This worked fine, but I found that the simple-card was redondant with
the graph of ports, so, now, in my system, the card creation is done
only from the graph of ports (without any more information in the DT -
this system was proposed in january 2015
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-January/08683=
7.html
but rejected).

At startup time, the audio driver scans its ports in the graph.
This permits for it to create its own DAIs.
Then, it looks at the remote-ports. These ones define the DAI links:
the CPU side is a local DAI, and the CODEC side is the parent of the
remote port plus a DAI number.
The problem is that the DAI number is not in the DT. It must be
computed. This is simply done scanning the ports of the codec (remote)
node and skipping the non-audio ports (indeed, this works because the
hdmi codec uses a dynamic port numbering scheme).

=46or information here is the DT of the audio controller:

audio1: audio-controller@b4000 {
	audio-card,format =3D "i2s";
	port@0 {
		port-type =3D "spdif";
		audio1_spdif0: endpoint@0 {
			remote-endpoint =3D <&spdif_out>;
		};
		audio1_spdif1: endpoint@1 {
			remote-endpoint =3D <&tda998x_spdif>;
		};
	};
	port@1 {
		port-type =3D "i2s";
		audio1_i2s: endpoint {
			remote-endpoint =3D <&tda998x_i2s>;
		};
	};

So, in brief:
- the simple-card with only "sound-dai" works fine with or without a
  graph of ports,
- for a full use of the graph of ports, forget about the simple-card.

--=20
Ken ar c'henta=F1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
