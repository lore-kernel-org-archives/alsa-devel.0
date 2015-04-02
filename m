From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs4271: Increase delay time after
	reset
Date: Thu, 2 Apr 2015 18:15:59 +0100
Message-ID: <20150402171559.GU6023@sirena.org.uk>
References: <1427962660-23517-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4413454056056092237=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1427962660-23517-1-git-send-email-pascal.huerst@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: pascal.huerst@gmail.com
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============4413454056056092237==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i483Pv/KqyjCUwB1"
Content-Disposition: inline


--i483Pv/KqyjCUwB1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2015 at 10:17:40AM +0200, pascal.huerst@gmail.com wrote:
> From: Pascal Huerst <pascal.huerst@gmail.com>
>=20
> The delay time after a reset in the codec probe callback was too short,
> and did not work on certain hw because the codec needs more time to
> power on. This increases the delay time from 1us to 1ms.

Applied, thanks.

--i483Pv/KqyjCUwB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVHXlOAAoJECTWi3JdVIfQJUoH/AnR8pjEaLNp6+AsGCDf3152
dMN2PrgSb18L8FgFwdEsjHnhQR2fe4v44POBpJW6omDBvFfaFcFs5oqqiNs+LnLP
85xO/fygpOe+e7STgBv75bPftR0JpfyP5mw+JOCqyNe9N74gSVT50EPviYrhOEpK
4SqCmYnUnNva3qEjvJm8L7vIUXbHI8uOvheouNayX+2ogQomUongppVFWYNW74W7
k0lyx+QXwCcAsz+GaR4OTAywJYy7vvfBQamM++MZh8Md7xpITvopFqrdLG90eA8y
DeJtId0ufd0Zvp9TcLcoUNe8s86Z+aJzcZEF5pQ5Q8VNbtXDH39m6InTmcWVPjc=
=ItmW
-----END PGP SIGNATURE-----

--i483Pv/KqyjCUwB1--

--===============4413454056056092237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4413454056056092237==--
