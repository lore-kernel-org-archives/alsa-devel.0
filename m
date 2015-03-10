From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/14] Fix wrong ctl value references in
	ASoC codecs
Date: Tue, 10 Mar 2015 20:15:32 +0000
Message-ID: <20150310201532.GL28806@sirena.org.uk>
References: <1425987556-569-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0709053562338438225=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DDBBD2605CF
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 21:15:45 +0100 (CET)
In-Reply-To: <1425987556-569-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============0709053562338438225==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8d7KAgWmJ23Ts4y"
Content-Disposition: inline


--n8d7KAgWmJ23Ts4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2015 at 12:39:02PM +0100, Takashi Iwai wrote:
> Hi,
>=20
> while looking through the ASoC codec codes, I noticed that lots of
> drivers refer to the wrong union value type for boolean controls.

Applied all, thanks.

--n8d7KAgWmJ23Ts4y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/1DjAAoJECTWi3JdVIfQZ+sH/1FHqwYUxPJqZKkPrNiEimQU
BfD3gRfdZsvFpCKSgwLNMG/3sFA0wfsqlW5VIl/Gpkd0TVPA3SQBLX6ihG6yUib/
V7jNymLx7g3totOr4LblwmnyJU+1tCv9Q/QZuUxJaqSyr045TpH8QwkV7x6ON/NE
pk1I3vZRPMp3AsnCF6/i3XFpPZPUlObZPQS/YAdiU4DSTgrzf7Uj0lptOSLRL95m
sE/EtU3ffkopAEop9BwCZ2eQ/uWk7BrY3eINpX9lHT9OJ9BF/tbzPxR2habqe+p3
qdB0y8eu+TmJFxwlzI3p+EX8s4LTICv/3qjKeIKDAAKpVKh4sJw9VzI4R8S834E=
=p5aW
-----END PGP SIGNATURE-----

--n8d7KAgWmJ23Ts4y--

--===============0709053562338438225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0709053562338438225==--
