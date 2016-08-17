From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/17] Baytrail audio fixes
Date: Wed, 17 Aug 2016 11:50:32 +0100
Message-ID: <20160817105032.GJ9347@sirena.org.uk>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <928a31f5-d032-c06c-f59d-04d0d7ef1220@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2148782524035443422=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 41D14266094
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 12:50:42 +0200 (CEST)
In-Reply-To: <928a31f5-d032-c06c-f59d-04d0d7ef1220@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2148782524035443422==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iuNVq+MSMwU9tqfB"
Content-Disposition: inline


--iuNVq+MSMwU9tqfB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 15, 2016 at 09:56:31AM -0500, Pierre-Louis Bossart wrote:

> x86: Add Atom PMC platform clocks". if we enable the MCLK for existing
> platforms but delay the MCLK support we probably break something. how do we
> go about this? should this go through the clock subsystem? I am not aware of
> any other users of these platform clocks so the impact on other subsystems
> should be zero.

You need to at least send clock API patches to the clock maintainers,
since there's no build time dependency the normal thing would be that
things will go through the clock tree.

--iuNVq+MSMwU9tqfB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXtEF3AAoJECTWi3JdVIfQcNwH/2XVnmxwgEQXlvAosdBIQW1a
UraYz0galAwAPBSrK6PpKdpc22aAe1///GyAtvQ1by3nHrnrBQIvcqCcTsRnAtn5
BI+UjexH6f0McoaCE8uJdeXyegCMWk2u1BuvdfQBltVEXKod/mbY0MnT05d7Xjmf
mUZwaSwUcgg/lilJPzoP7Rnx/lZ/gOUhpRyt17wF/t8vzT55vUH9mDEJc4yTAHlI
1/A0u4hILgq8kPduENTZAfbsyRNKv+cX81KxWWJ0UR7xA+B7eZ9aJGfYK532nqOI
NgjUeZQkpzws2wSSeQm8CAaJ/irABg3wn2wdud4rqsx16DFOxAn8bbR8GMu1CqI=
=sjBR
-----END PGP SIGNATURE-----

--iuNVq+MSMwU9tqfB--

--===============2148782524035443422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2148782524035443422==--
