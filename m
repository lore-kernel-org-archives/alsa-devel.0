From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on
 diagnostic routine
Date: Tue, 30 Jul 2019 16:50:27 +0100
Message-ID: <20190730155027.GJ4264@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730141935.GF4264@sirena.org.uk>
 <45156592-a90f-b4f8-4d30-9631c03f1280@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DesjdUuHQDwS2t4N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45156592-a90f-b4f8-4d30-9631c03f1280@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, Marco Felsch <m.felsch@pengutronix.de>, Takashi Iwai <tiwai@suse.com>, Annaliese McDermond <nh6z@nh6z.net>, Liam Girdwood <lgirdwood@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--DesjdUuHQDwS2t4N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2019 at 04:25:56PM +0100, Thomas Preston wrote:
> On 30/07/2019 15:19, Mark Brown wrote:

> > It is unclear what this mutex usefully protects, it only gets taken when
> > writing to the debugfs file to trigger this diagnostic mode but doesn't
> > do anything to control interactions with any other code path in the
> > driver.

> If another process reads the debugfs node "diagnostic" while the turn-on=
=20
> diagnostic mode is running, this mutex prevents the second process
> restarting the diagnostics.

> This is redundant if debugfs reads are atomic, but I don't think they are.

Like I say it's not just debugfs though, there's the standard driver
interface too.

--DesjdUuHQDwS2t4N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AZ0MACgkQJNaLcl1U
h9A+KQgAgi4HkmsbIandzuTrFA6N2E9Zrc7WMisuFB9GE/OnLiU559yFfrABha81
2AJ4vwv4WOwP6Cl48kFT7W90WgsJljB6F0d/SaiwvhNmwf2ifUVANo+tkNv8L2kn
W/7p0/OQ1tuFhU9OI98e1YbqSI/TEcgQx3CEp0diUdcmv1C55X6cn1tjj5Mn0+hz
Mf2IV9Q1KMJQBeHqm6PvdWjzxbnQ7iUEPQ6SoP6PwTjEvpWN/+Cv7q/wo1FCs1hb
1nYLoWrVYhOaQyzAxxJ/S2bRl5TybnmgSJOpj1ZNMRcHdED93sk3GMNSqqAOD68L
nQQV16tM/EvyPsbQE+AMJFrAKfZLdg==
=H0id
-----END PGP SIGNATURE-----

--DesjdUuHQDwS2t4N--
