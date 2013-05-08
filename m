From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm_adsp: Expose coefficient
 blocks as ALSA binary controls
Date: Wed, 8 May 2013 16:03:22 +0100
Message-ID: <20130508150322.GV7478@sirena.org.uk>
References: <1368018935-4902-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2072562123867522875=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D509D2610A2
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 17:03:33 +0200 (CEST)
In-Reply-To: <1368018935-4902-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============2072562123867522875==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t98UOKzcpBZ5uth4"
Content-Disposition: inline


--t98UOKzcpBZ5uth4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2013 at 02:15:35PM +0100, Dimitris Papastamos wrote:
> Add initial support for runtime tuning for the ADSP cores.  This
> is achieved by exposing the coefficient configuration blocks as
> ALSA binary controls.
> The current code assumes that no controls on the DSP are volatile.

Applied, thanks.

--t98UOKzcpBZ5uth4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRimkxAAoJELSic+t+oim9TCcP/3JQhjF+44QbY1ekpswW1eDe
O5zQuRIT+w5embc3UxDWAQHNbxcDR8Ho7WPjFDvsQEX44Ju3hetSqkTHQvuFXN+k
Y86OgCtbWbHNHwyej2WEmhq8oLgEAzMMSnstu1hVyQWUtzt5D4qzu6b3tCzBtjiP
Urk1/5JCduGt2LIc71piZe6Z15kMyJL54rvp1CcPkbchj42rs57NcG2PSuy99NWw
sXHRYtxQPDvyzMnXH4nvR1O07TPlkrW/OO5k5XZHLPBaXc4GibRGHIRwfwkoWvKq
wTq5K8O1gELuWWgMSJJF5cg+bN6fazIWwN5jkKEdJc3LcwX/VPYonrktkdK6bpgO
B2gFaki7cyu5YiQQT70Kkp5MWBcMQ7Yf9EJIAc4rGjdCw7YRKgijzhg/w8UFXJef
y5Z4LKRXR8osajg+xjhxmZFjxi3JuRJEB46pB45cuvOe2BqTyg2a7R+MmRZUWDW1
QDSDSFsqLDZgh5uBp2BBlBS/KLJvsqZ7Qfka8jdGpEoJCzNi4x4q1ulcbeAphQZU
WOGdrnX9ttNc3MIMpQlMm7y3SgRVyJlOHCnXjEZd6Mps9gdKwrVkwg5BsCqCt4Tf
6njaPpNFeOH/WXvnSaeJdzE47cPlkX+Al7CAAdLkrNkxgu+pPHSz/m4tzO3ySLVa
elhHbHdzruZsfxtHelQr
=eeZ3
-----END PGP SIGNATURE-----

--t98UOKzcpBZ5uth4--

--===============2072562123867522875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2072562123867522875==--
