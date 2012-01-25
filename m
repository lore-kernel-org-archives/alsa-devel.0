From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-pcm: msbits constraint: Drop 8
 and 16 bit sample sizes
Date: Wed, 25 Jan 2012 11:28:11 +0000
Message-ID: <20120125112810.GA3687@opensource.wolfsonmicro.com>
References: <1327478981-8443-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5276798270042632390=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A9CF5103B88
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 12:28:13 +0100 (CET)
In-Reply-To: <1327478981-8443-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5276798270042632390==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2012 at 10:09:41AM +0200, Peter Ujfalusi wrote:
> As per discussion we can safely ignore the 8 and 16 bit sample
> sizes when applying the msbits constraint.

Applied, thanks.

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPH+dEAAoJEBus8iNuMP3dD84QAIAIzpb/WZWRhcarqcCo2J0t
Q+JLd8Uacy14v+idv2YBs47nRThmF4Ld/2+itGCKrseslfuqfw4hUnrP8O7XxDcr
DKbedXDmkUO7tyFG1CKvGpyH7bCS3Ekj8jFpg0YbjqdYoQOLx8hj20fd/af4j64e
O5InSz72m8+oQQv3Vcobf6Jv6G+U0IVGEqeckLqqop7F9oxHRPCgqeZFBZPzGohN
WFSHEj+Rh2YnKwUIC0SoopnnBdT7j/1SEFCoxSNnLkxjTRikndct9dbyzKpDn28j
/smSeKBnfpNtLgwaviUHinyplbJyGnwpx9exGi18iR+Zt7zxuCHIs2b5Va8YB3Ky
37QlQfOSkr9ZWNN8QcQZIzWriveEOf5opybkK6jX7yC2P8zXDFOJCqKZtitA5ab+
EMsubfP7u8+DuKRqBu8v1MtmyogerrNyAI8aoXf4w7yNduz2cGzs8Tb8XtdTJfzn
0NfnfzbTsO/2vojxyjOlMGFootI9iO6T1l7CG7tIpojbn3+xCAjNckSJ6fs2nQc8
Ps4aXCVzyVnkuJuECJRth+ZGnE58ZmCf1L5wyQ6E8H+xk6fp0z5ocPyaJuELUzBl
HVbk3/Prjb/Nr0FN236ZHSw3jnAJwqn+LbA7XlBXbdWG25dMJrXN2XZMzuvgeT/G
XXqhMVGO17xmgIvBY5FJ
=w5BP
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

--===============5276798270042632390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5276798270042632390==--
