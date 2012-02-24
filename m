From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Q] ASoC: What's the real meaning of
	SND_SOC_DAIFMT_NB_NF?
Date: Fri, 24 Feb 2012 11:20:39 +0000
Message-ID: <20120224112039.GA5450@opensource.wolfsonmicro.com>
References: <CACKLOr1sDSEFCiAsRO-vKrk7f+r=_Ex9irog1NKDmXn7LJFCDw@mail.gmail.com>
	<20120223151934.GB4553@opensource.wolfsonmicro.com>
	<CACKLOr23+DPp=XZ=RJEPgKYyvw3UOxkWR8xtzYG9Y9NWcicJSg@mail.gmail.com>
	<20120223161446.GA7245@opensource.wolfsonmicro.com>
	<CACKLOr10yUYpMSrebnLvMkc=XQLUXNDxwM+P6U8ysH_Xre3Tmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1729454940740570320=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3AACF2455F
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 12:20:42 +0100 (CET)
In-Reply-To: <CACKLOr10yUYpMSrebnLvMkc=XQLUXNDxwM+P6U8ysH_Xre3Tmw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
List-Id: alsa-devel@alsa-project.org


--===============1729454940740570320==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 08:53:11AM +0100, javier Martin wrote:

> In the piece of code I've shown to you, when someone configures
> (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF) he's really selecting an
> active high frame clock when the standard says just the opposite
> (wm8974 datasheet p50).

> If I fixed the bug in the SSI I would break both of them, since I
> would be changing frame clock polarity.

No, with I2S the main effect of inverting the frame clock is to cause a
left/right swap which is a relatively subtle issue, it's not obvious on
an immediate listening test.  It's not really active high or active low
but rather indicating which channel the sample is.

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPR3J9AAoJEBus8iNuMP3dH3sP/jhLEfIUsZGavmkYc5/nWzpv
GbaNmdQUtBWPNxlLqSp9btfLdfP3WVH0mlRgRO1ShHgqs5TOqKYMMA4wfMDdnS8p
bUyyetbsKgfI64X752SskkoIRfbg3f2ykKDkOb428CQoWYxQwelIaGKclxXdYq8v
SYURQ9eleH0NRT6tgUKfpzLVXJ1kRRVHin3XC83y2YcREjuCUL4z+RXUxbl0xrH0
YQ0fz48FQ4MmRWN4jahp3ky8bQ9H669OFnvcNanVINWxnSWziOOr9uRlt2jYQghe
iYqe4LN51X5Ug9DmxBHkDZZFA+hm2TAEUBU4E9cidZ8WNUWmw9aovi+r0q4ohi3u
WkZXY0m2YucOyIKJIrcpIySxcKaKqhBHgLb6Oy1iPl6QvgGKomPftp/HXXXal6k7
XaAuz1RJqPq4hzepdeUopwBTYdai/vw3Q84/RrRXQlnfBXa36SS7FH85tVMi3XPE
G9WLEnWE0KMOJkdXquy+0VRdPH7KB5QLSNgPySXdp1weMW3lAIncHKdDTu5ZS4Ab
VM8aJ2yeJZIZTpM33i1WH2LteQOI2zI13/2732Uh/FZgMKu/HFBgO+NAQza49OM7
1FmbnQSOW+Hz/fJZQoSlfyQUsUR9LPyNx7wFuLvcb/i82LHKiFkMO7MS6PFQpjFo
EahXq8mDJUVesOUqz00N
=EDnc
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

--===============1729454940740570320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1729454940740570320==--
