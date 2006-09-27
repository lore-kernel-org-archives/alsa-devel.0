From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: 1.0.13rc3: relocation error: mocp: symbol
	snd_pcm_hw_params_get_channels_min ..
Date: Wed, 27 Sep 2006 20:07:56 +0200
Message-ID: <20060927180756.GA5202@aragorn.home.lxtec.de>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
	<Pine.LNX.4.61.0609270841040.9340@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1085959831=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0609270841040.9340@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1085959831==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Sep 2006 the mental interface of
Jaroslav Kysela told:

> On Tue, 26 Sep 2006, Elimar Riesebieter wrote:
>=20
> > Hi all,
> >=20
> > I am testing 1.0.13rc3 (lib/driver/utils) on PPC/2.6.18
> >=20
> > Starting a soundapp like moc gives:
> >=20
> > "relocation error: mocp: symbol snd_pcm_hw_params_get_channels_min,
> > version ALSA_0.9.0rc4 not defined in file libasound.so.2 with link
> > time reference"
> >=20
> > Any hints?
>=20
> What is output from commands 'nm /usr/lib/libasound.so.2 | grep=20
> snd_pcm_hw_params_get_channels_min'=20

nm: /usr/lib/libasound.so.2: no symbols

> and 'nm mocp | grep=20
> snd_pcm_hw_params_get_channels_min'?

nm: /usr/bin/mocp: no symbols

Elimar

--=20
  Experience is something you don't get until=20
  just after you need it!

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFGr383Ig8bsVPf7ARAoCzAKCGIPPp5kNYJqQO1JAI71P5Em9eSwCgnrEh
YzHRuOayov+GiGtc/rzfyAU=
=XMRL
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--


--===============1085959831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1085959831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1085959831==--
