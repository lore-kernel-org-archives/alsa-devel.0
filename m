From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: atmel-pcm: split into two file
Date: Sun, 2 Dec 2012 13:28:27 +0900
Message-ID: <20121202042826.GV17981@opensource.wolfsonmicro.com>
References: <1354074373-7671-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BrzieSmlpF6NDzIw"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354074373-7671-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--BrzieSmlpF6NDzIw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2012 at 11:46:12AM +0800, Bo Shen wrote:
> This patch is split original atmel-pcm.c into new atmel-pcm.c and
> atmel-pcm-pdc.c two files. The new atmel-pcm.c is the share routine
> while will be used for pdc or dma transfer.
>=20
> Using SND_ATMEL_SOC_PDC to select using PDC for audio transfer

Applied, thanks.

--BrzieSmlpF6NDzIw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutjgAAoJELSic+t+oim9qyAP/iH4LLXOch+7SmtF5r2f98SM
ZP5NGGCgPW70G9gkVVsDWpVRk7upmn4/AtRP5EtLaXQdgIi8ZiOm3tkx2Bv4jeHs
jSGsL2Cf22JpCVihNCWKHtAmCfDQXMBc1MEVMqaxY9b1JFCn2kNeF5I/z/vXzvXy
0PgRb+JS2NJVa/ie9BbU3U8vZr8cfevWsWVeMzTc9ql3fgZx480zdQ9zBeBHrV5N
AkZyoVxgSF9qYSnB7MPZiE8dt2F/gAu0UJfO5OOI176zXXzOe5CENCgl7B7QXIJm
9iAwZsXgjwq62iersyEj972+CWB+dcr5THPocoivdSWbZrgu2pp+rvYD1cv97mzy
AwiXTy7aeX+wdzjoHQMIOqhZhmgPNI23jOS/0o0DG08YwTFo1wwu6F5nyfxim3t9
n85gL27hy8kpgU3gTt5tTied6UPCRRaKHumDEpogO1E7MX/mDOcNE1IUXcHX5/qB
obAL+PTJo5cpxmjlLNZNPc3gvfegDc5Xoy4/pA7gV7qsAuP9WnKM3TcakAK6gbXn
nEMFAyKYerkC30MQ8DqGdtXFN5/PefIhs76ghCMhp7GtYIwEI624W7vSkr4L6ahH
fZXuaRawbkZmOubQfwgwzXp5e+wFbFxaDjsuWtO/cYj79UFW2NdQLTo+ceK2qUfI
orKbk5kZYPGMj4IVJXNA
=I+BV
-----END PGP SIGNATURE-----

--BrzieSmlpF6NDzIw--
