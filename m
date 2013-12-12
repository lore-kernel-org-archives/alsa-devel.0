From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASOC:DAPM: extend dapm kcontrol to support
 runtime route update
Date: Thu, 12 Dec 2013 10:43:47 +0000
Message-ID: <20131212104347.GH11044@sirena.org.uk>
References: <1386835619-18070-1-git-send-email-nhcao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0084541639945109720=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8797F260864
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 11:43:53 +0100 (CET)
In-Reply-To: <1386835619-18070-1-git-send-email-nhcao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nenghua Cao <nhcao@marvell.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Henry zhao <xzhao10@marvell.com>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, cxie4@marvell.com
List-Id: alsa-devel@alsa-project.org


--===============0084541639945109720==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1EKig6ypoSyM7jaD"
Content-Disposition: inline


--1EKig6ypoSyM7jaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 04:06:59PM +0800, Nenghua Cao wrote:
> From: nhcao <nhcao@marvell.com>
>=20
>     DPCM can dynamically alter the FE to BE PCM links at runtime based
> on mixer setting updates. DAPM has provided common get/put function for
> mixer/mux. But these function doesn't call soc_dpcm_runtime_update()
> func to update pcm links. This patch defines a DPCM DPCM kcontrol. For
> this control, the common get/put function will update FE to BE links
> dynamically. This patch has no impact to the current code.

Why shouldn't we just add the DPCM update to the standard controls -
what's the benefit in defining a new set of controls?

--1EKig6ypoSyM7jaD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqZNgAAoJELSic+t+oim9PNQP/0xtih5oLkeNJbDDNwrXIkhy
MKJmkc4nlfTt7tyujLp/5BkBtMUp0QAVeOaPhpJNZ2fl2DvcW5HInANJbqJi0ujo
COLUNos51V19HFUAvHbdDif06F67ALcgTxZQmCxtIB6VVTAX7vct0axo5QJdlkt+
/LXc2unZ8MIE9+or91u3sVSyqX15+CqaJv9C+lUEs5it+KYBTbGwudzd0kdtmGrE
/Bxj84ATp/D159WntqmurYX31s6cLF9C0KvACr78NzOH/uYgpOJ2tBTPo4i/pKC0
W6VbKo+DXyrfYfqekhJ/S6abZC/V/nIvb+Ce6sxDKX5DdastLEyatbzN2niOG+ck
iA5VYp22z8Pr7RzAIOQKOPg+fUsnT2JYIqWr2CbqVON0GMu0LZuRztNx655i3VNk
AS3yXpGKdBdNwYngTMOLJhjgOzbWfRN4kLklhJMpW9SM6C+gcTXci5axJtL77J60
8dhEPZ4aRMeb4HN6AIsGDWPIMbUjL6sUya5kP2bYjJ5f2Y8Rqw79uscoHQOccTSp
/1pkEkXYGMbuBVfs8SN8VAUDTkUsaZA3x0IkcGNKXxv/b2NFZl935F0cfPbaqEW6
aY8Pqe7DWovV5aksVQ6oFINToo55nD10FZ7JsDK/nALrNz9YAHX1jlR35l3nPrmX
tguSN7KXZHDYcnQyhGQU
=6iHI
-----END PGP SIGNATURE-----

--1EKig6ypoSyM7jaD--

--===============0084541639945109720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0084541639945109720==--
