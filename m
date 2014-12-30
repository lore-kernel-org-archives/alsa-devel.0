From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/6] ASoC: dwc: Prepare clock before use
Date: Tue, 30 Dec 2014 16:51:10 +0000
Message-ID: <20141230165110.GK17800@sirena.org.uk>
References: <cover.1419936132.git.Andrew.Jackson@arm.com>
 <faa0193d388fe808c2fae461954bb1730ba29244.1419936132.git.Andrew.Jackson@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qu+55eaNXpiLf04N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <faa0193d388fe808c2fae461954bb1730ba29244.1419936132.git.Andrew.Jackson@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jackson <andrew.jackson@arm.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--qu+55eaNXpiLf04N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2014 at 10:55:44AM +0000, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
>=20
> Some I2S clocks may require some time to get the clock ready
> for operation and so need to be prepared before they are enabled.
> So, prepare the clock as well as enabling it, but combine the
> two through clk_prepare_enable.

Applied, though the changelog is inaccurate - the need to do things
outside of hardirq context is the reason the common clock API has a
prepare stage but it's just a flat out requirement of the common clock
API to prepare clocks.

--qu+55eaNXpiLf04N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUotf9AAoJECTWi3JdVIfQsHYH/1MqZ5lyDjuDapIqu4M8WpCG
XDtrgSBuB2YvZGPMGh0c7n9l4S7xS3I/C3zhbs3RBLAEpl8hUZzbu8SfQQfcM7tw
neIyrAJ3VLxQGPN6U1t3lYPsFyCvcwUeBqLmOG/JwVVhBcWaL+pW39YDSt4NEt4H
CsHoAFwwtlQoqKZojEvujdyx5RL9H/OfTsccOHrlNKkEasQDEWPUdDLfaIlKHIW1
xENWBkv9smBLwzYS0rrjAtyWXvy5eKFwbBx/EAwrNFWd/ogwRHrPedRG1re0Pt2V
Lm7RpUWls2n9vfDdnzDJ3lQeHrcNAcpAGXYNSuNehLlXLfVLUFuWRv1bDGWAxaU=
=/tMT
-----END PGP SIGNATURE-----

--qu+55eaNXpiLf04N--
