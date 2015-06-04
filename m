From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ALSA: split params refinement to
	seperated file
Date: Thu, 4 Jun 2015 20:15:48 +0100
Message-ID: <20150604191548.GR14071@sirena.org.uk>
References: <1433429265-22054-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3867515137754577452=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 965352606C8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 21:15:55 +0200 (CEST)
In-Reply-To: <1433429265-22054-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, vivian.zhang@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3867515137754577452==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j5904Piqecmxrsp+"
Content-Disposition: inline


--j5904Piqecmxrsp+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2015 at 10:47:45PM +0800, Jie Yang wrote:

> The change moves refinement functions from original pcm_native.c and
> pcm_lib.c, to pcm_refine.c(similarly the declaration from pcm.h to
> pcm_refine.h), so it is not so big as it looks like.

I'd suggest that for review it'd be easier to have one patch for the
move and another for the change in behaviour: it's a bit hard to find
the actual change in what the kernel does in this diff and that's the
bit that needs most careful consideration.

git format-patch -M may also help.

--j5904Piqecmxrsp+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcKPjAAoJECTWi3JdVIfQO+YH/3/8+F0AYP5bJ4rTq4zuWa+3
LdZk0xWtZ3wvcCjuijGFgfwwsh67FeXUXQ3Pp1Y3nT4vFvzELzag6F+MyU3aK6wr
VrsCrKbcSZAY2p6rD2xINXaoJBpBeOCOHV8BKMrvhc9CPo5oWp4mhk7SID1P1Exp
qyWZqvZazzeh1Ava7sJZQK/Yoe5PV1EfyX8c7ZK8UAeUV0AKSweYRiyGAS2MDglh
SNAUQSP9Vv3DTv077dBOdVgyOgjv6GdTW4PNt/MhHKOiVu/UKXY4cm1csWhKou9E
y4lZFcOrTAgsE4kmeq/rrfI29aQgAuKKhm8w7dmFgNFO8CSarkwSAOnSVSq27Gc=
=HOdr
-----END PGP SIGNATURE-----

--j5904Piqecmxrsp+--

--===============3867515137754577452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3867515137754577452==--
