From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: wm8960: correct the max register
 value of mic boost pga
Date: Sat, 19 Sep 2015 07:50:38 -0700
Message-ID: <20150919145038.GP12027@sirena.org.uk>
References: <4c1fe5d2fa0ae6cf85e9be8b3b8a52feaae7d75b.1442566367.git.zidan.wang@freescale.com>
 <119b66684faaf7ff237dfccc864ec8e0561aefd3.1442566367.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5397644670868741994=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AEE626064F
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:32:10 +0200 (CEST)
In-Reply-To: <119b66684faaf7ff237dfccc864ec8e0561aefd3.1442566367.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5397644670868741994==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o2wwDLzH3PLiMjn3"
Content-Disposition: inline


--o2wwDLzH3PLiMjn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2015 at 05:19:43PM +0800, Zidan Wang wrote:
> the max register value of mic boost pga should be 3.

Please don't send random unrelated changes as a single series, if the
changes don't form part of a cohesive whole either working on the same
code or doing the same thing then just send a number of separate
patches.  This makes lots of parts of the workflow work better since
people won't assume interdependencies that don't exist.

--o2wwDLzH3PLiMjn3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/XY+AAoJECTWi3JdVIfQFb8H/3MOuXBAU86xuKV5Gr8NhFZt
YJxEZ/203AYEh2k1D4yzsu0ITd3hXKuMFq9S5FRef7ruHBmpo8rU3rv064HToy7W
qtDKtLtlgguFFDGwooBGFnYURJCLMczCwVu0ZWg4QIMGKnebWTigaD8bSxmFxZ3Y
aYhpl8wjyTotuTBee3IFI5iWbYfYbd+KNkGyAGQSEzjOyo/NJJWJZuTUjJeDoy2z
6zVMClVjZ7ic3DP5QMqWdDeRlWEosCu+JnC6IbOS/lNPC/CXO1NU1Chu8dm28M0X
oovFsC1q1sIlFTBhakYG0lex8oa+6Elx59zXRmDVxKxpRDILhE/okd05k5LREc0=
=zqM0
-----END PGP SIGNATURE-----

--o2wwDLzH3PLiMjn3--

--===============5397644670868741994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5397644670868741994==--
