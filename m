From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: add generic dt-card support
Date: Mon, 26 Jan 2015 19:22:44 +0100
Message-ID: <20150126192244.12a79eff@armhf>
References: <cover.1421868426.git.moinejf@free.fr>
	<d0c66c2e2f200119f9990fa52a503b1a4af6238f.1421868426.git.moinejf@free.fr>
	<54C0088F.9070609@metafoo.de>
	<20150122090723.50ac0156@armhf>
	<54C14EB3.8080305@metafoo.de>
	<20150123131554.623003f9@armhf>
	<54C252F4.9000504@metafoo.de>
	<20150123193456.276ea512@armhf>
	<54C381A7.3020209@metafoo.de>
	<20150124141820.3793bd47@armhf>
	<54C62AD1.2090207@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54C62AD1.2090207@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Jan 2015 12:53:53 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:
> > - a generic sound node in the case of multi controllers or multi co=
dec
> >    levels (after dt-card extension):
> >
> > 	sound {
> > 		compatible =3D "linux,dt-card";
> > 		audio-root =3D <&audio1>;	/* starting point of the graph */
> > 		... card properties ...
> > 	};
> >
> > For the last case, the creation of the simple dt-card builder could=
 be
> > done by a node in the controller, avoiding the DT to have a knowled=
ge
> > of this piece of software:
> >
> > 	&audio1 {
> > 		...
> > 		audio-card {
> > 			... card properties ...
> > 		}
> > 		port@0 {
> > 			...
> > 		};
> > 		...
> > 	}; =20
>=20
> Is there any advantage to putting the card node inside the controller=
 node=20
> rather than having it as a separate node?

There is no advantage, but it seems to me that the sound device is a
software entity which should not appear in the devicetree.

> >> I think this is something that needs to be done in the ASoC/ALSA c=
ore
> >> itself. Create the graph, wait until all endpoints of the graph ha=
ve been
> >> registered and then create the card. Or something similar. =20
> >
> > To go further, such a function could fully replace
> > snd_soc_register_card()! =20
>=20
> Yes, if the graph is strongly connected (which it should be) the fram=
ework=20
> will be able to identify when all components that belong to the graph=
 have=20
> been registered and is then able to create a card for it.

Russell's "Componentized device handling" would permit to synchronize
all components avoiding the PROBE_DEFERs, but there is a problem with
the tda998x: this one is a component of both the audio and video
subsystems, and the bind() callback does not indicate by which master
compoment it is called...

> Are you by chance at FOSDEM? If you are maybe we can sit down for a m=
oment=20
> and discuss things.

Sorry, I will not be at FOSDEM.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
