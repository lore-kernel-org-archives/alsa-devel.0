From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v11 5/8] ASoC: fsl-ssi: ac97-slave support
Date: Thu, 22 Aug 2013 11:09:34 +0100
Message-ID: <20130822100934.GV26118@sirena.org.uk>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-6-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4061971159960841270=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1376924761-4054-6-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4061971159960841270==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sBvc846/5FzkyDmz"
Content-Disposition: inline


--sBvc846/5FzkyDmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 05:05:58PM +0200, Markus Pargmann wrote:
> This patch adds ac97-slave support.
>=20
> For ac97, the registers have to be setup earlier than for other ssi
> modes because there is some communication with the external device
> before streaming. So this patch introduces a fsl_ssi_setup function to
> setup the registers for different ssi operation modes seperately.

Applied, thanks.

--sBvc846/5FzkyDmz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFeNaAAoJELSic+t+oim9a50QAISGiy6NOYwXQ6xoZuLw+2Bc
om3HR6iiV+jWNEFd6KztAA9Ln0k2/9tTtdj+wB2jADO5aRM4cBlm7cY2gL7CRgfq
5DQwuDHLqc0xdOrrTWdGSbDn0UZUUJE7xIeT1lOJARMOT5FazhKkXY/Xf4M7xy4N
D8AMYUJI6sagKcHv43C8Flkw2F5SiXQPRV5qnwHbYAuQA5LJj9D0HpKgcoffHXbT
oQkL+Us/q1hgj0TBlIYqxA+15qW36QCK7ZWt9gQKq9/gC2EyUNOLK56T5+YS3Vbn
M1KeNVQzTAnV5Cbiph5nvmzpeDmXhyYsziCgPAjoCxizbJWfCq89tXkhnwwEzJ9D
6n8ZwgqwG3EZJ83mBY+OwJvfyi4ucnbAhw28j/5okjrd3DSxNVQwfWjOlwKczqHF
JkITECxXcOs5CiyUAAdbCA7IhVS+7iegfG2TZ2CDwXCg+DEHXT3EFmhi9K3svPSl
nvX4g1qJeMgxSm/ktach0rFuHl6+3kyJm6SpkDrWgHVrFnWmejXuiiTdaIY1QtNT
AngM/d/Lsy0TF2dz6ScLuefI53vudSHAul7S/yShvFhe0NoFcdQWfYgwwf0fU9fl
ZrOOE2B1CeCuD06Aq58jNFgcth6ECeOYft+Xo8I6SVocJwQqNbaa11WS2XrGW6Wm
xYl0PW+StPImwYO4f9PC
=q1/P
-----END PGP SIGNATURE-----

--sBvc846/5FzkyDmz--


--===============4061971159960841270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4061971159960841270==--
