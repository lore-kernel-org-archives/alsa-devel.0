From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Fix mono
Date: Tue, 29 Jan 2013 10:01:32 +0800
Message-ID: <20130129020128.GE4748@opensource.wolfsonmicro.com>
References: <1359134360-25482-1-git-send-email-benoit.thebaudeau@advansee.com>
 <20130126085512.GC30594@opensource.wolfsonmicro.com>
 <1343658253.242147.1359209821129.JavaMail.root@advansee.com>
 <20130127025844.GC4650@opensource.wolfsonmicro.com>
 <1064296906.226931.1359407020092.JavaMail.root@advansee.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0399828384104900856=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 860B6265B5F
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 03:01:46 +0100 (CET)
In-Reply-To: <1064296906.226931.1359407020092.JavaMail.root@advansee.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0399828384104900856==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2013 at 10:03:40PM +0100, Beno=EEt Th=E9baudeau wrote:

> 1) snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
> -> all DAI formats: wrong sample rate for L/R, playing twice too fast

> 2) snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffe, 0xffffffe, 1, 0);
> -> all DAI formats: nothing on R, wrong sample rate for L, playing twice =
too
>    fast, plus loud noise superimposed for LEFT_J

Why are you having to call this in the first place?

Anyway, I guess we do have a hardware limiation here so I'll apply the
patch when you resend it.

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBy1hAAoJELSic+t+oim9dPoP/A7aJ+PITYLsppqWvk2Kpcff
cCclEDXcNp3MpOdU22zyD9uUa0zYZkZkRaooq2c6DrIZKUzIVBd3O5FuAPxOUVxp
7ifuBdzIYDp+ResqovM+0TyegFthiIu003/YUs5RfADZY+t15kd4zJ/QjhEw0/aL
pZ0jU3zURRdBoukwbhT4okkoqYj2YBJsDHyYYqPlR4r9uGoJO2t8j/n3Wp/IaN9m
x5/lkVqiaW20XvU8BvoqTCtfRMTOtY/D3upHZ0s7fkImDoBH4LBg0GvbNUQzZ6yu
EOMvMbZ1ruJLFLUJGTQgT4iENzC2jokzla/9RQIgN/6nOE1Z2Tri17sYJjVhBfxB
/SKCsDf+5pvqGGbYQHmPCn/idxswKnI/PdmEWEClpJjJ0esGyO7Kh5QpXkf0TwEg
1jdT2fEB/M7D2fX3rETTAZlLmosidmB6RbXZtwSUYVC0i4qlPnCxlpSokfiHf+Po
eO33lareXVEpoURJ2MFjLZbtu4DlnW6d/zIslZjNI+zlB27w/wCYT2nxmJQH+qhF
r4qWTUD4M5BD7frxw1I7xmYIV4hjm/RqntxmDSYBXRaodx/ZHnafbWOL6ub43a2E
q8ykIy0RBGmaeAArselpI8y4kmtp6b7BJ8+vtVISSx7rWQknIuj1CUvi8wez5yf9
/gpa6uwx9E2nZvG9Xs/i
=2Znz
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--

--===============0399828384104900856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0399828384104900856==--
