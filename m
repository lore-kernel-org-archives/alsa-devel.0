From: Jordi Mallach <jordi@debian.org>
Subject: Re: Old Debian patches
Date: Mon, 23 Dec 2002 17:43:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021223164345.GA11122@nubol.int.oskuro.net>
References: <20021221151722.GA26363@nubol.int.oskuro.net> <s5hvg1ku8bk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hvg1ku8bk.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2002 at 03:19:11PM +0100, Takashi Iwai wrote:
> thanks for the patches!

Thanks for reviewing :)

> > > After initialisation of ALSA version 0.9b12 the depmod complains about
> > > problems in snd-isapnp module.
> > >=20
> > > The following patch should get rid of the problem:
> >=20
> > --- isapnp.c    Sat Feb  9 19:30:13 2002
> > +++ isapnp.c.fix        Mon Apr  8 11:18:13 2002
> > @@ -2094,7 +2094,7 @@
> >  static void isapnp_release_resource(struct resource *res)
> >  {
> >         if (res) {
> > -               release_resource(res);
> > +               isapnp_release_resource(res);
> >                 kfree(res);
> >         }
> >  }
> >=20
> > We never got feedback from the user when we took over ALSA, so it was
> > never applied. I don't know if it's needed/valid.
> apparently this will cause an infinite loop, won't it?
> i haven't seen any isapnp-problems on my 2.2 environment...
> so, skipped now.

Ok. As I said, I've asked the submitter to check against recent alsa
verisons and never got new feedback, so we'll just close the bug. If
it's still there he can always reopen.

Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Bz1BJYSUupF6Il4RApPYAKC21D5953Ce8xREaRIQURrPszbHtACfa/sk
026imkIjb9MnulZRpAnmTbE=
=ajNz
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
