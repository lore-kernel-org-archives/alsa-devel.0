From: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: Quality resampling code for libasound
Date: Mon, 19 Feb 2007 14:11:25 +0100
Message-ID: <200702191411.25988.prakash@punnoor.de>
References: <45D92131.50601@usherbrooke.ca> <s5hirdy72ue.wl%tiwai@suse.de>
	<45D99DF7.90204@usherbrooke.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1406151911=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45D99DF7.90204@usherbrooke.ca>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1406151911==
Content-Type: multipart/signed; boundary="nextPart2307288.7DasY7T2X7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2307288.7DasY7T2X7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 19 Februar 2007 schrieb Jean-Marc Valin:
> >> The quality is similar to what you get with libsamplerate, but the
> >> license is BSD, so there should be no issue using it within libasound.
> >> There are 11 quality settings (0-10) and even the lowest quality
> >> provided is already miles better than the linear interpolation current=
ly
> >> being done (which creates insane amounts of aliasing when doing things
> >> like upsampling from 8 kHz to 48 kHz). I'm also willing to help whoever
> >> is interested in adding support for it.
> >
> > Basically I'd like to keep the default resampling code in alsa-lib as
> > simple as possible.  So, I recommend you to impelment this first as an
> > external plugin in alsa-plugins package just like like libsamplerate
> > one.
>
> What?? I hope you're joking here. It's one thing if you don't want my
> code for a reason or another, but being happy to keep things as they are
> currently is just insane. What libasound does is not resampling, it's
> audio mutilation, plain and simple.

ACK

(scnr)
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2307288.7DasY7T2X7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)

iD8DBQBF2aH9xU2n/+9+t5gRAvnfAJ9mIOkjGI3JiL3a+4p7LgD31yHk4gCffS5x
iyK5TxOOubzt/N3f1Il4Vcw=
=KJKl
-----END PGP SIGNATURE-----

--nextPart2307288.7DasY7T2X7--


--===============1406151911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1406151911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1406151911==--
