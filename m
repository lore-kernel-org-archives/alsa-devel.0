From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH resend] ASoC: adau1701: add regulator
	consumer support
Date: Mon, 20 Apr 2015 11:43:19 +0100
Message-ID: <20150420104319.GA14892@sirena.org.uk>
References: <1429521123-12764-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4111086275478759521=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1429521123-12764-1-git-send-email-pascal.huerst@gmail.com>
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
Cc: patch@alsa-project.org, tiwai@suse.de, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4111086275478759521==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2015 at 11:12:03AM +0200, pascal.huerst@gmail.com wrote:
> From: Pascal Huerst <pascal.huerst@gmail.com>
>=20
> The adau1701 has two power domains, DVDD and AVDD.
> Enable them both as long as the codec is in use.

Applied, thanks.

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNNhCAAoJECTWi3JdVIfQZa0H/RTwtO2pFMsMAbkawik3eNBG
4ku419bL905wtNzW/mfu53y/zQkFMcLEfUpLH9cHimp9kCR99CoQB9Aq1eS1+Dxk
hvoA0twxmbVbNWVnfbwPpoBjamRdG4YkIF1eh7z6dl9X7yQM1r+z6GGHaBm2/5XS
7fi+7RhIY3TZy+JSWSNUtXmRRLylvgUhEmgFYvkC4cqK3SlTbRoTScMe2VsSb6fb
otMJVxCIyW6udks/3Ax7L/vON1KtK2VnCdin5fw+pp/Gd06gAIomqQ3CeSrKoz/s
IM/nOaityKOwYIiAv8OK5OnnUTWOYf39WssUMLasd0Z2sL7LcN1A/j3Jh3UIX1U=
=2p5o
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

--===============4111086275478759521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4111086275478759521==--
