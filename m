From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adi: Add missing return statement.
Date: Mon, 5 Jan 2015 20:16:38 +0000
Message-ID: <20150105201638.GN2634@sirena.org.uk>
References: <1420042837-3337-1-git-send-email-andrew.jackson@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6671835670847094867=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A62E26047D
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 21:17:01 +0100 (CET)
In-Reply-To: <1420042837-3337-1-git-send-email-andrew.jackson@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Jackson <andrew.jackson@arm.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6671835670847094867==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rFUhhEVnhEf/dYhU"
Content-Disposition: inline


--rFUhhEVnhEf/dYhU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2014 at 04:20:37PM +0000, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
>=20
> The probe routine was disabling the clock even
> if the system was configured successfully.  Add
> a return statement to leave clocks enabled.

Applied, thanks.

--rFUhhEVnhEf/dYhU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqvElAAoJECTWi3JdVIfQPEEH/ieQEkbZOfcO7WAkKX+rY2A2
Enoyz591qB2CM3uJNV7icbhuSsRGgPw+kbKBr2UEuSyyB5PN+O6V4Bbi7xYnFuV3
ufObEQBPmNku2ly4A/ZZEJUGWlLbuAcIR+AFIkooiFG9t7JIM/EIv5xR/10yJQz9
O2Bl6Rhpa7ChiHV4OTJeKfWtuJX7AvxhcWqH4k3AcRwcMkyID0Ld0LKIzkKvsaTi
ArXcgdwbUzcB5a/pfmKhkO0M63ML5VFidcUwCl6+ss/9pA93I+JOUP9AoHAOxoN2
BT7UH6oYKALlj5+1FTkw5Z/JnpTPz+kd+9RKsOB7bfLoSibNInIGhFbYlV0u320=
=8FVh
-----END PGP SIGNATURE-----

--rFUhhEVnhEf/dYhU--

--===============6671835670847094867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6671835670847094867==--
