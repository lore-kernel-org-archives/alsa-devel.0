From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH][ASoC]Add ability to remove rate constraints from generic
 ASoC AC'97 CODEC driver
Date: Mon, 6 Apr 2015 17:41:50 +0100
Message-ID: <20150406164150.GM6023@sirena.org.uk>
References: <54FF7E13.4060801@maciej.szmigiero.name>
 <20150322182744.GB6643@sirena.org.uk>
 <551821A1.5030902@maciej.szmigiero.name>
 <20150330041935.GA1568@sirena.org.uk>
 <552062C8.80103@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="glNuw4S6NeIZr5j7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <552062C8.80103@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--glNuw4S6NeIZr5j7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2015 at 12:16:40AM +0200, Maciej S. Szmigiero wrote:
> W dniu 30.03.2015 06:19, Mark Brown pisze:
> > On Sun, Mar 29, 2015 at 06:00:33PM +0200, Maciej S. Szmigiero wrote:

> > Alternatively if you're just trying to open up the constraints why not
> > just open them up by default and make sure that the AC'97 generic code
> > is constraining things appropriately if it's not doing so already?

> By 'open them up by default' do you mean removing them altogether=20
> from ASOC AC'97 generic CODEC to let the AC'97 bus driver constrain
> rates on its own or do you mean retaining ability to constraint in
> ASOC AC'97 driver, just have it switched off by default?

I mean make the default setting be the maximum possible set of rates and
then allow the CODEC code to constrain based on what it finds on the
link.

Please also note that ASoC is spelt ASoC.

> (that is, what the current patch did, just change the default setting).

No, it added a device tree property for controlling things.

> If the rate constraints are removed (or disabled) from the ASOC AC'97
> generic CODEC driver then it can be used as-is in the (at least) fsl_ssi
> driver by registering AC'97 platform device there using index taken from
> DT property (cell-index) already defined as required in
> Documentation/devicetree/bindings/sound/fsl,ssi.txt.

> Now the question is what is more binding: the documentation which
> defines this property as required or DT files which don't define it at al=
l?

The driver really ought to continue to support existing DTs, it can
complain about them and assume the default value if the property really
is required for some reason though.

--glNuw4S6NeIZr5j7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIrdNAAoJECTWi3JdVIfQx+UH/2DsN7yX7iGKCaT3bMEbIBwS
WhjqOcDZ07SGfYXePK8+2WYDQ8iEEsyvxRlWuPx7GtMNkP6umjibwFzXqLaYRDIR
XFLsJVm+QH2W2HQlhSeafTTgbYQYZ5bYP5mU8OK8psKS41QHGSWwtEVrdKxbN+V+
JqNSXcPbXhy9RtIFHnSLyYObJFRPrCBh/cdumYM/DdM4Y5dwc9jmYMfh7ElPm0v7
X+CnpKUDs4mJCJXKdDZ+Io6nhZGbnxELD4KWX6AZSikrmITNcXsIO4eDUVIVRuaE
fOEc1yIGelf2EBq+fJtC0uoeRrD2I0sDyDF7a/i8B11OSQpQsUCSeJyP2uTRy4U=
=wm5g
-----END PGP SIGNATURE-----

--glNuw4S6NeIZr5j7--
