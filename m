From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: Intel: Make ADSP memory block
 allocation more generic
Date: Wed, 22 Oct 2014 10:07:36 +0100
Message-ID: <20141022090736.GG2344@sirena.org.uk>
References: <1413814012-5619-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20141021230224.GF2344@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3151630639041554530=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F353B26060F
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 11:07:59 +0200 (CEST)
In-Reply-To: <20141021230224.GF2344@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3151630639041554530==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2014 at 12:02:24AM +0100, Mark Brown wrote:
> On Mon, Oct 20, 2014 at 03:06:46PM +0100, Liam Girdwood wrote:
> > Current block allocation is tied to block type and requestor type. Make=
 the
> > allocation more generic by removing the struct module parameter and add=
ing
> > a generic block allocator structure. Also pass in the list that the blo=
cks
> > have to be added too in order to remove dependence on block requestor t=
ype.
>=20
> I'm having trouble apply this - patch 1 manages to apply with some fuzz
> but patch 5 is failing.  Probably needs refreshing against Vinod's
> recent changes?  I applied everything up to patch 4 (ASoC: Intel: Add
> runtime module support).

I had to drop these since the 0day tester found several build errors
(possibly ones that'd have been fixed when the full series was applied
or conflicts with Vinod's changes).

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR3PYAAoJECTWi3JdVIfQtOkH/10+JS147BS9n7pPN5SBKMTg
y1b3Fa+LVKj48BY0mvF04ulzpeOFyytaKidS7+Cckp3NAYUCTEoLPU1nNhTw+gPC
EmZ6FlhNmfuFGg+HT682XfBq4j1BHRhtuO0YENIsghf/mmh6C2293j1kx1ORfmmP
16Yj/G4H3dxRFx1XHhZDH41CsyPNBSwZBF4D/DO4hvp4pEhgSMqUFCijmFw/2P01
MPQGB3tBkKTu7EmDgxL8RLLvpTlD1FcRy6g+oG4Ga4bKO+yNJUIonzYSql7i7L2R
T1D35X5huoFgP4ic2+rztrNTSQPq0uQXvU6fjz/KphHjqRlxjChZt7xCFlT9vmE=
=lEj7
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--

--===============3151630639041554530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3151630639041554530==--
