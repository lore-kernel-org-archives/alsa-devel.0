From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Add sysfs entries via static
	attribute groups
Date: Mon, 2 Feb 2015 20:02:54 +0000
Message-ID: <20150202200254.GD21293@sirena.org.uk>
References: <1422645397-14983-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4430818618748292391=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 209852606F3
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 21:03:26 +0100 (CET)
In-Reply-To: <1422645397-14983-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4430818618748292391==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WEW+cUrJ0qt1Keq5"
Content-Disposition: inline


--WEW+cUrJ0qt1Keq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 30, 2015 at 08:16:37PM +0100, Takashi Iwai wrote:
> Instead of calling device_create_file() manually, assign the static
> attribute group entries at the device registration.  This simplifies
> the error handling and avoids the possible races.

Applied, thanks.

--WEW+cUrJ0qt1Keq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz9ftAAoJECTWi3JdVIfQDiwH/i8BnCRS/nHhAYcPlcyVtGs4
TmG17YS+cgPHk63begLMKibE1teL0lUwryNVlG8LhzvY2z5UiPhN+ySVoRyYZi3+
kE7gztDwXcPLpVz8Q1GEQY1sD0xC4+inZaAH/k7FB/nASsqvuDRDq1QXy101QgMF
pyyk6HAjSgAkHkcBdS15UYfcMep1F3ThS91JOhv4RtTCZvGvwQIh+rJ59WCI8bi2
cQS0TVZpByWWzOpsWcqnPLa42tvTq9qrrvPXXbqrLVfU8f88Sw09jIDrheuUWoRc
TewIuhcQRLkQ7nNNK42TjM7wFhdKsSG3RYRXKZUBgLW3v1CV3udkG28ncUvFsdw=
=/zZZ
-----END PGP SIGNATURE-----

--WEW+cUrJ0qt1Keq5--

--===============4430818618748292391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4430818618748292391==--
