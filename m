From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 3/4] ASoC: tda7802: Add enable device
	attribute
Date: Thu, 13 Jun 2019 19:14:43 +0100
Message-ID: <20190613181443.GQ5316@sirena.org.uk>
References: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
 <20190611174909.12162-4-thomas.preston@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0819496718414029623=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93AB3F80794
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 20:14:48 +0200 (CEST)
In-Reply-To: <20190611174909.12162-4-thomas.preston@codethink.co.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, Marco Felsch <m.felsch@pengutronix.de>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============0819496718414029623==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uRjmd8ppyyws0Tml"
Content-Disposition: inline


--uRjmd8ppyyws0Tml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2019 at 06:49:08PM +0100, Thomas Preston wrote:
> Add a device attribute to control the enable regulator. Write 1 to
> enable, 0 to disable (ref-count minus one), or -1 to force disable the
> physical pin.

> To disable a set of amplifiers wired to the same enable gpio, each
> device must be disabled. For example:

> 	echo 0 > /sys/devices/.../device:00/enable
> 	echo 0 > /sys/devices/.../device:01/enable

This is adding a new ABI completely outstide the standard ALSA and power
management frameworks and ABIs with no explanation as to why or
integration with the rest of the driver.  This is obviously not in the
slightest bit OK.  If there's something missing from the frameworks
extend the frameworks, don't just ignore them.

--uRjmd8ppyyws0Tml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0CkpIACgkQJNaLcl1U
h9BS2Qf/eUVj90LcvztgsSKTKJesxl0D3bt7RMK299c2vYLHkirE0vtrBBYdi4Pl
FJ8puURfuyztbRnoMYrmvkGzoB+kCtwXLSxo2i1Mi6NSlQfnwwg0aoE9RHuB0oOD
/2hT/ekihe5UadF/JGir89imbhQob5EDyVVzjEgyWULQ4ITpkAw8wiaIcF3GNrjY
yFLb/wBrR+BM4SXfJKc+SmWy+xt1btn93sWuiaU7SMS86bIEbT1h0w4vQ1p3v2+/
qjopN+wN8BrUnWRHi7xBR4eocG6hGN9+z6/Xkhr2XL8E0tyaDly5TMDZomOPYAif
beljIAen1oDtCE4MOp25DYHPAJUmzg==
=ioNi
-----END PGP SIGNATURE-----

--uRjmd8ppyyws0Tml--

--===============0819496718414029623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0819496718414029623==--
