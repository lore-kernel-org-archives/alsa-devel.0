From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v3 4/4] ASoC: simple-card: Add DT documentation for
 multi-DAI links
Date: Tue, 18 Mar 2014 09:17:28 +0100
Message-ID: <20140318091728.1d2240ca@armhf>
References: <cover.1394883134.git.moinejf@free.fr>
	<d054780a0edf4b2338a52e48bff9144e19aa614f.1394883134.git.moinejf@free.fr>
	<20140317164339.GR11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140317164339.GR11706@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Mar 2014 16:43:39 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Sat, Mar 15, 2014 at 12:30:05PM +0100, Jean-Francois Moine wrote:
	[snip]
> > +sound {
> > +	compatible =3D "simple-audio-card";
> > +	simple-audio-card,name =3D "Cubox Audio";
> > +
> > +	simple-audio-card,cpu@0 {		/* I2S - HDMI */
> > +		sound-dai =3D <&audio1 0>;
> > +		format =3D "i2s";
> > +	};
> > +	simple-audio-card,codec@0 {
> > +		sound-dai =3D <&tda998x 0>;
> > +	};
> > +
> > +	simple-audio-card,cpu@1 {		/* S/PDIF - HDMI */
> > +		sound-dai =3D <&audio1 1>;
> > +	};
> > +	simple-audio-card,codec@1 {
> > +		sound-dai =3D <&tda998x 1>;
> > +	};
>=20
> So, this is not exactly pretty as a binding.  I would expect to see t=
he
> links explicitly represented in the DT so you see the two DAIs in eac=
h
> link grouped into a container, the above isn't very easy to read and =
as
> Jyri says this lack of clarity also causes practical problems in that
> there's nowhere to place link specific parameters.
>=20
> I think what I'd expect to see here is that the simple card can eithe=
r
> be a container with a link in it directly or a container of links.

I agree. I see two possible syntaxes:

1) keep the same definitions in the containers:

sound {
	compatible =3D "simple-audio-card";
	simple-audio-card,name =3D "Cubox Audio";

	simple-audio-card,dai-link@0 {		/* I2S - HDMI */
		simple-audio-card,cpu {
			sound-dai =3D <&audio1 0>;
			format =3D "i2s";
		};
		simple-audio-card,codec {
			sound-dai =3D <&tda998x 0>;
		};
	};

	simple-audio-card,dai-link@1 {		/* S/PDIF - HDMI */
		simple-audio-card,cpu {
			sound-dai =3D <&audio1 1>;
		};
		simple-audio-card,codec {
			sound-dai =3D <&tda998x 1>;
		}
	};
	...

2) new definitions in the container

sound {
	compatible =3D "simple-audio-card";
	simple-audio-card,name =3D "Cubox Audio";

	simple-audio-card,dai-link@0 {		/* I2S - HDMI */
		format =3D "i2s";
		cpu-dai  =3D <&audio1 0>;
		codec-dai =3D <&tda998x 0>;
	};

	simple-audio-card,dai-link@1 {		/* S/PDIF - HDMI */
		cpu-dai =3D <&audio1 1>;
		codec-dai =3D <&tda998x 1>;
	};
	...

The 2nd syntax is simpler and clearer, but the properties of the CPU
DAI and of the CODEC DAI are the same in the container (format, clock
and PCM slots). Is this a problem?

BTW, there is a 'dai_fmt' in the DAI link, but this format is not used
in the simple-card. Why?

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
