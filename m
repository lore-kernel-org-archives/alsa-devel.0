From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] pcm_ladspa: add support for softfloat
Date: Wed, 7 Jan 2009 05:12:06 -0500
Message-ID: <200901070512.07648.vapier@gentoo.org>
References: <1231322810-5973-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6846265755426805989=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id E08441037F5
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 11:12:09 +0100 (CET)
In-Reply-To: <1231322810-5973-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: cliff.cai@analog.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============6846265755426805989==
Content-Type: multipart/signed;
  boundary="nextPart2525498.z53MdESyQz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2525498.z53MdESyQz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 07 January 2009 05:06:50 Mike Frysinger wrote:
> The ladspa module uses math functions unconditionally which breaks when
> building with --with-softfloat.  Tweak the code to only call the math
> functions when HAVE_SOFT_FLOAT is not defined.

bah, i'm not used to our alsa guy actually talking to upstream (since the l=
ast=20
one didnt).  guess i'll sit back and let you handle things since you're muc=
h=20
more proactive :).

so please ignore the last two patches from me ... Cliff will take care of=20
things.
=2Dmike

--nextPart2525498.z53MdESyQz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJZH/3AAoJEEFjO5/oN/WBh5kP/2BbJSbeMXjE5S0OxCi+OIIJ
/vXJD2P/G0d41a0QCHTKBHhQwTFJ2G73oqkY7p1vNoqOKZjWxyMGjbpuOBqtkm2Y
tV1zy8crEQ8o3uRbdC4DgFizDBSUCnayxg/PahI5de+TyG1FTC8GSHmSja2yMT5A
Z6xhYyI6vHO1YJp1CQhTu94E6KGCP8LmqA6+hQ4Q8RDfGcoKzIv5Fre3l+Bd6SEZ
N4NM6hzrfXnzOyIdtgPTVuVhuaKUrdDHg5cqCG2ONj6cmIozTRmAHWXpE72Xh0Ii
50bf5crr9Z/p3V1i9UjZV8c9FzXgaH4tb1RzNj8yMQmW092Z3zr3CdEfTQnXHWqo
hq+k8K5i65ar48pvKuLgQarypsUOwVW3K7B3YIYSLQLE+Hdfr8IwGhAJHJKhSkYu
RpXzxGmqSiwJ2j1cvwdZ1couweTotsg+JoqePm6/LWGnqFUPDU9pQvftbe8mT7Bi
vLDqO20NcH9otJ8bM9BMHOU/pqYwBjEas452RV8a3Wcx6kVDEIczh2CYjvfA41S6
vGtTZUYt2NuFtuXjz01T6ae+rIC8zLMeb/LHXi9b2f9vBd7TUXtIOjwRji3Bh1Ef
laQKAxdLPbrEH5osftHX9qMOZAxcxOdZAnxOdNGBIsUuC9YXoeDMnUM6kIJGXoqj
EGCIrTyLa+dyk7w3sv/J
=NB7y
-----END PGP SIGNATURE-----

--nextPart2525498.z53MdESyQz--

--===============6846265755426805989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6846265755426805989==--
