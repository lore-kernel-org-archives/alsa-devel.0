From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: wm_adsp: Interpret ADSP memory
 region lengths as 32 bit words
Date: Fri, 1 Nov 2013 10:47:15 -0700
Message-ID: <20131101174715.GP2493@sirena.org.uk>
References: <1383321417-1133-1-git-send-email-dp@opensource.wolfsonmicro.com>
 <1383321417-1133-4-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1737485813500166185=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 21F0D265049
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 18:47:28 +0100 (CET)
In-Reply-To: <1383321417-1133-4-git-send-email-dp@opensource.wolfsonmicro.com>
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


--===============1737485813500166185==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oDT6ON1uLKeoILhE"
Content-Disposition: inline


--oDT6ON1uLKeoILhE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2013 at 03:56:54PM +0000, Dimitris Papastamos wrote:
> From: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
>=20
> Pad the ADSP word (3 bytes) to 4 bytes in the kernel and calculate
> lengths based on padded ADSP words instead of treating them as bytes
>=20
> Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
> ---

If you're forwarding someone else's patch you need to add your own
signoff as well.

--oDT6ON1uLKeoILhE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSc+kUAAoJELSic+t+oim96JAP/RSCBKreVKyiUJy/6PyItb8/
ESzDnfc0doZrvC7sHbrv+Zttb/0FXtLqWlJJiXbx/BhrHm7EVcI5POoY+oafWtol
RupHGVVYJSR7IcYGkIYXmTkj39O7eNzlnH3pI6HiAYPm7leLC44hR7FAy3Qo8/JA
/gO4GfF8satqrS5ifv9m9hmMv/J2TIWRAA40VkYuWDcqFf/W9MaNBcQDeTrcOeoT
rF8Sde9/txfhlOHxSgo0RRga2gJ7fh+S9d39ATO1wJeW4fI2LagNP/QlCiA8mYIx
iyPWnWTmZOydGMmHTe5/J46deq+G2DB7l85OOsl2j3uG9nTp/uqsT8EJr7WyHzbS
REubHcOp3xl2xXygVLUeb5yLWLe8u3kWMkOJG9WENum9As771RwQyWLhngvE2S1M
PN8GhcH5LO+MH9IxPFb6CxeyfTaLIU2kSzrkUmdoaC7Lf3LUbcPYma4FGMsvUfjY
GHXm4m3s2h1LHlPd6kTrTfQv+Mt4nSzDgcf3gUhx/LwMHTFeekGv1xx4bU9vWwRB
UgU2OI4hjYbUCCPMfb4QlCReXErx7vqC7LAB+/A8UF3jcOZt7mNaN43Qr9HJIi7N
O9umpmr1QUFDKcf4C4IufIXuThA5j65GODBTFBUfoXny1Z9EI9UvndjD2YI27p4v
wR0+57RYMPpa5tJVni/w
=7l4h
-----END PGP SIGNATURE-----

--oDT6ON1uLKeoILhE--

--===============1737485813500166185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1737485813500166185==--
