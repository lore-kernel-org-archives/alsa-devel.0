From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] Audio: SST: use lock when changing
	SST state.
Date: Fri, 31 Oct 2014 12:48:40 +0000
Message-ID: <20141031124840.GV18557@sirena.org.uk>
References: <1414739301-12659-1-git-send-email-vinod.koul@intel.com>
 <1414739301-12659-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6901343609691575928=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71A352658FD
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 13:49:02 +0100 (CET)
In-Reply-To: <1414739301-12659-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Mythri P K <mythri.p.k@intel.com>, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6901343609691575928==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E+zqmlIEIVYE0XqN"
Content-Disposition: inline


--E+zqmlIEIVYE0XqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2014 at 12:38:21PM +0530, Vinod Koul wrote:
> From: Mythri P K <mythri.p.k@intel.com>
>=20
> SST state change should be done under sst_lock

Applied, but *please* try to use subject lines reflecting the style for
the subsystem.

--E+zqmlIEIVYE0XqN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU4UnAAoJECTWi3JdVIfQWmgH/iRFq5NejWBvJL1uIjKz1CBS
4yS0dbbTkYlbHljpQUCk4J2s/UgvIuTH1Yi9HPgBMVJAXI1oq0Z5l/rzXcR7enrW
EbvG+opQ+g2c1VY+jdPQ6BzxycR5gsO4lcTqWab/5h1MZQppTTEzzem1SxntSxkS
axhb5M/3LE52qLRWOemvZjxLYXpftD8exhRN65ks0zAjESjtVJYv7fkdgLeHjWLE
INIbp/apAsefCwc5c8oOuKN06saA/7xapQK7NDQ2zuhYcOOMIS7MEBjizKnMiDE6
wnaaom6L6zpf572kvGyZnXJH5znze/ABmPmrZvtrVFIVQdhOYJjKDftB7LkPz20=
=fK+h
-----END PGP SIGNATURE-----

--E+zqmlIEIVYE0XqN--

--===============6901343609691575928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6901343609691575928==--
