From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix integer overflow when
 calculating divisors
Date: Mon, 9 Jun 2014 21:00:52 +0100
Message-ID: <20140609200052.GN5099@sirena.org.uk>
References: <1402330603-16547-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8081799619160444927=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E2F6265197
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 22:01:09 +0200 (CEST)
In-Reply-To: <1402330603-16547-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============8081799619160444927==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8CLqiYUo6qiluZPB"
Content-Disposition: inline


--8CLqiYUo6qiluZPB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 09, 2014 at 07:16:43PM +0300, Anssi Hannula wrote:
> The calculation code does
> u64 = (u32 - u32) * 100000;

Applied, thanks.

--8CLqiYUo6qiluZPB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTlhJxAAoJELSic+t+oim9exQP/3Ykmz4qcvB3Mjtxe6BmWGko
h5YKtVR5+GrzkuyB0ryaiugsVHHUuftlOECgYzWKEp/ctp/Cl5mTV3f2SboGOboo
bufw1GCmTnOe2WdE2gZpbCQ9DNkXkRZzkJBlWy6rVyazI6JwPDKY2RDscWJYB/VX
cakAUOirxTBVo49Ywmd5oVO4bj7MBvM/qJXPUGUzFOjI/RFsjbqxlENFAoWMoiXH
JLv/DNAqaqI5eXAyLE0n8esTbbWX8bTMw5OmFIXj+W6MT+DcZ6m8Bhp26889pzOo
h+ncHrztAN031Qw8srecAXFxVOamZSqNVFP5WlMmxLpiKxQUe/smMTv1+UsrE1tW
P16J33is8p43OT+0u3HM6MgGKDWmAYlY45ljPlF4zfayy8eyfOtsRiSBCenPBEpl
Gylvxm37UYLv1sl6vwe5bvWgLueZMYcjncYVGoTD88CYMhab91WCOe1tIrCKPUUt
2TMtpwK5Y1e0nP8a6afeS3oucHle1Or80R/ca7Zy0ZGxDqsU3+NDPbuzu3ULuBfa
avNymQgW5R61NxGKDWZv2S2jNJThHdyis4QRy7PH5P4vCRvHp599tweV348Y4dtZ
XV4vrQSYJz9+TF915sY1T3nJ9lKIqrFGsXcXEeJSRCwABzv1/cx1PnB+rFlwfOQS
iNFCGV3i1KvQ5jZ/x3Mw
=3I+2
-----END PGP SIGNATURE-----

--8CLqiYUo6qiluZPB--

--===============8081799619160444927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8081799619160444927==--
