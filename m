From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc-core: make kernel complaints on
 -EPROBE_DEFER dev_dbg
Date: Wed, 9 Nov 2016 15:22:09 +0000
Message-ID: <20161109152209.dzejborw53no26ew@sirena.org.uk>
References: <20161109140036.GB20859@localhost.localdomain>
 <20161109143642.7knvr63vwmcgunjf@sirena.org.uk>
 <20161109151426.GA21280@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3732377376898091345=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AEB9B267097
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 16:22:25 +0100 (CET)
In-Reply-To: <20161109151426.GA21280@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3732377376898091345==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t4vv5ikst5culyff"
Content-Disposition: inline


--t4vv5ikst5culyff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 09, 2016 at 04:14:26PM +0100, Ladislav Michl wrote:
> On Wed, Nov 09, 2016 at 02:36:42PM +0000, Mark Brown wrote:

> > No, errors are errors and not displaying them just makes it harder for
> > people to debug things.  If you don't want to see errors just change
> > your system configuratiion to hide them.

> For sure I want to see all errors, but this is not hardware error nor
> kernel misconfiguration, so showing it to the user is a bit pointless.

How do we know that it's not a kernel misconfiguration?  It's common for
people to not build some of the component drivers they need.

> > If you don't like deferred probing please contribute to the efforts
> > to order probing.

> I just tried to make it consistend to other subsystems where patches to
> silence deferred probing warnings are accepted...

Which subsystems are these?  We should look at fixing them...

>=20
> > Please use subject lines matching the style for the subsystem.  This
> > makes it easier for people to identify relevant patches.
>=20
> I wasn't aware of it, sorry. Will fix it next time.
>=20
> Best regards,
> 	ladis

--t4vv5ikst5culyff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYIz8gAAoJECTWi3JdVIfQ+TMH/3sMYX2pkRcdGeJ/VHP55XJn
H/Z17Ty5/PXchg72lGRGzJG+rZTFFgW8NbbgzCu4SCFaOFEQ+gjAPhVRUMP0lImx
s3XFnIeC0X5sOJ5G4e0eOvUcXlygc1fK+3ftzh91rqMrii1wZpnZq447P4C+RgEf
4FtfEksDsBZ4mIAGi8e6SAkgxSFBFK+LnUoRlycrEXmrLc+8tRRov+TyZxli9BmI
rWfptai73fWzEen2LgW4cgna0tR2QP01UsIjRkwnqxprkYriZhjQf9mKGl0kjXvW
weZeDX36UkKf5Vik19HGaHufp9W6yCjylKmBiKc2rfUS6TYFfwE6h7OsCzo4eiQ=
=uXfk
-----END PGP SIGNATURE-----

--t4vv5ikst5culyff--

--===============3732377376898091345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3732377376898091345==--
