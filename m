From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: 1.0.13rc3: relocation error:
	mocp:	symbol	snd_pcm_hw_params_get_channels_min ..
Date: Wed, 27 Sep 2006 20:13:46 +0200
Message-ID: <20060927181346.GB5202@aragorn.home.lxtec.de>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
	<1159302210.2899.227.camel@mindpipe>
	<20060926204053.GB3067@samweis.home.lxtec.de>
	<1159304610.2899.231.camel@mindpipe> <s5hd59hqygh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0022249890=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hd59hqygh.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>, Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============0022249890==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Sep 2006 the mental interface of
Takashi Iwai told:

> At Tue, 26 Sep 2006 17:03:29 -0400,
> Lee Revell wrote:
> >=20
> > On Tue, 2006-09-26 at 22:40 +0200, Elimar Riesebieter wrote:
> > > On Tue, 26 Sep 2006 the mental interface of
> > > Lee Revell told:
> > >=20
> > > > On Tue, 2006-09-26 at 22:13 +0200, Elimar Riesebieter wrote:
> > > > > Hi all,
> > > > >=20
> > > > > I am testing 1.0.13rc3 (lib/driver/utils) on PPC/2.6.18
> > > > >=20
> > > > > Starting a soundapp like moc gives:
> > > > >=20
> > > > > "relocation error: mocp: symbol snd_pcm_hw_params_get_channels_mi=
n,
> > > > > version ALSA_0.9.0rc4 not defined in file libasound.so.2 with link
> > > > > time reference"
> > > > >=20
> > > > > Any hints?
> > > > >=20
> > > >=20
> > > > Application was compiled against a different alsa-lib version than =
is
> > > > present.
> > >=20
> > > This was my idea as well, but apps compiled with versions << 1.0.12
> > > are running with 1.0.13rc2?
> >=20
> > It's not guaranteed that using a wrong library version won't work.
>=20
> The backward compatibility is guaranteed.
> That's the very reason that such a versioned symbol was introduced.
> (And it was a big failure...)
>=20
> Please don't mix up the things about config files and the library ABI
> compatibility.  In a very rare case, the configuration file doesn't
> match with the driver version.  This happend once on emu10k1 (and
> people now think that it's a frequent case, unforunately, although
> we've tried to keep the compatibility of config stuff since then).
> But, the ABI is kept backward-compatible for many years.=20
>=20
> So, you don't have to use the same version of alsa-lib.  In general,
> the newer version is always better.  The newer one includes more
> bugfixes and new features.
>=20
>=20
> BTW, the problem here looks like a build of alsa-lib with versioned
> symbols.  Or, the app isn't linked to libasound at compile time, so it
> couldn't resolve the versioned symbols properly.  It's a common
> problem with versioned symbols.

The libs where build as follows:

=2E./configure --prefix=3D/usr \
--mandir=3D\$${prefix}/share/man \
--infodir=3D\$${prefix}/share/info \
--datadir=3D\$${prefix}/share \
--host=3D$(DEB_HOST_GNU_TYPE) \
--enable-static --disable-maintainer-mode

where --enable-shared[=3DPKGS]  build shared libraries
points by default to yes

Elimar

--=20
  >what IMHO then?
  IMHO - Inhalation of a Multi-leafed Herbal Opiate ;)
              --posting from alex in debian-user--

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFGr9a3Ig8bsVPf7ARAmnYAKCKB/0CqhcLUpmcu8zR0IwZNBRnuwCcCjFN
3oZUfO+OXpBNf9KAU83hSLE=
=qrwI
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--


--===============0022249890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0022249890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0022249890==--
