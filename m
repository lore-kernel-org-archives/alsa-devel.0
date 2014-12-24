From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: correct the fixed free block
	allocation
Date: Wed, 24 Dec 2014 12:14:23 +0000
Message-ID: <20141224121423.GT17800@sirena.org.uk>
References: <1419297165-28401-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5048853392087391235=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EAB6261490
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 13:14:38 +0100 (CET)
In-Reply-To: <1419297165-28401-1-git-send-email-yang.jie@intel.com>
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
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5048853392087391235==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tx2XG0Hc/yoUCMV6"
Content-Disposition: inline


--Tx2XG0Hc/yoUCMV6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2014 at 09:12:45AM +0800, Jie Yang wrote:
> For block span more than 1 section, when allocate it from
> a free block, we need allocate the remain buffers within
> the block, and then continue alloc the rest of needed
> size buffer.

Applied, thanks.

--Tx2XG0Hc/yoUCMV6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmq4fAAoJECTWi3JdVIfQgtsH/1pnW/4mGEpDe+aV9JmYwcy7
adQVwwhfc55wYlffixDeUVFXMG5UdZEm13BnisLi1f0FVfFhwPttwAlx8crjJ3j0
+4b4ud8CjvQs4HHihbYAhD8vhRb9gDnZZxcRY4X0LoPWOskrcJ/QcmLR3caQAt83
DmOxtsbKmlNWdp/sVwN9Hhmfx/JixJKmPOIatYXqjORoCl+vEPXTS2z0dbEmS1OS
bgVcCqif0NWTygQSy4DZUMgAqzER0mRuYbAqcPInOmIGMrsflplB/wSjZagf/IAc
tqdLEOeZJP+/D2TDYKQp7zkruNTl/Us9H2/JRkxPG8NJgPgv1IQ5bX/u4p2BFCw=
=4EUs
-----END PGP SIGNATURE-----

--Tx2XG0Hc/yoUCMV6--

--===============5048853392087391235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5048853392087391235==--
