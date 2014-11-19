From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: Add helper functions for deferred regmap setup
Date: Wed, 19 Nov 2014 10:46:36 +0000
Message-ID: <20141119104636.GA22111@sirena.org.uk>
References: <1416336354-32148-1-git-send-email-lars@metafoo.de>
 <1416336354-32148-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lYjFa3qL1bvncypl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416336354-32148-3-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--lYjFa3qL1bvncypl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2014 at 07:45:52PM +0100, Lars-Peter Clausen wrote:
> Some drivers (most notably the AC'97 drivers) do not have access to their
> regmap struct when the component/codec is registered. For those drivers the
> automatic regmap setup will not work and needs to be done manually,
> typically from the component/CODEC drivers probe callback.

Applied, thanks.

--lYjFa3qL1bvncypl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUbHULAAoJECTWi3JdVIfQg8sH/1nUhkNLtp7h1QWJzYUrLhbx
CbFejKUrciZwKJQZa+NGgXPXcUy1x4XiK2JJ6NeGsDx63tmekzKMT8cN0Cm5k4ue
8RI/t4A1LNX372GRbAYFv/1xkg7rqdMPvGwqJccXti4whfg2Bz9oW8gAdPviAmpb
BeNC6WD2OaxMgESrSvvio7YOTTCUMqbQosCiMJJzdo7Yuehxon1k41mArKJdzlWj
0dlhdvElT9WDBRT+QN/hsRCvimnBPb02KXXZdmMH/qZtM9dD0ZOAlCjl0XSw8Wyi
l7lkRsGCmVEMm8xs7NA5XQXJMe+iqvcv07OmMDdAuumh9ikM8ZQj5h/vh8rFCfo=
=mV5B
-----END PGP SIGNATURE-----

--lYjFa3qL1bvncypl--
