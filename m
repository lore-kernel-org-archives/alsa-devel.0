From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: sh: Don't opencode DMAengine API
	calls
Date: Tue, 19 Aug 2014 11:40:52 -0500
Message-ID: <20140819164052.GN24407@sirena.org.uk>
References: <1408463287-5546-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6635538637177316279=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 25EB0261600
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 18:44:15 +0200 (CEST)
In-Reply-To: <1408463287-5546-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org


--===============6635538637177316279==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H7cT1SUwsqXggVRO"
Content-Disposition: inline


--H7cT1SUwsqXggVRO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 19, 2014 at 05:48:06PM +0200, Lars-Peter Clausen wrote:
> Use the proper wrapper functions instead of directly calling the DMAengine
> callback functions.

Applied, thanks.

--H7cT1SUwsqXggVRO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT834KAAoJELSic+t+oim9OVEP/jtziiYPcDM3tZkIoaoRFhfn
pxJn60g/1P65z0ev8ZlN3D/cpDEdJ2P6n8U0naYypmPNre7AoUhalDQqyTCeY4MB
fgjqzRZgZn2IMIV7vtAqTT8JZCVHZEMOJS1LPDjelrC5oAOEIJMyahWFWBo2G6qv
MQynYGeztsHMmpAwm63clhyfo79oZxmbfRCU028WGqI2vi5wKFt0RSzQsE/e60hu
BI9MnUuCmOvjSl2NtCCjXLZdBGnQ98Ruyb/O178scxfqqY6+VeEN6SumemQLx8mA
knQ2p1XP5a31Jgu+TYWygdeBt7DbMZHRmT7dkwPTCi7Auxd4QOOFY3zJua1QCyv7
SCieuT8kUU91+OPmRzi4+BJ6aPjRTV7s79g5/jdnci5dHIHCi9+uVP9tvI/4Y3ju
vWa6aL+iG6Sg3OG8BI2B4f5IGmEXRV/iTqMf5xxcw48ApUTQDeKxcTdd4fTqZBXQ
DcgccjkAtIt3b4pePpVVmZfDlfjEZrxt7MXZRqgDskMqRGBFakAbgel1ilUa1NjZ
niK7ctLA7u4YomN1PSM0WUt+T6SCSC7qsU4cJD+cNZAE+7MYSIQ2eT/yqsNYMXv/
KubRxE01CA3WyU2LEn87SWqgGWcYZM06oFCp4Q8tZKq5syMPV3LneBHBhDeKESoF
3xTjs1V+emPCrmZGX/c3
=/BwJ
-----END PGP SIGNATURE-----

--H7cT1SUwsqXggVRO--

--===============6635538637177316279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6635538637177316279==--
