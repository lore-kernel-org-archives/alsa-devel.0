From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix irq_of_parse_and_map()
 return value check
Date: Thu, 17 Oct 2013 10:40:54 +0100
Message-ID: <20131017094054.GJ2443@sirena.org.uk>
References: <1380773722-1295-1-git-send-email-linux@roeck-us.net>
 <20131003155816.GU27287@sirena.org.uk>
 <525F4421.3090404@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0944784938352899781=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D28F5265358
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2013 11:40:58 +0200 (CEST)
In-Reply-To: <525F4421.3090404@roeck-us.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============0944784938352899781==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="agVz1gqRg0BwYviO"
Content-Disposition: inline


--agVz1gqRg0BwYviO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2013 at 06:57:53PM -0700, Guenter Roeck wrote:

> do you plan to send this patch upstream anytime soon ?

It'll go next time I send stuff if it hasn't already.

--agVz1gqRg0BwYviO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX7CjAAoJELSic+t+oim9ZvMP/iguM/JmDhW+NeRgbccLUquR
tGkh7Sr4EfaYAM80Z2jcRX2Z+WKB9zGZsNvT/y3sEM6UJnyyoY0Nhzfn0ZirHorJ
sNjvufySJvJWl4UwlPGekNo42Jp+8o0EFXzhDe5fThC2utJlT9F/Dtzqsh6veaCY
zz4LQkImJNjfx5OfjS1mfn4fqZnt/q/q1TJmFcwaJiU+2rYzVu0VWZqsIjFDxGI7
QD9jLRt1Y7IvZOFT/fbheR8B8pmx+5g/dh0ymdOVPJbLo2NmNPCMGimz7723R/Qh
QPBXIisyFkLJq9GjBXCYRlt4/fk8cIoynObJ2ihBOEXFGLcJ3qgUjmWaSd+hWumr
bHjLrgSB83mHU/yvBtcLsH7MUziVyyfg7JtvuenwAVVPfSha2N/3/Tz/vvQX/Rha
GC47KdnrH8+a69S0E/c6C5b9qK+BCY/lBGnWp08PR2r2NHc5Ob43QtsRBjCSK48v
sRbq+yXjV4BmWE1FHTvAFx2UbCQZCgkd/keTcQDDqcXClFvH31A4GY0VAyZXscqt
T5Xt23IAsSVf1M+fS728YBpPQ47DaLOZqvGqHxEBkk9SqjLUXpfCmxuWy1HZJKWy
e//AYo7jyi8845cCL97+vPG+kN/hO0VUpoj4sl/wgl2BwT4qGLW1u8OLwUCBixI8
bMfvi1xQmhyTzgI//y9M
=gIzk
-----END PGP SIGNATURE-----

--agVz1gqRg0BwYviO--

--===============0944784938352899781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0944784938352899781==--
