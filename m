From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: 1.0.13rc3: relocation error: mocp:
	symbol	snd_pcm_hw_params_get_channels_min ..
Date: Thu, 28 Sep 2006 20:44:36 +0200
Message-ID: <20060928184436.GB2855@samweis.home.lxtec.de>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
	<s5h1wpwpa49.wl%tiwai@suse.de>
	<20060928180207.GA2855@samweis.home.lxtec.de>
	<200609281416.41419.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1674406624=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200609281416.41419.vapier@gentoo.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: Takashi Iwai <tiwai@suse.de>, pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>, alsa-devel <alsa-devel@lists.sourceforge.net>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org


--===============1674406624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline


--cvVnyQ+4j833TQvp
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Sep 2006 the mental interface of
Mike Frysinger told:

> On Thursday 28 September 2006 14:02, Elimar Riesebieter wrote:
> > # readelf -W -s /usr/lib/libasound.so.2 | ...
> > __snd_pcm_hw_params_get_channels_min@@ALSA_0.9
> > snd_pcm_hw_params_get_channels_min@@ALSA_0.9
>=20
> so the question is where did your 0.9.0rc4 go ... unpacked 1.0.12 and=20
> 1.0.13rc3 and both give me the same list with the rc4 in it ...
>=20
> what version binutils ? =20

$ ld -v
GNU ld version 2.17 Debian GNU/Linux

> can you capture the entire configure & make output=20
> into a log file and compress it and post it ?

The output of
=2E/configure \
--prefix=3D/usr \
--mandir=3D/usr/share/man \
--infodir=3D/usr/share/info \
--datadir=3D/usr/share \
--build=3Dpowerpc-linux-gnu \
--enable-static=3Dyes \
--enable--shared=3Dno \
--disable-maintainer-mode \
> config.log
is attached.

THX
Elimar


--=20
  The path to source is always uphill!
                                -unknown-


--mP3DRpeJDSE+ciuQ
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config.log.gz"
Content-Transfer-Encoding: base64

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

--mP3DRpeJDSE+ciuQ--

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFHBgU3Ig8bsVPf7ARAi3YAKCMnwv27x5H2Hwc48kUaQ9tt5DpwQCgvutt
aiCiUrl7obDtiNDjAgxyebQ=
=ZO9Y
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--


--===============1674406624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1674406624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1674406624==--
