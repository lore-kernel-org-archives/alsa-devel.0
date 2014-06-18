From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 1/2] ASoC: ak5386: Add regulators to
 documentation and fix sparse warning
Date: Wed, 18 Jun 2014 17:12:49 +0200
Message-ID: <53A1AC71.7070403@zonque.org>
References: <1396029905-6807-1-git-send-email-zonque@gmail.com>
 <20140329101708.GH21628@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1332999579291191729=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 494CF2610C1
 for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2014 17:12:52 +0200 (CEST)
In-Reply-To: <20140329101708.GH21628@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1332999579291191729==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IF6RlF1po3a6ELaf2BQ7VmR1gXOOqgxNT"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IF6RlF1po3a6ELaf2BQ7VmR1gXOOqgxNT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/29/2014 11:17 AM, Mark Brown wrote:
> On Fri, Mar 28, 2014 at 07:05:04PM +0100, Daniel Mack wrote:
>> Document the newly added regulators to the DT binding document.
>>
>> Also, "static const char const *x" is not identical to "static const
>> char * const x", which sparse now complains about. Fix it.
>=20
> Applied, though this should really have been two patches as there's no
> overlap.
>=20

Hmm, for some reason, this patch didn't make it to mainline yet. Same
for another one that patches the same file which I sent the same day.
Want me to resend?


Thanks,
Daniel



--IF6RlF1po3a6ELaf2BQ7VmR1gXOOqgxNT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJToaxxAAoJELphMRr8Y1QkKHIQAK+S+6GlBwneuBLA+u6+m5g0
KJRnF9TOfdEYARW0I9Os/oiOO5bK2z7W7+026xQ4H5hTncFAyaBZrao3+6ld/3MX
Vg1ARr/T3TVawaHEWUguYRdy2Rm3c8WH9Vjg9q34qkxGBgA0t4uXvMinz3PEs8Bc
Y1RtBkAqAcDmjHAv6/CFIdTR75M+GsOyKiSwuADxE0WHbL/5R+Lb00JzPc9AY1rV
S+OOmuxNdS7dT41q/BrBAWQ1eQLEja7el+rZhShc7kjOu+hmqNQ/mni/L2ZOE0n1
6Z96LITcEpIz2I0mweOku0CYqBFxJld38cfr3Q4w+JDcnzKJTJTaS3igKRv7ewLC
HDiFYppPISy09J61RaRSeReZIFAY2vksjupyz2qM67GjVUdgt1t499leWi5hisK5
4y3r/Wvyw3B0k7wrNyk04VAGG1+xmQ+WNA99zG2lH8V4RQoC4rAOZo10C6wcJcZh
gjJXMdGqd7GhqCk417TLlSIzALkVWQ4dkcZEYX1hKMXDA0aotzxulFeo6xnIp0/2
2FpjYt1JTzhHjjTz51VeRgzgVaJUyGhTax3KhNP/lpe2DdwsPbuph7vZYhbXl64X
ONzSPz6sAdCEnTYI+dFKL8NVOixF85dg0B9AXhjpDEBMZH3sZSsq3x7iiA5YqvKN
X1X8ybaY7mSbUP/NXPfm
=cwCR
-----END PGP SIGNATURE-----

--IF6RlF1po3a6ELaf2BQ7VmR1gXOOqgxNT--

--===============1332999579291191729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1332999579291191729==--
