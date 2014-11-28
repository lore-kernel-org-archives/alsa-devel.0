From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Correct the xmax volume
Date: Fri, 28 Nov 2014 11:40:38 +0000
Message-ID: <20141128114038.GJ7712@sirena.org.uk>
References: <1417142488-14577-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1281825683676766834=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 333F5260468
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 12:40:43 +0100 (CET)
In-Reply-To: <1417142488-14577-1-git-send-email-yang.jie@intel.com>
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


--===============1281825683676766834==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hh4JweDS6K/aOlXZ"
Content-Disposition: inline


--hh4JweDS6K/aOlXZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 28, 2014 at 10:41:28AM +0800, Jie Yang wrote:
> The xmax volume should be corrected to ARRAY_SIZE(volume_map)-1, otherwise,
> the xmax value will be mapped to 0 wrongly.

Applied, thanks.

--hh4JweDS6K/aOlXZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUeF82AAoJECTWi3JdVIfQjWMIAIRhpWUzBIsWs9YdFRzhWCYI
Wz0mXPvE+0Ne9vT3Yho16S741itSC51Jt3sYGtC3y8vxEEbBlVhsY47pniNxfUZX
TIu1OE2CfwnuqIhr1T5wMRvKL1ZMNuiWZMaYVA3r1czYkHN5UcPkbBCDjQtyKt/G
b1vVkJP/AhVwZWNjFKHSuCbvOcV3VVI8KkdOYzeIVIJIFEUFE3hMkBViMglSqU6L
QsH8aQ2egvZb8C6QLYfwV341oNMszAXcAW/D3I0H0nGMap3L92ZvQ6ZmnufAEq8H
WXEeyaKH1M82d6W2o/NTipQf3nUePN084PeuKNedD4W3nWDeMRAhoHfc3wGzl7Y=
=OT6G
-----END PGP SIGNATURE-----

--hh4JweDS6K/aOlXZ--

--===============1281825683676766834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1281825683676766834==--
