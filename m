From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Thu, 3 Jul 2014 17:29:09 +0200
Message-ID: <20140703172909.60caf2c7@armhf>
References: <20140702183841.7c964832@armhf>
	<20140702165628.GO20799@lunn.ch>
	<20140702195154.47d6f6b4@armhf>
	<20140702194252.GN410@sirena.org.uk>
	<20140703074959.7c489912@armhf>
	<20140703104432.GV410@sirena.org.uk>
	<20140703133406.2d3e3a1d@armhf>
	<20140703115924.GY410@sirena.org.uk>
	<20140703152826.103c9d6c@armhf>
	<20140703134346.GW32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140703134346.GW32514-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, 3 Jul 2014 14:43:46 +0100
Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:

> > But, this means that there will be a lot of errors when DPCM will b=
e
> > used, because, in most cases for the Cubox (kirkwood audio + tda998=
x),
> > both ways I2S and S/PDIF will be activated at the same time for a
> > single stream (you may note that the routes from the second input
> > cannot be blocked by the CODEC after it received the first input,
> > because these routes have already been computed). =20
>=20
> This is /very/ easy to solve on the Cubox, if only you would listen
> to me - I've stated many times that I2S should not be used there.
>=20
> Just because the hardware is wired up with both the SPDIF connected
> and the I2S connected, it does *not* mean that we have to wire them
> both up in software.
>=20
> Indeed, *everything* works with just SPDIF.  The same is not true of
> I2S.  So, what we do for the Cubox is we just wire up SPDIF in softwa=
re
> and be done with it - we then get a fully functional setup.  So using
> I2S on the Cubox is mostly pointless - unless you wish to use I2S for
> testing purposes.
>=20
> Let me also point out that adding your changes - including the additi=
on
> of this codec patch - explicitly deny the possibility of:
> * using compressed audio streams via the optical SPDIF out socket
> * using compressed audio streams over HDMI
> * using audio rates and formats not supported by the attached HDMI
>   device via the optical SPDIF socket.
>=20
> These are serious issues which thus far you have so far failed to
> respond on.  People who use the Cubox as a media platform rather
> than (presumably) just a music jukebox want things like compressed
> audio out and SPDIF out to work.
>=20
> Look, one reason to use the optical socket is because you want to
> push out a stream at (eg) 96kHz to your audio system, but your TV
> doesn't support it.  With your approach, you explicitly block that
> because the TDA998x codec assocated with the Kirkwood CPU DAI
> refuses to allow that sample rate.  Fine, if the attached device
> does not support that rate, then the right thing to do may be to
> disable audio transmission over HDMI, but with the Cubox hardware,
> limiting the sample rates is totally the wrong solution.

I think that you did not look at my code.

Both S/PDIF and I2S work with the TDA998x. It is a choice of the audio
subsystem to do this choice, not Russell King. If you want only S/PDIF,
it is easy: just declare the S/PDIF DAIs, on both sides, source
(kirkwood) and sinks (tda998x and S/PDIF):

	dai-link@1 {		/* S/PDIF - HDMI */
		cpu {
			sound-dai =3D <&audio1 1>;
		};
		,codec {
			sound-dai =3D <&hdmi 1>;
		};
	};

	dai-link@2 {		/* S/PDIF - S/PDIF */
		cpu {
			sound-dai =3D <&audio1 1>;
		};
		codec {
			sound-dai =3D <&spdif_codec>;
		};
	};

When DPCM will handle the formats and rates, the audio subsystem will
find by itself if such stream will go to the HDMI only or to the S/PDIF
only or to both. The kirwood audio driver will work as it is and the td=
a998x
CODEC will work as it is. There will be no need to change these drivers=
=2E
All we need actually is some more code in DPCM or multi-codec or
whatever mechanism which will route the stream according to the rates
and formats.

Actually, as DPCM does not work, the user has to choose which PCM to
use, otherwise, the application does a format and rate translation.

Anyway, if you want S/PDIF output with the actual kernel (3.16-rc3), in
the DT, put:

	spdif_codec: spdif-codec {
		compatible =3D "linux,spdif-dit";
		#sound-dai-cells =3D <0>;
	};

	sound {
		compatible =3D "simple-audio-card";
		simple-audio-card,name =3D "Cubox Audio";
		simple-audio-card,format =3D "i2s";

		simple-audio-card,dai-link {		/* S/PDIF - S/PDIF */
			simple-audio-card,cpu {
				sound-dai =3D <&audio1 1>;
			};
			simple-audio-card,codec {
				sound-dai =3D <&spdif_codec>;
			};
		};
	};

&audio1 {
	status =3D "okay";
	clocks =3D <&gate_clk 13>, <&si5351 2>;
	clock-names =3D "internal", "extclk";
	pinctrl-0 =3D <&pmx_audio1_i2s1_spdifo &pmx_audio1_extclk>;
	pinctrl-names =3D "default";
	#sound-dai-cells =3D <1>;
};

and the sound should get out of your S/PDIF optical connector.

Eventually, the TDA998x is used in other machines. Are you sure that
the audio controllers of all these machines have a S/PDIF output
connected to the S/PDIF input of the tda998x?

The tda998x CODEC I propose works in all configurations.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
