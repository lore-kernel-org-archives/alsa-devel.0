From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH] ASoC:kirkwood: Don't raise an error when no DAI format
Date: Sun, 28 Sep 2014 18:05:50 +0200
Message-ID: <20140928180550.5f0b8f03@armhf>
References: <20140928150342.CC21B786A1D@smtpfb1-g21.free.fr>
	<20140928151207.GI5182@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140928151207.GI5182@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, 28 Sep 2014 16:12:07 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Sun, Sep 28, 2014 at 04:19:27PM +0200, Jean-Francois Moine wrote:
> > The two DAIs of the kirkwood controller have a unique PCM format.
> >=20
> > The simple-card sets the audio hardware definitions of all CPU DAIs=
=2E
> > The PCM format is defined only when it is present in the DT.
> >=20
> > This patch prevents the controller to raise an error when
> > the DT audio card definition by the simple card contains the PCM
> > format of one CPU DAI only.
>=20
> I think this is a silly idea - why should every driver have additiona=
l code
> to detect when it's called to do thing.  Why doesn't the simple card =
code
> always pass the required format?
>=20
> Looking at other drivers, no one else does this; they all appear to r=
equire
> the proper format to be specified.
>=20
> What some drivers do (eg, omap-mcbsp.c) is to block set_fmt when the
> DAI is already in use - setting a flag "configured" in hw_params, and
> clearing it in shutdown.  Maybe following this will solve your proble=
m.
>=20
> In any case, random drivers doing stuff differently without reason is
> really not a good idea.

As the simple card is done, the audio hardware definitions of the
platform and all the CPU DAIS are always set in the audio controller.

When the PCM format is globally defined (platform), the function
set_fmt() is called for all CPU DAIs (then, twice for the kirkwood
controller) with the same value. The DT is:

	sound {
		compatible =3D "simple-audio-card";
		simple-audio-card,name =3D "Cubox Audio";
		simple-audio-card,format =3D "i2s";

		simple-audio-card,dai-link@0 {	/* S/PDIF - HDMI & S/PDIF */
			...
		};
		simple-audio-card,dai-link@1 {	/* I2S - HDMI */
			...
		};
	};

The PCM format may also be defined per DAI link. The following DT works
the same as setting globally the format, i.e. there are two calls to
set_fmt() with 'i2s':

	sound {
		compatible =3D "simple-audio-card";
		simple-audio-card,name =3D "Cubox Audio";

		simple-audio-card,dai-link@0 {	/* S/PDIF - HDMI & S/PDIF */
			format =3D "i2s";
			...
		};
		simple-audio-card,dai-link@1 {	/* I2S - HDMI */
			format =3D "i2s";
			...
		};
	};

The problem appears when the format is defined in only one DAI link:

	sound {
		compatible =3D "simple-audio-card";
		simple-audio-card,name =3D "Cubox Audio";

		simple-audio-card,dai-link@0 {	/* S/PDIF - HDMI & S/PDIF */
			format =3D "i2s";
			...
		};
		simple-audio-card,dai-link@1 {	/* I2S - HDMI */
			/* no format */
			...
		};
	};

Then, audio does not work.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
