From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH] ASoC: generic: add generic compound card
 with DT support
Date: Thu, 2 Jan 2014 10:26:47 +0100
Message-ID: <20140102102647.6efec89d@armhf>
References: <20131231113138.102044cf@armhf>
	<52C466E1.3030302@metafoo.de>
	<20140101210814.31e3f3a9@armhf>
	<52C4766B.8080000@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52C4766B.8080000@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 01 Jan 2014 21:11:23 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 01/01/2014 09:08 PM, Jean-Francois Moine wrote:
> > On Wed, 01 Jan 2014 20:05:05 +0100
> > Lars-Peter Clausen <lars@metafoo.de> wrote:
> >=20
> >> As Mark also said, this binding definitely leaks way too much inte=
rnals of
> >> the current ASoC implementation. In my opinion the way forward for=
 ASoC is
> >> to stop to distinguish between different types of components. This=
 is on one
> >> hand CODECS and CPU-DAIs and on the other hand also front-end and =
beck-end
> >> DAIs. The first steps in this direction have already been take by =
the start
> >> of the component-fication, but its still a long way to go. Exposin=
g those
> >> concepts via the devicetree will only make it harder to get rid of=
 them
> >> later. The bindings for a compound card should essentially describ=
e which
> >> components are involved and how the fabric between and around them=
 looks
> >> like. If the type of the component is needed in the ASoC implement=
ation it
> >> should be possible to auto-discover it. Also I think we want to al=
ign the
> >> devicetree bindings with what the media people have been doing[1].
> >=20
> > (you forgot the [1] reference)
>=20
> http://lxr.free-electrons.com/source/Documentation/devicetree/binding=
s/media/video-interfaces.txt

I see the idea. So here is a proposal of DT for the Cubox (audio + vide=
o)
which should work without too many difficulties.

/* video / audio transmitter */

	tda998x: hdmi-encoder {
		compatible =3D "nxp,tda998x";
		...

		/* video */
		port@0 {
			tda998x_0: endpoint {
				reg =3D <0x230145>;
				remote-endpoint =3D <&lcd0_0>;
			};
		};

		/* audio */
		port@1 {
			hdmi_i2s_audio: endpoint@0 {
				reg =3D <0x03>;
				remote-endpoint =3D <&audio_hdmi_i2s>;
			};
			hdmi_spdif_audio: endpoint@1 {
				reg =3D <0x04>;
				remote-endpoint =3D <&audio_hdmi_spdif>;
			};
		};
	};

	toslink: spdif {
		compatible =3D "linux,spdif-dit";
		port {
			spdif_audio: endpoint {
				remote-endpoint =3D <&audio_spdif>;
			};
		};
	};

/* video */

	lcd0: video-controller {
		compatible =3D "marvell,dove-lcd";
		...
		port {
			lcd0_0: endpoint {
				remote-endpoint =3D <&tda998x_0>;
			};
		};
	};

	video {
		compatible =3D "media-video";
		video-controller =3D <&lcd0>;
	};

/* audio */

	audio1: audio-controller {
		compatible =3D "marvell,dove-audio";
		...
		port@0 {
			audio_hdmi_i2s: endpoint {
				remote-endpoint =3D <&hdmi_i2s_audio>;
			};
		};

		port@1 {
			audio_hdmi_spdif: endpoint@0 {
				remote-endpoint =3D <&hdmi_spdif_audio>;
			};
			audio_spdif: endpoint@1 {
				remote-endpoint =3D <&spdif_audio>;
			};
		};
	};

	sound {
		compatible =3D "media-audio";
		audio-controller =3D <&audio1>;
	};

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
