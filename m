From: Henrik Austad <henrik@austad.us>
Subject: Re: [very-RFC 5/8] Add TSN machinery to drive the
 traffic from a shim over the network
Date: Sun, 12 Jun 2016 10:34:32 +0200
Message-ID: <20160612083432.GC32724__9775.89717736027$1465720511$gmane$org@icarus.home.austad.us>
References: <1465683741-20390-1-git-send-email-henrik@austad.us>
 <1465683741-20390-6-git-send-email-henrik@austad.us>
 <1465716910.25087.88.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1436688604006104642=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1465716910.25087.88.camel@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: henrk@austad.us, linux-netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Henrik Austad <haustad@cisco.com>, alsa-devel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============1436688604006104642==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 12, 2016 at 12:35:10AM -0700, Joe Perches wrote:
> On Sun, 2016-06-12 at 00:22 +0200, Henrik Austad wrote:
> > From: Henrik Austad <haustad@cisco.com>
> >=20
> > In short summary:
> >=20
> > * tsn_core.c is the main driver of tsn, all new links go through
> > =A0 here and all data to/form the shims are handled here
> > =A0 core also manages the shim-interface.
> []
> > diff --git a/net/tsn/tsn_configfs.c b/net/tsn/tsn_configfs.c
> []
> > +static inline struct tsn_link *to_tsn_link(struct config_item *item)
> > +{
> > +	/* this line causes checkpatch to WARN. making checkpatch happy,
> > +	=A0* makes code messy..
> > +	=A0*/
> > +	return item ? container_of(to_config_group(item), struct tsn_link, gr=
oup) : NULL;
> > +}
>=20
> How about
>=20
> static inline struct tsn_link *to_tsn_link(struct config_item *item)
> {
> 	if (!item)
> 		return NULL;
> 	return container_of(to_config_group(item), struct tsn_link, group);
> }

Yes, I mulled over this for a while, but I got the impression that the=20
ternary-approach was the way used in configfs, and I tried staying in line=
=20
with that in tsn_configfs.

If you see other parts of the TSN-code, I tend to use the if (!item) ...=20
approach. So, I don't have any technical preferences either way really

--=20
Henrik Austad

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlddHpgACgkQ6k5VT6v45lmHfwCg/nSndGOel1ARBcWyifH89EA2
M30AnjjQkKDyREGszIp8dqDX0uodW0Km
=dEZu
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in


--===============1436688604006104642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1436688604006104642==--
