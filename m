From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] of: add empty of_find_node_by_path() for
	!OF
Date: Wed, 16 Apr 2014 18:15:52 +0100
Message-ID: <20140416171552.GU12304@sirena.org.uk>
References: <1397630960-26677-1-git-send-email-shc_work@mail.ru>
 <CAL_Jsq+MtkQcKs06xggrZkQHncSCBx6ABCaiud8HokEgAX2NMA@mail.gmail.com>
 <20140416142502.GR12304@sirena.org.uk>
 <CAL_JsqJNs5n8XmRe+-JWAcmunnTAoqeNFUwP2B6OitBd=QtXYQ@mail.gmail.com>
 <20140416160352.GS12304@sirena.org.uk>
 <CAL_JsqKPYiQpv8PDPsemSEuXJc_2Roqu-G3+8rV4dSHbXuHfDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1903074935802704748=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C85F2654DD
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 19:16:10 +0200 (CEST)
In-Reply-To: <CAL_JsqKPYiQpv8PDPsemSEuXJc_2Roqu-G3+8rV4dSHbXuHfDw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robherring2@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-ALSA <alsa-devel@alsa-project.org>, Alexander Shiyan <shc_work@mail.ru>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1903074935802704748==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RGwttE/plSABi47o"
Content-Disposition: inline


--RGwttE/plSABi47o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 16, 2014 at 11:10:15AM -0500, Rob Herring wrote:

> Yes. If this going to be a common pattern, a
> of_get_machine_compatible() helper might be useful. Usually, any code
> searching by path makes me suspicious.

I've always been surprised we don't have more infrastructure for
quirking off machine type in a similar way to how ACPI systems use DMI.

--RGwttE/plSABi47o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTrrEAAoJELSic+t+oim9BN0P/jaakJpYaLSqXJ8LCgJS9Z8Q
g9yTuMfMUFL3TENEPvzw+ctzd8dmch7r15HSlEuDbqDmhvSwbGNyWBBeLks9NVn2
e7zDLvPZqpgp4vdfG6y99RmjE6LtuWNZVX3lRihuFE5DZqw7+o4hbLCp4LjHlCrb
FciQ0ShMLy/jKHES3X2OHWqablYmAyZoFl1PsJXniclRiQ7y1CraVAa/eAUBygC4
4vFRTWUaty/jxZNtXW6Ed7g5eziZU1uYxZnCE5uug1GWE1+jLBjHJL3u+9/qGtWo
umybm3wvTFhdqQ9Y7ZqJ9+U0zNBAQrY+235i+jaErocsbbgHdHJmryrB9wo2M8/4
10WYX/8d0DDTVfRjO8Pw5bZFrofJLqJmJo1/SQzfOd4c2zHuBp3Z41zvr+IznZlP
xMXwXKzdTN0C5O7S2bcSWG7AQCR1tK9A65tHYTgYQMXy7W7X2sg5FVuxqep6pQZ/
rJoqNmfNxE2KiRqt2q3prhNTcAYvbXvL/PD1ByP5BGrh0ShINKT7GoC5MiA4EHTQ
5E5NfAmLUeSRq4DhJ975ohcs+1Vu3lAoAbcrE9wXYKitJERIXwIa4b37VMHCox7A
nx4GUxLrONs1eWN9r5MxmQlpmI3f7HNACWkooWOMJnRbUqzmOVvZGXWSJkCQGNhE
b8l/4aWfRZbu4QQnK5cP
=wSMP
-----END PGP SIGNATURE-----

--RGwttE/plSABi47o--

--===============1903074935802704748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1903074935802704748==--
