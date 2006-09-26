From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: 1.0.13rc3: relocation error: mocp: symbol
	snd_pcm_hw_params_get_channels_min ..
Date: Tue, 26 Sep 2006 22:13:19 +0200
Message-ID: <20060926201319.GA3067@samweis.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1392602714=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>
List-Id: alsa-devel@alsa-project.org


--===============1392602714==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I am testing 1.0.13rc3 (lib/driver/utils) on PPC/2.6.18

Starting a soundapp like moc gives:

"relocation error: mocp: symbol snd_pcm_hw_params_get_channels_min,
version ALSA_0.9.0rc4 not defined in file libasound.so.2 with link
time reference"

Any hints?

Elimar

--=20
  On the keyboard of life you have always
  to keep a finger at the escape key;-)

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFGYnf3Ig8bsVPf7ARAt+OAJ9gkEZQot770JcTbKdmnHwiJWzIiACfeF5w
2ouW9wwPBd4qjCGVihBq1oI=
=HSY6
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--


--===============1392602714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1392602714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1392602714==--
