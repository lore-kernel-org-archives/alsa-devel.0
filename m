From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic3x: Add controls for
 selecting HP power down modes
Date: Sat, 31 Dec 2016 18:49:15 +0000
Message-ID: <20161231184915.kcnidpdwpw42xdxi@sirena.org.uk>
References: <20161223092112.7992-1-peter.ujfalusi@ti.com>
 <20161223092112.7992-4-peter.ujfalusi@ti.com>
 <084901eb-25be-4941-0cbc-0e88cc4010d6@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0976307427663424878=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CAEA2670B3
 for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2016 19:49:26 +0100 (CET)
In-Reply-To: <084901eb-25be-4941-0cbc-0e88cc4010d6@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org


--===============0976307427663424878==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gkkdn36e3xlpkxbe"
Content-Disposition: inline


--gkkdn36e3xlpkxbe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 23, 2016 at 08:47:07PM +0200, Jarkko Nikula wrote:

> This certainly gives more possibilities to control this depending on
> use-case and device idleness. However I think does it find use or will
> it end up being a random choice?

I suspect most people won't understand it but OTOH I can see some
people wanting to use it so...

> Alternative could be some high-impedance widget that defines the output
> mode and what a machine driver wanting lower power consumption can
> connect instead of HP outputs. Another idea that comes to my mind do you
> hear the pop if output is let to be in high-impedance but is driven to
> VCM with some delay before powering up?

I can also see a system tying it to jack detection so you get the pop
reduction if the headphones are physically connected and low power if
they're not there and nothing is going to care anyway.

--gkkdn36e3xlpkxbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhn/aoACgkQJNaLcl1U
h9D8CQf+KOjlOECSn71Kq2Evb2wWVoBKWbT98DQmQkIGFSyDRBS7BtvSlRpq8oMT
IhVB7KARpV+gTe9K5k8EktosFjBkXoLEfdmKsklQNZWpsxIe+6EarvBXsuDaeyRf
QABZ0IUx9UIf+9dEZ/T7HhRuoduUngM0nm3VdfjVvnN+90q7UN9oRgKcEJUOmWo1
HaPnguSbbtdjO2kzu6IM1choyIgSFolIUHfQrMYDox6pV1sMtxVSQbx2klZK2IWd
FvXIEgNh0MHE/uqr7P0lJOkxcdmZx8szVUyON/lToDLzLsaOEs+JsQ/Ys7S3cpmA
oRAxYP5DxWi8nYMTK5Jlce55nXLymg==
=6hQH
-----END PGP SIGNATURE-----

--gkkdn36e3xlpkxbe--

--===============0976307427663424878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0976307427663424878==--
