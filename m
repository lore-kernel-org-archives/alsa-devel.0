From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 4/6] ASoC: Intel: mrfld- add ACPI module
Date: Mon, 10 Nov 2014 11:48:31 +0530
Message-ID: <20141110061831.GB18555@intel.com>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-5-git-send-email-vinod.koul@intel.com>
 <20141106124349.GB8509@sirena.org.uk>
 <20141106130909.GC1870@intel.com>
 <20141106134426.GI8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4591456391509020435=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 889222605D6
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 07:18:12 +0100 (CET)
In-Reply-To: <20141106134426.GI8509@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4591456391509020435==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 01:44:26PM +0000, Mark Brown wrote:
> On Thu, Nov 06, 2014 at 06:39:09PM +0530, Vinod Koul wrote:
> > On Thu, Nov 06, 2014 at 12:43:49PM +0000, Mark Brown wrote:
> > > On Tue, Nov 04, 2014 at 04:25:18PM +0530, Vinod Koul wrote:
>=20
> > > No, we should be able to build a kernel which runs with or without AC=
PI
> > > - make this a runtime check if it's required (a comment might be in
> > > order too since this is a weird thing to do).
>=20
> > yes that is doable by adding a parameter and setting that in specfic pr=
obe,
> > will add.
>=20
> There's a variable acpi_disabled you can check.
Thanks, thats a very good suggestion indeed :)

--=20
~Vinod

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUYFi3AAoJEHwUBw8lI4NHOhgP/3zWlFD62ETyjZmi3SN2U6PS
1mxdkEOpuK/RzjIfMDK7VlhuY2FzhjAy5RGB9h63ndXXPwvZcJ2l6PSGyEB6Kb7h
/wCf692B0OrXa3eIHm9A9O+u1ksuqCfi9Pi9eWK1kWlwfz8wUL+pKUpzavQy3vUy
TE2Ivl+zKbE5vs0JFRUlmK/7WCblccrndsJihRSix+o1Zw+H9EiLx/kiC8ZhuVzl
S+LVIbKO7Ue59j3MIQowBctRCihFlwogcuVBijxRC1Y+AdeadLFD2DGHCOBPHSCj
lFqH4PwXegL0bPMH3+ys9vp4HSbBgZkF4S6NqEGKtdI5aAjUptvYX/ADZcB719HD
VU1FLZgAO44z4qoaBbHbJNGdA4m8xIMxKQ/AMDOoziOphb4WZyzLw5wXcsUBaDEa
4t3b/vKgUfmNk2OPq3AqE57co5mIyuTPAhl4lG7OrPU10E6ZOyRK23rZoFqUCEWu
BTnGUGf4uNDwWw8MHE4OIPGAAL53la2yYgCrAAKAvuU8Ib5oKKQAQU6TfbtsTqgp
gVn0R12VeTXltTDXkcKYKZLFAmv1MkN8ixqVNPf3CjkbC3bOmfNXm7Z2YSupmpsE
Po+ydeQfZWD7wHv/6smzP/boeka0cdBRIY0DwwKxqkQjbQgS6b1ZnhJ/6r0TBRB5
urkT1u0JfhHkv+YUfvXC
=c5n4
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--

--===============4591456391509020435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4591456391509020435==--
